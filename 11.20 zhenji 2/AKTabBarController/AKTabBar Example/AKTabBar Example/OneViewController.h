//
//  OneViewController.h
//  龙代驾
//
//  Created by mac on 13-9-26.
//  Copyright (c) 2013年 Ali Karagoz. All rights reserved.
//

#import "ContentViewController.h"
#import "AVFoundation/AVFoundation.h"
#import "CoreAudio/CoreAudioTypes.h"


@interface OneViewController : ContentViewController<UIAlertViewDelegate>{
 
}



@property (nonatomic,strong) UIButton *btnZhuCe;
@property (nonatomic,strong)IBOutlet UIButton *btn1;
@property (nonatomic,strong)IBOutlet UIButton *btn2;
@property (nonatomic,strong)IBOutlet UIButton *btn3;
@property (nonatomic,strong)IBOutlet UIButton *btn4;

@property (nonatomic,strong)IBOutlet UIImageView * imageV;

-(IBAction)btnPress:(UIButton *)btn;

+(OneViewController *)SinSingleInit;

@end
