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

@interface HeatsyncViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate> {
	IBOutlet MKMapView *map;
    CLLocationManager *locMan;
	CLLocationCoordinate2D currentLocation;
    
    BOOL updating;
}

@property (nonatomic, retain) CLLocationManager *locMan;

@end
