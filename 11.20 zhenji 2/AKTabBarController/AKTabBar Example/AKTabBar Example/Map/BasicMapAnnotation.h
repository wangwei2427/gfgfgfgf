#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "BMKAnnotation.h"

@interface BasicMapAnnotation : NSObject <BMKAnnotation> {
	CLLocationDegrees _latitude;
	CLLocationDegrees _longitude;
	//NSString *_title;
}

@property (nonatomic, strong) NSString *title;

- (id)initWithLatitude:(CLLocationDegrees)latitude
		  andLongitude:(CLLocationDegrees)longitude;
- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate;

@end
