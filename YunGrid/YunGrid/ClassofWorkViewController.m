//
//  ClassofWorkViewController.m
//  YunGrid
//
//  Created by user on 14-6-23.
//  Copyright (c) 2014年 ___ZNJC___. All rights reserved.
//

#import "ClassofWorkViewController.h"
//#import "YNTaskViewController.h"
#import "TaskViewController.h"

@interface ClassofWorkViewController ()

@end

@implementation ClassofWorkViewController
@synthesize ip_path,username;
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
    CGRect frame=CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y+64, self.view.bounds.size.width, self.view.bounds.size.width-100);
    UITableView *tableView=[[UITableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
    tableView.delegate=self;
    tableView.dataSource=self;
    [self.view addSubview:tableView];
//    NSLog(@"ooo----%@",self.navigationController);
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[[UITableViewCell alloc]init];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:30.0];
    if (0==indexPath.row) {
        cell.textLabel.text=@"计划作业";
    }
    if (1==indexPath.row) {
        cell.textLabel.text=@"故障抢修";
    }
    if (2==indexPath.row) {
        cell.textLabel.text=@"临时作业";
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TaskViewController *t=[[TaskViewController alloc]init];
    if (1==indexPath.row) {
//        NSLog(@"000----%@",self.navigationController);
//        [self performSegueWithIdentifier:@"nextVC" sender:self];
    }
    if (0==indexPath.row) {
        t.ip_path=ip_path;
        t.username=@"172.27.35.1";
        t.username=ip_path;
        [self.navigationController pushViewController:t animated:YES];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
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

- (IBAction)press:(id)sender {
    [self performSegueWithIdentifier:@"nextVC" sender:self];

}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *identify=segue.identifier;
//    self.ip_path = self.usernameText.text;
    if ([identify isEqualToString:@"nextVC"]) {
        // Get the new view controller using [segue destinationViewController].
        UINavigationController *navController = (UINavigationController*)[segue destinationViewController];
//        YNTaskViewController *task=(YNTaskViewController*)[navController topViewController];
        // Pass the selected object to the new view controller.
//        task.username=self.username;
//        task.ip_path=self.ip_path;
//        task.username=@"172.27.35.1";
//        task.ip_path=@"172.27.35.1";
    }
}
@end
