//
//  PopulationOverlayView.m
//  Heatsync
//
//  Created by Peter Tsoi on 6/25/11.
//  Copyright 2011 Apple. All rights reserved.
//

#import "PopulationOverlayView.h"
#import "PopulationOverlay.h"

#import <CoreGraphics/CoreGraphics.h>

#define NUM_COLORS 9
@implementation PopulationOverlayView



// Create a table of possible colors to draw a grid cell with
- (void)initColors
{
    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
    colors = malloc(sizeof(CGColorRef) * NUM_COLORS);
    int i = 0;
    colors[i++] = CGColorCreate(rgb, (CGFloat[]){ .925, .313, .266, 1 }); // 1.00
    colors[i++] = CGColorCreate(rgb, (CGFloat[]){ .925, .438, .396, 1 }); // 0.77
    colors[i++] = CGColorCreate(rgb, (CGFloat[]){ .956, .523, .468, 1 }); // 0.59
    colors[i++] = CGColorCreate(rgb, (CGFloat[]){ .952, .592, .427, 1 }); // 0.46
    colors[i++] = CGColorCreate(rgb, (CGFloat[]){ .952, .660, .486, 1 }); // 0.35
    colors[i++] = CGColorCreate(rgb, (CGFloat[]){ .952, .660, .486, 1 }); // 0.35
    colors[i++] = CGColorCreate(rgb, (CGFloat[]){ .952, .716, .611, 1 }); // 0.27
    colors[i++] = CGColorCreate(rgb, (CGFloat[]){ .952, .716, .611, 1 }); // 0.27
    colors[i++] = CGColorCreate(rgb, (CGFloat[]){ .973, .943, .805, 1 }); // 0.12
    colors[i++] = CGColorCreate(rgb, (CGFloat[]){ 1, 1, 1, 1 }); // 0.10
    /*colors[i++] = CGColorCreate(rgb, (CGFloat[]){ .784, 1, 1, 1 }); // 0.08
     colors[i++] = CGColorCreate(rgb, (CGFloat[]){ .843, 1, 1, 1 }); // 0.06
     colors[i++] = CGColorCreate(rgb, (CGFloat[]){ .902, 1, 1, 1 }); // 0.04
     colors[i] = CGColorCreate(rgb, (CGFloat[]){ .784, .784, .784, 1 }); // 0.03*/
    
    
    
    /*colors[i++] = CGColorCreate(rgb, (CGFloat[]){ .925, .313, .266, 1 }); // 1.00
    colors[i++] = CGColorCreate(rgb, (CGFloat[]){ .925, .438, .396, 1 }); // 0.77
    colors[i++] = CGColorCreate(rgb, (CGFloat[]){ .956, .523, .468, 1 }); // 0.59
    colors[i++] = CGColorCreate(rgb, (CGFloat[]){ .952, .592, .427, 1 }); // 0.46
    colors[i++] = CGColorCreate(rgb, (CGFloat[]){ .952, .660, .486, 1 }); // 0.35
    colors[i++] = CGColorCreate(rgb, (CGFloat[]){ .952, .716, .611, 1 }); // 0.27
    colors[i++] = CGColorCreate(rgb, (CGFloat[]){ .964, .933, .462, 1 }); // 0.21
    colors[i++] = CGColorCreate(rgb, (CGFloat[]){ .973, .943, .684, 1 }); // 0.16
    colors[i++] = CGColorCreate(rgb, (CGFloat[]){ .973, .943, .805, 1 }); // 0.12
    colors[i++] = CGColorCreate(rgb, (CGFloat[]){ 1, 1, 1, 1 }); // 0.10
    colors[i++] = CGColorCreate(rgb, (CGFloat[]){ .784, 1, 1, 1 }); // 0.08
     colors[i++] = CGColorCreate(rgb, (CGFloat[]){ .843, 1, 1, 1 }); // 0.06
     colors[i++] = CGColorCreate(rgb, (CGFloat[]){ .902, 1, 1, 1 }); // 0.04
     colors[i] = CGColorCreate(rgb, (CGFloat[]){ .784, .784, .784, 1 }); // 0.03*/
    CGColorSpaceRelease(rgb);
}

// Look up a color in the table of colors for a peak ground acceleration
- (CGColorRef)colorForAcceleration:(CGFloat)value
{
    if (value > 0.88) return colors[0];
    if (value > 0.77) return colors[1];
    if (value > 0.66) return colors[2];
    if (value > 0.55) return colors[3];
    if (value > 0.44) return colors[4];
    if (value > 0.33) return colors[5];
    if (value > 0.22) return colors[6];
    if (value > 0.11) return colors[7];
    if (value > 0.0) return colors[8];
    /*if (value > 0.10) return colors[8];
     if (value > 0.08) return colors[9];
     if (value > 0.06) return colors[10];
     if (value > 0.04) return colors[11];
     if (value > 0.03) return colors[12];
     if (value > 0.02) return colors[13];*/
    
    /*
    if (value > 0.77) return colors[0];
    if (value > 0.59) return colors[1];
    if (value > 0.46) return colors[2];
    if (value > 0.35) return colors[3];
    if (value > 0.27) return colors[4];
    if (value > 0.21) return colors[5];
    if (value > 0.16) return colors[6];
    if (value > 0.12) return colors[7];
    if (value > 0.10) return colors[8];
     if (value > 0.08) return colors[9];
     if (value > 0.06) return colors[10];
     if (value > 0.04) return colors[11];
     if (value > 0.03) return colors[12];
     if (value > 0.02) return colors[13];*/
    
    
    /*
     
     if (value > 0.88) return colors[0];
     if (value > 0.77) return colors[1];
     if (value > 0.66) return colors[2];
     if (value > 0.55) return colors[3];
     if (value > 0.44) return colors[4];
     if (value > 0.33) return colors[5];
     if (value > 0.22) return colors[6];
     if (value > 0.11) return colors[7];
     if (value > 0.0) return colors[8];
     
     */
    return NULL;
}

- (id)initWithOverlay:(id <MKOverlay>)overlay
{
    if ((self = [super initWithOverlay:overlay])) {
        [self initColors];
    }
    return self;
}

- (void)dealloc
{
    int i;
    for (i = 0; i < NUM_COLORS; i++) {
        CGColorRelease(colors[i]);
    }
    free(colors);
    [super dealloc];
}

- (void)drawMapRect:(MKMapRect)mapRect
          zoomScale:(MKZoomScale)zoomScale
          inContext:(CGContextRef)ctx
{
    PopulationOverlay *samples = (PopulationOverlay *)self.overlay;
    
    double *values = NULL;
    MKMapRect *boundaries = NULL;
    int count = 0;
    
    // Fetch the grid values out of the model for this mapRect and zoomScale.
    [samples samplesInMapRect:mapRect
                      atScale:zoomScale
                       values:&values
                   boundaries:&boundaries
                        count:&count];
    
    CGContextSetAlpha(ctx, 0.75);
    
    // For each grid value that is colorable, color in its corresponding
    // boundary MKMapRect with the appropriate color.
    int i;
    for (i = 0; i < count; i++) {
        double value = values[i];
        
        MKMapRect boundary = boundaries[i];
        
        CGColorRef color = [self colorForAcceleration:value];
        if (color) {          
            CGContextSetFillColorWithColor(ctx, color);
            
            // Convert the MKMapRect (absolute points on the map proportional to screen points) to
            // a CGRect (points relative to the origin of this view) that can be drawn.
            CGRect boundaryCGRect = [self rectForMapRect:boundary];
            
            CGContextFillRect(ctx, boundaryCGRect);
        }
        //NSLog(@"Drawing[%i]: %f\n", i, value);
    }
    
    free(values);
    free(boundaries);
}

@end
