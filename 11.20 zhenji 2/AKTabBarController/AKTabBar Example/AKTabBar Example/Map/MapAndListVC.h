//
//  MapAndListVC.h
//  龙代驾
//
//  Created by FengXingTianXia on 13-12-14.
//  Copyright (c) 2013年 Ali Karagoz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
#import "AKTabBarController.h"
@interface MapAndListVC : UIViewController<BMKMapViewDelegate,BMKSearchDelegate>
{
    BMKMapView* _mapView;
    BMKSearch* _search;
}

@property (nonatomic,copy) NSString *isMain;
@property (weak, nonatomic) IBOutlet UITableView *tableV;
@property (nonatomic, strong) AKTabBarController *tabBarController;
@end
