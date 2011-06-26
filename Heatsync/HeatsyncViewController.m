//
//  HeatsyncViewController.m
//  Heatsync
//
//  Created by Justin Uang on 6/25/11.
//  Copyright 2011 Apple. All rights reserved.
//

#import "HeatsyncViewController.h"

@implementation HeatsyncViewController

@synthesize locMan;

#pragma mark -
#pragma mark Location Services

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    
	currentLocation=newLocation.coordinate;
	//One location is obtained.. just zoom to that location
	printf("\nUpdating to: %f, %f\n", currentLocation.latitude, currentLocation.longitude);
	
	MKCoordinateRegion region;
	region.center=currentLocation;
    
	//Set Zoom level using Span
	MKCoordinateSpan span;
	span.latitudeDelta=.005;
	span.longitudeDelta=.005;
	region.span=span;
	
	[map setRegion:region animated:TRUE];
	
	[manager stopUpdatingLocation];
    updating = NO;
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.locMan = [[[CLLocationManager alloc] init] autorelease];
	self.locMan.delegate = self;
    
    locMan.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    
    [locMan startUpdatingLocation];
    map.showsUserLocation = YES;
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
