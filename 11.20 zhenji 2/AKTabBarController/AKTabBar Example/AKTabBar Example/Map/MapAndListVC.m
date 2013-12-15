//
//  MapAndListVC.m
//  龙代驾
//
//  Created by FengXingTianXia on 13-12-14.
//  Copyright (c) 2013年 Ali Karagoz. All rights reserved.
//

#import "MapAndListVC.h"
//#import "Share/Weixin/SendMsgToWeChatViewController.h"
#import "AKTabBarController.h"
#import "SecondViewController.h"
#import "FourthViewController.h"
#import "FiveViewController.h"
#import "OneViewController.h"
#import "AppDelegate.h"
#import "SiJiXiangQingViewController.h"
#import "SiJiLieBiaoCell.h"
#import "OAApi.h"
#import "SVProgressHUD.h"
@interface MapAndListVC ()
@property (nonatomic, strong) UIButton *mapButton;
@property (nonatomic, strong) UIButton *listButton;
@property (nonatomic, strong) NSMutableData *data;
@end

@implementation MapAndListVC{
    NSMutableArray *arrayList;
    NSDictionary *dict;
    NSMutableArray *annotationArray;
    BMKPointAnnotation* pointAnnotation;
    BMKAnnotationView* newAnnotation;
    int j;
    NSString *lat;
    NSString *lon;
    bool isLocated;
    NSString *driverStatus;
    NSString *daijia_name;
    NSString *daijia_jiebie_id;
    UIButton *zoomout;
    UIButton *zoomin;
    UIButton *location;
}
@synthesize isMain = _isMain;
@synthesize tableV = _tableV;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewDidAppear:(BOOL)animated{
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [SVProgressHUD showWithStatus:@"加载中..." maskType:SVProgressHUDMaskTypeClear];
    arrayList = [[NSMutableArray alloc]initWithCapacity:0];
    annotationArray = [[NSMutableArray alloc]initWithCapacity:0];
    j = 0;
    isLocated = NO;
    
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 64, 320, [UIScreen mainScreen].bounds.size.height-64)];
    [self.view addSubview:_mapView];
    _tableV.frame = CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height);
    _tableV.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    
    UIView * titleView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 123, 30)];
    
    //地图按钮
    self.mapButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.mapButton.tag=1;
    self.mapButton.frame=CGRectMake(0, 0, 60, 30);
    [self.mapButton setImage:[UIImage imageNamed:@"地图.png"] forState:UIControlStateNormal];
    [self.mapButton setImage:[UIImage imageNamed:@"地图1.png"] forState:UIControlStateSelected];
    [self.mapButton addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:self.mapButton];
   
    //列表按钮
    self.listButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.listButton.tag=2;
    self.listButton.frame=CGRectMake(63, 0, 60, 30);
    [self.listButton setImage:[UIImage imageNamed:@"列表.png"] forState:UIControlStateNormal];
    [self.listButton setImage:[UIImage imageNamed:@"列表1.png"] forState:UIControlStateSelected];
    [self.listButton addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:self.listButton];
    
    self.navigationItem.titleView=titleView;
    UIBarButtonItem * rightButton = [[UIBarButtonItem alloc]
                                     initWithTitle:@"首页"
                                     style:UIBarButtonItemStyleBordered
                                     target:self
                                     action:@selector(shouye)];
    self.navigationItem.rightBarButtonItem = rightButton;
   
    if (![_isMain isEqualToString:@"1"]) {
        self.navigationItem.rightBarButtonItem = nil;
    }
    
    zoomout=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    zoomout.tag=1;
    zoomout.frame=CGRectMake(210, [UIScreen mainScreen].bounds.size.height-50, 50, 30);
    [zoomout setImage:[UIImage imageNamed:@"zoomout.png"] forState:UIControlStateNormal];
    [zoomout addTarget:self action:@selector(zoomChange:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:zoomout];
    
    zoomin=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    zoomin.tag=2;
    zoomin.frame=CGRectMake(260, [UIScreen mainScreen].bounds.size.height-50, 50, 30);
    UIImage * imageIn=[UIImage imageNamed:@"zoomin.png"];
    [zoomin setImage:imageIn forState:UIControlStateNormal];
    [zoomin addTarget:self action:@selector(zoomChange:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:zoomin];
    
    location = [UIButton buttonWithType:UIButtonTypeCustom];
    location.frame = CGRectMake(15, [UIScreen mainScreen].bounds.size.height-80, 40, 40);
    [location setBackgroundImage:[UIImage imageNamed:@"btn_locatebg"] forState:UIControlStateNormal];
    [self.view addSubview:location];
    [location addTarget:self action:@selector(reLocated) forControlEvents:UIControlEventTouchUpInside];
    self.data = [[NSMutableData alloc] init];
}

-(void)reLocated{
    
    [SVProgressHUD showWithStatus:@"加载中..." maskType:SVProgressHUDMaskTypeClear];
    //_mapView.showsUserLocation = NO;
    [self UpdataData];
}

-(void)zoomChange:(UIButton *)sender
{
    if (sender.tag == 2) {
        _mapView.zoomLevel++;
    }
    else
    {
        _mapView.zoomLevel--;
    }
   
}

-(void)UpdataData
{
    
    //     NSString * str=[NSString stringWithFormat:@"http://fr.eslgw.com/index.php/mobile/river_list?"];
    //    arrayList = [OAApi Url:str strLat:@"116.451248" strLon:@"39.86355"];
    //    NSLog(@"%@",arrayList);
    //    if (arrayList == nil || (id)arrayList == [NSNull null] ){
    //        NSLog(@"error");
    //    }
    //    if (arrayList.count>0) {
    //        [arrayList removeAllObjects];
    //    }
    
    //,self.strLat,self.strLon];
//
    self.data.length = 0;
    NSString * str=[NSString stringWithFormat:@"http://fr.eslgw.com/index.php/mobile/river_list?lng=%@&lat=%@",@"116.451248",@"39.86355"];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:str] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
      NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
//    NSData * response=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//    
//    if (response) {
//        arrayList=[NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:nil];
//        [_mapView setCenterCoordinate:_mapView.userLocation.coordinate animated:YES];
//        
//        NSLog(@"----%@",arrayList);
//        [self setAnnotionsWithList:arrayList];
//        [_tableV reloadData];
//    }
    
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    [self.data appendData:data];
    if (self.data) {
      arrayList=[NSJSONSerialization JSONObjectWithData:self.data options:NSJSONReadingMutableLeaves error:nil];
      [_mapView setCenterCoordinate:_mapView.userLocation.coordinate animated:YES];
        [self setAnnotionsWithList:arrayList];
        NSLog(@"<><><><><><><><><><><><><><><><><><><>%d",arrayList.count);
    }
    [_tableV reloadData];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    _mapView.showsUserLocation = YES;
    //_mapView.zoomLevel=16.0;
    [SVProgressHUD dismiss];
    [_mapView setCenterCoordinate:_mapView.userLocation.coordinate animated:YES];
    //反编译
    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){0, 0};
    pt = (CLLocationCoordinate2D){[lat doubleValue], [lon doubleValue]};
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
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *) error {
    self.data = nil;
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
}
#pragma mark baidu

-(void)setAnnotionsWithList:(NSArray *)list{
    if (annotationArray != nil) {
        [_mapView removeAnnotations:annotationArray];
    }
    j = 0;
    for (NSDictionary *dic in list) {
        NSLog(@"%@----%@",[dic objectForKey:@"lng"],[dic objectForKey:@"lat"]);
        BMKPointAnnotation *pointAnnotation2 = [[BMKPointAnnotation alloc]init];
        CLLocationCoordinate2D coor2;
        coor2.latitude = [[dic objectForKey:@"lng"]doubleValue];
        coor2.longitude = [[dic objectForKey:@"lat"]doubleValue];
        pointAnnotation2.coordinate = coor2;
        [_mapView addAnnotation:pointAnnotation2];
        [annotationArray addObject:pointAnnotation2];
//        driverStatus = [dic objectForKey:@"driverStatus"];
//        daijia_name = [dic objectForKey:@"daijia_name"];
//        daijia_jiebie_id = [dic objectForKey:@"daijia_jiebie_id"];
    }

}

// 根据anntation生成对应的View
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    NSString *AnnotationViewID = [NSString stringWithFormat:@"renameMark%d",j];
    
    //if (newAnnotation == nil) {
    newAnnotation = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
    // 设置颜色
    ((BMKPinAnnotationView*)newAnnotation).pinColor = BMKPinAnnotationColorPurple;
    // 从天上掉下效果
    ((BMKPinAnnotationView*)newAnnotation).animatesDrop = YES;
    // 设置可拖拽
    ((BMKPinAnnotationView*)newAnnotation).draggable = NO;
    //设置大头针图标
    if ([[arrayList[j] objectForKey:@"driverStatus"] isEqualToString:@"1"]) {
        ((BMKPinAnnotationView*)newAnnotation).image = [UIImage imageNamed:@"driver_green"];
    }
    else{
    ((BMKPinAnnotationView*)newAnnotation).image = [UIImage imageNamed:@"driver_red"];
    }
    //司机姓名
    UILabel *driverName = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 20)];
    driverName.text = [[arrayList objectAtIndex:j] objectForKey:@"daijia_name"];
    
    driverName.backgroundColor = [UIColor clearColor];
    driverName.font = [UIFont systemFontOfSize:12];
    driverName.textColor = [UIColor blackColor];
    driverName.textAlignment = NSTextAlignmentCenter;
    [newAnnotation addSubview:driverName];
    UIImageView *star = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"星星%d",[[[arrayList objectAtIndex:j]objectForKey:@"daijia_jiebie_id"]intValue]]]];
    star.frame = CGRectMake(5, 15, 50, 10);
    [newAnnotation addSubview:star];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 60, 40);
    [btn addTarget:self action:@selector(annotationClick:) forControlEvents:UIControlEventTouchUpInside];
    [newAnnotation addSubview:btn];
    btn.tag = j;
    NSLog(@"----%d",j);
    newAnnotation.tag = j;
    j++;
    return newAnnotation;
}
-(void)annotationClick:(UIButton *)sender
{
    AppDelegate *my=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    my.dict = [arrayList objectAtIndex:sender.tag];
    NSLog(@"%@",my.dict);
    SiJiXiangQingViewController * siji=[[SiJiXiangQingViewController alloc]initWithDic:my.dict father:@"1"];
    [self.navigationController pushViewController:siji animated:YES];

}
/**
 *当选中一个annotation views时，调用此接口
 *@param mapView 地图View
 *@param views 选中的annotation views
 */
- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
    
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
        
        
        lat=[NSString stringWithFormat:@"%f",userLocation.location.coordinate.latitude];
        lon=[NSString stringWithFormat:@"%f",userLocation.location.coordinate.longitude];
        
        
        if (!isLocated) {
            [self UpdataData];
            isLocated = YES;
//            [_mapView setCenterCoordinate:_mapView.userLocation.coordinate animated:YES];
//            //反编译
//            CLLocationCoordinate2D pt = (CLLocationCoordinate2D){0, 0};
//            pt = (CLLocationCoordinate2D){[lat doubleValue], [lon doubleValue]};
//            BOOL flag = [_search reverseGeocode:pt];
//            if (flag) {
//                NSLog(@"ReverseGeocode search success.");
//                
//            }
//            else{
//                NSLog(@"ReverseGeocode search failed!");
//                //            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请检查定位功能或稍后重试" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                //            [alert show];
//                
//            }
            
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


#pragma mark table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrayList count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"加载图片");
    
    static NSString * CustomCellIdentifier=@"CustomCellIdentifier";
    
    SiJiLieBiaoCell *cell = [tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SiJiLieBiaoCell" owner:self options:nil] lastObject];
    }
    
    
    NSDictionary * dic=[arrayList objectAtIndex:[indexPath row]];
    
    cell.labelName.text=[dic objectForKey:@"daijia_name"];
    float i=[[dic objectForKey:@"code"] floatValue];
    
    if (i<1) {
        i=i*1000.00;
        cell.labelKM.text=[NSString stringWithFormat:@"%.0fM",i];
    }else{
        cell.labelKM.text=[NSString stringWithFormat:@"%.2fKM",[[dic objectForKey:@"code"]floatValue]];
    }
    if ([[dic objectForKey:@"driverStatus"]intValue]==1) {
        cell.labelState.text=@"空闲";
        cell.labelState.textColor=[UIColor colorWithRed:57.0/255.0 green:149.0/255.0 blue:71.0/255.0 alpha:1];
    }
    else{
        cell.labelState.text=@"忙碌";
        cell.labelState.textColor=[UIColor colorWithRed:255.0/255.0 green:3.0/255.0 blue:4.0/255.0 alpha:1];
    }
    cell.labelNo.text=[NSString stringWithFormat:@"%@次",[dic objectForKey:@"times"]];
    cell.labelYear.text=[NSString stringWithFormat:@"%@年",[dic objectForKey:@"jialing"]];
    cell.labelAdds.text=[dic objectForKey:@"huji"];
    
    cell.imageX=[UIImage imageNamed:[NSString stringWithFormat:@"星星%@",[dic objectForKey:@"daijia_jiebie_id"]]];
    cell.imageXj.image=cell.imageX;
    
    NSString * strImage=[NSString stringWithFormat:@"http://fr.eslgw.com/upload/temp/%@",[dic objectForKey:@"img"]];
    NSURL *url = [NSURL URLWithString:strImage];
    UIImage * image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:url]];
    if ([[dic objectForKey:@"img"] isEqualToString: @""]) {
        [cell.imagePic setImage:[UIImage imageNamed:@"logomoren.png"]];
    }
    else{
        [cell.imagePic setImage:image];
    }
    
    if ([[dic objectForKey:@"driverStatus"] intValue]==1) {
        cell.imagePhone=[UIImage imageNamed:@"Phone2.png"];
        
    }else
    {
        cell.imagePhone=[UIImage imageNamed:@"Phone3.png"];
        
    }
    [cell.btnPhone setImage:cell.imagePhone forState:UIControlStateNormal];
    
    cell.strPhone=[dic objectForKey:@"daijia_phone"];
    
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    AppDelegate *my=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    my.dict = [arrayList objectAtIndex:[indexPath row]];
    NSLog(@"%@",my.dict);
    SiJiXiangQingViewController * siji=[[SiJiXiangQingViewController alloc]initWithDic:my.dict father:@"1"];
    [self.navigationController pushViewController:siji animated:YES];
    //[[NSNotificationCenter defaultCenter]postNotificationName:@"goXiangqing" object:nil];
            
            
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0;
}


//分类按钮点击事件
-(void)btnPress:(id)sender
{
    UIButton * btn=sender;
    switch (btn.tag) {
        case 1:
            NSLog(@"1");
            self.listButton.selected=NO;
            self.listButton.enabled=YES;
            self.mapButton.selected=YES;
            self.mapButton.enabled=NO;
            zoomin.hidden = NO;
            zoomout.hidden = NO;
            location.hidden = NO;
            _mapView.hidden = NO;
            _tableV.hidden = YES;
          
            
            break;
        case 2:
            NSLog(@"2");
            self.mapButton.selected=NO;
            self.listButton.selected=YES;
            self.mapButton.enabled=YES;
            self.listButton.enabled=NO;
            zoomin.hidden = YES;
            zoomout.hidden = YES;
            location.hidden = YES;
            _mapView.hidden = YES;
            _tableV.hidden = NO;
            [self.view exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
            break;
        default:
            break;
    }
}
-(void)shouye{
    
    CATransition * animation=[CATransition animation];
    animation.delegate=self;
    animation.duration=0.3;
    animation.type=kCATransitionMoveIn;
    animation.subtype=kCATransitionFromRight;
    
    
    self.tabBarController = [[AKTabBarController alloc] initWithTabBarHeight:(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? 70 : 50];
    [self.tabBarController setMinimumHeightToDisplayTitle:40.0];
    OneViewController * oneC=[OneViewController SinSingleInit];
    SecondViewController * secondC=[[SecondViewController alloc] init];
    ThirdViewController * thirdC=[[ThirdViewController alloc] init];
    FourthViewController * fourthC=[[FourthViewController alloc] init];
    FiveViewController * fiveC=[[FiveViewController alloc] init];
    
    UINavigationController *oneNavigationController = [[UINavigationController alloc] initWithRootViewController:oneC];
    UINavigationController *secondNavigationController = [[UINavigationController alloc] initWithRootViewController:secondC];
    UINavigationController *thirdNavigationController = [[UINavigationController alloc] initWithRootViewController:thirdC];
    UINavigationController *fourthNavigationController = [[UINavigationController alloc] initWithRootViewController:fourthC];
    UINavigationController *fiveNavigationController = [[UINavigationController alloc] initWithRootViewController:fiveC];
    [self.tabBarController setViewControllers:[NSMutableArray arrayWithObjects:
                                               oneNavigationController,secondNavigationController,thirdNavigationController,fourthNavigationController ,fiveNavigationController,nil]];
    
    UIApplication * app=[UIApplication sharedApplication];
    AppDelegate * appDe=(AppDelegate *)app.delegate;
    appDe.window.rootViewController=self.tabBarController;
    [[appDe.window layer]addAnimation:animation forKey:@"animation"];
    
}
-(void)viewWillAppear:(BOOL)animated {
    //self.navigationController.navigationBarHidden=YES;
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _search.delegate = self;
    _mapView.showsUserLocation = YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _search.delegate = nil;
   // [_mapView removeFromSuperview];
    _mapView.showsUserLocation = NO;
//    if (annotationArray != nil) {
//        [_mapView removeAnnotations:annotationArray];
//    }
    //    if (annotationArray != nil) {
    //        [_mapView removeAnnotations:annotationArray];
    //    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
