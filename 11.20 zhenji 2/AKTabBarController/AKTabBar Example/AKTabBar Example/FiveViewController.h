//
//  FiveViewController.h
//  龙代驾
//
//  Created by mac on 13-10-12.
//  Copyright (c) 2013年 Ali Karagoz. All rights reserved.
//

#import "ContentViewController.h"

@interface FiveViewController : ContentViewController
@property (strong,nonatomic)IBOutlet UIButton * btn1;
@property (strong,nonatomic)IBOutlet UIButton * btn2;
@property (strong,nonatomic)IBOutlet UIButton * btn3;

@property (strong,nonatomic) NSString * str;

-(IBAction)btnPress:(id)sender;
-(void)jianchawangluo;
@end
