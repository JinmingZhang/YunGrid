//
//  LoginViewController.m
//  YunGrid
//
//  Created by user on 14-7-16.
//  Copyright (c) 2014年 NCEPU. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pressBtn:(id)sender {
    ClassofWorkViewController *kindsOfWorks=[[ClassofWorkViewController alloc]init];
    
//    工作分类
    kindsOfWorks.ip_path=_usernameText.text;
    kindsOfWorks.username=_usernameText.text;
    
    [self.navigationController pushViewController:kindsOfWorks animated:YES];
}
@end
