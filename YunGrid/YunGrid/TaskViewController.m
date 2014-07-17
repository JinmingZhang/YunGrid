//
//  TaskViewController.m
//  YunGrid
//
//  Created by user on 14-6-24.
//  Copyright (c) 2014年 ___ZNJC___. All rights reserved.
//

#import "TaskViewController.h"
#import "YNGongzuoViewController.h"

@interface TaskViewController ()
@property (weak, nonatomic) IBOutlet UITextField *workunitText;
@property (weak, nonatomic) IBOutlet UITextView *taskText;
@property (weak, nonatomic) IBOutlet UITextField *chargemanText;
@property (weak, nonatomic) IBOutlet UITextField *managementText;

@end

@implementation TaskViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title=@"工作任务";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSArray *views=[[NSBundle mainBundle]loadNibNamed:@"Task" owner:self options:nil];
    [self.view addSubview:views[0]];
    [self getUserInfo];
    self.taskText.layer.borderWidth=0.5;
    self.taskText.layer.cornerRadius=5.0;
    // Do any additional setup after loading the view.
}
-(void)getUserInfo{
    NSDictionary *para=[NSDictionary dictionaryWithObject:self.username forKey:@"user"];
    //设置IP测试
    //self.ip_path=@"121.195.169.27";
    NSString *urlString=[NSString stringWithFormat:@"http://%@/ndzygk/peiwangzuoye/ipad_anquanjishujiaodidan_xl_c/userlogin",self.ip_path];
    NSLog(@"ip: %@",urlString);
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    [manager POST:urlString parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"success:%@",responseObject);
        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
        //        //系统自带JSON解析
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
        self.arr=[[NSArray alloc] init];
        self.arr=[dict objectForKey:@"abc"];
        //        NSLog(@"id:%@",[[arr objectAtIndex:0] objectForKey:@"task"]);
        //        NSLog(@"id:%@",[[arr objectAtIndex:0] objectForKey:@"charge_man"]);
        //        NSLog(@"id:%@",[[arr objectAtIndex:0] objectForKey:@"management"]);
        
        
        //在数据下载的线程中载入数据
        self.taskText.text=[[self.arr objectAtIndex:0] objectForKey:@"task"];
        self.chargemanText.text=[[self.arr objectAtIndex:0] objectForKey:@"charge_man"];
        self.workunitText.text=[[self.arr objectAtIndex:0] objectForKey:@"work_unit"];
        self.managementText.text=[[self.arr objectAtIndex:0] objectForKey:@"management"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error:%@",error);
    }];
}
- (IBAction)startToWork:(id)sender {
    NSString* docsdir = [NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString* dbpath = [docsdir stringByAppendingPathComponent:@"YNGrid.sqlite3"];
    
    NSString *dbpath_readonly=[[NSBundle mainBundle] pathForResource:@"YNGrid" ofType:@"sqlite3"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager copyItemAtPath:dbpath_readonly toPath:dbpath error:nil];
    //－－－－－－－－－－－－－－－－－－－－数据库复制结束－－－－－－－－－－－－－－－－－－－－－－－－
    
    
    YNGongzuoViewController *gongZuo = [[YNGongzuoViewController alloc] init];
    gongZuo.ip_path=self.ip_path;
    [self.navigationController pushViewController:gongZuo animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
