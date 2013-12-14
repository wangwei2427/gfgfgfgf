//
//  SiJiLieBiaoCell.m
//  龙代驾
//
//  Created by mac on 13-10-25.
//  Copyright (c) 2013年 Ali Karagoz. All rights reserved.
//

#import "SiJiLieBiaoCell.h"
#import "MainViewController.h"

@implementation SiJiLieBiaoCell
@synthesize imageX,imageP;
@synthesize imagePic,imageXj;
@synthesize labelAdds,labelKM,labelName,labelNo,labelState,labelYear;
@synthesize btnPhone;
@synthesize strPhone,strXJ;
@synthesize imagePhone;
//@synthesize strAdds,strName,strNo,strState,strYear,strXJ;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
-(IBAction)btnPress:(id)sender
{
    if ([self.labelState.text isEqualToString:@"忙碌"]) {
        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"司机正在忙碌，请空闲是在拨" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];

        [alert show];
    }
    else
    {
//        MainViewController * father=[MainViewController SingleInit];
//        if ([father.strZhangHao isEqualToString:@""])  {
//            UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"请输入您的电话" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            alert.alertViewStyle=UIAlertViewStylePlainTextInput;
//            [alert show];
//            
//        }
//        else
//        {
            [self callPhone];
 //       }

    }
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UITextField * textF=[alertView textFieldAtIndex:0];
    NSLog(@"textF=%@",textF.text);
    
    
    
    NSFileManager * fileManager=[NSFileManager defaultManager];
    NSArray * paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * filename=[paths objectAtIndex:0];
    NSString * filename1=[filename stringByAppendingPathComponent:@"ZhangHao.plist"];
    NSString * filename2=[filename stringByAppendingPathComponent:@"LinShiZhangHao.plist"];
    
    
    NSString * str11=[NSString stringWithFormat:@"http://fr.eslgw.com/index.php/mobile/cellphone?phone=%@&lat=39.908452&lng=116.4504792",textF.text];
    
    NSMutableURLRequest * request11=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:str11]];
    NSOperationQueue * queue1=[[NSOperationQueue alloc]init];
    [NSURLConnection sendAsynchronousRequest:request11 queue:queue1 completionHandler:^(NSURLResponse * response,NSData * data,NSError * error){
        if (error) {
            NSLog(@"httperror :%@%d",error.localizedDescription,error.code);
            // alertview  提示出错;
            response=nil;
            data=nil;
            error=nil;
        }else{
            
            
            if (![fileManager fileExistsAtPath:filename1]) {
                // 如果没有帐号 请求一个临时id  把电话号当临时id
                if (![fileManager fileExistsAtPath:filename2]) {
                    //请求临时id
                    NSArray * arr=[[NSArray alloc]initWithObjects:textF.text, nil];
                    [arr writeToFile:filename2 atomically:YES];
                    arr=nil;
                    NSLog(@"filename2=%@",filename2);
                }
            }
            

        }
    }];

    
    [self callPhone];
}

-(void)callPhone
{
 [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.strPhone]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
