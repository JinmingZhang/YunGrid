//
//  LoginViewController.h
//  YunGrid
//
//  Created by user on 14-7-16.
//  Copyright (c) 2014年 NCEPU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClassofWorkViewController.h"

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *usernameText;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;
- (IBAction)pressBtn:(id)sender;
@property NSString *ip_path;
@end
