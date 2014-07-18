//
//  ImageEditorViewController.h
//  YunGrid
//
//  Created by Alex on 14-4-26.
//  Copyright (c) 2014年 ___ZNJC___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMDatabase.h"
#import "FMResultSet.h"
//#import "ASIFormDataRequest.h"
#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLLocationManagerDelegate.h>

@interface ImageEditorViewController : UIViewController
<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITabBarDelegate, UIActionSheetDelegate, UIScrollViewDelegate, UIAlertViewDelegate,CLLocationManagerDelegate>
{
    IBOutlet __weak UIScrollView *_scrollView;
    IBOutlet __weak UIImageView *_imageView;
}

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabelShow;
@property (weak, nonatomic) IBOutlet UILabel *location;
@property (weak, nonatomic) IBOutlet UILabel *locationShow;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *teamLabel;
@property (weak, nonatomic) IBOutlet UITextField *contentLabelShow;
@property (weak, nonatomic) IBOutlet UITextField *teamLabelShow;
@property NSString *ip_path;
//@property (retain, nonatomic) ASIFormDataRequest *request;
@end
