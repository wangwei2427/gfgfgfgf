//
//  GeRenInfoViewController.m
//  龙代驾
//
//  Created by mac on 13-11-6.
//  Copyright (c) 2013年 Ali Karagoz. All rights reserved.
//

#import "GeRenInfoViewController.h"
#import "MainViewController.h"
#define w 60
#define h 30
@interface GeRenInfoViewController ()

@end

@implementation GeRenInfoViewController
{
    NSString *sex;
    BOOL isSaved;
}
@synthesize labelDanWei,labelName,labelNan,labelNv,labelPhone,labelQQ,labelShenfenZheng,labelYouxiang,labelZhuye,labelXB;
@synthesize textFieldDanwei,textFieldName,textFieldPhone,textFieldQQ,textFieldShenfenzheng,textFieldYouxiang,textFieldZhuye;
@synthesize btnSave,btnNan,btnNv;

@synthesize actView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)changeBtn:(id)sender
{
    UIButton * btn=sender;
    switch (btn.tag) {
        case 1:
            self.btnNan.selected=YES;
            self.btnNv.selected=NO;
            sex = @"1";
            break;
        case 2:
            self.btnNv.selected=YES;
            self.btnNan.selected=NO;
            sex = @"2";
            break;
        default:
            break;
    }
    NSLog(@"nan nan nan ");
}
-(void)addButton
{
//    self.labelDanWei=[[UILabel alloc]initWithFrame:CGRectMake(30, 100, w, h)];
//    self.labelDanWei.text=@"单    位:";
//    [self.view addSubview:self.labelDanWei];
//    self.labelDanWei=nil;
    
    self.labelName=[[UILabel alloc]initWithFrame:CGRectMake(30, 100, w,h)];
    self.labelName.text=@"姓    名:";
    [self.view addSubview:self.labelName];
    self.labelName=nil;
    
//    self.labelPhone=[[UILabel alloc]initWithFrame:CGRectMake(30, 180, w , h)];
//    self.labelPhone.text=@"电    话:";
//    [self.view addSubview:self.labelPhone];
//    self.labelPhone=nil;
    
    self.labelShenfenZheng=[[UILabel alloc]initWithFrame:CGRectMake(30, 220, w , h )];
    self.labelShenfenZheng.text=@"身份证:";
    [self.view addSubview:self.labelShenfenZheng];
    self.labelShenfenZheng=nil;
    
    self.labelQQ=[[UILabel alloc]initWithFrame:CGRectMake(30, 260, w, h)];
    self.labelQQ.text=@"Q     Q:";
    [self.view addSubview:self.labelQQ];
    self.labelQQ=nil;
    
    self.labelYouxiang=[[UILabel alloc]initWithFrame:CGRectMake(30, 300, w,h)];
    self.labelYouxiang.text=@"邮    箱:";
    [self.view addSubview:self.labelYouxiang];
    self.labelYouxiang=nil;
    
    self.labelZhuye=[[UILabel alloc]initWithFrame:CGRectMake(30, 180, w , h)];
    self.labelZhuye.text=@"主    页:";
    [self.view addSubview:self.labelZhuye];
    self.labelZhuye=nil;
    
    self.labelXB=[[UILabel alloc]initWithFrame:CGRectMake(30, 140, 60, h)];
    self.labelXB.text=@"性    别:";
    [self.view addSubview:self.labelXB];
    self.labelXB=nil;
    
    self.labelNan=[[UILabel alloc]initWithFrame:CGRectMake(115, 140, 20, h )];
    self.labelNan.text=@"男";
    [self.view addSubview:self.labelNan];
    self.labelNan=nil;
    
    self.labelNv=[[UILabel alloc]initWithFrame:CGRectMake(165, 140, 20, h)];
    self.labelNv.text=@"女";
    [self.view addSubview:self.labelNv];
    self.labelNv=nil;
    
    
//    self.textFieldDanwei=[[UITextField alloc]initWithFrame:CGRectMake(90, 100, 200, h)];
//    self.textFieldDanwei.borderStyle=UITextBorderStyleRoundedRect;
//    [self.view addSubview:self.textFieldDanwei];
    
    self.textFieldName=[[UITextField alloc]initWithFrame:CGRectMake(90, 100, 200, h)];
    self.textFieldName.borderStyle=UITextBorderStyleRoundedRect;
    [self.view addSubview:self.textFieldName];
    
//    self.textFieldPhone=[[UITextField alloc]initWithFrame:CGRectMake(90, 180, 200, h)];
//    self.textFieldPhone.borderStyle=UITextBorderStyleRoundedRect;
//    self.textFieldPhone.enabled = NO;
//    [self.view addSubview:self.textFieldPhone];
    
    self.textFieldShenfenzheng=[[UITextField alloc]initWithFrame:CGRectMake(90, 220, 200, h)];
    self.textFieldShenfenzheng.borderStyle=UITextBorderStyleRoundedRect;
    [self.view addSubview:self.textFieldShenfenzheng];
    
    self.textFieldQQ=[[UITextField alloc]initWithFrame:CGRectMake(90, 260, 200, h)];
    self.textFieldQQ.borderStyle=UITextBorderStyleRoundedRect;
    self.textFieldQQ.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:self.textFieldQQ];
    
    self.textFieldYouxiang=[[UITextField alloc]initWithFrame:CGRectMake(90, 300, 200, h)];
    self.textFieldYouxiang.borderStyle=UITextBorderStyleRoundedRect;
    [self.view addSubview:self.textFieldYouxiang];
    
    self.textFieldZhuye=[[UITextField alloc]initWithFrame:CGRectMake(90, 180, 200, h)];
    self.textFieldZhuye.borderStyle=UITextBorderStyleRoundedRect;
    [self.view addSubview:self.textFieldZhuye];
    
    
    self.btnSave=[UIButton buttonWithType:UIButtonTypeCustom];
    self.btnSave.frame=CGRectMake(200, 350, 85, 35);
    UIImage * image=[UIImage imageNamed:@"save.png"];
    [self.btnSave setImage:image forState:UIControlStateNormal];
    [self.btnSave addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnSave];
    self.btnSave=nil;
    image=nil;
    
    
    self.btnNan=[UIButton buttonWithType:UIButtonTypeCustom];
    self.btnNan.frame=CGRectMake(90, 145, 20, 20);
    self.btnNan.tag=1;
    UIImage * image1=[UIImage imageNamed:@"nv.png"];
    UIImage * image2=[UIImage imageNamed:@"nan.png"];
    [self.btnNan setImage:image1 forState:UIControlStateNormal];
    [self.btnNan setImage:image2 forState:UIControlStateSelected];
    [self.btnNan addTarget:self action:@selector(changeBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.btnNan.selected=YES;
    [self.view addSubview:self.btnNan];
    
    self.btnNv=[UIButton buttonWithType:UIButtonTypeCustom];
    self.btnNv.frame=CGRectMake(140, 145, 20, 20);
    self.btnNv.tag=2;
    [self.btnNv setImage:image1 forState:UIControlStateNormal];
    [self.btnNv setImage:image2 forState:UIControlStateSelected];
    [self.btnNv addTarget:self action:@selector(changeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnNv];
    image1=nil;
    image2=nil;
    
    
    UIToolbar * topView=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    [topView setBarStyle:UIBarStyleBlack];
    
    UIBarButtonItem * button1=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * button2=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * doneButton=[[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(resignKeyboard)];
    
    NSArray * buttonsArray=[NSArray arrayWithObjects:button1,button2,doneButton, nil];
    [topView setItems:buttonsArray animated:YES];
    [self.textFieldDanwei setInputAccessoryView:topView];
    [self.textFieldName setInputAccessoryView:topView];
    [self.textFieldPhone setInputAccessoryView:topView];
    [self.textFieldShenfenzheng setInputAccessoryView:topView];
    [self.textFieldQQ setInputAccessoryView:topView];
    [self.textFieldYouxiang setInputAccessoryView:topView];
    [self.textFieldZhuye setInputAccessoryView:topView];

    topView=nil;
    button1=nil;
    button2=nil;
    doneButton=nil;
    buttonsArray=nil;
    
    
}
-(void)resignKeyboard
{
    [self.textFieldZhuye resignFirstResponder];
    [self.textFieldYouxiang resignFirstResponder];
    [self.textFieldQQ resignFirstResponder];
    [self.textFieldShenfenzheng resignFirstResponder];
    [self.textFieldPhone resignFirstResponder];
    [self.textFieldName resignFirstResponder];
    [self.textFieldDanwei resignFirstResponder];
    
}
-(void)tishi
{
    [self.actView stopAnimating];
    UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"保存成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];

}
-(void)save
{
    
//    [self.view addSubview:self.actView];
//    [self.actView startAnimating];
    UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"是否确认提交" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    alert.delegate = self;
    [alert show];

    
    
//    NSArray * paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString * filename=[paths objectAtIndex:0];
//    NSString * filename1=[filename stringByAppendingPathComponent:@"GeRenInfo.plist"];
//    NSArray * ar=[NSArray arrayWithObjects:self.textFieldDanwei.text,self.textFieldName.text,self.textFieldPhone.text,self.textFieldShenfenzheng.text,self.textFieldQQ.text,self.textFieldYouxiang.text,self.textFieldZhuye.text, nil];
//    
//    [ar writeToFile:filename1 atomically:YES];
//    ar=nil;
//    
//    paths=nil;
//    filename=nil;
//    filename1=nil;
//    [self performSelector:@selector(tishi) withObject:nil afterDelay:1.0];

    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        NSLog(@"save");
        isSaved = NO;
        [self.activityView startAnimating];
        [self saveInfo];
    }
    
}
-(void)saveInfo
{
    MainViewController * main=[MainViewController SingleInit];
    //中文需要处理
    NSString *name = [self.textFieldName.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString * str=[NSString stringWithFormat:@"http://fr.eslgw.com/index.php/mobile/insert_information?phone=%@&qq=%@&email=%@&identity=%@&name=%@&people_home=%@&sex=%@",main.strZhangHao,self.textFieldQQ.text,self.textFieldYouxiang.text,self.textFieldShenfenzheng.text,name,self.textFieldZhuye.text,sex];
    
    NSURLRequest * request=[NSURLRequest requestWithURL:[NSURL URLWithString:str]];
    NSData * response=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if (response) {
        [self.activityView stopAnimating];
        isSaved = YES;
        [self tishi];
        NSLog(@"UUID=%@",[NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:nil]);
    }
    else
    {
        [self.activityView stopAnimating];
        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"提交失败，请重试。" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        
    }

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    isSaved = NO;
    
    UIImage * image=[UIImage imageNamed:@"personInfoBG.jpg"];
    self.view.layer.contents=(id)image.CGImage;
    image=nil;
    self.title=@"个人资料";
    
    
    
    [self addButton];
    self.actView=[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(110, ([UIScreen mainScreen].bounds.size.height-100)/2, 100, 100)];
    [ self.actView setBackgroundColor:[UIColor lightGrayColor]];
    infoArray = [[NSArray alloc]init];
    
    [self.activityView startAnimating];
    //MainViewController * main=[MainViewController SingleInit];
   
    //NSString * str=[NSString stringWithFormat:@"http://fr.eslgw.com/index.php/mobile/information?p=%@",main.strZhangHao];
    NSString * str=[NSString stringWithFormat:@"http://fr.eslgw.com/index.php/mobile/information?p=15510361045"];
    //NSError * error;
    NSURLRequest * request=[NSURLRequest requestWithURL:[NSURL URLWithString:str]];
    NSData * response=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if (response) {
        
        infoArray = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:nil];
        
        NSDictionary *dict = [infoArray objectAtIndex:0];
        NSLog(@"data = %@",dict);
        self.textFieldZhuye.text = [dict objectForKey:@"people_home"];
        self.textFieldYouxiang.text = [dict objectForKey:@"email"];
        self.textFieldQQ.text = [dict objectForKey:@"qq"];
        self.textFieldShenfenzheng.text = [dict objectForKey:@"identity"];
        self.textFieldName.text = [dict objectForKey:@"name"];
        sex = [dict objectForKey:@"sex"];
        if ([[dict objectForKey:@"sex"] isEqualToString:@"1"]) {
            btnNan.selected = YES;
            btnNv.selected = NO;
        }
        else
        {
            btnNan.selected = NO;
            btnNv.selected = YES;
        }
        [self.activityView stopAnimating];
    }
    else{
        [self.activityView stopAnimating];
        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"加载失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    
//        if (error) {
//            NSLog(@"httperror:%@%d",error.localizedDescription,error.code);
//            response=nil;
//            data=nil;
//            error=nil;
//        }
//        else
//        {
//            
//            infoArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
//           
//            NSDictionary *dict = [infoArray objectAtIndex:0];
//             NSLog(@"data = %@",dict);
//            self.textFieldZhuye.text = [dict objectForKey:@"people_home"];
//            self.textFieldYouxiang.text = [dict objectForKey:@"email"];
//            self.textFieldQQ.text = [dict objectForKey:@"qq"];
//            self.textFieldShenfenzheng.text = [dict objectForKey:@"identity"];
//            //self.textFieldPhone.text = [dict objectForKey:@"phone"];
//            self.textFieldName.text = [dict objectForKey:@"name"];
//            sex = [dict objectForKey:@"sex"];
//            if ([[dict objectForKey:@"sex"] isEqualToString:@"1"]) {
//                btnNan.selected = YES;
//                btnNv.selected = NO;
//                
//            }
//            else
//            {
//                btnNan.selected = NO;
//                btnNv.selected = YES;
//            }
//            [self.activityView stopAnimating];
////            NSLog(@"%@",self.textFieldZhuye.text);
////            if (self.textFieldZhuye.text.length > 0) {
////                self.textFieldZhuye.enabled = NO;
////            }
////            if (self.textFieldYouxiang.text.length > 0) {
////                self.textFieldYouxiang.enabled = NO;
////            }
////            if (self.textFieldQQ.text.length > 0) {
////                self.textFieldQQ.enabled = NO;
////            }
////            if (self.textFieldShenfenzheng.text.length > 0) {
////                self.textFieldShenfenzheng.enabled = NO;
////            }
////            if (self.textFieldPhone.text.length > 0) {
////                self.textFieldPhone.enabled = NO;
////            }
////            if (self.textFieldName.text.length > 0) {
////                self.textFieldName.enabled = NO;
////            }
//
//        }
//        
    
   // }];
    
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
