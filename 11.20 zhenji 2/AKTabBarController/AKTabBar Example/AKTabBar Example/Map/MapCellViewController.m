//
//  MapCellViewController.m
//  map
//
//  Created by mac on 13-10-15.
//  Copyright (c) 2013年 龙代驾. All rights reserved.
//

#import "MapCellViewController.h"
#define Arror_height 15

@interface MapCellViewController ()

@end

@implementation MapCellViewController
@synthesize nameSJ;
@synthesize zhuangtaiSJ;
@synthesize jibieSJ;
@synthesize jibieImage;
@synthesize nameLabel;
@synthesize beijingImageView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(id)initWithTitle:(NSString *)title Jibie:(NSInteger) i Zhuangtai:(NSInteger)isZaixian
{
    self=[super init];
    self.nameSJ=title;
    self.jibieSJ=i ;
    self.zhuangtaiSJ=isZaixian;
    
    return self;
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.view.frame=CGRectMake(0, 0, 65, 30);
    self.view.backgroundColor=[UIColor clearColor];
    
    self.beijingImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 65, 40)];
    
    if (self.zhuangtaiSJ==2) {
       //UIImage * imageBj = [UIImage imageNamed:@"driver_red.png"];
        [self.beijingImageView setImage:[UIImage imageNamed:@"driver_red.png"]];
        [self.view addSubview:self.beijingImageView];
        //imageBj=nil;
        self.beijingImageView=nil;
    }
    else{
        //UIImage * imageBj=[UIImage imageNamed:@"driver_green.png"];
        [self.beijingImageView setImage:[UIImage imageNamed:@"driver_green.png"]];
        [self.view addSubview:self.beijingImageView];
        //imageBj=nil;
        self.beijingImageView=nil;
    }
    
    
    self.nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(4, 3, 60, 15)];
    //self.nameLabel.font=[UIFont fontWithName:@"system" size:7];
    UIFont * font=[UIFont boldSystemFontOfSize:13 ];
    self.nameLabel.font=font;
    
    
    
    //self.nameLabel.textColor=[UIColor whiteColor];
    self.nameLabel.textAlignment=NSTextAlignmentCenter;
    self.nameLabel.text=self.nameSJ;
    [self.view addSubview:self.nameLabel];
    self.nameLabel=nil;
    
    self.jibieImage=[[UIImageView alloc]initWithFrame:CGRectMake(8, 20, 50, 10)];
    UIImage * image=[UIImage imageNamed:[NSString stringWithFormat:@"星星%i.png",self.jibieSJ]];
    [self.jibieImage setImage:image];
    [self.view addSubview:self.jibieImage];
    image=nil;
    self.jibieImage=nil;
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
