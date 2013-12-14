//
//  FourthViewController.h
//  AKTabBar Example
//
//  Created by Ali KARAGOZ on 04/05/12.
//  Copyright (c) 2012 Ali Karagoz. All rights reserved.
//

#import "ContentViewController.h"

@interface FourthViewController : ContentViewController<UITextViewDelegate,UIAlertViewDelegate>
@property (strong,nonatomic)UIButton * button;
@property (strong,nonatomic)UITextView * textView;
@property (strong,nonatomic)UIActivityIndicatorView * activityView;
-(void)btnPress;
-(void)resignKeyboard;
@end
