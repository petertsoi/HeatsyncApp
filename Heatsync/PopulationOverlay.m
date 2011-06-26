//
//  PopulationOverlay.m
//  Heatsync
//
//  Created by Peter Tsoi on 6/25/11.
//  Copyright 2011 Apple. All rights reserved.
//

#import "PopulationOverlay.h"


@implementation PopulationOverlay

#pragma mark Constructors/Destructors

- (id) initWithXSamples:(int)xSamples YSamples:(int)ySamples data:(double*)data
{
    self = [super init];
    if (self)
    {
        gridWidth = xSamples;
        gridHeight = ySamples;
        memcpy(grid, data, sizeof(data));
    }
}

- (void)dealloc
{
    free(grid);
    [super dealloc];
}

#pragma mark Delegate Methods

- (CLLocationCoordinate2D)coordinate
{
    return CLLocationCoordinate2DMake(origin.latitude - (gridHeight * gridSize / 2.0),
                                      origin.longitude - (gridWidth * gridSize / 2.0));                                      
}

- (MKMapRect)boundingMapRect
{
    // Compute the boundingMapRect given the origin, the gridSize and the grid width and height
    
    MKMapPoint upperLeft = MKMapPointForCoordinate(origin);
    
    CLLocationCoordinate2D lowerRightCoord = 
    CLLocationCoordinate2DMake(origin.latitude - (gridSize * gridHeight),
                               origin.longitude + (gridSize * gridWidth));
    
    MKMapPoint lowerRight = MKMapPointForCoordinate(lowerRightCoord);
    
    double width = lowerRight.x - upperLeft.x;
    double height = lowerRight.y - upperLeft.y;
    
    MKMapRect bounds = MKMapRectMake(upperLeft.x, upperLeft.y, width, height);
    return bounds;
}

#pragma mark Ughhhhhhh......

- (void)samplesInMapRect:(MKMapRect)rect
                 atScale:(MKZoomScale)scale
                  values:(double **)valuesOut
              boundaries:(MKMapRect **)boundariesOut
                   count:(int *)count
{
    CLLocationCoordinate2D rectOrigin = MKCoordinateForMapPoint(rect.origin);
    CLLocationCoordinate2D rectMax = MKCoordinateForMapPoint(MKMapPointMake(MKMapRectGetMaxX(rect), MKMapRectGetMaxY(rect)));
    
    // Don't want any returned grid square to be drawn smaller than 2pt.  
    // When the map is zoomed way out at world level, apply a reduction to
    // the grid and just do nearest neighbor sampling to find the a value
    double approximatePtsPerSquare = scale * (MKMapSizeWorld.width / (180.0 / gridSize));
    int gridReduction = MAX(1, (int)(4.0 / approximatePtsPerSquare));
    
    // Find the bounding indices (left, right, top, bottom) into the grid array
    int left = (rectOrigin.longitude - origin.longitude) / gridSize;
    left = MAX(left, 0);
    left = MIN(left, gridWidth - 1);
    
    int right = (rectMax.longitude - origin.longitude) / gridSize;
    right = MAX(right, 0);
    right = MIN(right, gridWidth - 1);
    
    int top = (origin.latitude - rectOrigin.latitude) / gridSize;
    top = MAX(top, 0);
    top = MIN(top, gridHeight - 1);
    
    int bottom = (origin.latitude - rectMax.latitude) / gridSize;
    bottom = MAX(bottom, 0);
    bottom = MIN(bottom, gridHeight - 1);
    
    int width = 1 + ((right - left) / gridReduction);
    int height = 1 + ((bottom - top) / gridReduction);
    
    *count = (width) * (height);
    MKMapRect *boundaries = malloc(sizeof(MKMapRect) * *count);
    double *values = malloc(sizeof(double) * *count);
    
    // Loop through the grid by the gridReduction factor, sampling values along the way
    int x, y, read = 0;
    for (y = top; y <= bottom; y += gridReduction) {
        for (x = left; x <= right; x += gridReduction) {
            // Convert an upper-left, lower-right latitude and longitude to an MKMapRect
            CLLocationCoordinate2D valueOrigin = 
            CLLocationCoordinate2DMake(origin.latitude - (y * gridSize),
                                       origin.longitude + (x * gridSize));
            CLLocationCoordinate2D valueLowerRight = 
            CLLocationCoordinate2DMake(valueOrigin.latitude - (gridSize * gridReduction),
                                       valueOrigin.longitude + (gridSize * gridReduction));
            
            MKMapPoint upperLeft = MKMapPointForCoordinate(valueOrigin);
            MKMapPoint lowerRight = MKMapPointForCoordinate(valueLowerRight);
            
            boundaries[read] = MKMapRectMake(upperLeft.x,
                                             upperLeft.y,
                                             lowerRight.x - upperLeft.x,
                                             lowerRight.y - upperLeft.y);
            
            // Read the grid value into the values array
            values[read] = *(grid + (gridWidth * y) + x);
            
            read++;
        }
    }
    
    *boundariesOut = boundaries;
    *valuesOut = values;
}
@end
