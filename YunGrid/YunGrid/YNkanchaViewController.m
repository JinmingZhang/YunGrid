//
//  YNkanchaViewController.m
//  YNGrid
//
//  Created by DevTeam on 14-4-10.
//  Copyright (c) 2014年 Michael Woo. All rights reserved.
//

#import "YNkanchaViewController.h"
#import <QuartzCore/QuartzCore.h>
//#import "ASIFormDataRequest.h"
#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"
#import "YNGongzuoViewController.h"
#import "YNXianchangkanchaViewController.h"
//#import "ImageeditorViewController.h"
#import "SignatureViewController.h"

@interface YNkanchaViewController ()
{
    NSString *s1;
    NSString *s2;
    NSString *s3;
}
@end

@implementation YNkanchaViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title=@"现场勘察记录单";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIScrollView *scroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0,768,1024)];
    scroll.backgroundColor=[UIColor grayColor];
    NSArray *views=[[NSBundle mainBundle]loadNibNamed:@"kancha" owner:self options:nil];
    
    UIView *view=views[0];
    scroll.contentSize=view.frame.size;
    scroll.contentInset=UIEdgeInsetsMake(0, 0, 0, 0);
    [scroll addSubview:view];
    [self.view addSubview:scroll];
    
    //圆角矩形的输入框
    self.label1.layer.borderWidth=1.0;
    self.label2.layer.cornerRadius=5.0;
    self.label2.layer.borderWidth=1.0;
    self.label3.layer.cornerRadius=5.0;
    self.label3.layer.borderWidth=1.0;
    self.label4.layer.cornerRadius=5.0;
    self.label4.layer.borderWidth=1.0;
    self.label5.layer.cornerRadius=5.0;
    self.label5.layer.borderWidth=1.0;
    self.label6.layer.cornerRadius=5.0;
    self.label6.layer.borderWidth=1.0;

    self.label8.layer.cornerRadius=5.0;
    self.label8.layer.borderWidth=1.0;
    self.label9.layer.cornerRadius=5.0;
    self.label9.layer.borderWidth=1.0;
    self.label10.layer.cornerRadius=5.0;
    self.label10.layer.borderWidth=1.0;
    self.label11.layer.cornerRadius=5.0;
    self.label11.layer.borderWidth=1.0;
    self.label12.layer.cornerRadius=5.0;
    self.label12.layer.borderWidth=1.0;
    self.label13.layer.cornerRadius=5.0;
    self.label13.layer.borderWidth=1.0;
    self.label14.layer.cornerRadius=5.0;
    self.label14.layer.borderWidth=1.0;
    self.label15.layer.cornerRadius=5.0;
    self.label15.layer.borderWidth=1.0;
    self.label16.layer.cornerRadius=5.0;
    self.label16.layer.borderWidth=1.0;
    self.label17.layer.cornerRadius=5.0;
    self.label17.layer.borderWidth=1.0;
    self.label18.layer.cornerRadius=5.0;
    self.label18.layer.borderWidth=1.0;
    self.label1.layer.cornerRadius=5.0;
    
    
    self.photoIntro.layer.borderWidth=1.0;
    self.photoIntro.layer.cornerRadius=5.0;

	// Do any additional setup after loading the view.}
    NSString *urlString=[NSString stringWithFormat:@"http://%@/ndzygk/peiwangzuoye/ipad_anquanjishujiaodidan_xl_c/getXianchangkancha_xl/2",self.ip_path];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //[responseObject dataUsingEncoding:NSUTF8StringEncoding];
        NSLog(@"JSON: %@", operation.responseString);
        
        //数据格式化Format
        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
        //系统自带JSON解析
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
        
        //通讯方法-------------------------
        
        
        //数据库操作------------------
        NSString* docsdir = [NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString* dataBasePath = [docsdir stringByAppendingPathComponent:@"YNGrid.sqlite3"];
        
        
        //NSString *dataBasePath =[[NSBundle mainBundle]pathForResource:@"YNGrid.sqlite3" ofType:nil];
        FMDatabase *db = [[FMDatabase alloc]initWithPath:dataBasePath];
        // NSLog(@"%@",db);
        [db open];
        
        //（不只一条原始数据，现在先删除一条）原始数据库中有数据？？？？
      // [db executeUpdate:@"delete from anquanjishujiaodidan_XL where id=1"];
        
        //（执行上面删除后才能插入数据--主键冲突）将数据插入到数据库中
        [db executeUpdate:@"insert into xianchangkanchajilu(id,work_id,profession_id,unit,charge_man,task,range_cut_power) values(?,?,?,?,?,?,?)",[dict objectForKey:@"id"], [dict objectForKey:@"work_id"],[dict objectForKey:@"profession_id"],[dict objectForKey:@"unit"],[dict objectForKey:@"charge_man"],[dict objectForKey:@"task"],[dict objectForKey:@"range_cut_power"]];
    
        //从数据库中读取数据，然后插入到表单中------------
        FMResultSet *resultSet = [db executeQuery:@"select * from xianchangkanchajilu"];
        while ([resultSet next]) {
               self.label1.text =[resultSet stringForColumn:@"unit"];
               self.label2.text =[resultSet stringForColumn:@"charge_man"];
               self.label3.text =[resultSet stringForColumn:@"task"];
               self.label4.text =[resultSet stringForColumn:@"range_cut_power"];


            
            self.label1.editable=NO;
            self.label2.editable =NO;
            self.label3.editable =NO;
            self.label4.editable =NO;

        
            //在表单中插入数据------------
        }
        [db close];
        //数据库操作结束------------------
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}







- (IBAction)tijiao:(id)sender {

//    NSString* docsdir = [NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    NSString* dataBasePath = [docsdir stringByAppendingPathComponent:@"YNGrid.sqlite3"];
//    //NSString *dataBasePath =[[NSBundle mainBundle]pathForResource:@"YNGrid.sqlite3" ofType:nil];
//    FMDatabase *db = [[FMDatabase alloc]initWithPath:dataBasePath];
//    [db open];
//    FMResultSet *resultSetpost = [db executeQuery:@"select * from xianchangkanchajilu"];
//    while ([resultSetpost next])
//    {
//        [db executeQuery:@"update xianchangkanchajilu set man = ?, address = ?,time = ?, power_parts = ?,content1 = ?, content2 = ?,content3 = ?, content4 = ?,content5 = ?, content6 = ?,content7 = ?, content8 = ?,risk = ?,remark=?,condition=?,content9=?   where id = ?" ,self.label5.text,self.label6.text,s3,self.label8.text,self.label9.text,self.label10.text,self.label11.text,self.label12.text,self.label13.text,self.label14.text,self.label15.text,self.label16.text,self.label17.text,self.label18.text,s1,s2,[resultSetpost stringForColumn:@"id"]];
//        
//        
//            //POST方法
//            //测试，提交到黄学长服务器
//        NSString *urlString=[NSString stringWithFormat:@"http://%@/ndzygk/peiwangzuoye/ipad_anquanjishujiaodidan_xl_c/saveXianchangkancha_xl",self.ip_path];
//        
//        [self setRequest:[ASIFormDataRequest requestWithURL:[NSURL URLWithString:urlString]]];
//        [self.request setPostValue:[resultSetpost stringForColumn:@"id"] forKey:@"id"];
//        [self.request setPostValue:[resultSetpost stringForColumn:@"work_id"]  forKey:@"work_id"];
//        [self.request setPostValue:self.label5.text  forKey:@"man"];
//        [self.request setPostValue:self.label6.text forKey:@"address"];
//        [self.request setPostValue:s3  forKey:@"time"];
//        [self.request setPostValue:self.label8.text forKey:@"power_parts"];
//        [self.request setPostValue:self.label9.text  forKey:@"content1"];
//        [self.request setPostValue:self.label10.text forKey:@"content2"];
//        [self.request setPostValue:self.label11.text  forKey:@"content3"];
//        [self.request setPostValue:self.label12.text forKey:@"content4"];
//        [self.request setPostValue:self.label13.text  forKey:@"content5"];
//        [self.request setPostValue:self.label14.text forKey:@"content6"];
//        [self.request setPostValue:self.label15.text  forKey:@"content7"];
//        [self.request setPostValue:self.label16.text forKey:@"content8"];
//          
//        [self.request setPostValue:self.label17.text forKey:@"risk"];
//        [self.request setPostValue:self.label18.text forKey:@"remark"];
//        [self.request setPostValue:s1  forKey:@"condition"];
//        [self.request setPostValue:s2  forKey:@"content9"];
//        [self.request setTimeOutSeconds:20];
//        [self.request startAsynchronous];
//        
//        
//        NSLog(@"%@",self.label17.text);
//        NSLog(@"%@",self.label18.text);
//        NSLog(@"提交成功");
//    }
//    
//    [db close];
//    
//    
//    
//    //YNXianchangkanchaViewController *xianchang=[[YNXianchangkanchaViewController alloc]init];
//    [self.navigationController popViewControllerAnimated:YES];

    }

- (IBAction)panduandaoda:(id)sender {
    if (_shifoudaoda.selectedSegmentIndex==0) {
        s2=@"能到达";
    }
    else if (_shifoudaoda.selectedSegmentIndex==1)
    {s2=@"不能到达";
    }
  
}


- (IBAction)panduan:(id)sender {
    if (_shifou.selectedSegmentIndex==0) {
        s1=@"具备作业条件";
    }
    else if (_shifou.selectedSegmentIndex==1)
    {s1=@"不具备作业条件";
    }
    NSLog(@"%@",s1);

}
- (IBAction)huoqudangqianshijian:(id)sender {
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    s3=[dateFormatter stringFromDate:[NSDate date]];
    [_dangqianshijian  setTitle:s3 forState:UIControlStateNormal];
}

- (IBAction)ImageEditorButton:(id)sender {
//    ImageEditorViewController *ie=[[ImageEditorViewController alloc] init];
//    ie.ip_path=self.ip_path;
//    [self.navigationController pushViewController:ie animated:YES];
}


//签名
- (IBAction)signAction:(id)sender {
    SignatureViewController *signview=[[SignatureViewController alloc] init];
    //表示来自现场勘查记录单
    signview.pageFrom=@"kancha";
    
    [self.navigationController pushViewController:signview animated:YES];

}

@end
