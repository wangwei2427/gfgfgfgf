//
//  DaiJiaXieYiViewController.m
//  龙代驾
//
//  Created by mac on 13-10-16.
//  Copyright (c) 2013年 Ali Karagoz. All rights reserved.
//

#import "DaiJiaXieYiViewController.h"

@interface DaiJiaXieYiViewController ()

@end

@implementation DaiJiaXieYiViewController
@synthesize naviBack;
@synthesize naviBar;
@synthesize textV;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"代驾协议";
    self.textV=[[UITextView alloc]initWithFrame:CGRectMake(1, 0, 318, [UIScreen mainScreen].bounds.size.height-50)];
    self.textV.delegate=self;
    
    self.textV.scrollEnabled=YES;
    self.textV.editable=NO;
    self.textV.text=@"1. 本协议由“北京吉祥月汽车技术服务有限公司”制定，解释权归“北京吉祥月汽车技术服务有限公司”所有.以下简称:龙代驾.\n2. 通过本客户端预约代驾服务即认定为您已了解龙代驾收费标准及双方责任和义务并认可. \n3. 客户在代驾开始前须依据龙代驾提供的代驾员信息核实代驾员身份,未经核实而发生非龙代驾提供的代驾服务,一切后果龙代驾不承担任何责任. \n4. 客户所提供车辆在代驾服务中不得有违法违禁品,并不得从事违法活动,龙代驾只提供代驾服务,不承担相应法律责任. \n5. 客户车辆应具备交强险,车辆损失险,第三者责任险.龙代驾只对投保三险的车辆提供代驾服务,客户应如实告之代驾员车辆保险情况,否则后果由客户自己负责. \n6. 龙代驾的代驾员在代驾服务中不得接触客户车内除了驾驶必须接触之外的任何物品,客户应保管好车内及随身物品.如发现物品丢失,需在代驾员离开前通知龙代驾并交由公安机关处理.服务结束同意司机离开即认定本次服务过程中未发生物品丢失情况. \n7. 客户严重醉酒必须有清醒同伴陪同,否则龙代驾的代驾员有权拒绝本次代驾服务. \n8. 服务过程中若发生违章由龙代驾负责,客户有权要求代驾员按指定路线行驶,但客户不得干扰代驾员驾驶车辆,若提出违章行驶要求,代驾员有权拒绝. \n9. 服务过程中因车辆自燃,爆胎,转向及刹车失灵,机件老化,外界掉落异物等非代驾员操作造成的车辆损伤及交通事故,龙代驾均不承担责任. \n10.对于交通事故的处理,若代驾车辆负主要责任,可先行使用车辆保险理赔.保险免赔部分由龙代驾承担并额外赔付上年保费的10%;车辆维修期间,交通费按每日100元补助(需二类以上维修机构以定损单为准).非代驾车辆负主要责任,龙代驾不负责损失赔偿. \n11.本协议的书面形式由代驾员提供,由龙代驾盖章,代驾员及客户签字方可生效,   本协议一式两份,客户,代驾员各保留一份,与本协议具有同等的法律效力.";

    [self.view addSubview:self.textV];
    
    // Do any additional setup after loading the view from its nib.
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
