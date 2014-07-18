//
//  ImageEditorViewController.m
//  YunGrid
//
//  Created by Alex on 14-4-26.
//  Copyright (c) 2014年 ___ZNJC___. All rights reserved.
//  图片编辑模块
//  利用CLImageEditor

#import "ImageEditorViewController.h"
#import "CLImageEditor.h"

@interface ImageEditorViewController ()
<CLImageEditorDelegate, CLImageEditorThemeDelegate>{
    CLLocationManager *locationManager;
    BOOL keyboard;
}
@end

@implementation ImageEditorViewController
@synthesize timeLabel,timeLabelShow,location,locationShow;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title=@"照片拍摄";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    timeLabel.hidden=YES;
    timeLabelShow.hidden=YES;
    locationShow.hidden=YES;
    location.hidden=YES;
    _teamLabel.hidden=YES;
    _teamLabelShow.hidden=YES;
    _contentLabel.hidden=YES;
    _contentLabelShow.hidden=YES;
    // Do any additional setup after loading the view from its nib.
    [self refreshImageView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [locationManager startUpdatingLocation];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardDidShow:) name:@"UIKeyboardDidShowNotification" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardDidHide:) name:@"UIKeyboardDidHideNotification" object:nil];
}
-(void)keyboardDidShow:(NSNotification *)notif{
    if (keyboard) {
        return;
    }
    NSDictionary *info=[notif userInfo];
    NSValue *aValue=[info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize=[aValue CGRectValue].size;

    CGRect viewFrame=_scrollView.frame;
    viewFrame.origin.y-=keyboardSize.height;
//    viewFrame.size.height-=keyboardSize.height;
    _scrollView.frame=viewFrame;
    
//    NSLog(@"%f",_scrollView.frame.origin.y);
    keyboard=YES;
    
}
-(void)keyboardDidHide:(NSNotification *)notif{
    NSDictionary *info=[notif userInfo];
    NSValue *aValue=[info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize=[aValue CGRectValue].size;
    
    CGRect viewFrame=_scrollView.frame;
//    viewFrame.size.height+=keyboardSize.height;
    viewFrame.origin.y+=(keyboardSize.height/2);
    _scrollView.frame=viewFrame;
    
    if (!keyboard) {
        return;
    }
    keyboard=NO;
    
}
- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)pushedNewBtn
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"图库", nil];
    [sheet showInView:self.view.window];
}

- (void)pushedEditBtn
{
    if(_imageView.image){
        CLImageEditor *editor = [[CLImageEditor alloc] initWithImage:_imageView.image];
        editor.delegate = self;
        //CLImageEditor *editor = [[CLImageEditor alloc] initWithDelegate:self];
        
        
         NSLog(@"%@", editor.toolInfo);
         NSLog(@"%@", editor.toolInfo.toolTreeDescription);
         //隐藏一下不用的工具
         CLImageToolInfo *tool = [editor.toolInfo subToolInfoWithToolName:@"CLToneCurveTool" recursive:NO];
         tool.available = NO;
         
         tool = [editor.toolInfo subToolInfoWithToolName:@"CLRotateTool" recursive:YES];
         tool.available = NO;
         
         tool = [editor.toolInfo subToolInfoWithToolName:@"CLHueEffect" recursive:YES];
         tool.available = NO;
        
         tool = [editor.toolInfo subToolInfoWithToolName:@"CLAdjustmentTool" recursive:YES];
         tool.available = NO;
        
         tool = [editor.toolInfo subToolInfoWithToolName:@"CLEffectTool" recursive:YES];
         tool.available = NO;
        
         tool = [editor.toolInfo subToolInfoWithToolName:@"CLBlurTool" recursive:YES];
         tool.available = NO;
        
        
        [self presentViewController:editor animated:YES completion:nil];
        //[editor showInViewController:self withImageView:_imageView];
    }
    else{
        [self pushedNewBtn];
    }
}

- (void)pushedSaveBtn
{
    if(_imageView.image){
        NSArray *excludedActivityTypes = @[UIActivityTypeAssignToContact, UIActivityTypeCopyToPasteboard, UIActivityTypeMessage];
        
        UIActivityViewController *activityView = [[UIActivityViewController alloc] initWithActivityItems:@[_imageView.image] applicationActivities:nil];
        
        
        activityView.excludedActivityTypes = excludedActivityTypes;
        activityView.completionHandler = ^(NSString *activityType, BOOL completed){
            //如果保存成功返回success
            //并返回上个页面
            if([self UploadImage]&&completed && [activityType isEqualToString:UIActivityTypeSaveToCameraRoll]){
                //UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"保存成功" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"保存成功" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alert show];
            }
        };
        
        [self presentViewController:activityView animated:YES completion:nil];
        //[self UploadImage];
        
    }
    else{
        [self pushedNewBtn];
    }
}

//在Alert点击“确定”后，返回上个页面
- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    // the user clicked one of the OK/Cancel buttons
    if (buttonIndex == 0)
    {
        [self.navigationController popViewControllerAnimated:YES];
        NSLog(@"ok");
    }
}

//上传图片至服务器
//同时提交work_id, profession_id

- (BOOL)UploadImage{
    
//    //服务器找id
//    NSString* docsdir = [NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    NSString* dataBasePath = [docsdir stringByAppendingPathComponent:@"YNGrid.sqlite3"];
//    //NSString *dataBasePath =[[NSBundle mainBundle]pathForResource:@"YNGrid.sqlite3" ofType:nil];
//    FMDatabase *db = [[FMDatabase alloc]initWithPath:dataBasePath];
//    [db open];
//    FMResultSet *resultSetpost = [db executeQuery:@"select * from xianchangkanchajilu"];
//    
//    
//    
//     NSString *urlString=[NSString stringWithFormat:@"http://%@/ndzygk/peiwangzuoye/ipad_anquanjishujiaodidan_xl_c/saveKanchajiluPhoto",self.ip_path];
//    
//    //http://121.195.169.32/ndzygk/peiwangzuoye/ipad_anquanjishujiaodidan_xl_c/saveGongzuopiaoSign
//    //http://121.195.169.32/peiwangzuoye/ipad_anquanjishujiaodidan_xl_c/saveKanchajiluPhoto
//    [self setRequest:[ASIFormDataRequest requestWithURL:[NSURL URLWithString:urlString]]];
//    [resultSetpost next];
//    NSLog(@"work_id: %@",[resultSetpost stringForColumn:@"work_id"]);
//    NSLog(@"profession_id: %@",[resultSetpost stringForColumn:@"profession_id"]);
//    [self.request setPostValue:[resultSetpost stringForColumn:@"work_id"] forKey:@"work_id"];
//    [self.request setPostValue:[resultSetpost stringForColumn:@"profession_id"] forKey:@"profession_id"];
//    //[self.request setPostValue:@"2" forKey:@"id"];
//    
//    //[self.request setPostValue:_imageView.image forKey:@"file"];
//    NSData *imageData = UIImageJPEGRepresentation(_imageView.image, 0.5);
//    [self.request setData:imageData withFileName:@"file.jpg" andContentType:@"image/jpeg" forKey:@"file"];
//    [self.request setTimeOutSeconds:20];
//    [self.request startAsynchronous];
    return true;
    
    //    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:@"http://121.195.169.16/ndzygk/peiwangzuoye/ipad_anquanjishujiaodidan_xl_c/saveSandacuoshiSign" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
    //        [formData appendPartWithFileURL:[NSURL fileURLWithPath:self.savedImagePath] name:@"file" fileName:@"file.png" mimeType:@"image/png" error:nil];
    //    } error:nil];
    //
    //    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    //    NSProgress *progress = nil;
    //
    //    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:&progress completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
    //        if (error) {
    //            NSLog(@"Error: %@", error);
    //        } else {
    //            NSLog(@"%@ %@", response, responseObject);
    //        }
    //    }];
    
    //    [uploadTask resume];
    //pop到上一个页面
    //[self.navigationController popViewControllerAnimated:YES];
    
    
}

#pragma mark- ImagePicker delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    CLImageEditor *editor = [[CLImageEditor alloc] initWithImage:image];
    editor.delegate = self;
    
    [picker pushViewController:editor animated:YES];
}

#pragma mark- CLImageEditor delegate

- (void)imageEditor:(CLImageEditor *)editor didFinishEdittingWithImage:(UIImage *)image
{
    _imageView.image = image;
    [self refreshImageView];
    timeLabel.hidden=NO;
    NSDateFormatter *dateForm=[[NSDateFormatter alloc]init];
    [dateForm setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    timeLabelShow.text=[dateForm stringFromDate:[NSDate date]];
    timeLabelShow.hidden=NO;
    location.hidden=NO;
    locationShow.hidden=NO;
    _contentLabelShow.hidden=NO;
    _contentLabel.hidden=NO;
    _teamLabelShow.hidden=NO;
    _teamLabel.hidden=NO;
    locationManager=[[CLLocationManager alloc]init];
    locationManager.delegate=self;
    locationManager.desiredAccuracy=kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    [editor dismissViewControllerAnimated:YES completion:nil];
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *currLocation=[locations lastObject];
    locationShow.text=[NSString stringWithFormat:@"纬度%3.8f经度%3.8f",currLocation.coordinate.latitude,currLocation.coordinate.longitude];
    
    
}

#pragma mark- Tapbar delegate

- (void)deselectTabBarItem:(UITabBar*)tabBar
{
    tabBar.selectedItem = nil;
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    [self performSelector:@selector(deselectTabBarItem:) withObject:tabBar afterDelay:0.2];
    
    switch (item.tag) {
        case 0:
            [self pushedNewBtn];
            break;
        case 1:
            [self pushedEditBtn];
            break;
        case 2:
            [self pushedSaveBtn];
            break;
        default:
            break;
    }
}

#pragma mark- Actionsheet delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==actionSheet.cancelButtonIndex){
        
        return;
    }
    
    UIImagePickerControllerSourceType type = UIImagePickerControllerSourceTypePhotoLibrary;
    
    if([UIImagePickerController isSourceTypeAvailable:type]){
        if(buttonIndex==0 && [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            type = UIImagePickerControllerSourceTypeCamera;
            
        }
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.allowsEditing = NO;
        picker.delegate   = self;
        picker.sourceType = type;
        
        [self presentViewController:picker animated:YES completion:nil];
    }
}

#pragma mark- ScrollView

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imageView.superview;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    CGFloat Ws = _scrollView.frame.size.width - _scrollView.contentInset.left - _scrollView.contentInset.right;
    CGFloat Hs = _scrollView.frame.size.height - _scrollView.contentInset.top - _scrollView.contentInset.bottom;
    CGFloat W = _imageView.superview.frame.size.width;
    CGFloat H = _imageView.superview.frame.size.height;
    
    CGRect rct = _imageView.superview.frame;
    rct.origin.x = MAX((Ws-W)/2, 0);
    rct.origin.y = MAX((Hs-H)/2, 0);
    _imageView.superview.frame = rct;
    
}

- (void)resetImageViewFrame
{
    CGSize size = (_imageView.image) ? _imageView.image.size : _imageView.frame.size;
    CGFloat ratio = MIN(_scrollView.frame.size.width / size.width, _scrollView.frame.size.height / size.height);
    CGFloat W = ratio * size.width;
    CGFloat H = ratio * size.height;
    _imageView.frame = CGRectMake(0, 0, W, H);
    _imageView.superview.bounds = _imageView.bounds;
    
}

- (void)resetZoomScaleWithAnimate:(BOOL)animated
{
    CGFloat Rw = _scrollView.frame.size.width / _imageView.frame.size.width;
    CGFloat Rh = _scrollView.frame.size.height / _imageView.frame.size.height;
    
    //CGFloat scale = [[UIScreen mainScreen] scale];
    CGFloat scale = 1;
    Rw = MAX(Rw, _imageView.image.size.width / (scale * _scrollView.frame.size.width));
    Rh = MAX(Rh, _imageView.image.size.height / (scale * _scrollView.frame.size.height));
    
    _scrollView.contentSize = _imageView.frame.size;
    _scrollView.minimumZoomScale = 1;
    _scrollView.maximumZoomScale = MAX(MAX(Rw, Rh), 1);
    
    [_scrollView setZoomScale:_scrollView.minimumZoomScale animated:animated];
    [self scrollViewDidZoom:_scrollView];
    
}

- (void)refreshImageView
{
    [self resetImageViewFrame];
    [self resetZoomScaleWithAnimate:NO];
}




@end
