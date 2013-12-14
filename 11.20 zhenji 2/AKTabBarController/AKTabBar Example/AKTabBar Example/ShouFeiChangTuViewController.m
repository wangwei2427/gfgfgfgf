//
//  ShouFeiChangTuViewController.m
//  龙代驾
//
//  Created by mac on 13-10-31.
//  Copyright (c) 2013年 Ali Karagoz. All rights reserved.
//

#import "ShouFeiChangTuViewController.h"

@interface ShouFeiChangTuViewController ()

@end

@implementation ShouFeiChangTuViewController


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
    self.label=[[UILabel alloc]initWithFrame:CGRectMake(20, 50, 280, 120)];
    self.label.numberOfLines=0;
    self.label.text=@"1.往返每公里1元\n2.单程每公里1.2元(包含司机返程路费)\n以上收费标准不含过桥、过路费、加油费及司机食宿";
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
