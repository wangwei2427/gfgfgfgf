//
//  ZhuCeViewController.m
//  map
//
//  Created by mac on 13-10-8.
//  Copyright (c) 2013年 龙代驾. All rights reserved.
//

#import "ZhuCeViewController.h"
#import "Share/Weixin/SendMsgToWeChatViewController.h"

#import "AKTabBarController.h"
#import "SecondViewController.h"
#import "FourthViewController.h"
#import "FiveViewController.h"
#import "OneViewController.h"
#import "AppDelegate.h"


@interface ZhuCeViewController ()

@end

@implementation ZhuCeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)Tiao
{
    
    
    self.tabBarController = [[AKTabBarController alloc] initWithTabBarHeight:(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? 70 : 50];
    [self.tabBarController setMinimumHeightToDisplayTitle:40.0];
    OneViewController * oneC=[[OneViewController alloc]init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:oneC];
    // navigationController.navigationBarHidden=YES;
    // navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
    [self.tabBarController setViewControllers:[NSMutableArray arrayWithObjects:
                                               navigationController,
                                               [[SecondViewController alloc] init],
                                               [[ThirdViewController alloc] init],
                                               [[FourthViewController alloc] init],[[FiveViewController alloc] init],nil]];
    
    
    UIApplication * app=[UIApplication sharedApplication];
    AppDelegate * appDe=app.delegate;
    appDe.window.rootViewController=self.tabBarController;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
