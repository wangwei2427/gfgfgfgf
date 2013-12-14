//
//  AppDelegate.h
//  AKTabBar Example
//
//  Created by Ali KARAGOZ on 03/05/12.
//  Copyright (c) 2012 Ali Karagoz. All rights reserved.
//
#import "Share/Weixin/SendMsgToWeChatViewController.h"
#import "BMapKit.h"
#import "WXApi.h"
#import "RespForWeChatViewController.h"

@class SinaWeibo;
@interface AppDelegate : UIResponder <UIApplicationDelegate,BMKGeneralDelegate,WXApiDelegate,sendMsgToWeChatViewDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (readonly, nonatomic) SinaWeibo *sinaWeibo;
@property (strong,nonatomic)ThirdViewController * thirdViewController;
@property (strong,nonatomic)BMKMapManager * mapManager;

@property (strong,nonatomic)NSDictionary *dict;

@end
