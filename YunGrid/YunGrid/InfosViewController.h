//
//  InfosViewController.h
//  YunGrid
//
//  Created by user on 14-7-21.
//  Copyright (c) 2014年 NCEPU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <Corelocation/CLLocationManagerDelegate.h>
#import "FMDatabase.h"
#import "FMResultSet.h"

@interface InfosViewController : UIViewController<CLLocationManagerDelegate,UITableViewDataSource,UITableViewDelegate>
@property NSString *ip_path;
@property NSString *latitudeInfo;
@property NSString *longtitudeInfo;
@property NSString *altitude;
@property NSString *time;
@property CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UILabel *currLongtitude;
@property (weak, nonatomic) IBOutlet UILabel *currLatitude;
@property (weak, nonatomic) IBOutlet UILabel *currAltitude;
@property (weak, nonatomic) IBOutlet UILabel *currTime;
- (IBAction)touchForBack:(id)sender;
- (IBAction)dropDown:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *dropDownBtn;
@property (weak, nonatomic) IBOutlet UIButton *dangersDropDownBtn;
- (IBAction)dangersDropDown:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *tools;
- (IBAction)selectTools:(id)sender;

@end
