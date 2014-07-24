//
//  InfosViewController.m
//  YunGrid
//
//  Created by user on 14-7-21.
//  Copyright (c) 2014年 NCEPU. All rights reserved.
//

#import "InfosViewController.h"

@interface InfosViewController (){
    NSMutableArray * arr;
    NSMutableArray * dangersArr;
    NSMutableArray * toolsArr;
}

@end

@implementation InfosViewController

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
    _locationManager=[[CLLocationManager alloc]init];
    _locationManager.delegate=self;
    _locationManager.desiredAccuracy=kCLLocationAccuracyBest;
    _locationManager.distanceFilter=100.0f;

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    _time=[dateFormatter stringFromDate:[NSDate date]];
    _currTime.text=_time;
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [_locationManager startUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    CLLocation *currentLocation=[locations lastObject];
    _longtitudeInfo=[NSString stringWithFormat:@"%3.5f",currentLocation.coordinate.longitude];
    _currLongtitude.text=_longtitudeInfo;
    NSLog(@"%@",_longtitudeInfo);
    _latitudeInfo =[NSString stringWithFormat:@"%3.5f",currentLocation.coordinate.latitude];
    _currLatitude.text=_latitudeInfo;
    
    _altitude=[NSString stringWithFormat:@"%3.2f米",currentLocation.altitude];
    _currAltitude.text=_altitude;
}
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"%@",error);
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [_locationManager stopUpdatingLocation];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)touchForBack:(id)sender {
    NSString *docsdir=[NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *dataBasePath=[docsdir stringByAppendingPathComponent:@"YNGrid.sqlite3"];
//    NSString *dataBasePath =[[NSBundle mainBundle]pathForResource:@"YNGrid.sqlite3" ofType:nil];
    FMDatabase *db=[[FMDatabase alloc]initWithPath:dataBasePath];
//    [db open];
    NSString *sql1=@"insert into locationInfos(id,name) values(20,'zhang')";
    [db executeUpdate:sql1];
    NSString *sql2=@"select * from locationInfos";
    FMResultSet *resultSet =[db executeQuery:sql2];
    while ([resultSet next]) {
        NSLog(@"%@",[resultSet stringForColumn:@"name"]);
    }
//    [db close];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)dropDown:(id)sender {
    arr = [[NSMutableArray alloc] init];
    NSString *docsdir=[NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *dataBasePath=[docsdir stringByAppendingPathComponent:@"YNGrid.sqlite3"];
    //    NSString *dataBasePath =[[NSBundle mainBundle]pathForResource:@"YNGrid.sqlite3" ofType:nil];
    FMDatabase *db=[[FMDatabase alloc]initWithPath:dataBasePath];
    [db open];
    NSString *sql2=@"select * from locationInfos";
    FMResultSet *resultSet =[db executeQuery:sql2];
    while ([resultSet next]) {

        [arr addObject:[resultSet stringForColumn:@"name"]];
    }
    [db close];

    CGRect frame=CGRectMake(_dropDownBtn.frame.origin.x, _dropDownBtn.frame.origin.y, 100, 200);
    UITableView *dropDownTable=[[UITableView alloc]initWithFrame:frame style:UITableViewStylePlain];
    dropDownTable.tag = 1;
    dropDownTable.dataSource=self;
    dropDownTable.delegate=self;
    [self.view addSubview:dropDownTable];
}
- (IBAction)dangersDropDown:(id)sender {
    dangersArr=[[NSMutableArray alloc]init];
    NSString *docsdir=[NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *dataBasePath=[docsdir stringByAppendingPathComponent:@"YNGrid.sqlite3"];
    FMDatabase *db=[[FMDatabase alloc]initWithPath:dataBasePath];
    [db open];
    NSString *sql = @"select * from safety_measure";
    FMResultSet *resultSet=[db executeQuery:sql];
    while ([resultSet next]) {
        [dangersArr addObject:[resultSet stringForColumn:@"risk_name"]];
        
//        [dangersArr addObject:[resultSet stringForColumn:@"risk_location"]];
//        [dangersArr addObject:[resultSet stringForColumn:@"control_measure"]];
    }
    [db close];
    CGRect frame=CGRectMake(_dangersDropDownBtn.frame.origin.x, _dangersDropDownBtn.frame.origin.y+_dangersDropDownBtn.frame.size.height, _dangersDropDownBtn.frame.size.width, 200);
    UITableView *dangersDropTable=[[UITableView alloc]initWithFrame:frame style:UITableViewStylePlain];
    dangersDropTable.dataSource=self;
    dangersDropTable.delegate=self;
    dangersDropTable.tag=2;
    [self.view addSubview:dangersDropTable];
}
- (IBAction)selectTools:(id)sender {
    toolsArr=[[NSMutableArray alloc]init];
    NSString *docsdir=[NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *dataBasePath=[docsdir stringByAppendingPathComponent:@"YNGrid.sqlite3"];
    FMDatabase *db=[[FMDatabase alloc]initWithPath:dataBasePath];
    [db open];
    NSString *sql = @"select * from tool";
    FMResultSet *resultSet=[db executeQuery:sql];
    while ([resultSet next]) {
        NSString *s1=[resultSet stringForColumn:@"tool_type"];
        NSString *s2=[resultSet stringForColumn:@"tool_name"];
        NSString *s3=[resultSet stringForColumn:@"tool_class"];
        NSString *s4=[resultSet stringForColumn:@"tool_unit"];
        NSString *s5=[resultSet stringForColumn:@"tool_number"];
        NSString *s=[NSString stringWithFormat:@"%@/%@/%@/%@/%@",s1,s2,s3,s4,s5];
        [toolsArr addObject:s];
    }
    [db close];
    CGRect frame=CGRectMake(_tools.frame.origin.x, _tools.frame.origin.y+_tools.frame.size.height, _tools.frame.size.width, 200);
    UITableView *toolsTable=[[UITableView alloc]initWithFrame:frame style:UITableViewStylePlain];
    toolsTable.tag=3;
    toolsTable.dataSource=self;
    toolsTable.delegate=self;
    [self.view addSubview:toolsTable];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    int number=0;
    if (tableView.tag==1) {
        number=  arr.count;
    }
    if (tableView.tag==2) {
        number = dangersArr.count;
    }
    if (tableView.tag==3) {
        number = toolsArr.count;
    }
    return number;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[[UITableViewCell alloc]init];
    if (tableView.tag==1) {
        cell.textLabel.text=[arr objectAtIndex:indexPath.row];
    }
    if (tableView.tag==2) {
        cell.textLabel.text=[dangersArr objectAtIndex:indexPath.row];
    }
    if (tableView.tag==3) {
        cell.textLabel.text=[toolsArr objectAtIndex:indexPath.row];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    if (tableView.tag==1) {
        _dropDownBtn.titleLabel.text=cell.textLabel.text;
    }
    if (tableView.tag==2) {
        _dangersDropDownBtn.titleLabel.text=cell.textLabel.text;
    }
    if (tableView.tag==3) {
        _tools.titleLabel.text=cell.textLabel.text;
    }
    [tableView removeFromSuperview];
}



@end
