//
//  DangQianDingDanViewController.h
//  龙代驾
//
//  Created by mac on 13-10-22.
//  Copyright (c) 2013年 Ali Karagoz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DangQianDingDanViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong,nonatomic)UITableView * tableV;
@property (strong,nonatomic)NSArray * arrOrder;
@property (strong,nonatomic)UIActivityIndicatorView * activityView;

@end
