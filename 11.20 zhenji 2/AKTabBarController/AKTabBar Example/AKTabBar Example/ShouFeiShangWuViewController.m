//
//  ShouFeiShangWuViewController.m
//  龙代驾
//
//  Created by mac on 13-10-31.
//  Copyright (c) 2013年 Ali Karagoz. All rights reserved.
//

#import "ShouFeiShangWuViewController.h"

@interface ShouFeiShangWuViewController ()

@end

@implementation ShouFeiShangWuViewController
@synthesize label;

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
    UIImage * bg=[UIImage imageNamed:@"推荐好友.png"];
    //xcode4
    self.view.layer.contents=(id)bg.CGImage;
    bg=nil;
    self.label=[[UILabel alloc]initWithFrame:CGRectMake(20, 50, 280, 100)];
    self.label.numberOfLines=0;
    
    self.label.text=@"起步价75元（包含2小时）超出每小时25元\n按服务时间收费、商务代驾开始时间必须在18:00前或07:00后。";
    self.label.textAlignment=NSTextAlignmentLeft;
    self.label.lineBreakMode=NSLineBreakByWordWrapping;
    [self.view addSubview:self.label];

	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
