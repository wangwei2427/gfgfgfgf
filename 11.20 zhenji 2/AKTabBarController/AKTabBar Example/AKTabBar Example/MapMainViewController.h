//
//  MapMainViewController.h
//  龙代驾
//
//  Created by mac on 13-10-23.
//  Copyright (c) 2013年 Ali Karagoz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
#import "AKTabBarController.h"
@interface MapMainViewController : UIViewController<BMKMapViewDelegate>
@property (strong,nonatomic)NSArray * arrayList;
@property (strong,nonatomic)UIView * mainView;
@property (strong,nonatomic)UIButton * btn1;
@property (strong,nonatomic)UIButton * btn2;
+(MapMainViewController *)SingleInit;
@property (nonatomic, strong) AKTabBarController *tabBarController;

@property (nonatomic,copy) NSString *isMain;
@end
