//
//  DingDanXiangQingViewController.h
//  龙代驾
//
//  Created by mac on 13-10-21.
//  Copyright (c) 2013年 Ali Karagoz. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BMapKit.h"

@protocol MapViewControllerDidSelectDelegate;

@interface DingDanXiangQingViewController : UIViewController<BMKMapViewDelegate,BMKSearchDelegate>
{
    BMKMapView* _historyMap;
    BMKSearch* _search;
}


@property (strong,nonatomic)UIImageView * imageV;
@property (strong,nonatomic)UIImageView *imageBg;
@property (strong,nonatomic)UIImageView * imageJiBie;
@property (strong,nonatomic)UIImage * imagePic;

@property (strong,nonatomic)UIButton * btnPhone;
@property (strong,nonatomic)UIButton * btnGo;
@property (strong,nonatomic)UIButton * btnFaPiao;
@property (strong,nonatomic)UIButton * btnPingJia;
@property (strong,nonatomic)UIButton * btnNext;

@property (strong,nonatomic)UILabel * labelName;
@property (strong,nonatomic)UILabel * labelYuYue;
@property (strong,nonatomic)UILabel * labelShiJian;
@property (strong,nonatomic)UILabel * labelChuFaDi;
@property (strong,nonatomic)UILabel * labelAdds;
@property (strong,nonatomic)UILabel * labelDingDanHao;
@property (strong,nonatomic)UILabel * labelDingDanHaoMa;
@property (strong,nonatomic)UILabel * labelDingDanZhuangTai;
@property (strong,nonatomic)UILabel * labelZhuangTai;
@property (strong,nonatomic)UILabel * labelMuDiDi;
@property (strong,nonatomic)UILabel * labelZhongDian;
@property (strong,nonatomic)UILabel * labelHuJiaoShiJian;
@property (strong,nonatomic)UILabel * labelHJTime;
@property (strong,nonatomic)UILabel * labelChuFaShiJian;
@property (strong,nonatomic)UILabel * labelChuFaTime;
@property (strong,nonatomic)UILabel * labelXingShi;
@property (strong,nonatomic)UILabel * labelKM;
@property (strong,nonatomic)UILabel * labelQiBuJia;
@property (strong,nonatomic)UILabel * labelQiBuJiaGe;
@property (strong,nonatomic)UILabel * labelDengHou;
@property (strong,nonatomic)UILabel * labelDengHouFei;
@property (strong,nonatomic)UILabel * labelYingShouJinE;
@property (strong,nonatomic)UILabel * labelYSJinE;
@property (strong,nonatomic)UILabel * labelYouHui;
@property (strong,nonatomic)UILabel * labelYouHuiJinE;
@property (strong,nonatomic)UILabel * labelFaPiao;
@property (strong,nonatomic)UILabel * labelFaPiaoKaiJv;
@property (strong,nonatomic)UILabel * labelShiFuJinE;
@property (strong,nonatomic)UILabel * labelShiFuMoney;
@property (strong,nonatomic)UILabel * labelLiChengMoney;
@property (strong,nonatomic)UILabel * labelYouHuiMoney;
@property (strong,nonatomic)UILabel * labelFaPiaoYouZi;

@property (strong,nonatomic)UILabel * labelLCMoney;
@property (strong,nonatomic)UILabel * labelFPYouzi;
@property (strong,nonatomic)UILabel * labelYHMoney;

@property (strong,nonatomic)NSDictionary * dicList;
@property (strong,nonatomic)NSArray * arrSJ;

@property (nonatomic, strong) NSMutableData *data;

@property (strong,nonatomic)UIActivityIndicatorView * activityView;

-(id)initWithDic:(NSDictionary *)dic;
-(void)btnPress:(id)sender;
-(void)addButton;

@end
