//
//  MapViewController.h
//  map
//
//  Created by mac on 13-10-10.
//  Copyright (c) 2013年 龙代驾. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"

@protocol MapViewControllerDidSelectDelegate;

@interface MapViewController : UIViewController<BMKMapViewDelegate,BMKSearchDelegate>
{
    BMKSearch* _search;
    //BMKMapView* _mapView;
    
}
@property (strong,nonatomic)NSArray * arrayList;
@property (strong,nonatomic)NSDictionary * dicList;
@property (strong,nonatomic)IBOutlet BMKMapView * _mapView;
@property (strong,nonatomic)BMKAnnotationView * annoView;
@property (strong,nonatomic)UIButton * btn1;
@property (strong,nonatomic)UIButton * btn2;
@property (strong,nonatomic)NSString * strFather;
@property (strong,nonatomic)NSString * strLat;
@property (strong,nonatomic)NSString * strLon;
@property (strong,nonatomic)UIActivityIndicatorView * activityView;

-(id)initWithFather:(NSString * )f;

@property(nonatomic,assign)id<MapViewControllerDidSelectDelegate> delegate;
- (void)resetAnnitations:(NSArray *)data;
-(void)setAnnotionsWithList:(NSArray *)list;
@end

@protocol MapViewControllerDidSelectDelegate <NSObject>
@optional
- (void)customMKMapViewDidSelectedWithInfo:(id)info;

@end