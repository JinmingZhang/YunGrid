//
//  SignatureViewController.m
//  YunGrid
//
//  Created by Alex on 14-4-19.
//  Copyright (c) 2014年 ___ZNJC___. All rights reserved.
//

#import "SignatureViewController.h"


@interface SignatureViewController ()

@end

@implementation SignatureViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title=@"签名";
        UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(UploadImage:)];
        self.navigationItem.rightBarButtonItem = anotherButton;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//上传图片至服务器
- (IBAction)UploadImage:(id)sender {
    [self snapshotig];
    NSString *urlString;
    NSString* docsdir = [NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString* dataBasePath = [docsdir stringByAppendingPathComponent:@"YNGrid.sqlite3"];
    FMDatabase *db = [[FMDatabase alloc]initWithPath:dataBasePath];
    [db open];
//    
//    //如果来自工作票
//#warning 需要修改，gzp的提交现在为许可
//    if ([self.pageFrom isEqual:@"gzp_xuke"]) {
    if(true){
        [db open];
        urlString=[NSString stringWithFormat:@"http://%@/ndzygk/peiwangzuoye/ipad_anquanjishujiaodidan_xl_c/saveGongzuopiaoSign",self.ip_path];

        NSLog(@"%@",dataBasePath);
        //NSString *dataBasePath =[[NSBundle mainBundle]pathForResource:@"YNGrid.sqlite3" ofType:nil];
        FMResultSet *resultSetpost = [db executeQuery:@"select * from gongzuopiao"];
        
//        [self setRequest:[ASIFormDataRequest requestWithURL:[NSURL URLWithString:urlString]]];
        [resultSetpost next];
//        此处MKNetworkKit 上传图片。
        MKNetworkEngine *engine=[[MKNetworkEngine alloc]initWithHostName:@"172.27.35.1" customHeaderFields:nil];
        MKNetworkOperation *op=[engine operationWithPath:@"/ndzygk/peiwangzuoye/ipad_anquanjishujiaodidan_xl_c/saveGongzuopiaoSign" params:nil httpMethod:@"POST"];
//        [op addFile:docsdir forKey:@"file"];
//        [op addFile:self.savedImagePath forKey:@"file" mimeType:@"png"];

        [op setFreezable:YES];
        [op addCompletionHandler:^(MKNetworkOperation *completeOperation){
            NSLog(@"上传成功");
        }errorHandler:^(MKNetworkOperation *completeOperation,NSError *error){
            NSLog(@"上传失败");
        }];
        [engine enqueueOperation:op];
//        NSLog(@"id: %@",[resultSetpost stringForColumn:@"id"]);
//        [self.request setPostValue:[resultSetpost stringForColumn:@"id"] forKey:@"id"];
        
//        [self.request setFile:self.savedImagePath withFileName:@"file.jpg" andContentType:@"image/jpg" forKey:@"file"];
//        [self.request setTimeOutSeconds:20];
//        [self.request startAsynchronous];
        [resultSetpost close];
        [db close];
    }
   
    //pop到上一个页面
    [self.navigationController popViewControllerAnimated:YES];
//
    
}
- (void) snapshotig{
    //截图
    //UIGraphicsBeginImageContextWithOptions(CGSizeMake(768, 1024), YES, 0);
    UIGraphicsBeginImageContext(self.view.bounds.size);
    //convert view to image
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    CGImageRef imageRef = viewImage.CGImage;
    
    //////－－－－－－－－－－－－－切图像
    CGRect rect =CGRectMake(0, 50, 768, 1024);//这里可以设置想要截图的区域
    CGImageRef imageRefRect =CGImageCreateWithImageInRect(imageRef, rect);
    UIImage *sendImage = [[UIImage alloc] initWithCGImage:imageRefRect];
    NSData *imageViewData = UIImagePNGRepresentation(sendImage);
    ///－－－－－－－－－－－－－切图像
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    self.savedImagePath = [documentsDirectory stringByAppendingPathComponent:@"result.jpg"];
    NSLog(@"%@", self.savedImagePath);
    [imageViewData writeToFile:self.savedImagePath atomically:YES];
    CGImageRelease(imageRefRect);
    //保存到照片本
    UIImageWriteToSavedPhotosAlbum(viewImage, nil, nil, nil);
    NSLog(@"切割成功");
    
}

@end
