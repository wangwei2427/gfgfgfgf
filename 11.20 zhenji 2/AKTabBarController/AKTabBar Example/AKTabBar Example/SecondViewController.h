//
//  SecondViewController.h
//  AKTabBar Example
//
//  Created by Ali KARAGOZ on 04/05/12.
//  Copyright (c) 2012 Ali Karagoz. All rights reserved.
//

#import "ContentViewController.h"
#import "ShouFeiChangTuViewController.h"
#import "ShouFeiShangWuViewController.h"
#import "ShouFeiJiuHouViewController.h"

@interface SecondViewController : ContentViewController<UIScrollViewDelegate>

@property (strong,nonatomic) UIButton *btnJiu;
@property (strong,nonatomic) UIButton *btnShang;
@property (strong,nonatomic) UIButton *btnChang;

@property (strong,nonatomic) UIView * mainView;

@property (strong,nonatomic) ShouFeiShangWuViewController * shangwuView;
@property (strong,nonatomic) ShouFeiChangTuViewController * changtuView;
@property (strong,nonatomic) ShouFeiJiuHouViewController  * jiuhouView;

@end
