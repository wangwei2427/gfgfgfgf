//
//  FourthViewController.m
//  AKTabBar Example
//
//  Created by Ali KARAGOZ on 04/05/12.
//  Copyright (c) 2012 Ali Karagoz. All rights reserved.
//

#import "FourthViewController.h"
#import "MainViewController.h"

@interface FourthViewController ()

@end

@implementation FourthViewController
@synthesize textView;
@synthesize button;
@synthesize activityView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"意见反馈";
    }
    return self;
}

- (NSString *)tabImageName
{
	return @"image-4";
}
-(void)btnPress
{
    MainViewController * main=[MainViewController SingleInit];
    NSLog(@"btn press......%@",self.textView.text);
    if ([self.textView.text isEqualToString:@""]) {
        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:nil message:@"请输入您的建议，谢谢" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
    self.activityView=[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(110, ([UIScreen mainScreen].bounds.size.height-100)/2, 100, 100)];
    [ self.activityView setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:self.activityView];
    [self.activityView startAnimating];
//cuid 是客户帐号，如果没有登录，就上传空
    NSString * str=[NSString stringWithFormat:@"http://fr.eslgw.com/index.php/mobile/word?cuid=%@&c=%@",main.strZhangHao,self.textView.text];
   
    NSMutableURLRequest * request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:str]];
    NSOperationQueue * queue=[[NSOperationQueue alloc]init];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse * response,NSData * data, NSError * error){
        if (error) {
            NSLog(@"httperror :%@%d",error.localizedDescription,error.code);

            [self.activityView stopAnimating];
            UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"提交失败,请重新提交" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert show];
            response=nil;
            data=nil;
            error=nil;
        }else{
            [self.activityView stopAnimating];
            UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"提交成功" delegate:self cancelButtonTitle:@"谢谢" otherButtonTitles:nil, nil];
            [alert show];
            response=nil;
            data=nil;
            error=nil;
            
        }
    }];
    
    request=nil;
    str=nil;
    queue=nil;
    }
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImage * image=[UIImage imageNamed:@"推荐好友.png"];
    
    self.view.backgroundColor=[UIColor colorWithPatternImage:image];
    image=nil;
    
    
    UITextView * textV =[[UITextView alloc]initWithFrame:CGRectMake(5, 80, 310, 200)];
    textV.delegate=self;
    textV.font=[UIFont systemFontOfSize:14];
    textV.scrollEnabled=NO;
    textV.editable=YES;

    textV.layer.borderColor=[UIColor grayColor].CGColor;
    textV.layer.cornerRadius=5.0;

    
    self.button=[UIButton buttonWithType:UIButtonTypeCustom];
    self.button.frame=CGRectMake(220, 300, 80, 35);
    UIImage * btnImage=[UIImage imageNamed:@"提交.png"];
    self.button.layer.contents=(id)btnImage.CGImage;
    [self.button addTarget:self action:@selector(btnPress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button];
    
    
    UITextView * tView=[[UITextView alloc]initWithFrame:CGRectMake(10, 80, 300, 200)];
    tView.delegate=self;
    tView.layer.borderColor=[UIColor grayColor].CGColor;
    tView.layer.cornerRadius=5.0;
    self.textView=tView;
    [self.view addSubview:self.textView];
    
    
    
    
    UIToolbar * topView=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    [topView setBarStyle:UIBarStyleBlack];
    
    UIBarButtonItem * button1=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * button2=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * doneButton=[[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(resignKeyboard)];
    
    NSArray * buttonsArray=[NSArray arrayWithObjects:button1,button2,doneButton, nil];
    [topView setItems:buttonsArray animated:YES];
    [self.textView setInputAccessoryView:topView];
    
    
    self.button=nil;
    topView=nil;
    button1=nil;
    button2=nil;
    doneButton=nil;
    buttonsArray=nil;
    
}
-(void)resignKeyboard
{
    [self.textView resignFirstResponder];
}

@end
