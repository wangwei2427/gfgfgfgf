//
//  FuWuPingJiaViewController.h
//  龙代驾
//
//  Created by mac on 13-10-18.
//  Copyright (c) 2013年 Ali Karagoz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FuWuPingJiaViewController : UIViewController<UITextViewDelegate>
@property (strong,nonatomic)UILabel * textLabel;
@property (strong,nonatomic)UIImageView * imageView1;
@property (strong,nonatomic)UIImageView * imageView2;
@property (strong,nonatomic)UIImageView * imageView3;
@property (strong,nonatomic)UIImageView * imageView4;
@property (strong,nonatomic)UIImageView * imageView5;
@property (strong,nonatomic)UIButton * button1;
@property (strong,nonatomic)UIButton * button2;
@property (strong,nonatomic)UIButton * button3;
@property (strong,nonatomic)UIButton * button4;
@property (strong,nonatomic)UIButton * button5;
@property (strong,nonatomic)UIButton * button6;
@property (strong,nonatomic)UITextView * textV;

@property (strong,nonatomic)NSDictionary * dicList;
@property (strong,nonatomic)UIActivityIndicatorView * activityView;

-(id)initWithDic:(NSDictionary * )dic;

-(void)btnPress:(id)sender;
-(void)addBtn;
@end
