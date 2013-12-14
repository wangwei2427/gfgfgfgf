//
//  DangQianDingDanViewController.m
//  龙代驾
//
//  Created by mac on 13-10-22.
//  Copyright (c) 2013年 Ali Karagoz. All rights reserved.
//

#import "DangQianDingDanViewController.h"
#import "DangQianDingDanCell.h"
#import "DingDanXiangQingViewController.h"
#import "MainViewController.h"
@interface DangQianDingDanViewController ()
@property (strong,nonatomic)DingDanXiangQingViewController * ddxq;

@end

@implementation DangQianDingDanViewController
@synthesize tableV;
@synthesize arrOrder;
@synthesize activityView;
@synthesize ddxq;

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
    self.title=@"当前订单";
    self.tableV=[[UITableView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:self.tableV];
    
    
    
    
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    self.activityView=[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(110, ([UIScreen mainScreen].bounds.size.height-100)/2, 100, 100)];
    [ self.activityView setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:self.activityView];
    [self.activityView startAnimating];
    self.ddxq=[[DingDanXiangQingViewController alloc]init];
    [self performSelector:@selector(updataXX) withObject:nil afterDelay:0.1];
}

-(void)updataXX
{

    MainViewController * main=[MainViewController SingleInit];
    NSString * cuid=main.strZhangHao;
    NSLog(@"cuid=%@",cuid);
    
    
    NSString * string=[NSString stringWithFormat:@"http://fr.eslgw.com/index.php/mobile/order_info?p=%@",cuid];
   // NSString * string=[NSString stringWithFormat:@"http://fr.eslgw.com/index.php/mobile/order_info?p=%@",@"15510361045"];
//    
//    NSMutableURLRequest * request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:string]];
//    NSOperationQueue * queue=[[NSOperationQueue alloc]init];
//    
//    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse * response,NSData * data, NSError * error){
//        if (error) {
//            [self.activityView stopAnimating];
//            NSLog(@"httperror :%@%d",error.localizedDescription,error.code);
//            UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请求失败,请检查网络稍后再试" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//            [alert show];
//            response=nil;
//            data=nil;
//            error=nil;
//        }else{
//            [self.activityView stopAnimating];
//             self.arrOrder=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
//            NSLog(@"self.arrorder=%@",self.arrOrder);
//            response=nil;
//            data=nil;
//            error=nil;
//            if ([self.arrOrder count]==0) {
//                UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"您当前无订单" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//                [alert show];
//            }else
//            {
//                self.tableV.delegate=self;
//                self.tableV.dataSource=self;
//                [self.tableV reloadData];
//            }
//        }
//    }];
//    
//    request=nil;
//    string=nil;
//    queue=nil;

    NSError * error;
    NSURLRequest * request=[NSURLRequest requestWithURL:[NSURL URLWithString:string]];
    NSData * response=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if (response){
        [self.activityView stopAnimating];
        self.arrOrder=[NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
        NSLog(@"arr=%@",self.arrOrder);
        
        if ([self.arrOrder count]==0) {
            UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"您当前无订单" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else
        {
            self.tableV.delegate=self;
            self.tableV.dataSource=self;
            [self.tableV reloadData];
        }
    }
    else
    {
        
        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请求失败,请检查网络稍后再试" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }
    error=nil;
    request=nil;
    response=nil;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arrOrder count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CustomCellIdentifier=@"CustomCellIdentifier";
    static BOOL nibsRegistered=NO;
    if (!nibsRegistered) {
        UINib * nib=[UINib nibWithNibName:@"DangQianDingDanCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CustomCellIdentifier];
        nibsRegistered=YES;
    }
    DangQianDingDanCell *cell = [tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    NSDictionary * dic=[self.arrOrder objectAtIndex:[indexPath row]];
    cell.labelName.text=[dic objectForKey:@"daijia_name"];
    cell.labelTime.text=[dic objectForKey:@"yuchu_time"];
    cell.labelChuFaDi.text=[dic objectForKey:@"yuyue_didian"];
    
    cell.imageX=[UIImage imageNamed:[NSString stringWithFormat:@"星星%@.png",[dic objectForKey:@"daijia_jiebie_id"]]];
    cell.imageXj.image=cell.imageX;
  
    NSURL * url=[NSURL URLWithString:[NSString stringWithFormat:@"http://fr.eslgw.com/upload/temp/%@",[dic objectForKey:@"img"]]];
    cell.imageP = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:url]];
    cell.imagePic.image=cell.imageP;
    self.ddxq.imagePic=cell.imageP;
    url=nil;

    cell.strPhone=[dic objectForKey:@"daijia_phone"];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
NSLog(@"cell=%ld",(long)[indexPath row]);
    
    //self.ddxq=[[DingDanXiangQingViewController alloc]initWithDic:[self.arrOrder objectAtIndex:[indexPath row]]];
    self.ddxq.dicList=[self.arrOrder objectAtIndex:[indexPath row]];
    [self.navigationController pushViewController:self.ddxq animated:YES];
    ddxq=nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0;
}

//-(void)viewDidDisappear:(BOOL)animated
//{
//   [super viewDidDisappear:YES];
//   [self.navigationController popViewControllerAnimated:YES];
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
