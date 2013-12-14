//
//  MapOutAnnotationView.m
//  map
//
//  Created by mac on 13-10-15.
//  Copyright (c) 2013年 龙代驾. All rights reserved.
//

#import "MapOutAnnotationView.h"

#define Arror_height 15
@implementation MapOutAnnotationView
@synthesize contentView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithAnnotation:(id<BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        self.canShowCallout=NO;
        //self.centerOffset=CGPointMake(0, -55);
        self.centerOffset=CGPointMake(0, 0);
         self.frame=CGRectMake(0, 0, 70, 50);
        self.contentView = [[BMKAnnotationView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - Arror_height)];
        self.contentView.backgroundColor   = [UIColor clearColor];
        [self addSubview:self.contentView];
        
    }
    return self;
}

@end
