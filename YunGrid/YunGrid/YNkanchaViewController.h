//
//  YNkanchaViewController.h
//  YNGrid
//
//  Created by DevTeam on 14-4-10.
//  Copyright (c) 2014年 Michael Woo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMDatabase.h"
#import "FMResultSet.h"

@protocol SendValue <NSObject>
-(void) sendBtnText:(NSIndexPath *)indexPath;

@end
@class ASIFormDataRequest;
@interface YNkanchaViewController : UIViewController
@property NSString *ip_path;


- (IBAction)panduan:(id)sender;
@property (retain, nonatomic) ASIFormDataRequest *request;

@property(nonatomic,assign) id<SendValue> delegate;
@property(nonatomic,copy) NSIndexPath *indexPath;
@property (weak, nonatomic) IBOutlet UITextView *label1;
@property (weak, nonatomic) IBOutlet UITextView *label2;
@property (weak, nonatomic) IBOutlet UITextView *label3;
@property (weak, nonatomic) IBOutlet UITextView *label4;
@property (weak, nonatomic) IBOutlet UITextView *label5;
@property (weak, nonatomic) IBOutlet UITextView *label6;
@property (weak, nonatomic) IBOutlet UIButton *dangqianshijian;
- (IBAction)huoqudangqianshijian:(id)sender;

@property (weak, nonatomic) IBOutlet UITextView *label8;
@property (weak, nonatomic) IBOutlet UITextView *label9;
@property (weak, nonatomic) IBOutlet UITextView *label10;
@property (weak, nonatomic) IBOutlet UITextView *label11;
@property (weak, nonatomic) IBOutlet UITextView *label12;
@property (weak, nonatomic) IBOutlet UITextView *label13;
@property (weak, nonatomic) IBOutlet UITextView *label14;
@property (weak, nonatomic) IBOutlet UITextView *label15;
@property (weak, nonatomic) IBOutlet UITextView *label16;
@property (weak, nonatomic) IBOutlet UITextView *label17;
@property (weak, nonatomic) IBOutlet UITextView *label18;

@property (weak, nonatomic) IBOutlet UITextView *photoIntro;


@property int selectOrInsert;
- (IBAction)tijiao:(id)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *shifoudaoda;
- (IBAction)panduandaoda:(id)sender;

@property (weak, nonatomic) IBOutlet UISegmentedControl *shifou;

@end
