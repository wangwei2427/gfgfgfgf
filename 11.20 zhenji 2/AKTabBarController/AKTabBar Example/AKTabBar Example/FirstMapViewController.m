//
//  FirstMapViewController.m
//  龙代驾
//
//  Created by mac on 13-10-29.
//  Copyright (c) 2013年 Ali Karagoz. All rights reserved.
//

#import "FirstMapViewController.h"
//#import "MapViewController.h"
#import "ShouyeMapViewController.h"
#import "SiJiLieBiaoViewController.h"
#import "Share/Weixin/SendMsgToWeChatViewController.h"
#import "AKTabBarController.h"
#import "SecondViewController.h"
#import "FourthViewController.h"
#import "FiveViewController.h"
#import "OneViewController.h"
#import "AppDelegate.h"
#import "MainViewController.h"


@interface FirstMapViewController ()
@property (strong,nonatomic)ShouyeMapViewController * map;
@property (strong,nonatomic)SiJiLieBiaoViewController * sijiList;
@end

@implementation FirstMapViewController
@synthesize arrayList;
@synthesize map;
@synthesize sijiList;
@synthesize dicSJList;
@synthesize mainView;
@synthesize btn1,btn2,btn3;
@synthesize tabBarController;
static  FirstMapViewController* father;
+(FirstMapViewController *)SingleInit
{
    
    if (father==nil) {
        
        father=[[FirstMapViewController alloc] init];
        
    }
    return father;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}
-(void)btnPress:(id)sender
{
    UIButton * btn=sender;
    
    
    switch (btn.tag) {
        case 1:
            NSLog(@"1");
            self.btn2.selected=NO;
            self.btn2.enabled=YES;
            
            self.btn1.selected=YES;
            self.btn1.enabled=NO;
            
            [self.view exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
          //  [self.map viewDidAppear:YES];
            
            break;
        case 2:
            NSLog(@"2");
            self.btn1.selected=NO;
            self.btn2.selected=YES;
            self.btn1.enabled=YES;
            self.btn2.enabled=NO;
       
            [self.view exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
           // [self.sijiList viewDidAppear:YES];
           // if (!self.sijiList.arrayList) {
                [self.sijiList performSelector:@selector(updataData) withObject:self afterDelay:1];

           // }
            
            
            break;

        default:
            break;
    }
    btn=nil;
}
-(void)pressItem
{
    
    CATransition * animation=[CATransition animation];
    animation.delegate=self;
    animation.duration=0.3;
    animation.type=kCATransitionMoveIn;
    animation.subtype=kCATransitionFromRight;

    
    self.tabBarController = [[AKTabBarController alloc] initWithTabBarHeight:(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? 70 : 50];
    [self.tabBarController setMinimumHeightToDisplayTitle:40.0];
    OneViewController * oneC=[OneViewController SinSingleInit];
    SecondViewController * secondC=[[SecondViewController alloc] init];
    ThirdViewController * thirdC=[[ThirdViewController alloc] init];
    FourthViewController * fourthC=[[FourthViewController alloc] init];
    FiveViewController * fiveC=[[FiveViewController alloc] init];
    
    UINavigationController *oneNavigationController = [[UINavigationController alloc] initWithRootViewController:oneC];
    UINavigationController *secondNavigationController = [[UINavigationController alloc] initWithRootViewController:secondC];
    UINavigationController *thirdNavigationController = [[UINavigationController alloc] initWithRootViewController:thirdC];
    UINavigationController *fourthNavigationController = [[UINavigationController alloc] initWithRootViewController:fourthC];
    UINavigationController *fiveNavigationController = [[UINavigationController alloc] initWithRootViewController:fiveC];
    // oneNavigationController.navigationBarHidden=YES;
    // navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
    [self.tabBarController setViewControllers:[NSMutableArray arrayWithObjects:
                                               oneNavigationController,secondNavigationController,thirdNavigationController,fourthNavigationController ,fiveNavigationController,nil]];
    

    UIApplication * app=[UIApplication sharedApplication];
    AppDelegate * appDe=(AppDelegate *)app.delegate;
    appDe.window.rootViewController=self.tabBarController;
    
    [[appDe.window layer]addAnimation:animation forKey:@"animation"];
    
    animation.delegate=nil;
    animation=nil;
    
    oneC=nil;
    secondC=nil;
    thirdC=nil;
    fourthC=nil;
    fiveC=nil;
    
    oneNavigationController=nil;
    secondNavigationController=nil;
    thirdNavigationController=nil;
    fourthNavigationController=nil;
    fiveNavigationController=nil;
    
    self.map._mapView.showsUserLocation=NO;
    self.map._mapView.delegate=nil;
    [self.map._mapView removeFromSuperview];
    [self.map.view removeFromSuperview];
    [self.sijiList.view removeFromSuperview];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    UIView * tableview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 123, 30)];
    self.btn1=[UIButton buttonWithType:UIButtonTypeCustom];
    btn1.tag=1;
    self.btn1.frame=CGRectMake(0, 0, 60, 30);
    UIImage * image1=[UIImage imageNamed:@"地图.png"];
    UIImage * image2=[UIImage imageNamed:@"地图1.png"];
    [self.btn1 setImage:image1 forState:UIControlStateNormal];
    [self.btn1 setImage:image2 forState:UIControlStateSelected];
    
    image2=nil;
    image1=nil;
    [self.btn1 addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
    [tableview addSubview:self.btn1];
    
    self.btn2=[UIButton buttonWithType:UIButtonTypeCustom];
    btn2.tag=2;
    self.btn2.frame=CGRectMake(63, 0, 60, 30);
    UIImage * image3=[UIImage imageNamed:@"列表.png"];
    UIImage * image4=[UIImage imageNamed:@"列表1.png"];
    
    [self.btn2 setImage:image3 forState:UIControlStateNormal];
    [self.btn2 setImage:image4 forState:UIControlStateSelected];
    
    image3 =nil;
    image4=nil;
    [self.btn2 addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
    [tableview addSubview:self.btn2];
    
    self.navigationItem.titleView=tableview;
    
    
    UIBarButtonItem * rightBarItem=[[UIBarButtonItem alloc]initWithTitle:@"首页" style:UIBarButtonItemStyleBordered target:self action:@selector(pressItem)];
    self.navigationItem.rightBarButtonItem=rightBarItem;
    
    tableview=nil;
    self.map=[[ShouyeMapViewController alloc]initWithFather:@"2"];
    // self.map._mapView.delegate=self;
    
    [self.view insertSubview:self.map.view atIndex:1];
    
    self.sijiList=[[SiJiLieBiaoViewController alloc]initWithFather:@"2"];
    self.sijiList.arrayList=self.arrayList;
    [self.view insertSubview:self.sijiList.view atIndex:0];
    
    self.btn1.enabled=NO;
    self.btn1.selected=YES;
    
   // self.map._mapView.showsUserLocation=YES;
    NSLog(@"~~~~~~~~~~~~~~");

   // [self performSelector:@selector(getImage) withObject:nil afterDelay:0.1];
	// Do any additional setup after loading the view.
}

-(void)getImage
{
    MainViewController * main=[MainViewController SingleInit];
    for (NSDictionary * dd in main.arrayMain) {
        NSString * strImage=[NSString stringWithFormat:@"http://fr.eslgw.com/upload/temp/%@",[dd objectForKey:@"img"]];
        NSURL *url = [NSURL URLWithString:strImage];
        NSData * dddata=[NSData dataWithContentsOfURL:url];
        [self.dicImage setObject:dddata forKey:[dd objectForKey:@"id"]];
        NSLog(@"image\n");
        strImage=nil;
        url=nil;
    }
   // self.first.dicImage=self.dicImage;
}


-(void)viewWillAppear:(BOOL)animated
{
   self.map._mapView.showsUserLocation=YES;
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
//    [super viewDidDisappear:YES];
//    [self.navigationController popViewControllerAnimated:NO];
    
    self.map._mapView.showsUserLocation=NO;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
