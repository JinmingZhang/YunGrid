//
//  TaskViewController.h
//  YunGrid
//
//  Created by user on 14-6-24.
//  Copyright (c) 2014年 ___ZNJC___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"

@interface TaskViewController : UIViewController
@property NSString *ip_path;
@property (weak, nonatomic) NSString *username;
@property NSArray *arr;
@end
