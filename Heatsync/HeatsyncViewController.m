//
//  HeatsyncViewController.m
//  Heatsync
//
//  Created by Justin Uang on 6/25/11.
//  Copyright 2011 Apple. All rights reserved.
//

#import "HeatsyncViewController.h"
#import "ASIHTTPRequest.h"
#import "SBJson.h"

@implementation HeatsyncViewController

@synthesize locMan;

#pragma mark -
#pragma mark MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    [self downloadTrendingData];
}

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
	span.latitudeDelta=.05;
	span.longitudeDelta=.05;
	region.span=span;
	
	[map setRegion:region animated:TRUE];
    
    globalRegion = region;
	
	[manager stopUpdatingLocation];
    updating = NO;
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
}

#pragma mark -
#pragma mark Get Network Data

- (void)downloadTrendingData {
    MKCoordinateRegion center = map.region;
    MKCoordinateRegion span = map.region;
    
    double bl_x = map.region.center.longitude - map.region.span.longitudeDelta;
    
    double bl_y = map.region.center.latitude - map.region.span.latitudeDelta;
    
    double tr_x = map.region.center.longitude + map.region.span.longitudeDelta;
    
    double tr_y = map.region.center.latitude + map.region.span.latitudeDelta;
    
    
    NSString *urlString = [NSString stringWithFormat:@"/trending_data?bl=%f,%f&tr=%f,%f&divx=%d&divy=%d", bl_x, bl_y, tr_x, tr_y, 8, 12];
    NSURL *requestURL = [NSURL URLWithString:urlString];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:requestURL];
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(downloadTrendingDataFinished:)];
    
    [request startAsynchronous];
}

- (void)downloadTrendingDataFinished:(ASIHTTPRequest *)request {
    NSString *responseString = [request responseString];
    NSArray *trendingAreaPopulations = [responseString JSONValue];
    
    for (NSNumber *populationForArea in trendingAreaPopulations) {
        //<#statements#>
    }
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
    
    map.delegate = self;
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
