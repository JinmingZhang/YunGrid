//
//  FileListViewController.m
//  YunGrid
//
//  Created by Michael Woo on 14-5-12.
//  Copyright (c) 2014年 ___ZNJC___. All rights reserved.
//

#import "FileListViewController.h"

@interface FileListViewController ()

@end

@implementation FileListViewController
@synthesize ip_path;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title=@"作业列表";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect frame = CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.height, self.view.bounds.size.height);
    UITableView *tableView=[[UITableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
    tableView.delegate =self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    // Do any additional setup after loading the view.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (0==section) {
        return @"配网操作";
    }else
        return @"配网作业";
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (0==section) {
        return 3;
    }else return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    NSString *cellTitle = [[NSString alloc]init];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:30.0];
    if (0==indexPath.section) {
        switch (indexPath.row) {
            case 0:
                cellTitle = @"配电网调度操作预令专项记录单";
                break;
//            case 1:
//                cellTitle = @"配电网电气操作现场勘查记录";
//                break;
            case 1:
                cellTitle = @"配电网电气操作风险控制措施单";
                break;
            case 2:
                cellTitle = @"配电网电气操作票";
                break;
                
            default:
                break;
        }
    }else{
        switch (indexPath.row) {
//            case 0:
//                cellTitle = @"现场勘查记录";
//                break;
            case 0:
                cellTitle = @"三大措施";
                break;
            case 1:
                cellTitle = @"10kV新建线路搭火作业指导书";
                break;
            case 2:
                cellTitle = @"10kV柱上配电变压器停电更换作业指导书";
                break;
            case 3:
                cellTitle = @"外单位工作任务许可单";
                break;
            case 4:
                cellTitle = @"线路工作安全技术交底单";
                break;
            case 5:
                cellTitle = @"线路一种工作票";
                break;
            case 6:
                cellTitle = @"低压工作票";
                break;
            case 7:
                cellTitle = @"电力线路分组工作派工单";
                break;
            case 8:
                cellTitle = @"线路工作接地线装拆记录表";
                break;
            case 9:
                cellTitle = @"个人保安接地线装拆记录表";
                
            default:
                break;
        }
    }
    cell.textLabel.text = cellTitle;
    cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    //三措学习
//    sancuoxuexiViewController *sanCuo= [[sancuoxuexiViewController alloc]init];
//    //工作票
//    YNGongzuopiaoViewController *gongZuoPiao =[[YNGongzuopiaoViewController alloc]init];
//    //安全技术交底
//    YNSecurityViewController *security = [[YNSecurityViewController alloc]init];
//    //低压工作票
////    LowVotPiaoViewController *lowVot =[[LowVotPiaoViewController alloc]init];
//    LowVotPiaooViewController *lowVot =[[LowVotPiaooViewController alloc]init];
//    //配电网调度操作预令专项记录单
//    PeiDianDiaoDuRecordViewController *peiDiaoduYu = [[PeiDianDiaoDuRecordViewController alloc]init];
//    //配电网电气操作现场勘查记录
//    PeiDianXianChangKanChaViewController *peiKanCha = [[PeiDianXianChangKanChaViewController alloc]init];
//    //配线网电气操作风险控制操作单
//    PeiDianFengXianKongZhiViewController *peiFengXian = [[PeiDianFengXianKongZhiViewController alloc]init];
//    //配电网电气操作票
//    DianQiCaoZuoPiaoViewController *dianQiPiao = [[DianQiCaoZuoPiaoViewController alloc]init];
//    //现场勘查记录
//    XianChangKanchaViewController *xianChang_Kancha =[[XianChangKanchaViewController alloc]init];
//    //分组工作派工单
//    FenZuPaiGongViewController *fenZuPaiGong = [[FenZuPaiGongViewController alloc] init];
//    //线路工作装拆接地线
//    JieDiXianViewController *jieDiXian = [[JieDiXianViewController alloc]init];
//    //个人保安装拆接地线
//    JieDiXian_GeRenViewController *geRen = [[JieDiXian_GeRenViewController alloc]init];
//    //外单位工作任务许可单
//    XuKeDanViewController *xuKe = [[XuKeDanViewController alloc]init];
//    //10KV柱上配电变压器停电更换作业指导书
//    TenKVViewController1 *tenKV1 = [[TenKVViewController1 alloc]init];
//    //10KV新建线路（变压器）停电搭火作业指导书
//    TenKVViewController2 *tenKV2 = [[TenKVViewController2 alloc]init];
//    
//    
//    if (0==indexPath.section) {
//        switch (indexPath.row) {
//            case 0:
//                peiDiaoduYu.ip_path=self.ip_path;
//                [self.navigationController pushViewController:peiDiaoduYu animated:YES];
//                break;
////            case 1:
////                peiKanCha.ip_path=self.ip_path;
////                [self.navigationController pushViewController:peiKanCha animated:YES];
////                break;
//            case 1:
//                peiFengXian.ip_path=self.ip_path;
//                [self.navigationController pushViewController:peiFengXian animated:YES];
//                break;
//            case 2:
//                dianQiPiao.ip_path=self.ip_path;
//                [self.navigationController pushViewController:dianQiPiao animated:YES];
//                break;
//                
//            default:
//                
//                break;
//        }
//    }else{
//        switch (indexPath.row) {
////            case 0:
////                xianChang_Kancha.ip_path=self.ip_path;
////                [self.navigationController pushViewController:xianChang_Kancha animated:YES];
////                break;
//            case 0:
//                sanCuo.ip_path=self.ip_path;
//                [self.navigationController pushViewController:sanCuo animated:YES];
//                break;
//            case 1:
//                tenKV2.ip_path = self.ip_path;
//                [self.navigationController pushViewController:tenKV2 animated:YES];
//                break;
//            case 2:
//                tenKV1.ip_path=self.ip_path;
//                [self.navigationController pushViewController:tenKV1 animated:YES];
//                break;
//            case 3:
//                xuKe.ip_path = self.ip_path;
//                [self.navigationController pushViewController:xuKe animated:YES];
//                break;
//            case 4:
//                security.ip_path=self.ip_path;
//                [self.navigationController pushViewController:security animated:YES];
//                break;
//            case 5:
//                gongZuoPiao.ip_path=self.ip_path;
//                [self.navigationController pushViewController:gongZuoPiao animated:YES];
//                break;
//            case 6:
//                lowVot.ip_path =self.ip_path;
//                [self.navigationController pushViewController:lowVot animated:YES];
//                break;
//            case 7:
//                fenZuPaiGong.ip_path = self.ip_path;
//                [self.navigationController pushViewController:fenZuPaiGong animated:YES];
//                break;
//            case 8:
//                jieDiXian.ip_path = self.ip_path;
//                [self.navigationController pushViewController:jieDiXian animated:YES];
//                break;
//            case 9:
//                geRen.ip_path = self.ip_path;
//                [self.navigationController pushViewController:geRen animated:YES];
//                
//            default:
//                break;
//        }
//    }
//}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

-(NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 4;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
