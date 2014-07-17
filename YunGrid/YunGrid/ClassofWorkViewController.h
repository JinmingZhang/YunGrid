//
//  ClassofWorkViewController.h
//  YunGrid
//
//  Created by user on 14-6-23.
//  Copyright (c) 2014年 ___ZNJC___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassofWorkViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
- (IBAction)press:(id)sender;
@property NSString *ip_path;
@property NSString *username;
@end
