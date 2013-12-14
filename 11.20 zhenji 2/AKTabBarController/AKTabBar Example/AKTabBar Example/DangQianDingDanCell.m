//
//  DangQianDingDanCell.m
//  龙代驾
//
//  Created by mac on 13-10-22.
//  Copyright (c) 2013年 Ali Karagoz. All rights reserved.
//

#import "DangQianDingDanCell.h"
#import "DingDanXiangQingViewController.h"
#import "DangQianDingDanViewController.h"

@implementation DangQianDingDanCell
@synthesize imageP;
@synthesize imagePic;
@synthesize imageX;
@synthesize imageXj;
@synthesize labelTime,labelChuFaDi,labelName;
@synthesize btnPhone;
@synthesize strPhone;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex==1) {
        //shangchuan
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.strPhone]];
        
    }
}
    
-(IBAction)btnPress:(id)sender
{
    NSLog(@"phone=%@", self.strPhone);
    UIAlertView * alert=[[UIAlertView alloc]initWithTitle:nil message:@"确定拨打电话吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
