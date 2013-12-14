//
//  DangQianDingDanCell.h
//  龙代驾
//
//  Created by mac on 13-10-22.
//  Copyright (c) 2013年 Ali Karagoz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DangQianDingDanCell : UITableViewCell<UIAlertViewDelegate>
@property (strong,nonatomic)IBOutlet UIImageView * imagePic;
@property (strong,nonatomic)IBOutlet UIImageView * imageXj;
@property (strong,nonatomic)IBOutlet UILabel * labelName;
@property (strong,nonatomic)IBOutlet UILabel * labelTime;
@property (strong,nonatomic)IBOutlet UILabel * labelChuFaDi;

@property (copy,nonatomic)UIImage * imageX;
@property (copy,nonatomic)UIImage * imageP;
@property (copy,nonatomic)NSString * strPhone;


@property (strong,nonatomic)IBOutlet UIButton * btnPhone;


-(IBAction)btnPress:(id)sender;

@end
