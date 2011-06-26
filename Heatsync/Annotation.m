#import "Annotation.h"
#import <MapKit/MapKit.h>


@implementation Annotation

@synthesize coordinate;
@synthesize title;
@synthesize subTitle;
@synthesize isNew;
@synthesize locationID;

- (NSString *)subTitle{
	return subTitle;
}

- (NSString *)title{
	//	NSLog(@"currenttitle: %@",currentTitle);
	return title;//  @"Marker Annotation";
}


-(id)initWithCoordinate:(CLLocationCoordinate2D)c new:(BOOL)aIsNew{
	coordinate=c;
	isNew = aIsNew;
	
	//NSLog(@"%f,%f",c.latitude,c.longitude);
	return self;
}


@end