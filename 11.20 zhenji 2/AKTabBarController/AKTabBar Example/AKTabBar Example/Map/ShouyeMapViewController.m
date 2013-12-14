//
//  ShouyeMapViewController.m
//  龙代驾
//
//  Created by mac on 13-11-11.
//  Copyright (c) 2013年 Ali Karagoz. All rights reserved.
//

#import "ShouyeMapViewController.h"
#import "BMapKit.h"
#import "SiJiXiangQingViewController.h"
#import "MainViewController.h"
#import "BasicMapAnnotation.h"
#import "MapCallOutAnnotation.h"
#import "MapOutAnnotationView.h"
#import "MapCellViewController.h"
#import "MapMainViewController.h"
#import "OneViewController.h"
#import "AppDelegate.h"

#define span 0.01


@interface ShouyeMapViewController ()
{
    NSMutableArray *_annotationList;
    NSArray * array;
    BOOL isNull;
    MapCallOutAnnotation * _calloutAnnotation;
    BOOL isLoad;
}
@end

@implementation ShouyeMapViewController

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
@synthesize act;

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
    
    NSLog(@"list count=%@", list );
    
    for (NSDictionary *dic in list) {
        self.dicList=nil;
        self.dicList=dic;
     //   CLLocationDegrees latitude=[[dic objectForKey:@"lat"] doubleValue];
      //  CLLocationDegrees longitude=[[dic objectForKey:@"lng"] doubleValue];
        
        CLLocationDegrees latitude=[[dic objectForKey:@"lng"] doubleValue];
        CLLocationDegrees longitude=[[dic objectForKey:@"lat"] doubleValue];
        
        BasicMapAnnotation * annotation=[[BasicMapAnnotation alloc]init];
        annotation.coordinate=CLLocationCoordinate2DMake(latitude, longitude);
        annotation.title=[dic objectForKey:@"id"];
        [self._mapView addAnnotation:annotation];
     //   latitude=nil;
     //   longitude=nil;
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
            NSLog(@"%@",[self.dicList objectForKey:@"daijia_name"]);
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
    
    }
    else
    {
        self._mapView.zoomLevel--;
    }
    btn=nil;
}


- (void)resetAnnitations:(NSArray *)data
{
    NSLog(@"reset");
    
    [_annotationList removeAllObjects];
    [_annotationList addObjectsFromArray:data];
    [self setAnnotionsWithList:_annotationList];
    CLLocationCoordinate2D location;
    location.latitude = [self.strLat doubleValue];
    location.longitude = [self.strLon doubleValue];
    [self._mapView setCenterCoordinate:location animated:YES];

}

-(void)viewWillAppear:(BOOL)animated
{
  
    
    self.activityView=[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(135, ([UIScreen mainScreen].bounds.size.height-100), 50, 50)];
    [ self.activityView setBackgroundColor:[UIColor blackColor]];
    self.activityView.alpha = 0.4;
    [self.view addSubview:self.activityView];
    //[self.activityView startAnimating];
    
    self._mapView.delegate = self;
    self._mapView.showsUserLocation = YES;
    self._mapView.zoomEnabled = YES;
    self._mapView.zoomLevel=16.0;
    if (self.arrayList) {
        [self.activityView stopAnimating];
    }
    isNull=YES;
    //[self updataXY];

}

-(void)viewDidDisappear:(BOOL)animated
{
    self._mapView.showsUserLocation = NO;
    self._mapView.delegate = nil;
    
    NSLog(@"shouye map  out");
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
//     NSLog(@"UUID=%@",[[UIDevice currentDevice]identifierForVendor]);
//    NSString * str=[NSString stringWithFormat:@"http://fr.eslgw.com/index.php/mobile/ceshi_map"];
//                    //,[[UIDevice currentDevice]identifierForVendor]];
//    //NSString * str=[NSString stringWithFormat:@"http://fr.eslgw.com/index.php/mobile/registerUser"];
//    NSURLRequest * request=[NSURLRequest requestWithURL:[NSURL URLWithString:str]];
//    NSOperationQueue *que = [[NSOperationQueue alloc]init];
//    [NSURLConnection sendAsynchronousRequest:request queue:que completionHandler:^(NSURLResponse * response,NSData * data,NSError * error){
//        if (error) {
//            NSLog(@"httperror:%@%d",error.localizedDescription,error.code);
//            response=nil;
//            data=nil;
//            error=nil;
//
//        }
//        else{
//            
//           //NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
//            NSLog(@"UUID=%@",[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error]);
//        }
//     }];
//    
    
    isNull=YES;
    
    isLoad = NO;
    _search = [[BMKSearch alloc]init];
    _search.delegate = self;
    
    self.title=@"地图";
    
    
    self.btn1=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn1.tag=1;
    self.btn1.frame=CGRectMake(210, [UIScreen mainScreen].bounds.size.height-50, 50, 30);
    UIImage * imageOut=[UIImage imageNamed:@"zoomout.png"];
    [self.btn1 setImage:imageOut forState:UIControlStateNormal];
    [self.btn1 addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btn1];
    
    
    self.btn2=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn2.tag=2;
    self.btn2.frame=CGRectMake(260, [UIScreen mainScreen].bounds.size.height-50, 50, 30);
    UIImage * imageIn=[UIImage imageNamed:@"zoomin.png"];
    [self.btn2 setImage:imageIn forState:UIControlStateNormal];
    [self.btn2 addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
    imageIn=nil;
    _annotationList = [[NSMutableArray alloc] init];
    //self._mapView = [[BMKMapView alloc]init];
    self._mapView.frame=CGRectMake(0, 65, 320, [UIScreen mainScreen].bounds.size.height-65);
    [self.view addSubview:self.btn2];

    UIButton *location = [UIButton buttonWithType:UIButtonTypeCustom];
    location.frame = CGRectMake(15, [UIScreen mainScreen].bounds.size.height-80, 40, 40);
    [location setBackgroundImage:[UIImage imageNamed:@"btn_locatebg"] forState:UIControlStateNormal];
    [self.view addSubview:location];
    [location addTarget:self action:@selector(reLocated) forControlEvents:UIControlEventTouchUpInside];
    
  	// Do any additional setup after loading the view.
}

-(void)reLocated{
    [self updataXY];
}
-(void)updataXY
{
   
    NSString * str=[NSString stringWithFormat:@"http://fr.eslgw.com/index.php/mobile/river_list?lng=%@&lat=%@",self.strLat,self.strLon];
  [self.activityView startAnimating];
    NSURLRequest * request=[NSURLRequest requestWithURL:[NSURL URLWithString:str]];
    NSData * response=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if (response) {
        isLoad = YES;
        self.arrayList=[NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:nil];
        [self.activityView stopAnimating];
        self._mapView.zoomLevel=16.0;
        NSLog(@"----%@",self.arrayList);
        [self resetAnnitations:self.arrayList];
        MainViewController * main=[MainViewController SingleInit];
        main.arrayMain=self.arrayList;
        isLoad = YES;

    }
    else{
        [self function];
    }

     self._mapView.zoomLevel=16.0;
}

-(void)function{
    if (isLoad == NO) {
        [self.activityView stopAnimating];
     
        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"当前网络不稳定，加载失败，请选择操作：" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"重新加载", nil];
        alert.delegate = self;
        [alert show];
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self updataXY];
    }
}


- (void)viewDidUnload {
    [super viewDidUnload];
    self._mapView.showsUserLocation=NO;
    self._mapView.delegate = nil;
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    self._mapView.delegate=nil;
    // Dispose of any resources that can be recreated.
}


/**
 *地图区域即将改变时会调用此接口
 *@param mapview 地图View
 *@param animated 是否动画
 */
- (void)mapView:(BMKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{

}

/**
 *地图区域改变完成后会调用此接口
 *@param mapview 地图View
 *@param animated 是否动画
 */
- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{

}

/**
 *根据anntation生成对应的View
 *@param mapView 地图View
 *@param annotation 指定的标注
 *@return 生成的标注View
 */
-(void)ttt
{
    NSLog(@"annoView.title=%@",self.annoView.annotation.title);
    
    NSDictionary * dicSJ;
    for (NSDictionary * dic   in self.arrayList) {
        if ([[dic objectForKey:@"id"] isEqualToString:self.annoView.annotation.title]) {
            dicSJ=dic;
        }
    }
    NSLog(@"dicsj=%@",self.strFather);
    AppDelegate *my=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    my.dict = dicSJ;
    NSLog(@"%@------%@",my.dict,dicSJ);
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"goXiangqing" object:nil];

}

/**
 *当mapView新添加annotation views时，调用此接口
 *@param mapView 地图View
 *@param views 新添加的annotation views
 */
- (void)mapView:(BMKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    NSLog(@"did add annotationViews");
    
    
    
}

/**
 *当选中一个annotation views时，调用此接口
 *@param mapView 地图View
 *@param views 选中的annotation views
 */
- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
    NSLog(@"did select annotation");
    self.annoView=view;
    NSString * str=[view.annotation title];
    NSLog(@"annotation.title=%@",str);
    str =nil;
    
    if ([view.annotation isKindOfClass:[BasicMapAnnotation class]]) {
        [self ttt];
        [mapView deselectAnnotation:view.annotation animated:YES];
    }
    
    
}

/**
 *当取消选中一个annotation views时，调用此接口
 *@param mapView 地图View
 *@param views 取消选中的annotation views
 */
- (void)mapView:(BMKMapView *)mapView didDeselectAnnotationView:(BMKAnnotationView *)view
{
    NSLog(@"did deselect annotation");

}

/**
 *拖动annotation view时，若view的状态发生变化，会调用此函数。ios3.2以后支持
 *@param mapView 地图View
 *@param view annotation view
 *@param newState 新状态
 *@param oldState 旧状态
 */
- (void)mapView:(BMKMapView *)mapView annotationView:(BMKAnnotationView *)view didChangeDragState:(BMKAnnotationViewDragState)newState
   fromOldState:(BMKAnnotationViewDragState)oldState
{
    
}



/**
 *当点击annotation view弹出的泡泡时，调用此接口
 *@param mapView 地图View
 *@param view 泡泡所属的annotation view
 */
- (void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view
{
    NSLog(@"popo..");
}

/**
 *根据overlay生成对应的View
 *@param mapView 地图View
 *@param overlay 指定的overlay
 *@return 生成的覆盖物View
 */
- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id <BMKOverlay>)overlay
{
    return nil;
}

/**
 *当mapView新添加overlay views时，调用此接口
 *@param mapView 地图View
 *@param overlayViews 新添加的overlay views
 */
- (void)mapView:(BMKMapView *)mapView didAddOverlayViews:(NSArray *)overlayViews
{
    
}

/**
 *点中底图标注后会回调此接口
 *@param mapview 地图View
 *@param mapPoi 标注点信息
 */
- (void)mapView:(BMKMapView *)mapView onClickedMapPoi:(BMKMapPoi*)mapPoi
{
    
}

/**
 *点中底图空白处会回调此接口
 *@param mapview 地图View
 *@param coordinate 空白处坐标点的经纬度
 */
- (void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate;
{
    
}

/**
 *双击地图时会回调此接口
 *@param mapview 地图View
 *@param coordinate 返回双击处坐标点的经纬度
 */

// 默认是双击放大地图，重写方法会覆盖自带的方法

//- (void)mapview:(BMKMapView *)mapView onDoubleClick:(CLLocationCoordinate2D)coordinate
//{
//    static float i=span;
//    i=i-0.01;
//    //如果i太小 不能显示完全
//    NSLog(@"i=%f",i);
//    if (i<0.001) {
//        i=0.01;
//    }
//
//    NSLog(@"Double Click");
//    BMKCoordinateRegion viewRegion=BMKCoordinateRegionMake(coordinate, BMKCoordinateSpanMake(i, i));
//    BMKCoordinateRegion adjustedRegion=[self._mapView regionThatFits:viewRegion];
//    [self._mapView setRegion:adjustedRegion animated:YES];
//}

/**
 *长按地图时会回调此接口
 *@param mapview 地图View
 *@param coordinate 返回长按事件坐标点的经纬度
 */
//- (void)mapview:(BMKMapView *)mapView onLongClick:(CLLocationCoordinate2D)coordinate
//{
//    NSLog(@"onLongClick");
//    //  [self ttt];
//    
//}

/**
 *在地图View将要启动定位时，会调用此函数
 *@param mapView 地图View
 */

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
    if (userLocation.location.coordinate.latitude!=0) {
        
        
        self.strLat=[NSString stringWithFormat:@"%f",userLocation.location.coordinate.latitude];
        self.strLon=[NSString stringWithFormat:@"%f",userLocation.location.coordinate.longitude];
      

        if (isNull) {
            [self updataXY];
             //[self._mapView setCenterCoordinate:self._mapView.userLocation.coordinate animated:YES];
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
        //[self.activityView stopAnimating];
    }
    
    
    // self._mapView.showsUserLocation=NO;
    
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