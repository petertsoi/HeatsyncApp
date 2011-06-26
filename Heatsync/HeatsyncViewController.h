//
//  HeatsyncViewController.h
//  Heatsync
//
//  Created by Justin Uang on 6/25/11.
//  Copyright 2011 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@class ASIHTTPRequest;

@interface HeatsyncViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate> {
	IBOutlet MKMapView *map;
    CLLocationManager *locMan;
	CLLocationCoordinate2D currentLocation;
    
    MKCoordinateRegion globalRegion;
    
    BOOL updating;
    
    MKCoordinateRegion regionBeforeZoom;
}

@property (nonatomic, retain) CLLocationManager *locMan;
@property (nonatomic) MKCoordinateRegion regionBeforeZoom;

- (void)downloadTrendingData;

- (void)downloadTrendingDataFinished:(ASIHTTPRequest *)request;

@end
