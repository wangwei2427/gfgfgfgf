//
//  FaPiaoViewController.h
//  龙代驾
//
//  Created by mac on 13-10-19.
//  Copyright (c) 2013年 Ali Karagoz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIDropDown.h"

@interface FaPiaoViewController : UIViewController<UITextFieldDelegate,NIDropDownDelegate>
{
    NIDropDown * dropDwon;
}
@property (strong,nonatomic)UILabel * labelTiShi;
@property (strong,nonatomic)UILabel * labelFuKuanDanWei;
@property (strong,nonatomic)UILabel * labelFaPiaoLeiXing;
@property (strong,nonatomic)UILabel * labelShouJianRen;
@property (strong,nonatomic)UILabel * labelPhone;
@property (strong,nonatomic)UILabel * labelAdds;
@property (strong,nonatomic)UILabel * labelYouZheng;
@property (strong,nonatomic)UILabel * labelMoney;
@property (strong,nonatomic)UITextField * textFieldFuKuanDanWei;
@property (strong,nonatomic)UITextField * textFieldShouJianRen;
@property (strong,nonatomic)UITextField * textFieldPhone;
@property (strong,nonatomic)UITextField * textFieldAdds;
//@property (nonatomic,strong)UITextField * textFieldMoney;
@property (strong,nonatomic)UILabel * labelMoneyShow;
@property (strong,nonatomic)UITextField * textFieldYouZheng;
@property (strong,nonatomic)UITextField * textFieldFaPiaoLeiXing;

@property (strong,nonatomic)UIButton * btnOk;
@property (strong,nonatomic)UIActivityIndicatorView * activityView;

@property (strong,nonatomic)NSString * strDingDanID;

-(id)initWithStr:(NSString *)str;
-(void)btnPress;
-(void)addButton;
-(void)resignKeyboard;

-(void)rel;

@end
