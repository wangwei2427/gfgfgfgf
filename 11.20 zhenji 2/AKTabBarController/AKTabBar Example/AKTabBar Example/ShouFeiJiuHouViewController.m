//
//  ShouFeiJiuHouViewController.m
//  龙代驾
//
//  Created by mac on 13-11-1.
//  Copyright (c) 2013年 Ali Karagoz. All rights reserved.
//

#import "ShouFeiJiuHouViewController.h"

@interface ShouFeiJiuHouViewController ()

@end

@implementation ShouFeiJiuHouViewController
@synthesize btn1;
@synthesize scrollView;
@synthesize textV;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.view.frame=CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height-180);
    
    
    self.scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320,[UIScreen mainScreen].bounds.size.height-175)];
    self.scrollView.delegate=self;
    [self.scrollView setContentSize:CGSizeMake(320, 360)];
    self.scrollView.showsVerticalScrollIndicator=NO;
    
    self.btn1=[UIButton buttonWithType:UIButtonTypeCustom];
    self.btn1.frame=CGRectMake(10, 0, 300, 160);
    UIImage * btnImage=[UIImage imageNamed:@"收费.png"];
    //xcode4
    self.btn1.layer.contents=(id)btnImage.CGImage;
    self.btn1.enabled=NO;
    [self.scrollView addSubview:self.btn1];
  
    
    self.textV=[[UITextView alloc]initWithFrame:CGRectMake(10, 170, 300, 190)];
    self.textV.scrollEnabled=NO;
    self.textV.editable=NO;
    self.textV.backgroundColor=[UIColor clearColor];
    self.textV.text=@"特别提示：代驾里程10公里内，按起步价收取代驾费。\n1、起步价以预约出发时间段为准收取，默认最短约定时间为客户呼叫时间延后15分钟。\n2、总里程超出10公里，超出部分每10公里收取20元，尾数不足10公里部分按20元收取。\n3、等候时间计算以约定出发时间开始，若司机在约定出发时间之后到达，以司机到达时间为准，开始计算等候时间。不足30分钟不收取等候费，每满30分钟收取20元。\n4、预约出发时间前10分钟以上取消预约免收消单返程费。（消单返程费20元）若产生等候费则按等候费标准收取消单返程费。";
    [self.scrollView addSubview:self.textV];
    [self.view addSubview:self.scrollView];
    self.scrollView=nil;

	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
