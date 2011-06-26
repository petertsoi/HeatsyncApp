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
#import "Annotation.h"
#import "HSAnnotationView.h"

#import "PopulationOverlay.h"
#import "PopulationOverlayView.h"

#define kSpanLatDeltaMax            2

@implementation HeatsyncViewController

@synthesize locMan;
@synthesize regionBeforeZoom;

#pragma mark -
#pragma mark MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    NSLog(@"change");
    /*if (map.region.span.latitudeDelta > kSpanLatDeltaMax) {
        [map setRegion:globalRegion animated:YES];
    }*/
    //else {
        if (!updating) {
            [self downloadTrendingData];
        }
        
        
    //}
}

//- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated {
//    if (map.region.span.latitudeDelta < kSpanLatDeltaMax) {
//        self.regionBeforeZoom = mapView.region;
//    }
//}

#pragma mark -
#pragma mark Location Services

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    
	currentLocation=newLocation.coordinate;
	//One location is obtained.. just zoom to that location
	printf("\nUpdating to: %f, %f\n", currentLocation.latitude, currentLocation.longitude);
	
	MKCoordinateRegion region;
	region.center = currentLocation;
    
	//Set Zoom level using Span
	MKCoordinateSpan span;
	span.latitudeDelta=.02;
	span.longitudeDelta=.02;
	region.span=span;
	
	[map setRegion:region animated:TRUE];
    
    globalRegion = region;
	
	[manager stopUpdatingLocation];
    updating = NO;
    
    [self addPin];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
}

#pragma mark -
#pragma mark Get Network Data

- (void)downloadTrendingData {
    MKCoordinateRegion center = map.region;
    MKCoordinateRegion span = map.region;
    
    double bl_x = map.region.center.longitude - map.region.span.longitudeDelta/2;
    
    double bl_y = map.region.center.latitude - map.region.span.latitudeDelta/2;
    
    double tr_x = map.region.center.longitude + map.region.span.longitudeDelta/2;
    
    double tr_y = map.region.center.latitude + map.region.span.latitudeDelta/2;
    NSString *urlString = [[NSString stringWithFormat:@"http://ec2-50-19-194-124.compute-1.amazonaws.com/trending_data?bl=%f,%f&tr=%f,%f&divx=%d&divy=%d", bl_y, bl_x, tr_y, tr_x, 16, 16] stringByAddingPercentEscapesUsingEncoding:
                           NSASCIIStringEncoding];
    NSURL *requestURL = [NSURL URLWithString:urlString];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:requestURL];
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(downloadTrendingDataFinished:)];
    
    [request startAsynchronous];
}

- (void)downloadTrendingDataFinished:(ASIHTTPRequest *)request {

    if (populationOverlay != nil){
        [map removeOverlay:populationOverlay];
    }
    
    NSString *responseString = [request responseString];
    NSLog(@"%@",[[request originalURL] absoluteString]);
    NSLog(@"%@", responseString);
    NSArray *trendingAreaPopulations = [responseString JSONValue];
    
    // ugly test set. remove before flight.
    /*trendingAreaPopulations = [@"[5, 10, 15, 20, 25, 5, 12, 32, 0, 16, 27, 30, 7, 4, 3, 18, 9, 28, 5, 12, 19, 0, 5, 16, 18]" JSONValue];*/
    int height = 16;
    int width = 16;
    // end test set
    
    // Area calculations
    double bl_x = map.region.center.longitude - map.region.span.longitudeDelta/2;
    double bl_y = map.region.center.latitude - map.region.span.latitudeDelta/2;
    double tr_x = map.region.center.longitude + map.region.span.longitudeDelta/2;
    double tr_y = map.region.center.latitude + map.region.span.latitudeDelta/2;
    
    CLLocationCoordinate2D topLeft = CLLocationCoordinate2DMake(tr_y, bl_x);
    
    double regionSquareSize = fabs((tr_x - bl_x) * (tr_y - bl_y));
    
    
    
    
    
    
    
    
    double grid[[trendingAreaPopulations count]];
    unsigned int maxSoFar = 0;
    for (int i = 0; i < [trendingAreaPopulations count]; i++) {
        grid[i] = [[trendingAreaPopulations objectAtIndex:i] doubleValue];
        NSLog(@"Pre-Norm %f", grid[i]);
        maxSoFar = MAX(grid[i], maxSoFar);
    }
    
    double maxRatio = (double)maxSoFar / regionSquareSize;
    
    double normalized[[trendingAreaPopulations count]];
    
    if (maxSoFar == 0)
        maxSoFar = 1;
    
    for (int i = 0; i < [trendingAreaPopulations count]; i++) {
        normalized[i] = grid[i] / (double)maxSoFar;
        NSLog(@"Normalized[%i]: %f", i, normalized[i]);
    }
    
    
   
    
    int i = 0;
    
    NSLog(@"maxRatio: %f \t for = %i / %f\n", maxRatio, maxSoFar, regionSquareSize);
    
    populationOverlay = [[PopulationOverlay alloc] initAt:topLeft 
                                                                WithXSamples:width 
                                                                    YSamples:height 
                                                                    gridSize:fabs((tr_x - bl_x))/(double)width
                                                                        data:normalized];
    
    // Position and zoom the map to just fit the grid loaded on screen
//    [map setVisibleMapRect:[populationOverlay boundingMapRect]];
//    
    // Add the earthquake hazard map to the map view
    [map addOverlay:populationOverlay];
    
    // Let the map view own the hazards model object now
    [populationOverlay release];

    
}

- (void)addPin{
	CLLocationCoordinate2D myCoord = [map convertPoint:CGPointMake(160, 200) toCoordinateFromView:map];
	Annotation *defaultAnnotation = [[Annotation alloc] initWithCoordinate:myCoord new:YES];
	defaultAnnotation.title = @"Caffe Macs";
	
	[map addAnnotation:defaultAnnotation];
	[map selectAnnotation:defaultAnnotation animated:YES];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(Annotation *)annotation{
	return [[HSAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"Hello"];
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

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay
{
    PopulationOverlayView *view = [[PopulationOverlayView alloc] initWithOverlay:overlay];
    return [view autorelease];
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
