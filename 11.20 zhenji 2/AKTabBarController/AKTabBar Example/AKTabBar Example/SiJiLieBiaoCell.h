//
//  SiJiLieBiaoCell.h
//  龙代驾
//
//  Created by mac on 13-10-25.
//  Copyright (c) 2013年 Ali Karagoz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SiJiLieBiaoCell : UITableViewCell<UIAlertViewDelegate>
{
    float strKM;
}
@property (strong,nonatomic)IBOutlet UIImageView * imagePic;
@property (strong,nonatomic)IBOutlet UIImageView * imageXj;
@property (strong,nonatomic)IBOutlet UILabel * labelName;
@property (strong,nonatomic)IBOutlet UILabel * labelKM;
@property (strong,nonatomic)IBOutlet UILabel * labelState;
@property (strong,nonatomic)IBOutlet UILabel * labelNo;
@property (strong,nonatomic)IBOutlet UILabel * labelYear;
@property (strong,nonatomic)IBOutlet UILabel * labelAdds;

@property (strong,nonatomic)UIImage * imageX;
@property (strong,nonatomic)UIImage * imageP;
@property (strong,nonatomic)UIImage * imagePhone;

@property (strong,nonatomic)NSString * strXJ;
@property (strong,nonatomic)NSString * strPhone;


@property (strong,nonatomic)IBOutlet UIButton * btnPhone;
-(IBAction)btnPress:(id)sender;

@end
