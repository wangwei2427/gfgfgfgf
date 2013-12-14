//
//  MapViewController.m
//  map
//
//  Created by mac on 13-10-10.
//  Copyright (c) 2013年 龙代驾. All rights reserved.
//


#import "MapViewController.h"

#import "SiJiXiangQingViewController.h"
#import "MainViewController.h"
#import "BasicMapAnnotation.h"
#import "MapCallOutAnnotation.h"
#import "MapOutAnnotationView.h"
#import "MapCellViewController.h"
#import "MapMainViewController.h"
#import "OneViewController.h"
#import "FirstMapViewController.h"
#define span 0.01

@interface MapViewController ()
{
    NSMutableArray *_annotationList;
    NSArray * array;
    
    BOOL isNull;

    MapCallOutAnnotation * _calloutAnnotation;
    //反地理编码
    CLLocationManager *locManager;

}

@end

@implementation MapViewController
@synthesize arrayList;
@synthesize dicList;
@synthesize _mapView;
@synthesize annoView;
@synthesize btn2;
@synthesize btn1;
@synthesize delegate;
@synthesize strFather;
@synthesize strLat;
@synthesize strLon;
@synthesize activityView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(id)initWithFather:(NSString * )f
{
    self=[super init];
    if (self) {
        self.strFather=f;
    }
    return self;
}
-(void)setAnnotionsWithList:(NSArray *)list
{
    NSLog(@"list count=%i", [list count]);
    for (NSDictionary *dic in list) {
        self.dicList=nil;
        self.dicList=dic;
   //     CLLocationDegrees latitude=[[dic objectForKey:@"lat"] doubleValue];
    //    CLLocationDegrees longitude=[[dic objectForKey:@"lng"] doubleValue];
        
        CLLocationDegrees latitude=[[dic objectForKey:@"lng"] doubleValue];
        CLLocationDegrees longitude=[[dic objectForKey:@"lat"] doubleValue];
        
        BasicMapAnnotation * annotation=[[BasicMapAnnotation alloc]init];
        annotation.coordinate=CLLocationCoordinate2DMake(latitude, longitude);
        annotation.title=[dic objectForKey:@"id"];
        [self._mapView addAnnotation:annotation];
      //  latitude=nil;
       // longitude=nil;
    }
}

- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    NSLog(@"view for annotation");


    if ([annotation isKindOfClass:[BMKPointAnnotation class]]){
        BMKPinAnnotationView * newAnnotationView=[[BMKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor=BMKPinAnnotationColorPurple;
        newAnnotationView.animatesDrop=YES;      //设置该标注点动画显示
        newAnnotationView.image=[UIImage imageNamed:@"pin_red.png"];
        return newAnnotationView;
    }
    else
    {
        MapOutAnnotationView * annotationView=(MapOutAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"CalloutView"];
        if (!annotationView) {

                annotationView=[[MapOutAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"CalloutView"];
           
                MapCellViewController * cell=[[MapCellViewController alloc]initWithTitle:[self.dicList objectForKey:@"daijia_name"] Jibie:[[self.dicList objectForKey:@"daijia_jiebie_id"] intValue] Zhuangtai:[[self.dicList objectForKey:@"driverStatus"]intValue ]];
                [annotationView.contentView addSubview:cell.view];  
        }
       return annotationView;
    }
    return nil;
}

-(void)btnPress:(id)sender
{
    UIButton * btn=sender;
    if (btn.tag==2) {
        self._mapView.zoomLevel++;
     
        BOOL isOK=self._mapView.zoomIn;
        if (isOK) {
          NSLog(@"isOK");
          NSLog(@"zoomlevel=%f",self._mapView.zoomLevel);
        }
     //   isOK=nil;
    }
    else
    {
        self._mapView.zoomLevel--;
        BOOL isOK=self._mapView.zoomOut;
        if (isOK) {
            NSLog(@"isOK");
             NSLog(@"zoomlevel=%f",self._mapView.zoomLevel);
        }
      //  isOK=nil;
    }
    btn=nil;
}


- (void)resetAnnitations:(NSArray *)data
{
    [_annotationList removeAllObjects];
    [_annotationList addObjectsFromArray:data];
    [self setAnnotionsWithList:_annotationList];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    isNull=YES;
    
    
    _search = [[BMKSearch alloc]init];
    _search.delegate = self;
    
    
    self.title=@"地图";
    self.activityView=[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(110, ([UIScreen mainScreen].bounds.size.height-100)/2, 100, 100)];
    [ self.activityView setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:self.activityView];
   // [self.activityView startAnimating];
    
    self.btn1=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn1.tag=1;
    self.btn1.frame=CGRectMake(210, [UIScreen mainScreen].bounds.size.height-45, 50, 30);
    
    UIImage * imageOut=[UIImage imageNamed:@"zoomout.png"];
    [self.btn1 setImage:imageOut forState:UIControlStateNormal];
    [self.btn1 addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btn1];
    
    
    self.btn2=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn2.tag=2;
   
     self.btn2.frame=CGRectMake(260, [UIScreen mainScreen].bounds.size.height-45, 50, 30);


    UIImage * imageIn=[UIImage imageNamed:@"zoomin.png"];
    [self.btn2 setImage:imageIn forState:UIControlStateNormal];
    [self.btn2 addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
    imageIn=nil;
    _annotationList = [[NSMutableArray alloc] init];
    
    //self._mapView = [[BMKMapView alloc]init];
    self._mapView.frame=CGRectMake(0, 65, 320, [UIScreen mainScreen].bounds.size.height-65);
    //[self.view addSubview:self._mapView];
 
    self._mapView.delegate = self;
    self._mapView.showsUserLocation=YES;
    self._mapView.zoomEnabled=YES;
    self._mapView.zoomLevel=16.0;
    
    [self.view addSubview:self.btn2];
    MainViewController * mm=[MainViewController SingleInit];
    self.arrayList=mm.arrayMain;
   //[self resetAnnitations:self.arrayList];

    
	// Do any additional setup after loading the view.
}
//-(void)updataXY
//{
//    
//    NSString * str=[NSString stringWithFormat:@"http://fr.eslgw.com/index.php/mobile/river_list?lng=%@&lat=%@",self.strLat,self.strLon];
//    
//    NSError * error;
//    NSURLRequest * request=[NSURLRequest requestWithURL:[NSURL URLWithString:str]];
//    NSData * response=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//    if (response){
//        [self.activityView stopAnimating];
//        self.arrayList=[NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
//        [self resetAnnitations:self.arrayList];
//        MainViewController * main=[MainViewController SingleInit];
//        main.arrayMain=self.arrayList;
//        
//        
//        NSLog(@"map map map map map map map");
//    }
//    
//    
//    //    MainViewController * main=[MainViewController SingleInit];
//    //    main.arrayMain=nil;
//    //    [main updataXY];
//    //    self.arrayList=main.arrayMain;
//    //    MapMainViewController * mapMain=[MapMainViewController SingleInit];
//    //    mapMain.arrayList=self.arrayList;
//    //    [self resetAnnitations:self.arrayList];
//}

- (void)viewDidUnload {
    [super viewDidUnload];
    self._mapView.showsUserLocation=NO;
    self._mapView.delegate = nil;
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(void)viewWillAppear:(BOOL)animated
{
//    self._mapView.delegate = self;
//    self._mapView.showsUserLocation=YES;
//    self._mapView.zoomEnabled=YES;
//    self._mapView.zoomLevel=16.0;
//    [self.view addSubview:self.btn2];
//    MainViewController * mm=[MainViewController SingleInit];
//    self.arrayList=mm.arrayMain;
//    [self resetAnnitations:self.arrayList];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
   

   // self._mapView.delegate=nil;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    self._mapView.delegate=nil;
    // Dispose of any resources that can be recreated.
}

-(void)ttt
{
    NSLog(@"annoView.title=%@",self.annoView.annotation.title);
    
    NSDictionary * dicSJ;
    for (NSDictionary * dic   in self.arrayList) {
        if ([[dic objectForKey:@"id"] isEqualToString:self.annoView.annotation.title]) {
            dicSJ=dic;
            NSLog(@"dicsj=%@",dicSJ);
            SiJiXiangQingViewController * siji=[[SiJiXiangQingViewController alloc]initWithDic:dicSJ father:self.strFather];
            // FirstMapViewController * firstMap=[FirstMapViewController SingleInit];
            MainViewController * main=[MainViewController SingleInit];
            [main.nav pushViewController:siji animated:YES];
            siji=nil;
            return;
        
        }
    }
}
- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{

    self.annoView=view;
    if ([view.annotation isKindOfClass:[BasicMapAnnotation class]]) {
        [self ttt];
        [mapView deselectAnnotation:view.annotation animated:YES];
    }
    
    
}

- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id <BMKOverlay>)overlay
{
    return nil;
}

- (void)mapViewWillStartLocatingUser:(BMKMapView *)mapView
{
    NSLog(@"start location");
}

/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */
- (void)mapViewDidStopLocatingUser:(BMKMapView *)mapView
{
    NSLog(@"stop location");
}

/**
 *用户位置更新后，会调用此函数
 *@param mapView 地图View
 *@param userLocation 新的用户位置
 */
- (void)mapView:(BMKMapView *)mapView didUpdateUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"userLocation.latitude=%f",userLocation.location.coordinate.latitude);
    NSLog(@"userLocation.longitude=%f",userLocation.location.coordinate.longitude);
    self.strLat=[NSString stringWithFormat:@"%f",userLocation.location.coordinate.latitude];
    self.strLon=[NSString stringWithFormat:@"%f",userLocation.location.coordinate.longitude];
    
    if (isNull) {
        [self._mapView setCenterCoordinate:self._mapView.userLocation.coordinate animated:YES];
        isNull=nil;
        //反编译
        CLLocationCoordinate2D pt = (CLLocationCoordinate2D){0, 0};
        pt = (CLLocationCoordinate2D){[self.strLat doubleValue], [self.strLon doubleValue]};
        BOOL flag = [_search reverseGeocode:pt];
        if (flag) {
            NSLog(@"ReverseGeocode search success.");
            
        }
        else{
            NSLog(@"ReverseGeocode search failed!");
//            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请检查定位功能或稍后重试" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [alert show];
            
        }
    
    }


   // self._mapView.showsUserLocation=NO;
   
    NSLog(@"strlat =%@",self.strLat);
}
//处理反编译结果
- (void)onGetAddrResult:(BMKAddrInfo*)result errorCode:(int)error
{
    
    if (result.strAddr != nil) {
        UILabel *address = [[UILabel alloc]init];
        address.frame = CGRectMake(0, 0, 320, 20);
        address.backgroundColor = [UIColor blackColor];
        address.textColor = [UIColor whiteColor];
        address.textAlignment = NSTextAlignmentCenter;
        address.alpha = 0.6;
        address.text = result.strAddr;
        [_mapView addSubview:address];
        
    }
}

/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)mapView:(BMKMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
    
}


@end