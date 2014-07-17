//
//  YNXianchangkanchaViewController.m
//  YunGrid
//
//  Created by DevTeam on 14-4-17.
//  Copyright (c) 2014年 ___ZNJC___. All rights reserved.
//

#import "YNXianchangkanchaViewController.h"
//#import "YNkanchaViewController.h"
//#import "PeiDianXianChangKanChaViewController.h"

@interface YNXianchangkanchaViewController ()

@end

@implementation YNXianchangkanchaViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title=@"现场勘察";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}
//分几组
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


//每一组有几个元素
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

//添加table内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =[[UITableViewCell alloc]init];
    cell.backgroundColor=[UIColor whiteColor];
    cell.textLabel.font=[UIFont boldSystemFontOfSize:30.0f];
    
    if (0==indexPath.section) {
        switch (indexPath.row) {
            case 1:
                cell.textLabel.text=@"配电网电气操作现场勘查记录";
                break;
            case 0:
                cell.textLabel.text=@"勘查记录单";
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

//table内容响应
-(void )tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
////    YNpaigongdanViewController *paigongdan=[[YNpaigongdanViewController alloc]init];
//    YNkanchaViewController *kan=[[YNkanchaViewController alloc]init];
//    PeiDianXianChangKanChaViewController *peiKanCha = [[PeiDianXianChangKanChaViewController alloc]init];
//    if (0==indexPath.section)
//    {
//        switch (indexPath.row)
//        {
//            case 1:
//                //配电网电气操作现场勘查记录
////                paigongdan.ip_path=self.ip_path;
//                peiKanCha.ip_path=self.ip_path;
//              [self.navigationController pushViewController:peiKanCha animated:YES];
//                break;
//            case 0:
//                //跳转到勘察记录单
//                
//                kan.ip_path=self.ip_path;
//                [self.navigationController pushViewController:kan animated:YES];
//                break;
//            default:
//                break;
//        }
//    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
