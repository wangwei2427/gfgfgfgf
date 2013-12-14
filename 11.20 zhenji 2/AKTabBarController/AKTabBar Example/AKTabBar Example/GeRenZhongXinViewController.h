//
//  GeRenZhongXinViewController.h
//  龙代驾
//
//  Created by mac on 13-10-24.
//  Copyright (c) 2013年 Ali Karagoz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"

@interface GeRenZhongXinViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong,nonatomic)MainViewController * main;
@property (strong,nonatomic)UITableView * tableV;
@property (strong,nonatomic)NSArray * arrayList;
@property (strong,nonatomic)NSMutableDictionary * dicImage;

@property (strong,nonatomic)UIActivityIndicatorView * activityView;
-(void)updateData;
@end
