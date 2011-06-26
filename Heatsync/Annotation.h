#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface Annotation : NSObject <MKAnnotation>{
	
	CLLocationCoordinate2D coordinate;
	
	NSString *subTitle;
	NSString *title;
	
	BOOL isNew;
	
	int locationID;
}

@property  CLLocationCoordinate2D coordinate;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *subTitle;
@property BOOL isNew;
@property int locationID;

- (NSString *)title;

- (NSString *)subTitle;

- (id)initWithCoordinate:(CLLocationCoordinate2D)c new:(BOOL)aIsNew;

@end