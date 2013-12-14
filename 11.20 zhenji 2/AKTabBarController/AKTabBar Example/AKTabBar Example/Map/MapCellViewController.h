//
//  MapCellViewController.h
//  map
//
//  Created by mac on 13-10-15.
//  Copyright (c) 2013年 龙代驾. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MapCellViewController : UIViewController
@property (strong,nonatomic)IBOutlet UILabel * nameLabel;
@property (strong,nonatomic)IBOutlet UIImageView * jibieImage;
@property (strong,nonatomic)IBOutlet UIImageView * beijingImageView;
@property (strong,nonatomic)NSString * nameSJ;
@property NSInteger jibieSJ;
@property NSInteger zhuangtaiSJ;

-(id)initWithTitle:(NSString *)title Jibie:(NSInteger) i Zhuangtai:(NSInteger)isZaixian;

@end
