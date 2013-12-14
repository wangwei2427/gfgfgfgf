//
//
//  NIDropDown.m
//  龙代驾
//
//  Created by mac on 13-10-19.
//  Copyright (c) 2013年 Ali Karagoz. All rights reserved.
//


#import "NIDropDown.h"
#import "QuartzCore/QuartzCore.h"

@interface NIDropDown ()
@property(nonatomic, strong) UIView * v ;
@property(nonatomic, strong) UIButton *btnSender;

@end

@implementation NIDropDown
@synthesize v;
@synthesize btnSender;
@synthesize btn1,btn2;
@synthesize delegate;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(id)initWithButton:(UIButton *)b
{
    self=[super init];
    if (self) {
        btnSender = b;
        self.frame = CGRectMake(75, 160, 80, 0);
        
        self.layer.masksToBounds = NO;
        self.layer.cornerRadius = 8;
        self.layer.shadowOffset = CGSizeMake(-5, 5);
        self.layer.shadowRadius = 5;
        self.layer.shadowOpacity = 0.5;
        
        
        self.v=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 0)];
        self.v.backgroundColor=[UIColor colorWithWhite:0.9 alpha:1];
        
        
        self.btn1=[UIButton buttonWithType:UIButtonTypeCustom];
        self.btn1.frame=CGRectMake(0, 0, 80, 30);
       
        [self.btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.btn1 setTitle:@"代驾费" forState:UIControlStateNormal];
        self.btn1.tag=1;
        [self.btn1 addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
  //      [self.v addSubview:self.btn1];
        
        self.btn2=[UIButton buttonWithType:UIButtonTypeCustom];
        self.btn2.frame=CGRectMake(0, 30, 80, 30);
        [self.btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.btn2 setTitle:@"服务费" forState:UIControlStateNormal];
        self.btn2.tag=2;
        [self.btn2 addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
 //       [self.v addSubview:self.btn2];
//        
//        self.btn3=[UIButton buttonWithType:UIButtonTypeCustom];
//        self.btn3.frame=CGRectMake(0, 60, 80, 30);
//        self.btn3.titleLabel.text=@"C";
//        self.btn3.tag=3;
//        self.btn3.backgroundColor=[UIColor greenColor];
//        [self.btn3 addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
//        [self.v addSubview:self.btn3];

        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        self.frame = CGRectMake(75, 160, 80, 60);
        self.v.frame=CGRectMake(0, 0, 80, 60);
        [UIView commitAnimations];
        
        [self addSubview:self.v];
        [b.superview.superview addSubview:self];
        [self.v addSubview:self.btn1];
        [self.v addSubview:self.btn2];

    }
    return self;
}
-(void)btnPress:(UIButton *)sender
{
    UIButton*btn=sender;
    switch (btn.tag) {
        case 1:
             [self.delegate DropDownDelegateMethod:@"代驾费"];
            break;
        case 2:
             [self.delegate DropDownDelegateMethod:@"服务费"];
            break;
//        case 3:
//             [self.delegate DropDownDelegateMethod:@"C"];
//            break;
            
        default:
            break;
    }
    [self hideDropDown];
   // [self myDelegate];

    btn=nil;
}
-(void)hideDropDown
{
   
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    self.frame = CGRectMake(70, 140, 80, 0);
    self.v.frame=CGRectMake(0, 0, 80, 0);
    [UIView commitAnimations];
    [self.btn1 removeFromSuperview];
    [self.btn2 removeFromSuperview];
  //  [self.btn3 removeFromSuperview];
    [self.v removeFromSuperview];
    self.btn1=nil;
  //  self.btn3=nil;
    self.btn2=nil;
    self.v =nil;
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self hideDropDown];
    UITableViewCell *c = [tableView cellForRowAtIndexPath:indexPath];
    [btnSender setTitle:c.textLabel.text forState:UIControlStateNormal];
    [self myDelegate];
}

- (void) myDelegate {
    [self.delegate niDropDownDelegateMethod:self];   
}



@end
