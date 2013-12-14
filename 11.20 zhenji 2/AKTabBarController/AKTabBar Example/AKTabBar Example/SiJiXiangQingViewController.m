//
//  SiJiXiangQingViewController.m
//  龙代驾
//
//  Created by mac on 13-10-21.
//  Copyright (c) 2013年 Ali Karagoz. All rights reserved.
//

#import "SiJiXiangQingViewController.h"
#import "CustomCell.h"
#import "MainViewController.h"
#define h 15

@interface SiJiXiangQingViewController ()
@property (strong,nonatomic)MainViewController * father;

@end

@implementation SiJiXiangQingViewController
@synthesize arrayList;
@synthesize dicXQ;
@synthesize imageView;
@synthesize imageXingJi;
@synthesize labelAdds;
@synthesize labelCishu;
@synthesize labelDaiJia;
@synthesize labelGongLi;
@synthesize labelHuji,labelJiaLing,labelJiaZhao,labelJiaZhaoHao,labelJuLi,labelName,labelNian,labelPingJia,labelZhuangTai;
@synthesize btnPhone;
@synthesize tableV;
@synthesize strFather;

@synthesize activityView;
@synthesize father;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(id)initWithDic:(NSDictionary *)dic father:(NSString *)f;  //是司机列表跳到司机详情f==2 是一开始的地图到这 ，f＝＝1 是首页地图到这
{
    self=[super init];
    if (self) {
        self.dicXQ=dic;
        self.strFather=f;
        NSLog(@"---%@",f );
      //  [self updataXY];
   //     [self performSelector:@selector(updataXY) withObject:nil afterDelay:0.1];
       // self.father=[MainViewController SingleInit];
       // self.arrayList=[self.father.dicPingJia objectForKey:[self.dicXQ objectForKey:@"id"]];
      //  [self.activityView stopAnimating];
    }
    return self;
}

-(id)initWithDic:(NSDictionary *)dic f:(NSString *)f//是当前订单跳到司机详情
{
    
     NSLog(@"ffffff=%@",f );

    self=[super init];
    if (self) {
        self.dicXQ=dic;
        self.strFather=f;
       // [self updataXY];
    }
    return self;
}

/*-(void)getPingjia
{
        
        NSString * str=[NSString stringWithFormat:@"http://fr.eslgw.com/index.php/mobile/com_list?daijia=%@",[self.dicXQ objectForKey:@"id"]];
        NSMutableURLRequest * request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:str]];
        NSOperationQueue * queue=[[NSOperationQueue alloc]init];
        [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse * response,NSData * data,NSError * error){
            if (error) {
                NSLog(@"httperror:%@%d",error.localizedDescription,error.code);
                response=nil;
                data=nil;
                error=nil;
            }
            else
            {
                self.arrayList=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
                response=nil;
                data=nil;
                error=nil;
                
            }
        }];
        
        request=nil;
        str=nil;
        queue=nil;
    
}
*/
-(void)updataXY
{
    
    NSString * strId=[self.dicXQ objectForKey:@"id"];
    NSString * str=[NSString stringWithFormat:@"http://fr.eslgw.com/index.php/mobile/com_list?daijia=%@",strId];
    NSMutableURLRequest * request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:str]];
    NSOperationQueue * queue=[[NSOperationQueue alloc]init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse * response,NSData * data,NSError * error){
        if (error) {
            NSLog(@"httperror:%@%d",error.localizedDescription,error.code);
            response=nil;
            data=nil;
            error=nil;
        }
        else
        {
            self.arrayList=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
            response=nil;
            data=nil;
            error=nil;
            [self.activityView stopAnimating];
            NSLog(@"self.arrayList=%@",self.arrayList);
           // self.arrayList=[self.father.dicPingJia objectForKey:[self.dicXQ objectForKey:@"id"]];
            NSLog(@"%@>>>>>>>%@",self.arrayList,self.dicXQ);
            [self.father.dicPingJia setObject:self.arrayList forKey:[self.dicXQ objectForKey:@"id"]];
            
            [self.tableV reloadData];
            
        }
    }];
    
    request=nil;
    str=nil;
    queue=nil;

}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        NSString * strId=[self.dicXQ objectForKey:@"id"];
        NSString * str=[NSString stringWithFormat:@"http://fr.eslgw.com/index.php/mobile/cellphone?id=%@", strId];
        
        NSMutableURLRequest * request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:str]];
        NSOperationQueue * queue=[[NSOperationQueue alloc]init];
        [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse * response,NSData * data,NSError * error){
            if (error) {
                [self.activityView stopAnimating];
                UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"服务器报错，请稍后再试" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                [alert show];
            }
            else
            {
                [self.activityView stopAnimating];
                NSString * tel=[self.dicXQ objectForKey:@"daijia_phone"];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",tel]]];
                
                NSLog(@"tel=%@",tel);
                tel=nil;
            }
            
        }];
        
        request=nil;
        str=nil;
        queue=nil;
    
    }
    
}
-(void)callPhone
{
    UIAlertView * alert=[[UIAlertView alloc]initWithTitle:nil message:@"确定拨打电话吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}

-(void)alertV
{
    if ([[self.dicXQ objectForKey:@"driverStatus"] intValue]==1) {
        if (self.btnPhone.enabled==NO) {
            self.btnPhone.enabled=YES;
        }
        [self.activityView startAnimating];
        [self callPhone];
    }
    else
    {
        
        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"司机正在忙碌，请稍后再拨" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        self.btnPhone.enabled=NO;
    }
}
//-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    UITextField * textF=[alertView textFieldAtIndex:0];
//    NSLog(@"textf.text=%@",textF.text);
//    
//    
//    NSFileManager * fileManager=[NSFileManager defaultManager];
//    NSArray * paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString * filename=[paths objectAtIndex:0];
//    NSString * filename1=[filename stringByAppendingPathComponent:@"ZhangHao.plist"];
//    NSString * filename2=[filename stringByAppendingPathComponent:@"LinShiZhangHao.plist"];
//    
//    
//    NSString * str11=[NSString stringWithFormat:@"http://fr.eslgw.com/index.php/mobile/cellphone?phone=%@&lat=39.908452&lng=116.4504792",textF.text];
//    
//    NSMutableURLRequest * request11=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:str11]];
//    NSOperationQueue * queue1=[[NSOperationQueue alloc]init];
//    [NSURLConnection sendAsynchronousRequest:request11 queue:queue1 completionHandler:^(NSURLResponse * response,NSData * data,NSError * error){
//        if (error) {
//            NSLog(@"httperror :%@%d",error.localizedDescription,error.code);
//            // alertview  提示出错;
//            response=nil;
//            data=nil;
//            error=nil;
//        }else{
//            
//            
//            if (![fileManager fileExistsAtPath:filename1]) {
//                // 如果没有帐号 请求一个临时id  把电话号当临时id
//                if (![fileManager fileExistsAtPath:filename2]) {
//                    //请求临时id
//                    NSArray * arr=[[NSArray alloc]initWithObjects:textF.text, nil];
//                    [arr writeToFile:filename2 atomically:YES];
//                    arr=nil;
//                    NSLog(@"filename2=%@",filename2);
//                }
//            }
//            
//            
//        }
//    }];
//    
//    
//    [self callPhone];
//
//}

-(void)addButton
{

    UIFont * textFont=[UIFont systemFontOfSize:12];
    UIColor * textColor=[UIColor colorWithWhite:0.6 alpha:1.0];
    
    self.imageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 70, 50, 60)];
    
    NSString * strImage=[NSString stringWithFormat:@"http://fr.eslgw.com/upload/temp/%@",[self.dicXQ objectForKey:@"img"]];
    NSURL *url = [NSURL URLWithString:strImage];
   UIImage * image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:url]];
    strImage=nil;
    url=nil;
    if ([[self.dicXQ objectForKey:@"img"] isEqualToString: @""]) {
        [self.imageView setImage:[UIImage imageNamed:@"logomoren.png"]];
    }
    else{
        [self.imageView setImage:image];
    }

    
    [self.view addSubview:self.imageView];
    self.imageView=nil;
     image=nil;
    
    self.imageXingJi=[[UIImageView alloc]initWithFrame:CGRectMake(65, 95, 75, 16)];
    //int i=[[self.dicXQ objectForKey:@"daijia_jiebie_id"]intValue];
    NSString * s=[NSString stringWithFormat:@"星星%i.png",[[self.dicXQ objectForKey:@"daijia_jiebie_id"]intValue] ];
    UIImage * imageXJ=[UIImage imageNamed:s ];
    [self.imageXingJi setImage:imageXJ];
    [self.view addSubview:self.imageXingJi];
    imageXJ=nil;
    self.imageXingJi=nil;
    s=nil;
    
    self.labelName=[[UILabel alloc]initWithFrame:CGRectMake(55, 70, 100, h)];
    self.labelName.text=[self.dicXQ objectForKey:@"daijia_name"];
    self.labelName.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:self.labelName];
    self.labelName=nil;
    
    self.labelGongLi=[[UILabel alloc]initWithFrame:CGRectMake(190, 70, 50, h)];
    self.labelGongLi.textColor=textColor;
    self.labelGongLi.font=textFont;
    

    float i=[[self.dicXQ objectForKey:@"code"] floatValue];
    if (i<1) {
            i=i*1000.00;
            self.labelGongLi.text=[NSString stringWithFormat:@"%.0fM",i ];
    }
    else
    {
         self.labelGongLi.text=[NSString stringWithFormat:@"%.2fKM",i ];
    }
        [self.view addSubview:self.labelGongLi];
        self.labelGongLi=nil;
        
        
        self.labelJuLi =[[UILabel alloc]initWithFrame:CGRectMake(160, 70, 35, h)];
        self.labelJuLi.text=@"距离:";
        self.labelJuLi.textColor=textColor;
        self.labelJuLi.font=textFont;
        [self.view addSubview:self.labelJuLi];
        self.labelJuLi=nil;

    

  
    
    
    self.labelZhuangTai=[[UILabel alloc]initWithFrame:CGRectMake(260, 70, 50, h)];
    if ([[self.dicXQ objectForKey:@"driverStatus"] intValue]==1) {
        self.labelZhuangTai.text=@"空闲";
        self.labelZhuangTai.textColor=[UIColor colorWithRed:57.0/255.0 green:149.0/255.0 blue:71.0/255.0 alpha:1];
    }
    else{
        self.labelZhuangTai.text=@"忙碌";
        self.labelZhuangTai.textColor=[UIColor colorWithRed:255.0/255.0 green:3.0/255.0 blue:4.0/255.0 alpha:1];
    }
    [self.view addSubview:self.labelZhuangTai];
    self.labelZhuangTai=nil;
    
    self.labelJiaZhao=[[UILabel alloc]initWithFrame:CGRectMake(160, 95, 35, h)];
    self.labelJiaZhao.textColor=textColor;
    self.labelJiaZhao.font=textFont;
    self.labelJiaZhao.text=@"驾照:";
    [self.view addSubview:self.labelJiaZhao];
    self.labelJiaZhao=nil;
    
    self.labelJiaZhaoHao=[[UILabel alloc]initWithFrame:CGRectMake(190, 95, 125, h)];
    

    
    NSString * st=[self.dicXQ objectForKey:@"shenfenzheng"];
    if (st.length<18) {
        self.labelJiaZhaoHao.text=st;
    }
    else
    {
        NSMutableString * must=[NSMutableString stringWithString:st];
        [must replaceCharactersInRange:NSMakeRange(12, 4) withString:@"****"];
        self.labelJiaZhaoHao.text=must;
         must=nil;
    }
    
    //self.labelJiaZhaoHao.text=st;
    st=nil;
  
    
    self.labelJiaZhaoHao.textColor=textColor;
    self.labelJiaZhaoHao.font=textFont;
    [self.view addSubview:self.labelJiaZhaoHao];
    self.labelJiaZhaoHao=nil;
    
    self.labelDaiJia=[[UILabel alloc]initWithFrame:CGRectMake(65, 120, 35, h)];
    self.labelDaiJia.textColor=textColor;
    self.labelDaiJia.text=@"代驾:";
    self.labelDaiJia.font=textFont;
    [self.view addSubview:self.labelDaiJia];
    self.labelDaiJia=nil;
    
    self.labelCishu=[[UILabel alloc]initWithFrame:CGRectMake(100, 120, 50, h)];
    
    self.labelCishu.text=[NSString stringWithFormat:@"%@次",[self.dicXQ objectForKey:@"times"]];
    self.labelCishu.textColor=textColor;
    self.labelCishu.font=textFont;
    [self.view addSubview:self.labelCishu];
    self.labelCishu=nil;
    
    self.labelJiaLing=[[UILabel alloc]initWithFrame:CGRectMake(160, 120, 35, h)];
    self.labelJiaLing.textColor=textColor;
    self.labelJiaLing.font=textFont;
    self.labelJiaLing.text=@"驾龄:";
    [self.view addSubview:self.labelJiaLing];
    self.labelJiaLing=nil;
    
    self.labelNian=[[UILabel alloc]initWithFrame:CGRectMake(190, 120, 40, h)];
    self.labelNian.text=[self.dicXQ objectForKey:@"jialing"];
    self.labelNian.textColor=textColor;
    self.labelNian.font=textFont;
    [self.view addSubview:self.labelNian];
    self.labelNian=nil;
    
    self.labelHuji=[[UILabel alloc]initWithFrame:CGRectMake(235, 120, 35, h)];
    self.labelHuji.textColor=textColor;
    self.labelHuji.font=textFont;
    self.labelHuji.text=@"户籍:";
    [self.view addSubview:self.labelHuji];
    self.labelHuji=nil;
    
    self.labelAdds=[[UILabel alloc]initWithFrame:CGRectMake(270, 120, 50, h)];
    self.labelAdds.font=textFont;
    self.labelAdds.text=[self.dicXQ objectForKey:@"huji"];
    self.labelAdds.textColor=textColor;
    [self.view addSubview:self.labelAdds];
    self.labelAdds=nil;
    
    textColor=nil;
    textFont=nil;
    
    
    self.btnPhone=[UIButton buttonWithType:UIButtonTypeCustom];
    self.btnPhone.frame=CGRectMake(20, 165, 280, 35);
    if ([[self.dicXQ objectForKey:@"driverStatus"] intValue]==1) {
        UIImage * imagePhone=[UIImage imageNamed:@"Phone.png"];
        [self.btnPhone setImage:imagePhone forState:UIControlStateNormal];
        imagePhone=nil;
    }else
    {
        UIImage * imageP=[UIImage imageNamed:@"Phone4.png"];
        [self.btnPhone setImage:imageP forState:UIControlStateNormal];
        imageP=nil;
    }
    [self.btnPhone addTarget:self action:@selector(alertV) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnPhone];
    self.btnPhone=nil;
    
    self.labelPingJia=[[UILabel alloc]initWithFrame:CGRectMake(0, 220, 320, 20)];
    self.labelPingJia.text=@"客户评价";
    self.labelPingJia.textColor=[UIColor greenColor];
    self.labelPingJia.textAlignment=NSTextAlignmentCenter;
    self.labelPingJia.backgroundColor=[UIColor grayColor];
    [self.view addSubview:self.labelPingJia];
    self.labelPingJia=nil;

    

    
    if ([self.strFather isEqualToString:@"1"]) {
        self.tableV=[[UITableView alloc]initWithFrame:CGRectMake(0, 245, 320, [UIScreen mainScreen].bounds.size.height-255) style:UITableViewStylePlain];
        self.activityView=[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(110, 260, 100, 100)];
       
    }else
    {
        self.tableV=[[UITableView alloc]initWithFrame:CGRectMake(0, 245, 320, [UIScreen mainScreen].bounds.size.height-245) style:UITableViewStylePlain];
        self.activityView=[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(110, 300, 100, 100)];
    }
    
    self.tableV.delegate=self;
    self.tableV.dataSource=self;
    [self.view addSubview:self.tableV];
    
      if ( [self.strFather isEqualToString:@"3"] ) {
       [self.activityView setBackgroundColor:[UIColor grayColor]];
       [self.view addSubview:self.activityView];
       [self.activityView startAnimating];
     }
    if ([self.arrayList count]==0) {
        [self updataXY];
    }
    else
    {
    [self.tableV reloadData];
    }
    

}
-(void)stopActivityView
{
    [self.activityView stopAnimating];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"司机详情";
    self.father=[MainViewController SingleInit];
    self.arrayList=[self.father.dicPingJia objectForKey:[self.dicXQ objectForKey:@"id"]];
    NSLog(@"self.arrayList%@",self.arrayList);
    
    [self performSelector:@selector(addButton) withObject:self afterDelay:0.1];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewDidAppear:(BOOL)animated
{
   
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arrayList count];
    NSLog(@"self.arrayList count=%i",[self.arrayList count]);
    
}
  static BOOL nibsRegistered=NO;
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CustomCellIdentifier=@"CustomCellIdentifier";
   // static BOOL nibsRegistered=NO;
    if (!nibsRegistered) {
        UINib * nib=[UINib nibWithNibName:@"CustomCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CustomCellIdentifier];
        nibsRegistered=YES;
    }
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
    
    NSDictionary * dicL=[self.arrayList objectAtIndex:[indexPath row]];
   
    NSString * st=[dicL objectForKey:@"phone"];
    NSMutableString * must=[NSMutableString stringWithString:st];
    if (must.length>8) {
         [must replaceCharactersInRange:NSMakeRange(4, 4) withString:@"****"];

    }
    cell.labelPhone.text=must;
    st=nil;
    must=nil;
    
    NSMutableString * mustStr=[NSMutableString stringWithString:[dicL objectForKey:@"creat_time"]];
    [mustStr deleteCharactersInRange:NSMakeRange(16, 3)];
    cell.labelTime.text=mustStr;
    must=nil;

    
  //  cell.labelPJ.text=[dicL objectForKey:@"content"];
    int i=[[dicL objectForKey:@"comment"]intValue];
    switch (i ) {
        case 5:
            cell.labelPingJia.text=@"非常好";
            break;
        case 4:
            cell.labelPingJia.text=@"良好";
            break;
        case 3:
            cell.labelPingJia.text=@"一般";
            break;
        case 2:
            cell.labelPingJia.text=@"很差";
            break;
        case 1:
            cell.labelPingJia.text=@"非常差";
            break;
            
        default:
            break;
    }
    cell.imageXJ=[UIImage imageNamed:[NSString stringWithFormat:@"星星%i",i ]];
    cell.imageV.image=cell.imageXJ;
    
    dicL=nil;
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0;
}

-(void)viewDidDisappear:(BOOL)animated
{
//    [super viewDidDisappear:YES];
//    [self.navigationController popViewControllerAnimated:NO];
    nibsRegistered=nil;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
