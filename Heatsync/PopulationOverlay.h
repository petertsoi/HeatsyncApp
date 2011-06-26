//
//  PopulationOverlay.h
//  Heatsync
//
//  Created by Peter Tsoi on 6/25/11.
//  Copyright 2011 Apple. All rights reserved.
//

#import <MapKit/MapKit.h>


@interface PopulationOverlay : NSObject <MKOverlay> {
    CLLocationCoordinate2D origin; // position of upper left hazard
    CLLocationDegrees gridSize; // delta degrees for each square in the grid
    
    int gridWidth;  // number of squares in the grid in the x direction
    int gridHeight; // "" y direction
    
    double * grid;
}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;


- (id) initWithXSamples:(int)xSamples YSamples:(int)ySamples data:(double*)data; 

- (MKMapRect)boundingMapRect;

- (void)samplesInMapRect:(MKMapRect)rect
                 atScale:(MKZoomScale)scale
                  values:(double **)valuesOut
              boundaries:(MKMapRect **)boundariesOut
                   count:(int *)count;

@end
