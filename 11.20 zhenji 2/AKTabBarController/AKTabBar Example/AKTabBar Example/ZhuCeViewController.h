//
//  ZhuCeViewController.h
//  map
//
//  Created by mac on 13-10-8.
//  Copyright (c) 2013年 龙代驾. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AKTabBarController;


@interface ZhuCeViewController : UIViewController<UITextFieldDelegate>
@property (strong,nonatomic)IBOutlet UITextField * textFieldNO;
@property (strong,nonatomic)IBOutlet UITextField * textFieldCheck;
@property (strong,nonatomic)UINavigationController * nav;
@property (nonatomic, strong) AKTabBarController *tabBarController;

@property (strong,nonatomic)UIActivityIndicatorView * activityView;
-(void)resignKeyboard;
-(IBAction)PressBtn:(id)sender;
-(void)Tiao;
@end
