//
//  GeRenViewController.m
//  龙代驾
//
//  Created by mac on 13-11-6.
//  Copyright (c) 2013年 Ali Karagoz. All rights reserved.
//

#import "GeRenViewController.h"
#import "GeRenZhongXinViewController.h"
#import "GeRenInfoViewController.h"

@interface GeRenViewController ()
@property (strong,nonatomic)GeRenZhongXinViewController * GRZXView;
@property (strong,nonatomic)GeRenInfoViewController  * GeRenInfoView;

@end

@implementation GeRenViewController
@synthesize strMoney,strNo,strPoint;
@synthesize labelCi,labelCS,labelFen,labelJF,labelMoney,labelNo,labelPoint,labelXF,labelYuan;
@synthesize btnGeRen,btnLiShi,btnXiangQing;
@synthesize GRZXView;
@synthesize GeRenInfoView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)addButton
{
    self.labelXF=[[UILabel alloc]initWithFrame:CGRectMake(20, 100, 100, 20)];
    self.labelXF.text=@"总消费金额:";
    [self.view addSubview:self.labelXF];
    self.labelXF=nil;
    
    self.labelMoney=[[UILabel alloc]initWithFrame:CGRectMake(130, 100, 60, 20)];
    if (!self.strMoney) {
        self.labelMoney.text=@"0";
    }
    else{
        self.labelMoney.text=self.strMoney;
    }
    self.labelMoney.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:self.labelMoney];
    self.labelMoney=nil;
    self.strMoney=nil;
    
    self.labelYuan=[[UILabel alloc]initWithFrame:CGRectMake(190, 100, 40, 20)];
    self.labelYuan.text=@"元";
    [self.view addSubview:self.labelYuan];
    self.labelYuan=nil;
    
    
    self.labelCS=[[UILabel alloc]initWithFrame:CGRectMake(20, 140, 100, 20)];
    self.labelCS.text=@"总使用次数:";
    [self.view addSubview:self.labelCS];
    self.labelCS=nil;
    
    self.labelNo=[[UILabel alloc]initWithFrame:CGRectMake(130, 140, 60, 20)];
    if (!self.strNo) {
        self.labelNo.text=@"0";
    }
    else
    {
        self.labelNo.text=self.strNo;
    }
    self.labelNo.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:self.labelNo];
    self.labelNo=nil;
    self.strNo=nil;
    
    self.labelCi=[[UILabel alloc]initWithFrame:CGRectMake(190, 140, 40, 20)];
    self.labelCi.text=@"次";
    [self.view addSubview:self.labelCi];
    self.labelCi=nil;
    
    self.labelJF=[[UILabel alloc]initWithFrame:CGRectMake(20, 180, 100, 20)];
    self.labelJF.text=@"总   积   分:";
    [self.view addSubview:self.labelJF];
    self.labelJF=nil;
    
    self.labelPoint=[[UILabel alloc]initWithFrame:CGRectMake(130, 180, 60, 20)];
    if (!self.strPoint) {
        self.labelPoint.text=@"0";
    }
    else
    {
        self.labelPoint.text=self.strPoint;
    }
    self.labelPoint.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:self.labelPoint];
    self.labelPoint=nil;
    self.strPoint=nil;
    
    self.labelFen=[[UILabel alloc]initWithFrame:CGRectMake(190, 180, 40, 20)];
    self.labelFen.text=@"分";
    [self.view addSubview:self.labelFen];
    self.labelFen=nil;
    
    self.btnXiangQing=[UIButton buttonWithType:UIButtonTypeCustom];
    self.btnXiangQing.frame=CGRectMake(220, 178, 70, 30);
    self.btnXiangQing.tag=1;
    UIImage * image=[UIImage imageNamed:@"detailed.png"];
    [self.btnXiangQing setImage:image forState:UIControlStateNormal];
    [self.btnXiangQing addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnXiangQing];
    image=nil;
    
    self.btnLiShi=[UIButton buttonWithType:UIButtonTypeCustom];
    self.btnLiShi.frame=CGRectMake(40, 220, 100, 100);
    self.btnLiShi.tag=2;
    UIImage * image1=[UIImage imageNamed:@"historyList.png"];
    [self.btnLiShi setImage:image1 forState:UIControlStateNormal];
    [self.btnLiShi addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnLiShi];
    image1=nil;
    
    self.btnGeRen=[UIButton buttonWithType:UIButtonTypeCustom];
    self.btnGeRen.frame=CGRectMake(180, 220, 100, 100);
    self.btnGeRen.tag=3;
    UIImage * image2=[UIImage imageNamed:@"personInfo.png"];
    [self.btnGeRen setImage:image2 forState:UIControlStateNormal];
    [self.btnGeRen addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnGeRen];
    image2=nil;
    self.btnGeRen=nil;
    
}
-(void)btnPress:(id)sender
{
    UIButton * button=sender;
    switch (button.tag) {
        case 1:
            NSLog(@"xiangqing");
            [self alert];
            break;
        case 2:
            NSLog(@"lishidingdan");
            [self.navigationController pushViewController:self.GRZXView animated:YES];
            break;
        case 3:
            NSLog(@"gerenziliao");
            [self.navigationController pushViewController:self.GeRenInfoView animated:YES];
            break;
            
        default:
            break;
    }
}
//详情提示
-(void)alert{
    UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"亲！下一个版本就可以看见我了。" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"个人中心";
    
    UIImage * image=[UIImage imageNamed:@"personBG.jpg"];
    self.view.layer.contents=(id)image.CGImage;
    self.view.backgroundColor=[UIColor whiteColor];
    image=nil;
    [self addButton];
    
    self.GRZXView=[[GeRenZhongXinViewController alloc]init];
    self.GeRenInfoView=[[GeRenInfoViewController alloc]init];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
