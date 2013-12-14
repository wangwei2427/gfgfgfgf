//
//  MainViewController.m
//  AKTabBar Example
//
//  Created by mac on 13-9-16.
//  Copyright (c) 2013年 Ali Karagoz. All rights reserved.
//

#import "MainViewController.h"
#import "AKTabBarController.h"
#import "SecondViewController.h"
#import "FourthViewController.h"
#import "FiveViewController.h"
#import "OneViewController.h"
#import "AppDelegate.h"
#import "ZhuCeViewController.h"
//#import "FirstMapViewController.h"
#import "Reachability.h"
#import "QuartzCore/QuartzCore.h"
#import "MapMainViewController.h"
#import "SiJiXiangQingViewController.h"
#import "MapAndListVC.h"
@interface MainViewController ()
{
    BOOL wangluo;
    BOOL isZhuce;
    BOOL isConnect;//检测是否有网络
}
-(void)updataXY;
@end

@implementation MainViewController
@synthesize locManager;
@synthesize dicPingJia;
@synthesize dicImage;
@synthesize arrayMain;
@synthesize strZhangHao;
@synthesize main;
@synthesize strLon,strLat;
@synthesize nav;
@synthesize dicHistory;
@synthesize arrayHistory;

@synthesize strISImage,strISPingjia;

static MainViewController * father;
+(MainViewController *)SingleInit
{
    if (father==nil) {
        father=[[MainViewController alloc] init];
        father.dicPingJia=[[NSMutableDictionary alloc]initWithCapacity:20];
        father.dicImage=[[NSMutableDictionary alloc]initWithCapacity:20];
        father.dicHistory=[[NSMutableDictionary alloc]initWithCapacity:20];
        father.arrayHistory=[[NSMutableArray alloc]initWithCapacity:20];
        }
    
    return father;
}

-(void)jianchawangluo
{
    
    if (([Reachability reachabilityForLocalWiFi].currentReachabilityStatus == NotReachable)&&([Reachability reachabilityForInternetConnection].currentReachabilityStatus == NotReachable)) {
        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"网络不可用" message:@"网络连接失败，请检查网络设置" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alert show];
        wangluo=NO;
        NSLog(@"网络连接失败");
        isConnect = 0;
    }
    else {
        wangluo=YES;
        NSLog(@"网络连接正常");
        [self performSelector:@selector(tiao) withObject:nil afterDelay:0.1];
        isConnect = 1;
        self.activityView=[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(110, ([UIScreen mainScreen].bounds.size.height-100)/2+100, 100, 100)];
        [ self.activityView setBackgroundColor:[UIColor clearColor]];
        self.activityView.alpha = 0.6;
        [self.view addSubview:self.activityView];
        [self.activityView startAnimating];
        UILabel *lable = [[UILabel alloc]init];
        lable.frame = CGRectMake(15, 70, 100, 20);
        [self.activityView addSubview:lable];
        lable.text = @"加载中...";
        lable.textColor = [UIColor whiteColor];

            }
    
}

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
	// Do any additional setup after loading the view.
    
    
    NSFileManager * fileManager=[NSFileManager defaultManager];
    NSArray * paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * filename=[paths objectAtIndex:0];
    NSString * filename1=[filename stringByAppendingPathComponent:@"ZhangHao.plist"];

    if ([fileManager fileExistsAtPath:filename1]) {
        isZhuce=YES;
        NSArray * ar=[NSArray arrayWithContentsOfFile:filename1];
        self.strZhangHao=[ar objectAtIndex:0];
        NSLog(@"strzhanghao=%@",self.strZhangHao);
        ar=nil;
       
    }
    else
    {
        isZhuce=NO;
        
    }
    
    
    self.locManager=[[CLLocationManager alloc]init];
    self.locManager.delegate=self;
    [self.locManager startUpdatingLocation];
    if ([UIScreen mainScreen].bounds.size.height==568) {
        NSLog(@"568 ");
        UIImage * image=[UIImage imageNamed:@"loading.jpg"];
        self.view.layer.contents=(id)image.CGImage;
        image=nil;
        
    }
    else
    {
        UIImage * image=[UIImage imageNamed:@"loding.jpg"];
        self.view.layer.contents=(id)image.CGImage;
        image=nil;
    }
    
    [self jianchawangluo];
   
}

-(void)updataXY
{
    NSLog(@"self.arrmain count=%i\n",[self.arrayMain count]);
    //同步加载
    
    if ([self.arrayMain count]==0) {
        NSError * error;
       NSString * str=[NSString stringWithFormat:@"http://fr.eslgw.com/index.php/mobile/river_list?lng=%@&lat=%@", self.strLat,self.strLon];
        NSURLRequest * request=[NSURLRequest requestWithURL:[NSURL URLWithString:str]];
        NSData * response=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        
        if (!response) {
            UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"服务器报错，请稍后再试" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert show];
        }
        else
        {
            self.arrayMain=[NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
            NSLog(@"arr=%@",arrayMain);
        
          //  [self getImage];
            isConnect = 0;
        }
        
    }
}

//-(void)getPingjia
//{
//    
//    for (NSDictionary * ddd in self.arrayMain) {
//        
//        NSString * str=[NSString stringWithFormat:@"http://fr.eslgw.com/index.php/mobile/com_list?daijia=%@",[ddd objectForKey:@"id"]];
//        NSMutableURLRequest * request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:str]];
//        NSOperationQueue * queue=[[NSOperationQueue alloc]init];
//        [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse * response,NSData * data,NSError * error){
//            if (error) {
//                NSLog(@"httperror:%@%d",error.localizedDescription,error.code);
//                response=nil;
//                data=nil;
//                error=nil;
//            }
//            else
//            {
//                NSArray * arr=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
//                response=nil;
//                data=nil;
//                error=nil;
//                if ([arr count]!=0) {
//                    [self.dicPingJia setObject:arr forKey:[ddd objectForKey:@"id"]];
//                    NSLog(@"dicpingjia=%@",self.dicPingJia);
//                }
//                
//                arr=nil;
//                
//                
//            }
//        }];
//        
//        request=nil;
//        str=nil;
//        queue=nil;
//        
//    }
//    
//}

//-(void)getImage
//{
//    for (NSDictionary * dd in self.arrayMain) {
//       NSString * strImage=[NSString stringWithFormat:@"http://fr.eslgw.com/upload/temp/%@",[dd objectForKey:@"img"]];
//        NSURL *url = [NSURL URLWithString:strImage];
//        NSData * dddata=[NSData dataWithContentsOfURL:url];
//        [self.dicImage setObject:dddata forKey:[dd objectForKey:@"id"]];
//        NSLog(@"image\n");
//        strImage=nil;
//        url=nil;
//    }
//    [self getPingjia];
//}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
     [self.locManager stopUpdatingLocation];
    self.strLat=[NSString stringWithFormat:@"%f",manager.location.coordinate.latitude];
    self.strLon=[NSString stringWithFormat:@"%f",manager.location.coordinate.longitude];
    NSLog(@"strlat=%@",self.strLat);
    NSLog(@"strLon=%@",self.strLon);
    if (isConnect == 1) {
        //[self updataXY];
    }
    
    
    
}
-(void)goMap
{
    MapAndListVC *map = [[MapAndListVC alloc]init];
    [self.navigationController pushViewController:map animated:YES];
//    CATransition * animation=[CATransition animation];
//    animation.delegate=self;
//    animation.duration=0.5;
//   // animation.timingFunction=UIViewAnimationCurveEaseInOut;
//
//    animation.type=kCATransitionMoveIn;
// animation.subtype=kCATransitionFromRight;
//    
//    MapMainViewController * mapMain=[MapMainViewController SingleInit];
//    mapMain.isMain = @"1";
//    self.nav=[[UINavigationController alloc]initWithRootViewController:mapMain];
//    // self.nav=[[UINavigationController alloc]initWithRootViewController:mapMain];
//    UIApplication * app=[UIApplication sharedApplication];
//    AppDelegate * appDe=(AppDelegate *)app.delegate;
//    appDe.window.rootViewController=self.nav;
//    
//    [[appDe.window  layer] addAnimation:animation forKey:@"animation"];
//    
//    animation.delegate=nil;
//    animation=nil;
}
-(void)goZhuCe
{
    CATransition * animation=[CATransition animation];
    animation.delegate=self;
    animation.duration=0.5;
    // animation.timingFunction=UIViewAnimationCurveEaseInOut;
    animation.type=kCATransitionMoveIn;
    animation.subtype=kCATransitionFromRight;

    ZhuCeViewController * zhuce=[[ZhuCeViewController alloc]initWithNibName:@"ZhuCeViewController" bundle:nil];//如果注册了 就直接进主页    没注册就跳到注册页面
    UIApplication * app=[UIApplication sharedApplication];
    AppDelegate * dele=(AppDelegate *)app.delegate;
    dele.window.rootViewController=zhuce;
    [[dele.window layer] addAnimation:animation forKey:@"animation"];
    animation.delegate=nil;
    animation=nil;
}

-(void)tiao
{
   
//    NSFileManager * fileManager=[NSFileManager defaultManager];
//    NSArray * paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString * filename=[paths objectAtIndex:0];
//    NSString * filename1=[filename stringByAppendingPathComponent:@"ZhangHao.plist"];
//    NSString * filename2=[filename stringByAppendingPathComponent:@"LinShiZhangHao.plist"];
//    if (![fileManager fileExistsAtPath:filename1]) {
//        // 如果没有帐号 请求一个临时id
//        if (![fileManager fileExistsAtPath:filename2]) {
//            isZhuce=NO;//如果帐号没有
//        }
//        isZhuce=YES;
//        NSArray * ar=[NSArray arrayWithContentsOfFile:filename2];
//        self.strZhangHao=[ar objectAtIndex:0];
//        ar=nil;
//        [self goZhuCe];
//    }
//    else
//    {
//        isZhuce=YES;
//        NSArray * ar=[NSArray arrayWithContentsOfFile:filename1];
//        self.strZhangHao=[ar objectAtIndex:0];
//        //  当解析完成之后再跳 要不然地图上没数据
//        [self performSelector:@selector(goMap) withObject:self afterDelay:1];
//    }
    
    if (isZhuce) {
        [self performSelector:@selector(goMap) withObject:self afterDelay:1];
    }
    else
    {
        [self performSelector:@selector(goMap) withObject:self afterDelay:1];
        //[self goZhuCe];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
