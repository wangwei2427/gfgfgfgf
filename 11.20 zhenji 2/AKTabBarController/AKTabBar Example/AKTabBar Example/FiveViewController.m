//
//  FiveViewController.m
//  龙代驾
//
//  Created by mac on 13-10-12.
//  Copyright (c) 2013年 Ali Karagoz. All rights reserved.
//

#import "FiveViewController.h"
#import "DaiJiaXieYiViewController.h"
#import "Reachability.h"



@interface FiveViewController ()
{
    DaiJiaXieYiViewController * daijia;
}

@end

@implementation FiveViewController
@synthesize btn1,btn2,btn3;
@synthesize str;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title=@"更多";
        self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"推荐好友.png"]];
    }
    return self;
}
- (NSString *)tabImageName
{
	return @"image-5";
}
-(IBAction)btnPress:(id)sender
{
    UIButton * button=sender;
    if (button.tag==3) {
        daijia=[[DaiJiaXieYiViewController alloc]initWithNibName:@"DaiJiaXieYiViewController" bundle:nil];

    }
 
  
    switch (button.tag) {
        case 1:
            NSLog(@"客服电话");
            [self alert];
            break;
        case 2:
            NSLog(@"当前版本");
            [self version];
            break;
        case 3:
            NSLog(@"代驾协议");
            [self.navigationController pushViewController:daijia animated:YES];
            break;
        default:
            break;
    }
}
-(void)version
{
    UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"您当前使用的版本是V1.01" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
   
    [alert show];
}
-(void)alert
{
    UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"您确定要呼叫客服吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = 1;
    [alert show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 1) {
        if (buttonIndex == 1) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://4006050112"]];
        }
    }
    else {
        if (buttonIndex==1) {
            UIApplication * application=[UIApplication sharedApplication];
            [application openURL:[NSURL URLWithString:self.str]];
        }

    }
    
}

//-(void)JianCeBanBen
//{
//    
//    [self jianchawangluo];
//    
//    if (wangluo==NO) {
//        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"网络不可用" message:@"无法与服务器通讯，请检查网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [alert show];
//        alert=nil;
//        
//    }
//    else {
//        
//        NSLog(@"网络连接正常");
//        NSURL *url=[NSURL URLWithString:@"http://itunes.apple.com/lookup?id=280444950@qq.com"];
//        NSError *error=nil;
//        NSString *jsonString=[NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
//        SBJsonParser * parser=[[SBJsonParser alloc]init];
//        
//        NSDictionary *rootDic=[parser objectWithString:jsonString];
//        NSArray * infoArray=[rootDic objectForKey:@"results"];
//        NSDictionary * relesaseInfo=[infoArray objectAtIndex:0];
//        NSString *latestVersion=[relesaseInfo objectForKey:@"version"];
//        NSLog(@"latestversion=%@",latestVersion);
//        self.str=[relesaseInfo objectForKey:@"trackViewUrl"];
//        
//        
//        
//        //获取当前版本信息
//        NSString *version=[NSString stringWithFormat:@"%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
//        NSString *Build=[NSString stringWithFormat:@"%@",[[NSBundle mainBundle]  objectForInfoDictionaryKey:@"CFBundleVersion"]];
//        
//        NSLog(@"version    %@,   Build    %@",version,Build);
//        //检查版本信息
//        if (![version isEqualToString:latestVersion]) {
//            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否更新版本？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//            [alert show];
//            alert=nil;
//            
//        }
//
//    
//
//}
-(void)jianchawangluo
{
//    if (([Reachability reachabilityForLocalWiFi].currentReachabilityStatus == NotReachable)&&([Reachability reachabilityForInternetConnection].currentReachabilityStatus == NotReachable)) {
//        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"网络不可用" message:@"无法与服务器通讯，请检查网络" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        
//        [alert show];
//        alert=nil;
//        wangluo=NO;
//        
//        
//    }
//    else {
//        wangluo=YES;
//    }
//    
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
