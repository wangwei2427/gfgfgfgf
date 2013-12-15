//
//  GeRenZhongXinViewController.m
//  龙代驾
//
//  Created by mac on 13-10-24.
//  Copyright (c) 2013年 Ali Karagoz. All rights reserved.
//

#import "GeRenZhongXinViewController.h"
#import "GeRenZhongXinCell.h"
#import "DingDanXiangQingViewController.h"


@interface GeRenZhongXinViewController ()

@end

@implementation GeRenZhongXinViewController
@synthesize main;

@synthesize tableV;
@synthesize arrayList;
@synthesize activityView;
@synthesize dicImage;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)updateData
{
   // MainViewController * main=[MainViewController SingleInit];
   // main.strZhangHao
  //  NSString * string=[NSString stringWithFormat:@"http://192.168.1.98/index.php/mobile/history_info?p=%@",main.strZhangHao];
    NSString * string=[NSString stringWithFormat:@"http://fr.eslgw.com/index.php/mobile/get_history_order_list?p=%@",@"15510361045"];
    
    NSError * error;
    NSURLRequest * request=[NSURLRequest requestWithURL:[NSURL URLWithString:string]];
    NSData * response=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if (response){
        [self.activityView stopAnimating];
        self.arrayList=[NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
        NSLog(@"arr=%@",self.arrayList);
        
        if ([self.arrayList count]==0) {
            UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"您没有历史订单" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else
        {
            
            main.arrayHistory=[self.arrayList mutableCopy];
            
            for (NSDictionary * dd in self.arrayList)
            {
                NSString * strImage=[NSString stringWithFormat:@"http://fr.eslgw.com/upload/temp/%@",[dd objectForKey:@"img"]];
                NSURL *url = [NSURL URLWithString:strImage];
                NSData * dddata=[NSData dataWithContentsOfURL:url];
                [self.dicImage setObject:dddata forKey:[dd objectForKey:@"id"]];
                strImage=nil;
                url=nil;
            }
            main.dicHistory=self.dicImage;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"历史订单";
    self.dicImage=[NSMutableDictionary dictionaryWithCapacity:10];
    
    self.tableV=[[UITableView alloc]initWithFrame:self.view.frame];
    self.tableV.delegate=self;
    self.tableV.dataSource=self;
    [self.view addSubview:self.tableV];
    
    self.activityView=[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(110, ([UIScreen mainScreen].bounds.size.height-100)/2, 100, 100)];
    [ self.activityView setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:self.activityView];
    [self.activityView startAnimating];

    self.main=[MainViewController SingleInit];
    if ([self.main.arrayHistory count]==0) {
        [self updateData];
    }
    else
    {
        [self.activityView stopAnimating];
        self.arrayList=self.main.arrayHistory;
        NSLog(@"self.main=%@",self.main.arrayHistory);
        NSLog(@"self.arraylist=%@",self.arrayList);
        self.tableV.delegate=self;
        self.tableV.dataSource=self;
        [self.tableV reloadData];

    }
    
    

    
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
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CustomCellIdentifier=@"CustomCellIdentifier";
    static BOOL nibsRegistered=NO;
    if (!nibsRegistered) {
        UINib * nib=[UINib nibWithNibName:@"GeRenZhongXinCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CustomCellIdentifier];
        nibsRegistered=YES;
    }
    NSDictionary * dic=[self.arrayList objectAtIndex:[indexPath row]];
    GeRenZhongXinCell *cell = [tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
    
    cell.imageP=[UIImage imageWithData:[self.dicImage objectForKey:[dic objectForKey:@"id"]]];
    [cell.imagePic setImage:cell.imageP];
    
    

    cell.labelName.text=[dic objectForKey:@"daijia_name"];

    cell.labelChuFaDi.text=[dic objectForKey:@"yuyue_didian"];

    int i=[[dic objectForKey:@"order_status"] intValue];
    switch (i ) {
        case 1:
            
            cell.labelZhuangTai.text=@"正在执行";
            cell.labelZhuangTai.textColor=[UIColor colorWithRed:255.0/255.0 green:3.0/255.0 blue:4.0/255.0 alpha:1];
            
            break;
            
        case 2:
            cell.labelZhuangTai.text=@"已完成";

            cell.labelZhuangTai.textColor=[UIColor colorWithRed:57.0/255.0 green:149.0/255.0 blue:71.0/255.0 alpha:1];
            
            break;
        case 3:
            cell.labelZhuangTai.text=@"已取消";
            cell.labelZhuangTai.textColor=[UIColor colorWithRed:57.0/255.0 green:149.0/255.0 blue:71.0/255.0 alpha:1];
            
        default:
            break;
    }
    

    dic=nil;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSDictionary * ddd=[self.arrayList objectAtIndex:indexPath.row];
  
    DingDanXiangQingViewController * ddxq=[[DingDanXiangQingViewController alloc]initWithDic:ddd];
    NSString * string=[ddd objectForKey:@"id"];
    NSLog(@"%@",[ddd objectForKey:@"id"]);
    UIImage * ima=[UIImage imageWithData:[self.dicImage objectForKey:string]];
    ddxq.imagePic=ima;
    [self.navigationController pushViewController:ddxq animated:YES];
//    ima=nil;
//    string=nil;
//    ddd=nil;
//    ddxq=nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
