//
//  YNGongzuoViewController.m
//  YunGrid
//
//  Created by Michael Woo on 14-4-17.
//  Copyright (c) 2014年 ___ZNJC___. All rights reserved.
//

#import "YNGongzuoViewController.h"

@interface YNGongzuoViewController ()

@end

@implementation YNGongzuoViewController



//表头
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title=@"工作内容";
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect frame = CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y+50, self.view.bounds.size.height, self.view.bounds.size.width);
    UITableView *tableView = [[UITableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
    tableView.delegate=self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
	// Do any additional setup after loading the view.
    //self.view.backgroundColor=[UIColor
}



//分几组
//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//   return @"aa";
//}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


//每一组有几个元素
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (0==section) {
        //第一组2个元素
        return 3;
    }else{
        return 0;
    }
}

//添加table内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =[[UITableViewCell alloc]init];
    
    cell.backgroundColor=[UIColor whiteColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font=[UIFont boldSystemFontOfSize:30.0f];
    
    if (0==indexPath.section) {
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text=@"现场勘查";
                //测试url的值能否传递过来
                //cell.textLabel.text=self.url;
                break;
            case 1:
                cell.textLabel.text=@"作业文件编制";
                break;
            case 2:
                cell.textLabel.text=@"现场作业";
                break;
            default:
                break;
        }
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

-(NSInteger) tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 4;
}

//内容响应
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YNXianchangkanchaViewController * kancha=[[YNXianchangkanchaViewController alloc]init];
//    YNkanchaViewController *kancha=[[YNkanchaViewController alloc]init];
//    YNSecurityViewController *sec=[[YNSecurityViewController alloc]init];
    FileListViewController *fileList = [[FileListViewController alloc]init];
    if (0==indexPath.section)
    {
        switch (indexPath.row)
        {
            case 0:
                kancha.ip_path=self.ip_path;
                [self.navigationController pushViewController:kancha animated:YES];
                break;
            case 1:
                fileList.ip_path =self.ip_path;
                [self.navigationController pushViewController:fileList animated:YES];
                break;
            case 2:
                //跳转安全技术交底单
//                sec.ip_path=self.ip_path;
//                [self.navigationController pushViewController:sec animated:YES];
//                break;
            
            default:
                break;
        }
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
