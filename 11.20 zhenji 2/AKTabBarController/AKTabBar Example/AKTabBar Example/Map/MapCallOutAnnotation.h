//
//  MapCallOutAnnotation.h
//  map
//
//  Created by mac on 13-10-23.
//  Copyright (c) 2013年 龙代驾. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "BMKAnnotation.h"


@interface MapCallOutAnnotation : NSObject <BMKAnnotation> {
	CLLocationDegrees _latitude;
	CLLocationDegrees _longitude;
}

@property (nonatomic) CLLocationDegrees latitude;
@property (nonatomic) CLLocationDegrees longitude;

- (id)initWithLatitude:(CLLocationDegrees)latitude
		  andLongitude:(CLLocationDegrees)longitude;

@end