//
//  GeRenInfoViewController.h
//  龙代驾
//
//  Created by mac on 13-11-6.
//  Copyright (c) 2013年 Ali Karagoz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GeRenInfoViewController : UIViewController
{
    NSArray *infoArray;
}
@property (strong,nonatomic)UILabel * labelDanWei;
@property (strong,nonatomic)UILabel * labelName;
@property (strong,nonatomic)UILabel * labelPhone;
@property (strong,nonatomic)UILabel * labelShenfenZheng;
@property (strong,nonatomic)UILabel * labelQQ;
@property (strong,nonatomic)UILabel * labelYouxiang;
@property (strong,nonatomic)UILabel * labelZhuye;
@property (strong,nonatomic)UILabel * labelNan;
@property (strong,nonatomic)UILabel * labelNv;
@property (strong,nonatomic)UILabel * labelXB;

@property (strong,nonatomic)UITextField * textFieldDanwei;
@property (strong,nonatomic)UITextField * textFieldName;
@property (strong,nonatomic)UITextField * textFieldPhone;
@property (strong,nonatomic)UITextField * textFieldShenfenzheng;
@property (strong,nonatomic)UITextField * textFieldQQ;
@property (strong,nonatomic)UITextField * textFieldYouxiang;
@property (strong,nonatomic)UITextField * textFieldZhuye;

@property (strong,nonatomic)UIButton * btnSave;
@property (strong,nonatomic)UIButton * btnNan;
@property (strong,nonatomic)UIButton * btnNv;
@property (strong,nonatomic)UIActivityIndicatorView * activityView;
@property (strong,nonatomic)UIActivityIndicatorView * actView;

-(void)changeBtn:(id)sender;
-(void)addButton;
-(void)save;


@end
