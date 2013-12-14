//
//  RespForWeChatViewController.mm
//  SDKSample
//
//  Created by Tencent on 12-4-9.
//  Copyright (c) 2012年 Tencent. All rights reserved.
//

#import "RespForWeChatViewController.h"

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

@implementation RespForWeChatViewController
@synthesize delegate = _delegate;
@synthesize m_nsLastText;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


-(void) onCancelText
{
    //[self dismissModalViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) onCompleteText:(NSString*)nsText
{
  //  [self dismissModalViewControllerAnimated:NO];
    [self dismissViewControllerAnimated:NO completion:nil];
    self.m_nsLastText = nsText;
    if (_delegate)
    {
        [_delegate RespTextContent:m_nsLastText] ;
    }
    //[self dismissModalViewControllerAnimated:NO];
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)sendTextContent
{
    TextViewController* viewController = [[TextViewController alloc] init];
    viewController.m_delegate = self;
    viewController.m_nsLastText = m_nsLastText;
    
    
    UINavigationController *navigatitonController = [[UINavigationController alloc]initWithRootViewController:viewController];
	//[self presentModalViewController:navigatitonController animated:YES];
    [self presentViewController:navigatitonController animated:YES completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setTitle:@"回应文本消息给微信" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14]; 
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setFrame:CGRectMake(10, 25, 145, 40)];
    [btn addTarget:self action:@selector(sendTextContent) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    m_nsLastText = @"完善的跨终端即时通讯能力，使得Mac可以与PC、手机、Pad等终端的QQ进行无缝沟通，让您的交流更畅快。 完善的跨终端即时通讯能力，使得Mac可以与PC、手机、Pad等终端的QQ进行无缝沟通，让您的交流更畅快。 ";
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.m_nsLastText = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}



@end
