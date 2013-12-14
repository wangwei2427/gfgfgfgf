//
//  SiJiXiangQingViewController.h
//  龙代驾
//
//  Created by mac on 13-10-21.
//  Copyright (c) 2013年 Ali Karagoz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SiJiXiangQingViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property (strong,nonatomic)NSArray * arrayList;

@property (strong,nonatomic)NSDictionary * dicXQ;
@property (strong,nonatomic)UIImageView * imageView;
@property (strong,nonatomic)UIImageView * imageXingJi;
@property (strong,nonatomic)UILabel * labelName;

@property (strong,nonatomic)UILabel * labelDaiJia;
@property (strong,nonatomic)UILabel * labelCishu;
@property (strong,nonatomic)UILabel * labelJuLi;
@property (strong,nonatomic)UILabel * labelGongLi;
@property (strong,nonatomic)UILabel * labelJiaZhao;
@property (strong,nonatomic)UILabel * labelJiaZhaoHao;
@property (strong,nonatomic)UILabel * labelJiaLing;
@property (strong,nonatomic)UILabel * labelNian;
@property (strong,nonatomic)UILabel * labelZhuangTai;
@property (strong,nonatomic)UILabel * labelHuji;
@property (strong,nonatomic)UILabel * labelAdds;

@property (strong,nonatomic)UIButton * btnPhone;

@property (strong,nonatomic)UILabel * labelPingJia;
@property (strong,nonatomic)UITableView * tableV;

@property (strong,nonatomic)NSString * strFather;


@property (strong,nonatomic)UIActivityIndicatorView * activityView;

-(void)addButton;
-(void)callPhone;



-(id)initWithDic:(NSDictionary *)dic father:(NSString *)f;
-(id)initWithDic:(NSDictionary *)dic f:(NSString *)f;

@end
