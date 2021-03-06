//
//  DingDanXiangQingViewController.m
//  龙代驾
//
//  Created by mac on 13-10-21.
//  Copyright (c) 2013年 Ali Karagoz. All rights reserved.
//

#import "DingDanXiangQingViewController.h"
#import "FaPiaoViewController.h"
#import "FuWuPingJiaViewController.h"
#import "SiJiXiangQingViewController.h"
#import "FirstMapViewController.h"
#import "DangQianDingDanCell.h"
#import "CustomOverlayView.h"
#import "CustomOverlay.h"
#import "BMKRouteSearchType.h"
#import "BMKSearch.h"
#define w 55
#define h 15

@interface DingDanXiangQingViewController ()

@end

@implementation DingDanXiangQingViewController

@synthesize imagePic;

@synthesize btnFaPiao,btnGo,btnPhone,btnPingJia,btnNext;
@synthesize imageJiBie,imageV,imageBg;
@synthesize labelAdds,labelChuFaDi,labelChuFaShiJian,labelChuFaTime,labelDengHou,labelDengHouFei,labelDingDanHao;
@synthesize labelDingDanHaoMa,labelDingDanZhuangTai,labelFaPiao,labelFaPiaoKaiJv,labelHJTime,labelHuJiaoShiJian;
@synthesize labelKM,labelMuDiDi,labelName,labelQiBuJia,labelQiBuJiaGe,labelShiFuJinE,labelShiFuMoney,labelShiJian;
@synthesize labelXingShi,labelYingShouJinE,labelYouHui,labelYouHuiJinE,labelYSJinE,labelYuYue,labelZhongDian,labelZhuangTai;
@synthesize labelFaPiaoYouZi,labelLiChengMoney,labelYouHuiMoney,labelFPYouzi,labelLCMoney,labelYHMoney;

@synthesize dicList;

@synthesize arrSJ;
@synthesize activityView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(id)initWithDic:(NSDictionary *)dic
{
    self=[super init];
    if (self) {
        self.dicList=dic;
        
        
    }
    return self;
}

-(void)btnPress:(id)sender
{
    UIButton * btn=sender;
    if (btn.tag==1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[self.dicList objectForKey:@"daijia_phone"]]];
        NSLog(@"phone=%@",[self.dicList objectForKey:@"daijia_phone"]);
    }
    if (btn.tag==2) {
        FaPiaoViewController * fapiao=[[FaPiaoViewController alloc]initWithStr:[self.dicList objectForKey:@"daijia_id"]];
        [self.navigationController pushViewController:fapiao animated:YES];
        fapiao=nil;
    }
    if (btn.tag==3) {
        FuWuPingJiaViewController * fuwu=[[FuWuPingJiaViewController alloc]initWithDic:self.dicList];
        [self.navigationController pushViewController:fuwu animated:YES];
        fuwu=nil;
    }
    if (btn.tag==4) {
        
        SiJiXiangQingViewController * siji=[[SiJiXiangQingViewController alloc]initWithDic:[self.arrSJ objectAtIndex:0] f:@"3"];
        NSLog(@"%@",self.arrSJ);
        [self.navigationController pushViewController:siji animated:YES];
        siji=nil;
    }
    if (btn.tag==5) {
        if ([self.arrSJ count]==0) {
            SiJiXiangQingViewController * siji=[[SiJiXiangQingViewController alloc]initWithDic:self.dicList f:@"3"];
            [self.navigationController pushViewController:siji animated:YES];
            siji=nil;

        }
        else
        {
        SiJiXiangQingViewController * siji=[[SiJiXiangQingViewController alloc]initWithDic:[self.arrSJ objectAtIndex:0] f:@"3"];
            [self.navigationController pushViewController:siji animated:YES];
            siji=nil;

        }
        
    }
    btn=nil;
}
-(void)addButton
{
    
    self.btnNext=[UIButton buttonWithType:UIButtonTypeCustom];
    self.btnNext.frame=CGRectMake(3, 68, 314, 70);
    self.btnNext.tag=5;
    [self.btnNext addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnNext];
    self.btnNext=nil;
    
    self.imageBg=[[UIImageView alloc]initWithFrame:CGRectMake(3, 68, 314, 70)];
    UIImage * iamgeBg=[UIImage imageNamed:@"文本.png"];
    [self.imageBg setImage:iamgeBg];
    [self.view addSubview:self.imageBg];
    iamgeBg=nil;
    self.imageBg=nil;
    
    self.imageV=[[UIImageView alloc]initWithFrame:CGRectMake(12, 70, 55, 64)];
    [self.imageV setImage:self.imagePic];
    [self.view addSubview:self.imageV];
    self.imageV=nil;
    
    self.labelName=[[UILabel alloc]initWithFrame:CGRectMake(70, 80, w , h )];
    self.labelName.text=[self.dicList objectForKey:@"daijia_name"];
    [self.view addSubview:self.labelName];
    self.labelName=nil;
    
    self.imageJiBie=[[UIImageView alloc]initWithFrame:CGRectMake(140, 80, 80, 15)];
    UIImage * image=[UIImage imageNamed:[NSString stringWithFormat:@"星星%@", [self.dicList objectForKey:@"daijia_jiebie_id"]]];
    [self.imageJiBie setImage:image];
    [self.view addSubview:self.imageJiBie];
    self.imageJiBie=nil;
   image=nil;
    
    UIFont * textFont=[UIFont systemFontOfSize:12];
    UIColor * textColor=[UIColor colorWithWhite:0.6 alpha:1.0];
    
    self.labelYuYue=[[UILabel alloc]initWithFrame:CGRectMake(70, 100, w, h)];
    self.labelYuYue.text=@"预约时间:";
    self.labelYuYue.textColor=textColor;
    self.labelYuYue.font=textFont;
    [self.view addSubview:self.labelYuYue];
    self.labelYuYue=nil;
    
    self.labelShiJian=[[UILabel alloc]initWithFrame:CGRectMake(130, 100, w+w+w, h)];
    self.labelShiJian.textColor=textColor;
    self.labelShiJian.font=textFont;
    self.labelShiJian.text=[self.dicList objectForKey:@"yuchu_time"];
    [self.view addSubview:self.labelShiJian];
    self.labelShiJian=nil;
    
    self.labelChuFaDi =[[UILabel alloc]initWithFrame:CGRectMake(70, 120, w, h)];
    self.labelChuFaDi.text=@"出 发 地:";
    self.labelChuFaDi.textColor=textColor;
    self.labelChuFaDi.font=textFont;
    [self.view addSubview:self.labelChuFaDi];
    self.labelChuFaDi=nil;
    
    self.labelAdds=[[UILabel alloc]initWithFrame:CGRectMake(130, 120, w+w+w, h)];
    self.labelAdds.textColor=textColor;
    self.labelAdds.font=textFont;
    self.labelAdds.text=[self.dicList objectForKey:@"yuyue_didian"];
    [self.view addSubview:self.labelAdds];
   self.labelAdds=nil;
    
    self.labelDingDanHaoMa=[[UILabel alloc]initWithFrame:CGRectMake(70, 140, w+w, h)];
    self.labelDingDanHaoMa.text=[self.dicList objectForKey:@"order_num"];
    self.labelDingDanHaoMa.font=textFont;
    [self.view addSubview:self.labelDingDanHaoMa];
    self.labelDingDanHaoMa=nil;
    
    
    self.labelZhuangTai=[[UILabel alloc]initWithFrame:CGRectMake(250, 140, w, h)];
    int i =[[self.dicList objectForKey:@"order_status"]intValue];
    switch (i) {
        case 0:
            self.labelZhuangTai.text=@"待分派";
            break;
        case 1:
            self.labelZhuangTai.text=@"正在执行";
            break;
        case 2:
            self.labelZhuangTai.text=@"已完成";
            break;
        case 3:
            self.labelZhuangTai.text=@"已取消";
            break;
            
        default:
            break;
    }
    self.labelZhuangTai.font=textFont;
    [self.view addSubview:self.labelZhuangTai];
    self.labelZhuangTai=nil;
    //目的地
    self.labelZhongDian=[[UILabel alloc]initWithFrame:CGRectMake(70, 160, 200, h)];
    self.labelZhongDian.text=[self.dicList objectForKey:@"zhongdian"];
    self.labelZhongDian.font=textFont;
    [self.view addSubview:self.labelZhongDian];
    self.labelZhongDian=nil;
    
    //呼叫时间
    self.labelHJTime=[[UILabel alloc]initWithFrame:CGRectMake(70, 180, w+w, h)];
    //   self.labelHJTime.text=[self.dicList objectForKey:@""];
    self.labelHJTime.font=textFont;
    [self.view addSubview:self.labelHJTime];
    self.labelHJTime=nil;
    
    //等候费
    self.labelDengHouFei=[[UILabel alloc]initWithFrame:CGRectMake(250, 220, w, h)];
    self.labelDengHouFei.text=[self.dicList objectForKey:@"denghoufei"];
    self.labelDengHouFei.font=textFont;
    [self.view addSubview:self.labelDengHouFei];
    self.labelDengHouFei=nil;
    
    //出发时间
    self.labelChuFaTime=[[UILabel alloc]initWithFrame:CGRectMake(250, 180, w+w+w, h)];
    
    if ([[self.dicList objectForKey:@"go_time"] isKindOfClass:[NSNull class]]) {
        self.labelChuFaTime.text=@"";
    }
    else
    {
        self.labelChuFaTime.text=[self.dicList objectForKey:@"go_time"];
    }
    
    self.labelChuFaTime.font=textFont;
    [self.view addSubview:self.labelChuFaTime];
    self.labelChuFaTime=nil;
    
    //起步价
    self.labelQiBuJiaGe=[[UILabel alloc]initWithFrame:CGRectMake(70, 220, w, h)];
    self.labelQiBuJiaGe.text=[self.dicList objectForKey:@"price"];
    self.labelQiBuJiaGe.font=textFont;
    [self.view addSubview:self.labelQiBuJiaGe];
    self.labelQiBuJiaGe=nil;
    
    //行驶公里
    self.labelKM=[[UILabel alloc]initWithFrame:CGRectMake(70, 200, w, h)];
    if ([[self.dicList objectForKey:@"km"] isKindOfClass:[NSNull class]]) {
        self.labelKM.text=@"";
    }
    else
    {
        self.labelKM.text=[self.dicList objectForKey:@"km"];
    }
    
    self.labelKM.font=textFont;
    [self.view addSubview:self.labelKM];
    self.labelKM=nil;
    
    //应收金额
    self.labelYSJinE=[[UILabel alloc]initWithFrame:CGRectMake(70, 240, w, h)];
    self.labelYSJinE.text=[self.dicList objectForKey:@"yshoufei"];
    self.labelYSJinE.font=textFont;
    [self.view addSubview:self.labelYSJinE];
    self.labelYSJinE=nil;
    
    //开具发票
    self.labelFaPiao=[[UILabel alloc]initWithFrame:CGRectMake(250, 200, w+w+w+w, h)];
    int p=[[self.dicList objectForKey:@"fapiao"]intValue];
    if (p==0) {
        self.labelFaPiao.text=@"否";
    }
    else
    {
        self.labelFaPiao.text=@"是";
    }
    
    self.labelFaPiao.font=textFont;
    [self.view addSubview:self.labelFaPiao];
    self.labelFaPiao=nil;
    
    //实付金额
    self.labelShiFuMoney=[[UILabel alloc]initWithFrame:CGRectMake(250, 260, w, h)];
    self.labelShiFuMoney.text=[self.dicList objectForKey:@"shoufei"];
    self.labelShiFuMoney.font=textFont;
    [self.view addSubview:self.labelShiFuMoney];
    self.labelShiFuMoney=nil;
    //里程金额
    self.labelLCMoney=[[UILabel alloc]initWithFrame:CGRectMake(70, 260, w , h)];
    self.labelLCMoney.text=[self.dicList objectForKey:@"mileage"];
    self.labelLCMoney.font=textFont;
    [self.view addSubview:self.labelLCMoney];
    self.labelLCMoney=nil;
    //优惠金额
    self.labelYHMoney=[[UILabel alloc]initWithFrame:CGRectMake(250, 240, w , h)];
    self.labelYHMoney.text=[self.dicList objectForKey:@"youhui"];
    self.labelYHMoney.font=textFont;
    [self.view addSubview:self.labelYHMoney];
    self.labelYHMoney=nil;
    
    
    self.labelFaPiaoYouZi=[[UILabel alloc]initWithFrame:CGRectMake(190, 240, w , h)];
    self.labelFaPiaoYouZi.text=@"发票邮资:";
    self.labelFaPiaoYouZi.font=textFont;
    self.labelFaPiaoYouZi.textColor=[UIColor grayColor];
    if (p!=0) {
        [self.view addSubview:self.labelFaPiaoYouZi];
    }
    self.labelFaPiaoYouZi=nil;
    
    self.labelFPYouzi=[[UILabel alloc]initWithFrame:CGRectMake(250, 240, w, h)];
    self.labelFPYouzi.text=@"7元";
    self.labelFPYouzi.font=textFont;
    self.labelFPYouzi.textColor=[UIColor grayColor];
    if (p!=0) {
        [self.view addSubview:self.labelFPYouzi];
    }
self.labelFPYouzi=nil;
    
    textFont=nil;
    
    
    self.btnPhone=[UIButton buttonWithType:UIButtonTypeCustom];
    self.btnPhone.frame=CGRectMake(260, 90, 30, 30);
    self.btnPhone.tag=1;
    UIImage * imageBtnPhone=[UIImage imageNamed:@"Phone1.png"];
    [self.btnPhone setImage:imageBtnPhone forState:UIControlStateNormal];
    [self.btnPhone addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnPhone];
    self.btnPhone=nil;
    imageBtnPhone=nil;
    
    self.btnGo=[UIButton buttonWithType:UIButtonTypeCustom];
    self.btnGo.frame=CGRectMake(290, 95, 20, 20);
    self.btnGo.tag=4;
    UIImage * imageGo=[UIImage imageNamed:@"next.png"];
    [self.btnGo setImage:imageGo forState:UIControlStateNormal];
    [self.btnGo addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnGo];
    self.btnGo=nil;
    imageGo=nil;
    
    self.btnFaPiao=[UIButton buttonWithType:UIButtonTypeCustom];
    self.btnFaPiao.frame=CGRectMake(80, 290, 70, 25);
    self.btnFaPiao.tag=2;
    
    UIImage * imageFaPiao=[UIImage imageNamed:@"发票补录.png"];
    if (p==0) {
        imageFaPiao=[UIImage imageNamed:@"fapiao.png"];
        self.btnFaPiao.enabled=NO;
    }
    
    [self.btnFaPiao setImage:imageFaPiao forState:UIControlStateNormal];
    [self.btnFaPiao addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnFaPiao];
    self.btnFaPiao=nil;
    imageFaPiao=nil;
    
    
    self.btnPingJia=[UIButton buttonWithType:UIButtonTypeCustom];
    self.btnPingJia.frame=CGRectMake(170, 290, 70, 25);
    self.btnPingJia.tag=3;
    UIImage * imagePJ=[UIImage imageNamed:@"服务评价.png"];
    [self.btnPingJia setImage:imagePJ forState:UIControlStateNormal];
    [self.btnPingJia addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnPingJia];
    self.btnPingJia=nil;
    imagePJ=nil;
    
    
    [self.activityView stopAnimating];
    
}
-(void)updateData
{
    NSString * strid=[self.dicList objectForKey:@"id"];
    [self.activityView startAnimating];

    self.data.length = 0;
    NSString * str=[NSString stringWithFormat:@"http://fr.eslgw.com/index.php/mobile/get_history_order_info?id=%@",strid];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:str] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];

}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.activityView stopAnimating];

    [self.data appendData:data];
    if (self.data) {
        self.arrSJ=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        self.dicList = [self.arrSJ objectAtIndex:0];
        NSLog(@"self.arrSj=%@",self.dicList);
        NSLog(@"UUID=%@",[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil]);
        [self addButton];

    }
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *) error {
    self.data = nil;
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
    //[SVProgressHUD dismiss];
    [self.activityView stopAnimating];
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络连接失败，请稍后重试。" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"订单详情";
    self.data = [[NSMutableData alloc] init];

    _historyMap = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 337, 320, 180)];
    [self.view addSubview:_historyMap];
    _historyMap.delegate = self;
    int num = 4;
    
    CLLocationCoordinate2D coors[4] = {0};
    coors[0].latitude = 39.315;
    coors[0].longitude = 116.304;
    coors[1].latitude = 39.515;
    coors[1].longitude = 116.504;
    coors[2].latitude = 39.515;
    coors[2].longitude = 116.504;
    coors[3].latitude = 39.815;
    coors[3].longitude = 116.704;
    _historyMap.centerCoordinate = coors[0];
    BMKPolyline* polyline = [BMKPolyline polylineWithCoordinates:coors count:4];
    [_historyMap addOverlay:polyline];
   
    for (int i = 0; i < num; i++) {
        // 添加一个PointAnnotation
        BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
        annotation.coordinate = coors[i];
        annotation.title = @"司机当前位置";
        [_historyMap addAnnotation:annotation];
    }
    
    
    
    UIFont * textFont=[UIFont systemFontOfSize:12];

    self.labelDingDanHao=[[UILabel alloc]initWithFrame:CGRectMake(10, 140, w, h)];
    self.labelDingDanHao.text=@"订 单 号:";
    self.labelDingDanHao.font=textFont;
    [self.view addSubview:self.labelDingDanHao];
    self.labelDingDanHao=nil;
    
    self.labelDingDanZhuangTai=[[UILabel alloc]initWithFrame:CGRectMake(190, 140, w, h)];
    self.labelDingDanZhuangTai.text=@"订单状态:";
    self.labelDingDanZhuangTai.font=textFont;
    [self.view addSubview:self.labelDingDanZhuangTai];
    self.labelDingDanZhuangTai=nil;
    
    self.labelMuDiDi=[[UILabel alloc]initWithFrame:CGRectMake(10, 160, w, h)];
    self.labelMuDiDi.text=@"目 的 地:";
    self.labelMuDiDi.font=textFont;
    [self.view addSubview:self.labelMuDiDi];
    self.labelMuDiDi=nil;
    
    self.labelHuJiaoShiJian=[[UILabel alloc]initWithFrame:CGRectMake(10, 180, w, h)];
    self.labelHuJiaoShiJian.text=@"呼叫时间:";
    self.labelHuJiaoShiJian.font=textFont;
    [self.view addSubview:self.labelHuJiaoShiJian];
    self.labelHuJiaoShiJian=nil;
    
    self.labelDengHou=[[UILabel alloc]initWithFrame:CGRectMake(190, 220, w, h)];
    self.labelDengHou.text=@"等 候 费:";
    self.labelDengHou.font=textFont;
    [self.view addSubview:self.labelDengHou];
    self.labelDengHou=nil;
    
    self.labelChuFaShiJian=[[UILabel alloc]initWithFrame:CGRectMake(190, 180, w, h)];
    self.labelChuFaShiJian.text=@"出发时间:";
    self.labelChuFaShiJian.font=textFont;
    [self.view addSubview:self.labelChuFaShiJian];
    self.labelChuFaShiJian=nil;
    
    
    self.labelQiBuJia=[[UILabel alloc]initWithFrame:CGRectMake(10, 220, w, h)];
    self.labelQiBuJia.text=@"起 步 价:";
    self.labelQiBuJia.font=textFont;
    [self.view addSubview:self.labelQiBuJia];
    self.labelQiBuJia=nil;
    
    self.labelXingShi=[[UILabel alloc]initWithFrame:CGRectMake(10, 200, w, h)];
    self.labelXingShi.text=@"行驶公里:";
    self.labelXingShi.font=textFont;
    [self.view addSubview:self.labelXingShi];
    self.labelXingShi=nil;
    
    self.labelYingShouJinE=[[UILabel alloc]initWithFrame:CGRectMake(10, 240, w, h)];
    self.labelYingShouJinE.text=@"应收金额:";
    self.labelYingShouJinE.font=textFont;
    [self.view addSubview:self.labelYingShouJinE];
    self.labelYingShouJinE=nil;
    
    self.labelFaPiaoKaiJv=[[UILabel alloc]initWithFrame:CGRectMake(190, 200, w, h)];
    self.labelFaPiaoKaiJv.text=@"发票开据:";
    self.labelFaPiaoKaiJv.font=textFont;
    [self.view addSubview:self.labelFaPiaoKaiJv];
    self.labelFaPiaoKaiJv=nil;
    
    self.labelShiFuJinE=[[UILabel alloc]initWithFrame:CGRectMake(190, 260, w, h)];
    self.labelShiFuJinE.text=@"实付金额:";
    self.labelShiFuJinE.font=textFont;
    [self.view addSubview:self.labelShiFuJinE];
    self.labelShiFuJinE=nil;
    
    self.labelLiChengMoney=[[UILabel alloc]initWithFrame:CGRectMake(10, 260, w , h)];
    self.labelLiChengMoney.text=@"里程金额:";
    self.labelLiChengMoney.font=textFont;
    [self.view addSubview:self.labelLiChengMoney];
    self.labelLiChengMoney=nil;
    
    
    self.labelYouHuiMoney=[[UILabel alloc]initWithFrame:CGRectMake(190, 240, w , h)];
    self.labelYouHuiMoney.text=@"优惠金额:";
    self.labelYouHuiMoney.font=textFont;
    [self.view addSubview:self.labelYouHuiMoney];
    self.labelYouHuiMoney=nil;
    if (self.dicList) {
        [self addButton];
    }else
    {
       // [self performSelector:@selector(updateData) withObject:nil afterDelay:0.1];
        
    }
    self.activityView=[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(135, ([UIScreen mainScreen].bounds.size.height-200), 50, 50)];
    [self.activityView setBackgroundColor:[UIColor blackColor]];
    self.activityView.alpha = 0.4;
    [self.view addSubview:self.activityView];
    [self.activityView startAnimating];
}
- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id <BMKOverlay>)overlay
{
    if ([overlay isKindOfClass:[BMKPolyline class]]){
        BMKPolylineView* polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
        polylineView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:1];
        polylineView.lineWidth = 2.0;
        return polylineView;
    }
    return nil;
    
}
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        return newAnnotationView;
    }
    return nil;
}
- (void)mapViewWillStartLocatingUser:(BMKMapView *)mapView
{
    NSLog(@"start locating");
}

/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */
- (void)mapViewDidStopLocatingUser:(BMKMapView *)mapView
{
    NSLog(@"stop locating");
}

/**
 *用户位置更新后，会调用此函数
 *@param mapView 地图View
 *@param userLocation 新的用户位置
 */
- (void)mapView:(BMKMapView *)mapView didUpdateUserLocation:(BMKUserLocation *)userLocation
{
   // [self._mapView setCenterCoordinate:self._mapView.userLocation.coordinate animated:YES];
}

/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)mapView:(BMKMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
    UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"定位失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}
-(void)viewWillAppear:(BOOL)animated
{
    [_historyMap viewWillAppear];
    _historyMap.delegate = self;
    _search.delegate = self;
    //_historyMap.showsUserLocation = YES;
}
-(void)viewDidAppear:(BOOL)animated
{
    [self updateData];

}
-(void)viewWillDisappear:(BOOL)animated
{
    [_historyMap viewWillDisappear];
    [_historyMap removeFromSuperview];
    _historyMap.delegate = nil;
    _search.delegate = nil;
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
