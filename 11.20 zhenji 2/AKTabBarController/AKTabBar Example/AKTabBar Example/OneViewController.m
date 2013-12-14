//
//  OneViewController.m
//  龙代驾
//
//  Created by mac on 13-9-26.
//  Copyright (c) 2013年 Ali Karagoz. All rights reserved.
//

#import "OneViewController.h"

#import "MapMainViewController.h"
#import "ZhuCeViewController.h"
#import "XiTongXiaoXiViewController.h"
#import "GeRenViewController.h"
#import "DangQianDingDanViewController.h"
#import "MapAndListVC.h"
//#import "LCVoice.h"
#import "MainViewController.h"

@interface OneViewController ()
{
    BOOL luyining;

    MainViewController * main;
    GeRenViewController * GeRenView;
    XiTongXiaoXiViewController * XiTongView;
    DangQianDingDanViewController* DangQianView;
    MapAndListVC * mapMainView;
}
//@property (strong,nonatomic)LCVoice * voice;
@end

@implementation OneViewController
//@synthesize voice;
@synthesize imageV;

@synthesize btnZhuCe;
@synthesize btn1;
@synthesize btn2;
@synthesize btn3;
@synthesize btn4;

static OneViewController * one;

+(OneViewController *)SinSingleInit
{
    if (one==nil) {
        one=[[OneViewController alloc]init];
    }
    return one;

}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"首页";
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImage * bg =[UIImage imageNamed:@"主页.jpg"];
    self.view.layer.contents=(id)bg.CGImage;
    
    self.imageV.userInteractionEnabled=YES;
    [self.imageV touchesBegan:nil withEvent:nil];
    

    GeRenView=[[GeRenViewController alloc]init];
    XiTongView=[[XiTongXiaoXiViewController alloc]initWithStyle:UITableViewStylePlain];
    DangQianView=[[DangQianDingDanViewController alloc]init];
    mapMainView=[[MapAndListVC alloc]init];
    
    main=[MainViewController SingleInit];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)btnPress:(UIButton *)btn;
{
    
    NSLog(@"press %i button",btn.tag);
    

    
    switch (btn.tag) {
        case 1:
            
            [self.navigationController pushViewController:mapMainView animated:YES];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"hideTabbar" object:nil];
            self.navigationController.navigationBarHidden=NO;
            break;
        case 2:
            if (!main.strZhangHao) {
                UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"首次使用请输入您的电话号码" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                alert.alertViewStyle=UIAlertViewStylePlainTextInput;
                [alert show];
            }
            else
            {
                [self.navigationController pushViewController:DangQianView animated:YES];
                 self.navigationController.navigationBarHidden=NO;
            }
            break;
        case 3:

            if (!main.strZhangHao) {
                NSLog(@"main.strzhanghao=%@",main.strZhangHao);
                UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"首次使用请输入您的电话号码" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                alert.alertViewStyle=UIAlertViewStylePlainTextInput;
                [alert show];
            }
            else
            {

            [self.navigationController pushViewController:GeRenView animated:YES];
            self.navigationController.navigationBarHidden=NO;
            }
            break;
        case 4:
            [self.navigationController pushViewController:XiTongView animated:YES];
            self.navigationController.navigationBarHidden=NO;
            
            
            break;
            
        default:
            break;
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{

    
    
    
    if (buttonIndex==1) {
        
        UITextField * textF=[alertView textFieldAtIndex:0];
        NSLog(@"textf.text=%@",textF.text);
        if (textF.text.length>0) {
            NSArray * paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString * filename=[paths objectAtIndex:0];
            NSString * filename1=[filename stringByAppendingPathComponent:@"ZhangHao.plist"];
            NSLog(@"filename1=%@",filename1);
            
            NSString * str11=[NSString stringWithFormat:@"http://fr.eslgw.com/index.php/mobile/phone?p=%@",textF.text];
            
            NSError * error;
            NSURLRequest * request=[NSURLRequest requestWithURL:[NSURL URLWithString:str11]];
            NSData * response=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
            if (response) {
                NSArray * arr=[[NSArray alloc]initWithObjects:textF.text, nil];
                [arr writeToFile:filename1 atomically:YES];
                arr=nil;
                UIAlertView * alert=[[UIAlertView alloc]initWithTitle:nil message:@"注册成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                        [alert show];
                
                main=[MainViewController SingleInit];
                main.strZhangHao=textF.text;
            }

         }
        else
        {
            UIAlertView * alert=[[UIAlertView alloc]initWithTitle:nil message:@"请输入电话号码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }

    }
//    else
//    {
//  
//    }

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"appearTabbar" object:nil];
    self.navigationController.navigationBarHidden=YES;
}

- (NSString *)tabImageName
{
	return @"image-1";
}

- (NSString *)tabTitle
{
	return self.title;
}
- (void)customMKMapViewDidSelectedWithInfo:(id)info
{
    NSLog(@"%@",info);
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}



@end
