//
//  ViewController.h
//  ApiClient
//
//  Created by Tencent on 12-2-27.
//  Copyright (c) 2012年 Tencent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextViewController.h"
#import "WXApiObject.h"
#import "WXApi.h"
#import "ContentViewController.h"
#import "SinaWeibo.h"
#import "SinaWeiboRequest.h"
#import "MessageUI/MessageUI.h"




@protocol sendMsgToWeChatViewDelegate <NSObject>
//- (void) sendTextContent:(NSString*)nsText;
//- (void) doAuth;
- (void) sendTextContent;
//-(void) RespTextContent;
@end


@interface ThirdViewController : ContentViewController < TextViewControllerDelegate,SinaWeiboDelegate,SinaWeiboRequestDelegate,MFMessageComposeViewControllerDelegate>
{
    
    
    UIButton *_shareButton;
    UITextView *_textView;
    UIView *_shareView;
    UIActivityIndicatorView *_indicator;
    NSString* m_nsLastText;
}

@property (nonatomic, strong) id<sendMsgToWeChatViewDelegate> delegate;
@property (nonatomic, retain) NSString* m_nsLastText;
@property (readonly, nonatomic) SinaWeibo *sinaWeibo;
@property (strong, nonatomic) UIButton *shareButton;
@property (strong, nonatomic) UITextView *textView;
@property (strong, nonatomic) UIView *shareView;
@property (strong, nonatomic) UIActivityIndicatorView *indicator;

- (void) addButton;
- (void) addShareView;
- (void) share:(UIButton*) sender;
- (void) removeShare:(UIButton*) sender;
- (void) sendShare:(UIButton*) sender;
- (void) exitShare:(UIButton*) sender;
@end
