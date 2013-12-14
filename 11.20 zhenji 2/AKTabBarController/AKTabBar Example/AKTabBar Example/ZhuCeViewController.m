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
#import "FirstMapViewController.h"
#import "MainViewController.h"


@interface ZhuCeViewController ()

@end

@implementation ZhuCeViewController
@synthesize textFieldCheck;
@synthesize textFieldNO;
@synthesize nav;
@synthesize activityView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(IBAction)PressBtn:(id)sender
{
    UIButton * button=sender;
    switch (button.tag) {
        case 0:
            NSLog(@"yanzhengma");
            [self huoquyanchengma];
       
            break;
        case 1:
            NSLog(@"zhuce");
            [self resignKeyboard];
            [self loading];
            
            break;
        case 2:
            NSLog(@"不注册");
            [self resignKeyboard];
            [self goMap];
            break;
            
        default:
            break;
    }
    button=nil;
}
-(void)huoquyanchengma
{
    NSLog(@"self.textfieldno=%@",self.textFieldNO.text);
    NSString * strN=self.textFieldNO.text;
   
    if ([strN isEqualToString:@""]) {
        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"手机号不能为空" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }
    else{
        [self.activityView startAnimating];
         NSString * str=[NSString stringWithFormat:@"http://fr.eslgw.com/index.php/mobile/register?s=%@",strN];
         NSMutableURLRequest * request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:str]];
         NSOperationQueue * queue=[[NSOperationQueue alloc]init];
    
         [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse * response,NSData * data, NSError * error){
            if (error) {
                [self.activityView stopAnimating];
                 NSLog(@"httperror :%@%d",error.localizedDescription,error.code);
                 UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请求失败,请检查网络稍后再试" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                 [alert show];
                 response=nil;
                 data=nil;
                 error=nil;
            }else{
                [self.activityView stopAnimating];
                 NSLog(@"chenggong");
                 response=nil;
                 data=nil;
                 error=nil;
            }
          }];
    
          request=nil;
          str=nil;
          queue=nil;
    }
    strN=nil;

}
-(void)loading
{
    
    
  //  @property(nonatomic,readonly,retain) NSUUID      *identifierForVendor NS_AVAILABLE_IOS(6_0);      // a UUID
    NSString * stringN=self.textFieldNO.text;
    NSString * stringC=self.textFieldCheck.text;
    
    if ([stringC isEqualToString:@""]||[stringN isEqualToString:@""]) {
        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"手机号和验证码不能为空" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }
    else
    {
        
        [self.activityView startAnimating];
          NSLog(@"name=%@\n,model=%@\n,localizedModel=%@\n,systemName=%@\n,systemVersion=%@\n",[UIDevice currentDevice].name,[UIDevice currentDevice].model,[UIDevice currentDevice].localizedModel,[UIDevice currentDevice].systemName,[UIDevice currentDevice].systemVersion);
          NSLog(@"identifier====%@",[UIDevice currentDevice].identifierForVendor);
          NSString * str=[NSString stringWithFormat:@"http://fr.eslgw.com/index.php/mobile/reg_code?s=%@&code=%@",stringN,stringC];

          NSMutableURLRequest * request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:str]];
          NSOperationQueue * queue=[[NSOperationQueue alloc]init];
    
         [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse * response,NSData * data, NSError * error){
             if (error) {
                 
                 [self.activityView stopAnimating];
                 NSLog(@"httperror :%@%d",error.localizedDescription,error.code);
    
                // alertview  提示出错;
                 UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"注册失败，请稍后再试" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                 [alert show];

            
                  response=nil;
                  data=nil;
                  error=nil;
             }else{
                 [self.activityView stopAnimating];
                  NSDictionary * dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
                  response=nil;
                  data=nil;
                  error=nil;
                 int i=[[dic objectForKey:@"status"] intValue];
                 dic=nil;
                 NSLog(@"i=%i",i);
                 if (i==0) {
                     UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"注册失败,请稍后再试" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                     [alert show];
                 }
                 if(i==1)
                 {
                     MainViewController * main=[MainViewController SingleInit];
                     main.strZhangHao=stringN;
                     
                     NSArray * array=[NSArray arrayWithObjects:stringN, nil];
                  //   NSFileManager * fileManager=[NSFileManager defaultManager];
                     NSArray * paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                     NSString * filename=[paths objectAtIndex:0];
                     NSString * filename1=[filename stringByAppendingPathComponent:@"ZhangHao.plist"];
                     [array writeToFile:filename1 atomically:YES];
                     NSLog(@"filename=%@",filename1);
                     array=nil;
                    // fileManager=nil;
                     paths=nil;
                     filename=nil;
                     filename1=nil;
                     

                     [self goMap];
                 }
                 if (i==2) {
                     UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"此账号已注册" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                     [alert show];
                 }
                 if (i==3) {
                     UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"验证码不正确" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                     [alert show];
                 }
            }
         }];
    
              request=nil;
              str=nil;
              queue=nil;
    
      }

}

-(void)goMap
{
    CATransition * animation=[CATransition animation];
    animation.delegate=self;
    animation.duration=0.5;
    // animation.timingFunction=UIViewAnimationCurveEaseInOut;
    
    animation.type=kCATransitionMoveIn;
    animation.subtype=kCATransitionFromRight;
    
    FirstMapViewController * mapMain=[FirstMapViewController SingleInit];
    MainViewController * main=[MainViewController SingleInit];
    main.nav=[[UINavigationController alloc]initWithRootViewController:mapMain];
   // self.nav=[[UINavigationController alloc]initWithRootViewController:mapMain];
    UIApplication * app=[UIApplication sharedApplication];
    AppDelegate * appDe=(AppDelegate *)app.delegate;
    appDe.window.rootViewController=main.nav;
    
    [[appDe.window layer] addAnimation:animation forKey:@"animation"];
    
}
-(void)Tiao
{
    
    CATransition * animation=[CATransition animation];
    animation.delegate=self;
    animation.duration=0.5;
    
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
    
    [[appDe.window layer] addAnimation:animation forKey:@"animation"];
    
    
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
    
    
}
-(void)resignKeyboard
{
   
        [self.textFieldNO resignFirstResponder];
        [self.textFieldCheck resignFirstResponder];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.textFieldNO becomeFirstResponder];

    
    UIToolbar * topView=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    [topView setBarStyle:UIBarStyleBlack];
    
    UIBarButtonItem * button1=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * button2=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * doneButton=[[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(resignKeyboard)];
    
    NSArray * buttonsArray=[NSArray arrayWithObjects:button1,button2,doneButton, nil];
    [topView setItems:buttonsArray animated:YES];
    [self.textFieldNO setInputAccessoryView:topView];
    [self.textFieldCheck setInputAccessoryView:topView];
    
    buttonsArray=nil;
    button2=nil;
    button1=nil;
    topView=nil;
    self.activityView=[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(110, ([UIScreen mainScreen].bounds.size.height-100)/2, 100, 100)];
    [ self.activityView setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:self.activityView];
    

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
