//
//  SignatureViewController.h
//  YunGrid
//
//  Created by Alex on 14-4-19.
//  Copyright (c) 2014年 ___ZNJC___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMDatabase.h"
#import "FMResultSet.h"
//#import "ASIFormDataRequest.h"
#import "MKNetworkEngine.h"
#import "MKNetworkOperation.h"

@interface SignatureViewController : UIViewController
@property NSString *ip_path;
@property NSString *savedImagePath;
//@property (retain, nonatomic) ASIFormDataRequest *request;
//得到所来自的页面
@property NSString *pageFrom;
//得到是“谁”的签名
@property NSString *signFrom;
@end
