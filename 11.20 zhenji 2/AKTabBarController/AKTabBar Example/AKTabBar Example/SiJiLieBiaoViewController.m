//
//  SiJiLieBiaoViewController.m
//  龙代驾
//
//  Created by mac on 13-10-25.
//  Copyright (c) 2013年 Ali Karagoz. All rights reserved.
//

#import "SiJiLieBiaoViewController.h"
#import "SiJiLieBiaoCell.h"
#import "SiJiXiangQingViewController.h"
#import "MapMainViewController.h"
#import "MainViewController.h"
#import "AppDelegate.h"
#import "ShouyeMapViewController.h"

@interface SiJiLieBiaoViewController ()

@property (strong,nonatomic)MapMainViewController * mapMain;
@property (strong,nonatomic)MainViewController * first;
@end

@implementation SiJiLieBiaoViewController
@synthesize arrayList;
@synthesize strFather;
@synthesize first;
@synthesize mapMain;
@synthesize dicImage;
@synthesize dicPingjia;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(id)initWithFather:(NSString *)f
{
    self=[super init];
    if (self) {
        self.strFather=f;
    }
    return self;
}
-(void)getImage
{
    for (NSDictionary * dd in self.arrayList) {
        NSString * strImage=[NSString stringWithFormat:@"http://fr.eslgw.com/upload/temp/%@",[dd objectForKey:@"img"]];
        NSLog(@"%@",[dd objectForKey:@"img"]);
        NSURL *url = [NSURL URLWithString:strImage];
        NSData * dddata=[NSData dataWithContentsOfURL:url];
        [self.dicImage setObject:dddata forKey:[dd objectForKey:@"id"]];
        NSLog(@"image\n");
        strImage=nil;
        url=nil;
    }
    self.first.dicImage=self.dicImage;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"司机列表";
    
    if ([self.strFather isEqualToString:@"1"])
    {
        self.tableV=[[UITableView alloc]initWithFrame:CGRectMake(0, 65, 320, [UIScreen mainScreen].bounds.size.height-65)];
    }
    else
    {
        self.tableV=[[UITableView alloc]initWithFrame:CGRectMake(0, 65, 320, [UIScreen mainScreen].bounds.size.height-65)];
    }
   
    
    [self.view addSubview:self.tableV];
    
    self.first=[MainViewController SingleInit];
    self.arrayList=self.first.arrayMain;
    NSLog(@"%@---%@",self.arrayList,self.dicImage);
    self.dicImage=[NSMutableDictionary dictionaryWithCapacity:20];
    self.dicImage=self.first.dicImage;
    
    if ([self.dicImage count]==0) {
        NSLog(@"self.dicImage=%@",self.dicImage);
        self.tableV.delegate=self;
        self.tableV.dataSource=self;
    }
    else
    {
        [self getImage];
    }

    self.mapMain=[MapMainViewController SingleInit];
    
    
    // Do any additional setup after loading the view from its nib.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arrayList count];
}
static BOOL nibsRegistered=NO;
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"加载图片");
    
    static NSString * CustomCellIdentifier=@"CustomCellIdentifier";
    //static BOOL nibsRegistered=NO;
    if (!nibsRegistered) {
        UINib * nib=[UINib nibWithNibName:@"SiJiLieBiaoCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CustomCellIdentifier];
        nibsRegistered=YES;
    }
    SiJiLieBiaoCell *cell = [tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
    NSDictionary * dic=[self.arrayList objectAtIndex:[indexPath row]];
    NSLog(@"%@",dic);
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
   // cell.strXJ=[dic objectForKey:@"daijia_jiebie_id"];
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
    
    
    image=nil;

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
    
    SiJiXiangQingViewController * sjxq=[[SiJiXiangQingViewController alloc]initWithDic:[self.arrayList objectAtIndex:[indexPath row]] father:self.strFather];
   AppDelegate *my=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    my.dict = [self.arrayList objectAtIndex:[indexPath row]];
    NSLog(@"%@",my.dict);
    
    int i= [self.strFather intValue];
    switch (i ) {
        case 1:
            [[NSNotificationCenter defaultCenter]postNotificationName:@"goXiangqing" object:nil];
            

            break;
        case 2:

            //[main.nav pushViewController:sjxq animated:YES];
            break;
            
        default:
            break;
    }
    sjxq=nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0;
}
-(void)updataData
{
//    if (self.arrayList==nil) {
//       
//        self.arrayList=self.mapMain.arrayList;
//        if (self.arrayList==nil) {
//            self.arrayList=self.first.arrayMain;
//        }
//    }
    MainViewController * main=[MainViewController SingleInit];
    self.arrayList=main.arrayMain;
    
    self.dicImage=[FirstMapViewController SingleInit].dicImage;
    NSLog(@"self....dicimage=%@",self.dicImage);
    [self.tableV reloadData];
}
-(void)viewDidDisappear:(BOOL)animated
{
    nibsRegistered=nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
