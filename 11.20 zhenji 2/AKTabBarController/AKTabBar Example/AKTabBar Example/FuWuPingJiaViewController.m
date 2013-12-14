//
//  FuWuPingJiaViewController.m
//  龙代驾
//
//  Created by mac on 13-10-18.
//  Copyright (c) 2013年 Ali Karagoz. All rights reserved.
//

#import "FuWuPingJiaViewController.h"
#import "MainViewController.h"

@interface FuWuPingJiaViewController (){
   // int i;
}
@property (strong,nonatomic)NSString * strSmile;
@end

@implementation FuWuPingJiaViewController
@synthesize textLabel;
@synthesize textV;
@synthesize imageView1,imageView2,imageView3,imageView4,imageView5;
@synthesize button1,button2,button3,button4,button5,button6;
@synthesize dicList;
@synthesize strSmile;
@synthesize activityView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(id)initWithDic:(NSDictionary * )dic
{
    self=[super init];
    if (self) {
        NSLog(@"dic =%@",dic);
        self.dicList=dic;
        NSLog(@"self.dicList-------------------=%@",self.dicList);
        dic=nil;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.strSmile=@"4";         //默认良好
    self.title=@"服务评价";
    [self addBtn];
    self.activityView=[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(110, ([UIScreen mainScreen].bounds.size.height-100)/2, 100, 100)];
    [ self.activityView setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:self.activityView];

    // Do any additional setup after loading the view from its nib.
}
-(void)addBtn
{
    self.textLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 70, 140, 30)];
    self.textLabel.text=@"请您给代驾员评分:";
    self.textLabel.font=[UIFont systemFontOfSize:14];
    self.textLabel.textColor=[UIColor colorWithWhite:0.6 alpha:1.0];
    [self.view addSubview:self.textLabel];
    
    
    self.imageView1=[[UIImageView alloc]init];
    self.imageView1.frame=CGRectMake(22, 105, 25, 25);
    UIImage * image1=[UIImage imageNamed:@"表情1.png"];
    [self.imageView1 setImage:image1];
    [self.view addSubview:self.imageView1];
    image1=nil;
    self.imageView1=nil;
    
    self.imageView2=[[UIImageView alloc]init];
    self.imageView2.frame=CGRectMake(88, 105, 25, 25);
    UIImage * image2=[UIImage imageNamed:@"表情2.png"];
    [self.imageView2 setImage:image2];
    [self.view addSubview:self.imageView2];
    image2=nil;
    self.imageView2=nil;
    
    
    self.imageView3=[[UIImageView alloc]init];
    self.imageView3.frame=CGRectMake(152, 105, 25, 25);
    UIImage * image3=[UIImage imageNamed:@"表情3"];
    [self.imageView3 setImage:image3];
    [self.view addSubview:self.imageView3];
    image3=nil;
    self.imageView3=nil;
    
    
    self.imageView4=[[UIImageView alloc]init];
    self.imageView4.frame=CGRectMake(212, 105, 25, 25);
    UIImage * image4=[UIImage imageNamed:@"表情4.png"];
    [self.imageView4 setImage:image4];
    [self.view addSubview:self.imageView4];
    image4=nil;
    self.imageView4=nil;
    
    
    self.imageView5=[[UIImageView alloc]init];
    self.imageView5.frame=CGRectMake(273, 105, 25, 25);
    UIImage * image5=[UIImage imageNamed:@"表情5.png"];
    [self.imageView5 setImage:image5];
    [self.view addSubview:self.imageView5];
    image5=nil;
    self.imageView5=nil;
    
    self.button1=[UIButton buttonWithType:UIButtonTypeCustom];
    self.button1.frame=CGRectMake(10, 135, 54, 25);
    self.button1.tag=1;
    UIImage * btnImage1=[UIImage imageNamed:@"非常好.png"];
    [self.button1 setImage:btnImage1 forState:UIControlStateNormal];
    [self.button1 addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button1];
    btnImage1=nil;
    self.button1=nil;
    
    self.button2=[UIButton buttonWithType:UIButtonTypeCustom];
    self.button2.frame=CGRectMake(72, 135, 54, 25);
    self.button2.tag=2;
    UIImage * btnImage2=[UIImage imageNamed:@"良好.png"];
    [self.button2 setImage:btnImage2 forState:UIControlStateNormal];
    [self.button2 addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button2];
    btnImage2=nil;
    self.button2=nil;
    
    self.button3=[UIButton buttonWithType:UIButtonTypeCustom];
    self.button3.frame=CGRectMake(134, 135, 55, 25);
    self.button3.tag=3;
    UIImage * btnImage3=[UIImage imageNamed:@"一般.png"];
    [self.button3 setImage:btnImage3 forState:UIControlStateNormal];
    [self.button3 addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button3];
    btnImage3=nil;
    self.button3=nil;
    
    self.button4=[UIButton buttonWithType:UIButtonTypeCustom];
    self.button4.frame=CGRectMake(196, 135, 54, 25);
    self.button4.tag=4;
    UIImage * btnImage4=[UIImage imageNamed:@"很差.png"];
    [self.button4 setImage:btnImage4 forState:UIControlStateNormal];
    [self.button4 addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button4];
    btnImage4=nil;
    self.button4=nil;
    
    self.button5=[UIButton buttonWithType:UIButtonTypeCustom];
    self.button5.frame=CGRectMake(258, 135, 54, 25);
    self.button5.tag=5;
    UIImage * btnImage5=[UIImage imageNamed:@"非常差.png"];
    [self.button5 setImage:btnImage5 forState:UIControlStateNormal];
    [self.button5 addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button5];
    btnImage5=nil;
    self.button5=nil;
    
    self.button6=[UIButton buttonWithType:UIButtonTypeCustom];
    self.button6.frame=CGRectMake(240, 360, 70, 35);
    self.button6.tag=6;
    UIImage * btnImage6=[UIImage imageNamed:@"确定.png"];
    [self.button6 setImage:btnImage6 forState:UIControlStateNormal];
    [self.button6 addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button6];
    btnImage6=nil;
    self.button6=nil;
    
    
    self.textV =[[UITextView alloc]initWithFrame:CGRectMake(10, 180, 300, 170)];
    self.textV.delegate=self;
    self.textV.font=[UIFont systemFontOfSize:14];
    self.textV.scrollEnabled=NO;
    self.textV.editable=YES;
    self.textV.text=@"备注:";
    self.textV.layer.borderColor=[UIColor grayColor].CGColor;
    self.textV.layer.cornerRadius=5.0;
    self.textV.backgroundColor=[UIColor colorWithWhite:0.9 alpha:1.0];
    [self.view addSubview:self.textV];
    
    
    UIToolbar * topView=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    [topView setBarStyle:UIBarStyleBlack];
    UIBarButtonItem * btnItem1=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * btnItem2=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * doneButton=[[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(resignKeyboard)];
    NSArray * buttonsArray=[NSArray arrayWithObjects:btnItem1,btnItem2,doneButton, nil];
    [topView setItems:buttonsArray animated:YES];
    [self.textV setInputAccessoryView:topView];
    
    topView=nil;
    btnItem1=nil;
    btnItem2=nil;
    doneButton=nil;
    buttonsArray=nil;


}
-(void)btnPress:(id)sender
{
    UIButton * btn=sender;
    switch (btn.tag) {
        case 1:
           // i=1;
            self.strSmile=@"1";
            NSLog(@"1");
            break;
        case 2:
           // i=2;
            self.strSmile=@"2";
            NSLog(@"2");
            break;
        case 3:
           // i=3;
            self.strSmile=@"3";
            NSLog(@"3");
            break;
        case 4:
           // i=4;
            self.strSmile=@"4";
            NSLog(@"4");
            break;
        case 5:
           // i=5;
            self.strSmile=@"5";
            NSLog(@"5");
            break;
        case 6:
            
            NSLog(@"6");
    
            [self submit];
        default:
            break;
    }
}
-(void)submit
{
    

    [self.activityView startAnimating];
    
    MainViewController * main=[MainViewController SingleInit];
    NSLog(@"mainSTRzhanghao=%@",main.strZhangHao);
    NSString * strid=[self.dicList objectForKey:@"daijia_id"];
    NSString * strNum=[self.dicList objectForKey:@"order_num"];
    NSLog(@"strid=%@/n,strnum=%@/n,strsmile=%@/n,selftextv.text=%@",strid,strNum,strSmile, self.textV.text);
    NSString * strppp=self.textV.text;
    NSMutableString * ssss=[NSMutableString stringWithString:strppp];
    NSString * sss=[ssss substringFromIndex:3];
    NSLog(@"ssss=%@",sss);
    
    
    NSString * str=[NSString stringWithFormat:@"http://fr.eslgw.com/index.php/mobile/comment?order=%@&daijia=%@&p=%@&com=%@&con=%@",strNum,strid,main.strZhangHao,self.strSmile,sss];
    strid=nil;
    strNum=nil;
    self.strSmile=nil;
    
    NSMutableURLRequest * request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:str]];
    NSOperationQueue * queue=[[NSOperationQueue alloc]init];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse * response,NSData * data, NSError * error){
        if (error) {
            NSLog(@"error=%@------%i",error.localizedDescription,error.code);
            [self.activityView stopAnimating];
            UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"上传失败，请检查网络重新上传" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert show];
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
-(void)resignKeyboard
{
    [self.textV resignFirstResponder];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
