//
//  CustomCell.h
//  CustomCell
//
//  Created by mac on 13-10-21.
//  Copyright (c) 2013年 龙代驾. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell
@property (strong,nonatomic)IBOutlet UIImageView * imageV;
@property (strong,nonatomic)IBOutlet UILabel * labelPingJia;
@property (strong,nonatomic)IBOutlet UILabel * labelPhone;
@property (strong,nonatomic)IBOutlet UILabel * labelTime;
@property (strong,nonatomic)IBOutlet UILabel * labelPJ;

@property (copy,nonatomic)UIImage * imageXJ;

@end
