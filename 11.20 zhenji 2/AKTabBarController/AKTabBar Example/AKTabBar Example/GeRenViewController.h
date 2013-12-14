//
//  GeRenViewController.h
//  龙代驾
//
//  Created by mac on 13-11-6.
//  Copyright (c) 2013年 Ali Karagoz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GeRenViewController : UIViewController
@property (strong,nonatomic)NSString * strMoney;
@property (strong,nonatomic)NSString * strNo;
@property (strong,nonatomic)NSString * strPoint;

@property (strong,nonatomic)UILabel * labelXF;
@property (strong,nonatomic)UILabel * labelCS;
@property (strong,nonatomic)UILabel * labelJF;
@property (strong,nonatomic)UILabel * labelMoney;
@property (strong,nonatomic)UILabel * labelNo;
@property (strong,nonatomic)UILabel * labelPoint;
@property (strong,nonatomic)UILabel * labelYuan;
@property (strong,nonatomic)UILabel * labelCi;
@property (strong,nonatomic)UILabel * labelFen;

@property (strong,nonatomic)UIButton * btnXiangQing;
@property (strong,nonatomic)UIButton * btnLiShi;
@property (strong,nonatomic)UIButton * btnGeRen;
-(void)addButton;
@end
