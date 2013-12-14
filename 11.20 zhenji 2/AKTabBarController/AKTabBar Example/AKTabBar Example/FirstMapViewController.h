//
//  FirstMapViewController.h
//  龙代驾
//
//  Created by mac on 13-10-29.
//  Copyright (c) 2013年 Ali Karagoz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
@class AKTabBarController;
@interface FirstMapViewController : UIViewController<BMKMapViewDelegate>
@property (strong,nonatomic)NSArray * arrayList;
@property (strong,nonatomic)NSMutableDictionary * dicSJList;
@property (strong,nonatomic)NSMutableDictionary * dicPingjia;
@property (strong,nonatomic)NSMutableDictionary * dicImage;
@property (strong,nonatomic)UIView * mainView;
@property (strong,nonatomic)UIButton * btn1;
@property (strong,nonatomic)UIButton * btn2;
@property (strong,nonatomic)UIButton * btn3;
@property (nonatomic, strong) AKTabBarController *tabBarController;
+(FirstMapViewController *)SingleInit;
-(void)pressItem;

@end
