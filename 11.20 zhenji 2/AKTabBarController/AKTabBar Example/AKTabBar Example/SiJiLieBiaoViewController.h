//
//  SiJiLieBiaoViewController.h
//  龙代驾
//
//  Created by mac on 13-10-25.
//  Copyright (c) 2013年 Ali Karagoz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SiJiLieBiaoViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong,nonatomic)UITableView * tableV;
@property (strong,nonatomic)NSArray * arrayList;
@property (strong,nonatomic)NSMutableDictionary * dicPingjia;
@property (strong,nonatomic)NSMutableDictionary * dicImage;
@property (strong,nonatomic)NSString * strFather;
-(id)initWithFather:(NSString * )f;
-(void)updataData;
@end
