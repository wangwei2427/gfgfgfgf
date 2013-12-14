//
//  FaPiaoViewController.m
//  龙代驾
//
//  Created by mac on 13-10-19.
//  Copyright (c) 2013年 Ali Karagoz. All rights reserved.
//

#import "FaPiaoViewController.h"

#define w 65
#define h 30

@interface FaPiaoViewController ()

@end

@implementation FaPiaoViewController
@synthesize labelAdds;
@synthesize labelFaPiaoLeiXing;
@synthesize labelFuKuanDanWei;
@synthesize labelMoney;
@synthesize labelPhone;
@synthesize labelShouJianRen;
@synthesize labelTiShi;
@synthesize labelYouZheng;
@synthesize textFieldAdds;
@synthesize textFieldFuKuanDanWei;
//@synthesize textFieldMoney;
@synthesize labelMoneyShow;
@synthesize textFieldPhone;
@synthesize textFieldShouJianRen;
@synthesize textFieldYouZheng;
@synthesize textFieldFaPiaoLeiXing;
@synthesize btnOk;

@synthesize activityView;
@synthesize strDingDanID;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(id)initWithStr:(NSString *)str
{
    self=[super init];
    if (self) {
        self.strDingDanID=str;
        NSLog(@"strdingdaniD=%@",self.strDingDanID);
    }
    return self;
}

//代驾类型  代驾费  服务费
-(void)btnPress
{
    //先判断网络（mainview 实例方法  判断网络）把 textField.text 传到服务器上去
    [self.activityView startAnimating];
    
    NSString * str=[NSString stringWithFormat:@"http://fr.eslgw.com/index.php/mobile/receipt?order=%@&d=%@&type=%@&s=%@&code=%@&p=%@&a=%@",self.strDingDanID,self.textFieldFuKuanDanWei.text,self.textFieldFaPiaoLeiXing.text,self.textFieldShouJianRen.text,self.textFieldYouZheng.text,self.textFieldPhone.text,self.textFieldAdds.text];

    NSMutableURLRequest * request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:str]];
    NSOperationQueue * queue=[[NSOperationQueue alloc]init];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse * response,NSData * data, NSError * error){
        if (error) {
            NSLog(@"error=%@------%i",error.localizedDescription,error.code);
            [self.activityView stopAnimating];
            UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"上传失败，请检查网络重新上传" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert show];
            // alertview  提示出错;
            response=nil;
            data=nil;
            error=nil;
        }else{
            [self.activityView stopAnimating];
            UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"上传成功" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
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
-(void)btnGo:(id)sender
{
    NSLog(@"go");
    if (dropDwon ==nil) {
        dropDwon=[[NIDropDown alloc]initWithButton:sender];
        dropDwon.delegate=self;
    }
        else {
            
            [dropDwon hideDropDown];
            [self rel];
        }
}

- (void) niDropDownDelegateMethod: (NIDropDown *) sender {
    [self rel];
}
-(void)DropDownDelegateMethod:(NSString * )str
{
    NSLog(@"str=%@",str);
    self.textFieldFaPiaoLeiXing.text=str;
}
-(void)rel{
    
    dropDwon = nil;
}


-(void)resignKeyboard
{

    [self.textFieldFuKuanDanWei resignFirstResponder];
    [self.textFieldShouJianRen resignFirstResponder];
    [self.textFieldPhone resignFirstResponder];
    [self.textFieldAdds resignFirstResponder];
   // [self.textFieldMoney resignFirstResponder];
    [self.textFieldYouZheng resignFirstResponder];
    [self.textFieldFaPiaoLeiXing resignFirstResponder];
}
-(void)addButton
{
    UIFont * textFont=[UIFont systemFontOfSize:14];
    
    self.labelTiShi=[[UILabel alloc]initWithFrame:CGRectMake(5, 65, 315, h)];
    self.labelTiShi.textColor=[UIColor colorWithWhite:0.6 alpha:1];
    self.labelTiShi.font=[UIFont systemFontOfSize:12];
    self.labelTiShi.text=@"为了保证您的发票信息正确无误，请您认真填写发票信息";
    [self.view addSubview:self.labelTiShi];
   
    self.labelFuKuanDanWei=[[UILabel alloc]initWithFrame:CGRectMake(10, 90, w , h )];
    self.labelFuKuanDanWei.text=@"付款单位:";
    self.labelFuKuanDanWei.font=textFont;
    [self.view addSubview:self.labelFuKuanDanWei];
   
    self.labelFaPiaoLeiXing=[[UILabel alloc]initWithFrame:CGRectMake(10, 130, w , h)];
    self.labelFaPiaoLeiXing.text=@"发票类型:";
    self.labelFaPiaoLeiXing.font=textFont;
    [self.view addSubview:self.labelFaPiaoLeiXing];
   
    self.labelShouJianRen=[[UILabel alloc]initWithFrame:CGRectMake(10, 170, w, h)];
    self.labelShouJianRen.text=@"收件人:";
    self.labelShouJianRen.font=textFont;
    [self.view addSubview:self.labelShouJianRen];
 
    self.labelPhone=[[UILabel alloc]initWithFrame:CGRectMake(10, 210, w, h)];
    self.labelPhone.text=@"联系电话:";
    self.labelPhone.font=textFont;
    [self.view addSubview:self.labelPhone];
    
    self.labelAdds=[[UILabel alloc]initWithFrame:CGRectMake(10, 250, w, h)];
    self.labelAdds.text=@"快递地址:";
    self.labelAdds.font=textFont;
    [self.view addSubview:self.labelAdds];

    self.labelMoney=[[UILabel alloc]initWithFrame:CGRectMake(175, 130, w, h)];
    self.labelMoney.text=@"发票金额:";
    self.labelMoney.font=textFont;
    [self.view addSubview:self.labelMoney];

    self.labelYouZheng=[[UILabel alloc]initWithFrame:CGRectMake(155, 170, w, h)];
    self.labelYouZheng.text=@"邮政编码:";
    self.labelYouZheng.font=textFont;
    [self.view addSubview:self.labelYouZheng];
    
    self.textFieldFuKuanDanWei=[[UITextField alloc]initWithFrame:CGRectMake(75, 90, 230, h)];
    self.textFieldFuKuanDanWei.borderStyle=UITextBorderStyleRoundedRect;
    self.textFieldFuKuanDanWei.delegate=self;
    self.textFieldFuKuanDanWei.font=textFont;
    self.textFieldFuKuanDanWei.clearButtonMode=UITextFieldViewModeWhileEditing;
    self.textFieldFuKuanDanWei.keyboardType=UIKeyboardTypeAlphabet;
    [self.view addSubview:self.textFieldFuKuanDanWei];
    
    self.textFieldFaPiaoLeiXing =[[UITextField alloc]initWithFrame:CGRectMake(75, 130, 80, h )];
    self.textFieldFaPiaoLeiXing.borderStyle=UITextBorderStyleRoundedRect;
    self.textFieldFaPiaoLeiXing.delegate=self;
    self.textFieldFaPiaoLeiXing.font=textFont;
    self.textFieldFaPiaoLeiXing.keyboardType=UIKeyboardTypeAlphabet;
    [self.view addSubview:self.textFieldFaPiaoLeiXing];
    
    UIButton * btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, 20, 20);
    UIImage * imageB=[UIImage imageNamed:@"三角.png"];
    [btn setImage:imageB forState:UIControlStateNormal];
    self.textFieldFaPiaoLeiXing.rightView=btn;
    self.textFieldFaPiaoLeiXing.rightViewMode=UITextFieldViewModeAlways;
    [btn addTarget:self action:@selector(btnGo:) forControlEvents:UIControlEventTouchUpInside];
    imageB=nil;
    btn=nil;
    

    self.textFieldShouJianRen=[[UITextField alloc]initWithFrame:CGRectMake(75, 170, 80, h)];
    self.textFieldShouJianRen.borderStyle=UITextBorderStyleRoundedRect;
    self.textFieldShouJianRen.delegate=self;
    self.textFieldShouJianRen.font=textFont;
    self.textFieldShouJianRen.clearButtonMode=UITextFieldViewModeWhileEditing;
    self.textFieldShouJianRen.keyboardType=UIKeyboardTypeAlphabet;
    [self.view addSubview:self.textFieldShouJianRen];

    self.textFieldPhone=[[UITextField alloc]initWithFrame:CGRectMake(75, 210, 230, h)];
    self.textFieldPhone.borderStyle=UITextBorderStyleRoundedRect;
    self.textFieldPhone.delegate=self;
    self.textFieldPhone.font=textFont;
    self.textFieldPhone.clearButtonMode=UITextFieldViewModeWhileEditing;
    self.textFieldPhone.keyboardType=UIKeyboardTypePhonePad;
    [self.view addSubview:self.textFieldPhone];

    self.textFieldAdds=[[UITextField alloc]initWithFrame:CGRectMake(75, 250, 230, h)];
    self.textFieldAdds.borderStyle=UITextBorderStyleRoundedRect;
    self.textFieldAdds.delegate=self;
    self.textFieldAdds.font=textFont;
    self.textFieldAdds.clearButtonMode=UITextFieldViewModeWhileEditing;
    self.textFieldAdds.keyboardType=UIKeyboardTypeAlphabet;
    [self.view addSubview:self.textFieldAdds];
    
//    self.textFieldMoney=[[UITextField alloc]initWithFrame:CGRectMake(240, 130, 60, h)];
//    self.textFieldMoney.borderStyle=UITextBorderStyleRoundedRect;
//    self.textFieldMoney.delegate=self;
//    self.textFieldMoney.font=textFont;
//    self.textFieldMoney.text=@"6元";
//   
//  //  self.textFieldMoney.editing=NO;
//    self.textFieldMoney.clearButtonMode=UITextFieldViewModeWhileEditing;
//    self.textFieldMoney.keyboardType=UIKeyboardTypeDecimalPad;
//    [self.view addSubview:self.textFieldMoney];
    
    self.labelMoneyShow=[[UILabel alloc]initWithFrame:CGRectMake(240, 130, 60, h )];
    self.labelMoneyShow.text=@"7元";
    self.labelMoneyShow.textColor=[UIColor grayColor];
    [self.view addSubview:self.labelMoneyShow];
    self.labelMoneyShow=nil;

    self.textFieldYouZheng=[[UITextField alloc]initWithFrame:CGRectMake(220, 170, 85, h)];
    self.textFieldYouZheng.borderStyle=UITextBorderStyleRoundedRect;
    self.textFieldYouZheng.delegate=self;
    self.textFieldYouZheng.font=textFont;
    self.textFieldYouZheng.adjustsFontSizeToFitWidth = YES;
    self.textFieldYouZheng.clearButtonMode=UITextFieldViewModeWhileEditing;
    self.textFieldYouZheng.keyboardType=UIKeyboardTypePhonePad;
    [self.view addSubview:self.textFieldYouZheng];

    self.btnOk=[UIButton buttonWithType:UIButtonTypeCustom];
    self.btnOk.frame=CGRectMake(220, 290, 70, 33);
    UIImage * btnImage=[UIImage imageNamed:@"确定"];
    [self.btnOk setImage:btnImage forState:UIControlStateNormal];
    btnImage=nil;
    [self.btnOk addTarget:self action:@selector(btnPress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnOk];
    self.btnOk=nil;
    
    UIToolbar * topView=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    [topView setBarStyle:UIBarStyleBlack];
    
    UIBarButtonItem * button1=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * button2=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * doneButton=[[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(resignKeyboard)];
    
    NSArray * buttonsArray=[NSArray arrayWithObjects:button1,button2,doneButton, nil];
    [topView setItems:buttonsArray animated:YES];
    [self.textFieldFuKuanDanWei setInputAccessoryView:topView];
    [self.textFieldShouJianRen setInputAccessoryView:topView];
    [self.textFieldPhone setInputAccessoryView:topView];
    [self.textFieldAdds setInputAccessoryView:topView];
   // [self.textFieldMoney setInputAccessoryView:topView];
    [self.textFieldFaPiaoLeiXing setInputAccessoryView:topView];
    [self.textFieldYouZheng setInputAccessoryView:topView];
    

    
    self.labelYouZheng=nil;
    self.labelMoney=nil;
    self.labelAdds=nil;
    self.labelPhone=nil;
    self.labelShouJianRen=nil;
    self.labelFaPiaoLeiXing=nil;
    self.labelFuKuanDanWei=nil;
    self.labelTiShi=nil;
    
    textFont=nil;
    
    button1=nil;
    button2=nil;
    doneButton=nil;
    buttonsArray=nil;
    topView=nil;
    
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"发票信息";
    self.activityView=[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(110, ([UIScreen mainScreen].bounds.size.height-100)/2, 100, 100)];
    self.activityView.center=self.view.center;
    [self.activityView setBackgroundColor:[UIColor grayColor]];
   
    [self addButton];
     [self.view addSubview:self.activityView];
	// Do any additional setup after loading the view.
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    [self.navigationController popViewControllerAnimated:NO];
    self.textFieldYouZheng=nil;
  //  self.textFieldMoney=nil;
    self.textFieldAdds=nil;
    self.textFieldPhone=nil;
    self.textFieldShouJianRen=nil;
    self.textFieldFuKuanDanWei=nil;
    self.textFieldFaPiaoLeiXing=nil;

    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
