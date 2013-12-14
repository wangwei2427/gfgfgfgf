//
//  NIDropDown.m
//  龙代驾
//
//  Created by mac on 13-10-19.
//  Copyright (c) 2013年 Ali Karagoz. All rights reserved.
//
#import <UIKit/UIKit.h>

@class NIDropDown;
@protocol NIDropDownDelegate
- (void) niDropDownDelegateMethod: (NIDropDown *) sender;
-(void)DropDownDelegateMethod:(NSString * )str;
@end 

@interface NIDropDown : UIView

@property (nonatomic, retain) id <NIDropDownDelegate> delegate;
@property (strong,nonatomic)UIButton * btn1;
@property (strong,nonatomic)UIButton * btn2;
//@property (strong,nonatomic)UIButton * btn3;

-(void)hideDropDown;
-(id)initWithButton:(UIButton *)b;
-(void)btnPress:(UIButton *)sender;
@end
