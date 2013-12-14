//
//  SecondViewController.m
//  AKTabBar Example
//
//  Created by Ali KARAGOZ on 04/05/12.
//  Copyright (c) 2012 Ali Karagoz. All rights reserved.
//

#import "SecondViewController.h"
#import "ShouFeiShangWuViewController.h"
#import "ShouFeiChangTuViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

@synthesize btnChang,btnJiu,btnShang;
@synthesize shangwuView;
@synthesize changtuView;
@synthesize jiuhouView;
@synthesize mainView;

- (id)init
{
    self = [super init];
    if (self) {
        self.title = @"收费标准";
        UIImage * bg=[UIImage imageNamed:@"推荐好友.png"];
        //xcode4
        //self.view.layer.contents=(id)bg.CGImage;
        bg=nil;
    }
    return self;
}

- (NSString *)tabImageName
{
	return @"image-2";
}
-(void)btnPress:(id)sender
{
    UIButton * b=sender;
    
    
    switch (b.tag) {
        case 1:
            NSLog(@"1");
            
            self.btnShang.selected=NO;
            self.btnChang.selected=NO;
            self.btnJiu.selected=YES;

            if (self.mainView.subviews) {
                for (UIView * v in self.mainView.subviews) {
                    [v removeFromSuperview];
                }
            }
            [self.mainView addSubview:self.jiuhouView.view];

            break;
        case 2:
            NSLog(@"2");
            
            self.btnJiu.selected=NO;
            self.btnChang.selected=NO;
            self.btnShang.selected=YES;

            if (self.mainView.subviews) {
                for (UIView * v in self.mainView.subviews) {
                    [v removeFromSuperview];
                }
            }
            [self.mainView addSubview:self.shangwuView.view];

            break;
            
        case 3:
            self.btnJiu.selected=NO;
            self.btnShang.selected=NO;
            self.btnChang.selected=YES;

            if (self.mainView.subviews) {
                for (UIView * v in self.mainView.subviews) {
                    [v removeFromSuperview];
                }
            }
            [self.mainView addSubview:self.changtuView.view];
            
            break;
            
        default:
            break;
    }
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    self.btnJiu=[UIButton buttonWithType:UIButtonTypeCustom];
    self.btnJiu.frame=CGRectMake(20, 80, 80, 30);
    self.btnJiu.tag=1;
    UIImage * imageJ1=[UIImage imageNamed:@"酒后.png"];
    UIImage * imageJ2=[UIImage imageNamed:@"酒后1.png"];
    [self.btnJiu setImage:imageJ1 forState:UIControlStateNormal];
    [self.btnJiu setImage:imageJ2 forState:UIControlStateSelected];
    [self.btnJiu addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnJiu];

    
    self.btnShang=[UIButton buttonWithType:UIButtonTypeCustom];
    self.btnShang.frame=CGRectMake(120, 80, 80, 30);
    self.btnShang.tag=2;
    UIImage * imageS1=[UIImage imageNamed:@"商务.png"];
    UIImage * imageS2=[UIImage imageNamed:@"商务1.png"];
    [self.btnShang setImage:imageS1 forState:UIControlStateNormal];
    [self.btnShang setImage:imageS2 forState:UIControlStateSelected];
    [self.btnShang addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnShang];
    
    
    self.btnChang=[UIButton buttonWithType:UIButtonTypeCustom];
    self.btnChang.frame=CGRectMake(220, 80, 80, 30);
    self.btnChang.tag=3;
    UIImage * imageC=[UIImage imageNamed:@"长途.png"];
    UIImage * imageC1=[UIImage imageNamed:@"长途1.png"];
    [self.btnChang setImage:imageC forState:UIControlStateNormal];
    [self.btnChang setImage:imageC1 forState:UIControlStateSelected];
    [self.btnChang addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnChang];



    self.mainView=[[UIView alloc]initWithFrame:CGRectMake(0, 125, 320, [UIScreen mainScreen].bounds.size.height-170)];
    [self.view addSubview:self.mainView];
    
    self.changtuView=[[ShouFeiChangTuViewController alloc]init];
    self.shangwuView=[[ShouFeiShangWuViewController alloc]init];
    self.jiuhouView=[[ShouFeiJiuHouViewController alloc]init];
    

    [self.mainView insertSubview:self.jiuhouView.view atIndex:0];
    
    
    self.btnJiu.selected=YES;
    self.btnShang.selected=NO;
    self.btnChang.selected=NO;
    
}

@end
