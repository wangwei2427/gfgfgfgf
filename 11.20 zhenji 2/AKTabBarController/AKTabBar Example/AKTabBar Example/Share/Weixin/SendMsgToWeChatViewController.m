//
//  ViewController.m
//  ApiClient
//
//  Created by Tencent on 12-2-27.
//  Copyright (c) 2012年 Tencent. All rights reserved.
//

#import "SendMsgToWeChatViewController.h"
#import "AppDelegate.h"

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

#define TIPSLABEL_TAG 10086




@implementation ThirdViewController

@synthesize delegate;
@synthesize m_nsLastText;
@synthesize shareButton;
@synthesize textView;
@synthesize shareView;
@synthesize indicator;
//@synthesize sinaWeibo;

- (SinaWeibo*)sinaWeibo
{
     //AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
     AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    myDelegate.sinaWeibo.delegate=self;
    return myDelegate.sinaWeibo;
   // self.delegate=[sendMsgToWeChatViewDelegate]
   //  delegate.sinaWeibo.delegate = self;
    // return delegate.sinaWeibo;
//    UIApplication* dele=[UIApplication sharedApplication];
//    AppDelegate * appDele=(AppDelegate *)dele.delegate;
//    appDele.sinaWeibo.delegate=self;
//    
//    return appDele.sinaWeibo;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"推荐好友";
    }
    return self;
}

- (NSString *)tabImageName
{
	return @"image-3";
}

-(void) onCancelText
{
    //[self dismissModalViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) onCompleteText:(NSString*)nsText
{
    //    [self dismissViewControllerAnimated:YES completion:nil];
    // //   [self dismissModalViewControllerAnimated:YES];
    //    self.m_nsLastText = nsText;
    //    if (delegate)
    //    {
    //        [delegate sendTextContent:m_nsLastText] ;
    //    }
}

- (void)sendTextContent
{
    SendMessageToWXReq * req=[[SendMessageToWXReq alloc]init];
    req.text=@"欢迎使用龙代驾";
    req.bText=YES;
    //    req.scene=_scene;
    [WXApi sendReq:req];
    
    //    TextViewController* viewController = [[TextViewController alloc] init];
    //    viewController.m_delegate = self;
    //    viewController.m_nsLastText = m_nsLastText;
    //
    //
    //    UINavigationController *navigatitonController = [[UINavigationController alloc]initWithRootViewController:viewController];
    //    [self presentViewController:navigatitonController animated:YES completion:nil];
}
//-(void) RespTextContent
//{
//
//}
-(void)wxShare
{
    if ([WXApi isWXAppInstalled]) {
        if ([WXApi isWXAppSupportApi]) {
            if ([WXApi openWXApp]) {
                [self sendTextContent];
                
                //                AppDelegate * appDele=[[AppDelegate alloc]init];
                //                [appDele sendTextContent];
                
            }
            else
            {
                UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"微信打开失败，请稍后再试" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                [alert show];
                
            }
        }
        else
        {
            UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"微信版本低，请下载最新版本的微信" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert show];
            
        }
    }
    else
    {
        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请先安装微信" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
        
    }
}
//- (void)doOAuth
//{
//    if (delegate)
//    {
//        [delegate doAuth];
//    }
//}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIImage * bg=[UIImage imageNamed:@"推荐好友.png"];
    self.view.layer.contents=(id)bg.CGImage;
    
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage * im=[UIImage imageNamed:@"微信推荐.png"];
    btn.layer.contents=(id)im.CGImage;
    [btn setFrame:CGRectMake(9, 90, 300, 42)];
  //  btn.contentMode=UIViewContentModeScaleAspectFill;
    [btn addTarget:self action:@selector(wxShare) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    m_nsLastText = @"完善的跨终端即时通讯能力，使得Mac可以与PC、手机、Pad等终端的QQ进行无缝沟通，让您的交流更畅快。 完善的跨终端即时通讯能力，使得Mac可以与PC、手机、Pad等终端的QQ进行无缝沟通，让您的交流更畅快。 ";
    
    
    
    
    _indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [_indicator setFrame:CGRectMake(0, 0, 50, 50)];
    _indicator.center = self.view.center;
    [self.view addSubview:_indicator];
    
    [self addButton];
    
    
}
- (void) addButton
{
    self.shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.shareButton setFrame:CGRectMake(10, 141, 300, 40)];
    UIImage * im=[UIImage imageNamed:@"微博推荐.png"];
    self.shareButton.layer.contents=(id)im.CGImage;
    [self.shareButton addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
  //  self.shareButton.contentMode=UIViewContentModeScaleAspectFill;
    [self.view addSubview:self.shareButton];
    
    UIButton * btnDuanxin=[UIButton buttonWithType:UIButtonTypeCustom];
    btnDuanxin.frame=CGRectMake(10, 190, 300, 40) ;
    UIImage * image=[UIImage imageNamed:@"短信推荐.png"];
    [btnDuanxin setImage:image forState:UIControlStateNormal];
    [btnDuanxin addTarget:self action:@selector(duanxinShare) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnDuanxin];
    btnDuanxin=nil;
}
-(void)duanxinShare
{
    Class messageClass=(NSClassFromString(@"MFMessageComposeViewController"));
    if (messageClass !=nil) {
        if ([messageClass canSendText]) {
            [self displaySMSComposerSheet];
        }else
        {
            UIAlertView * alert=[[UIAlertView alloc]initWithTitle:nil message:@"设备不支持短信功能" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    
}
-(void)displaySMSComposerSheet
{
    MFMessageComposeViewController * picker=[[MFMessageComposeViewController alloc]init];
    picker.messageComposeDelegate=self;
    NSString * smsBody=[NSString stringWithFormat:@"快去下载龙代驾，地址是%@",@"www.longdaijia.com"];
    picker.body=smsBody;
    [self presentViewController:picker animated:YES completion:nil];
}
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [controller dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"result==%u",result);

}

- (void) addShareView
{
    _shareView = [[UIView alloc] initWithFrame:CGRectMake(20, 80, 280, 200)];
    //   _shareView.layer.masksToBounds = YES;
    //   _shareView.layer.cornerRadius = 6.0;
    //   _shareView.layer.borderWidth = 1.0;
    _shareView.backgroundColor = [UIColor grayColor];
   
    
    UIButton *quXiaoButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [quXiaoButton setFrame:CGRectMake(5, 5, 60, 30)];
    quXiaoButton.backgroundColor=[UIColor redColor];
    [quXiaoButton setTitle:@"取消" forState:UIControlStateNormal];
    [quXiaoButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [quXiaoButton addTarget:self action:@selector(removeShare:) forControlEvents:UIControlEventTouchUpInside];
    [_shareView addSubview:quXiaoButton];
    
    UIButton *fenXiangButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [fenXiangButton setFrame:CGRectMake(280-65, 5, 60, 30)];
    fenXiangButton.backgroundColor=[UIColor redColor];
    [fenXiangButton setTitle:@"发送" forState:UIControlStateNormal];
    [fenXiangButton addTarget:self action:@selector(sendShare:) forControlEvents:UIControlEventTouchUpInside];
    [fenXiangButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_shareView addSubview:fenXiangButton];
    
    UIButton *tuiChuButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    tuiChuButton.backgroundColor=[UIColor redColor];
    [tuiChuButton setFrame:CGRectMake(100, 165, 100, 30)];
    [tuiChuButton setTitle:@"退出登陆" forState:UIControlStateNormal];
    [tuiChuButton addTarget:self action:@selector(exitShare:) forControlEvents:UIControlEventTouchUpInside];
    [tuiChuButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_shareView addSubview:tuiChuButton];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 5, 100, 30)];
    // label.textAlignment = UITextAlignmentCenter;
    label.text = @"新浪微博";
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:[[UIFont familyNames] objectAtIndex:0] size:20];
    [_shareView addSubview:label];
    
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(5, 40, 270, 120)];
    //_textView.layer.cornerRadius = 6.0;
    
    [self.textView becomeFirstResponder];
    //[_textView setTextAlignment:UITextAlignmentLeft];
    [self.textView setBackgroundColor:[UIColor whiteColor]];
    [self.textView becomeFirstResponder];
    self.textView.keyboardType = UIKeyboardTypeASCIICapable;
    [_shareView addSubview:self.textView];
    
     [self.view addSubview:_shareView];
}

//分享按钮响应方法
- (void) share:(UIButton*) sender
{
    SinaWeibo *sinaWeibo = [self sinaWeibo];
    
    
    BOOL authValid = sinaWeibo.isAuthValid;
    
    if (!authValid)
    {
        [sinaWeibo logIn];
    }
    else
    {
        [self addShareView];
        [_textView becomeFirstResponder];
    }
    
}

//登陆成功后回调方法
- (void) sinaweiboDidLogIn:(SinaWeibo *)sinaweibo
{
    [self addShareView];
    [_textView becomeFirstResponder];
}

//取消按钮回调方法
- (void) removeShare:(UIButton*) sender
{
    [_shareView removeFromSuperview];
}

//发送按钮回调方法
- (void) sendShare:(UIButton*) sender
{
    NSString *postStatusText = self.textView.text;
    NSLog(@"poststatustext=%@",self.textView.text);
    
    SinaWeibo *sinaWeibo = [self sinaWeibo];
    
    [sinaWeibo requestWithURL:@"statuses/updates.json" params:[NSMutableDictionary dictionaryWithObjectsAndKeys:postStatusText,@"status", nil] httpMethod:@"POST" delegate:self];
    
    [_shareView removeFromSuperview];
    
    [self.indicator startAnimating];
}

//退出登陆回调方法
- (void) exitShare:(UIButton*) sender
{
    SinaWeibo *sinaWeibo = [self sinaWeibo];
    
    [sinaWeibo logOut];
    
    [_shareView removeFromSuperview];
    
    NSLog(@"退出登陆");
}

//请求完成回调该方法
- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
    [self.indicator stopAnimating];
    
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"发送成功" message:@"提示" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
    
    NSLog(@"发送成功");
}

//请求失败回调该方法
- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error
{
    [self.indicator stopAnimating];
    
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"发送失败,请检测网络链接" message:@"提示" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
    
    NSLog(@"发送失败");
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.m_nsLastText = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}




@end
