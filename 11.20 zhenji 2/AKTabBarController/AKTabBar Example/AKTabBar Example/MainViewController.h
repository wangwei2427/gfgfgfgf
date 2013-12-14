//
//  MainViewController.h
//  AKTabBar Example
//
//  Created by mac on 13-9-16.
//  Copyright (c) 2013年 Ali Karagoz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreLocation/CoreLocation.h"
#import "FirstMapViewController.h"
@class AKTabBarController;
@interface MainViewController : UIViewController<CLLocationManagerDelegate,UINavigationControllerDelegate>
@property (strong,nonatomic)UINavigationController * nav;
@property (strong,nonatomic)CLLocationManager * locManager;
@property (nonatomic, strong) AKTabBarController *tabBarController;
@property (strong,nonatomic)NSArray * arrayMain;
@property (strong,nonatomic)NSMutableDictionary * dicPingJia;
@property (strong,nonatomic)NSMutableDictionary * dicImage;

@property (strong,nonatomic)NSMutableArray * arrayHistory;
@property (strong,nonatomic)NSMutableDictionary * dicHistory;
@property (strong,nonatomic)NSString * strZhangHao;
@property (strong,nonatomic)FirstMapViewController * main;
@property (strong,nonatomic)NSString * strLon;
@property (strong,nonatomic)NSString * strLat;

@property (strong,nonatomic)NSString * strISPingjia;
@property (strong,nonatomic)NSString * strISImage;

@property (strong,nonatomic)UIActivityIndicatorView * activityView;

+(MainViewController *)SingleInit;

-(void)goMap;
-(void)goZhuCe;
-(void)updataXY;
@end
