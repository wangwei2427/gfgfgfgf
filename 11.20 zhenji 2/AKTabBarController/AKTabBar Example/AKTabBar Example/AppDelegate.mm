//
//  AppDelegate.m
//  AKTabBar Example
//
//  Created by Ali KARAGOZ on 03/05/12.
//  Copyright (c) 2012 Ali Karagoz. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "SinaWeibo.h"
#import "FirstMapViewController.h"
#import "MapAndListVC.h"
#define kAppKey             @"589890824"
#define kAppSecret          @"1fb8e8fad1a47c42a9e1b4e2acd9b527"
#define kAppRedirectURL     @"http://www.sina.com"



@implementation AppDelegate
@synthesize sinaWeibo;
@synthesize thirdViewController;
@synthesize mapManager;
@synthesize dict;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    dict = [[NSDictionary alloc]init];
    //jiqima   [[UIDevice currentDevice]identifierForVendor]];
    //MainViewController * mainController=[MainViewController SingleInit];
    //FirstMapViewController *mainController = [[FirstMapViewController alloc]init];
    MapAndListVC *map = [[MapAndListVC alloc]init];
    map.isMain = @"1";
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:map];
    self.window.rootViewController = nav;

    
    
    mapManager =[[BMKMapManager alloc]init];
    BOOL ret=[mapManager start:@"E0c27a4bd9e81291f7cce79d2e365316" generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }

    // If the device is an iPad, we make it taller.
       
    // Below you will find an example of possible customization, just uncomment the lines
    
    /*
    // Tab background Image
    [_tabBarController setBackgroundImageName:@"noise-dark-gray.png"];
    [_tabBarController setSelectedBackgroundImageName:@"noise-dark-blue.png"];

    // Tabs top embos Color
    [_tabBarController setTabEdgeColor:[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.8]];

    // Tabs Colors settings
    [_tabBarController setTabColors:@[[UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.0],
                                          [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0]]]; // MAX 2 Colors
    
    [_tabBarController setSelectedTabColors:@[[UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1.0],
                                                  [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.0]]]; // MAX 2 Colors

    // Tab Stroke Color
    [_tabBarController setTabStrokeColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0]];

    // Icons Color settings
    [_tabBarController setIconColors:@[[UIColor colorWithRed:174.0/255.0 green:174.0/255.0 blue:174.0/255.0 alpha:1],
                                           [UIColor colorWithRed:228.0/255.0 green:228.0/255.0 blue:228.0/255.0 alpha:1]]]; // MAX 2 Colors
    
    [_tabBarController setSelectedIconColors:@[[UIColor colorWithRed:174.0/255.0 green:174.0/255.0 blue:174.0/255.0 alpha:1],
                                                   [UIColor colorWithRed:228.0/255.0 green:228.0/255.0 blue:228.0/255.0 alpha:1]]]; // MAX 2 Colors
    
    // Text Color
    [_tabBarController setTextColor:[UIColor colorWithRed:157.0/255.0 green:157.0/255.0 blue:157.0/255.0 alpha:1.0]];
    [_tabBarController setSelectedTextColor:[UIColor colorWithRed:228.0/255.0 green:228.0/255.0 blue:228.0/255.0 alpha:1.0]];
    
    // Hide / Show glossy on tab icons
    [_tabBarController setIconGlossyIsHidden:YES];
    */
    
    
    [_window makeKeyAndVisible];
    
    
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeBadge)];

    
    thirdViewController=[[ThirdViewController alloc]init];
    
    sinaWeibo = [[SinaWeibo alloc] initWithAppKey:kAppKey appSecret:kAppSecret appRedirectURI:kAppRedirectURL andDelegate:self.thirdViewController];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *sinaWeiboInfo = [defaults objectForKey:@"SinaWeiboAutoData"];
    
    if ([sinaWeiboInfo objectForKey:@"AccessTokenKey"] && [sinaWeiboInfo objectForKey:@"ExpirationDateKey"] && [sinaWeiboInfo objectForKey:@"UserIDKey"])
    {
        sinaWeibo.accessToken = [sinaWeiboInfo objectForKey:@"AccessTokenKey"];
        
        sinaWeibo.expirationDate = [sinaWeiboInfo objectForKey:@"ExpirationDateKey"];
        
        sinaWeibo.userID = [sinaWeiboInfo objectForKey:@"UserIDKey"];
    }
    

    [WXApi registerApp:@"wx3cb49c43f4fff573"];
    
    

    return YES;
}

-(void) onReq:(BaseReq*)req
{
    if([req isKindOfClass:[GetMessageFromWXReq class]])
    {
        // 微信请求App提供内容， 需要app提供内容后使用sendRsp返回
        NSString *strTitle = [NSString stringWithFormat:@"微信请求App提供内容"];
        NSString *strMsg = @"微信请求App提供内容，App要调用sendResp:GetMessageFromWXResp返回给微信";
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.tag = 1000;
        [alert show];
        
    }
    else if([req isKindOfClass:[ShowMessageFromWXReq class]])
    {
        ShowMessageFromWXReq* temp = (ShowMessageFromWXReq*)req;
        WXMediaMessage *msg = temp.message;
        
        //显示微信传过来的内容
        WXAppExtendObject *obj = msg.mediaObject;
        
        NSString *strTitle = [NSString stringWithFormat:@"微信请求App显示内容"];
        NSString *strMsg = [NSString stringWithFormat:@"标题：%@ \n内容：%@ \n附带信息：%@ \n缩略图:%u bytes\n\n", msg.title, msg.description, obj.extInfo, msg.thumbData.length];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    else if([req isKindOfClass:[LaunchFromWXReq class]])
    {
        //从微信启动App
        NSString *strTitle = [NSString stringWithFormat:@"从微信启动"];
        NSString *strMsg = @"这是从微信启动的消息";
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }
}

-(void) onResp:(BaseResp*)resp
{
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        //  NSString *strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
        //   NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享成功" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }
}

- (void) sendTextContent
{
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.text = @"人文的东西并不是体现在你看得到的方面，它更多的体现在你看不到的那些方面，它会影响每一个功能，这才是最本质的。但是，对这点可能很多人没有思考过，以为人文的东西就是我们搞一个很小清新的图片什么的。”综合来看，人文的东西其实是贯穿整个产品的脉络，或者说是它的灵魂所在。";
    req.bText = YES;
    
    
    [WXApi sendReq:req];
}

-(void) RespTextContent
{
    GetMessageFromWXResp* resp = [[GetMessageFromWXResp alloc] init];
    resp.text = @"人文的东西并不是体现在你看得到的方面，它更多的体现在你看不到的那些方面，它会影响每一个功能，这才是最本质的。但是，对这点可能很多人没有思考过，以为人文的东西就是我们搞一个很小清新的图片什么的。”综合来看，人文的东西其实是贯穿整个产品的脉络，或者说是它的灵魂所在。";
    resp.bText = YES;
    
    [WXApi sendResp:resp];
}


//推送识别码
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSLog(@"My token is: %@",deviceToken);
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSString *error_str = [NSString stringWithFormat: @"%@", error];
    NSLog(@"Failed to get token, error:%@", error_str);
    
}
-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [WXApi handleOpenURL:url delegate:self];
}
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [WXApi handleOpenURL:url delegate:self];
}

@end
