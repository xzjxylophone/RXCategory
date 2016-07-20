//
//  MainViewController.m
//  RXCategoryExample
//
//  Created by Rush.D.Xzj on 15/11/16.
//  Copyright © 2015年 Rush.D.Xzj. All rights reserved.
//

#import "MainViewController.h"
#import "RXCategoryHeader.h"
@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.edgesForExtendedLayout = UIRectEdgeNone;
//    [self test1];
    
    
    [self test2];
    
//    [self test3];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Test
- (void)test1
{
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(40, 40, 20, 20)];
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(80, 80, 20, 20)];
    
    [UIView setDefaultColorsInViews:@[view1, view2, view3]];
    
    [self.view addSubview:view1];
    [self.view addSubview:view2];
    [self.view addSubview:view3];
    
    
    
    
    NSString* message = @"test=yes";
    NSString *key = @"yiyizuche2015";
    NSString* str = [message rx_transform_AES128EncryptWithKey:key];
    NSString* res = [str rx_transform_AES128DecryptWithKey:key];
    if ([str isEqualToString:@"30WfPSljF8xIlv7HtCds4w=="]) {
        NSLog(@"success");
    } else {
        NSLog(@"failed");
    }
    NSLog(@"%@",str);
    NSLog(@"%@",res);
}
- (void)test2
{
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 100, 100)];
    view1.backgroundColor = [UIColor redColor];
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectZero];
    view2.backgroundColor = [UIColor greenColor];
    
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectZero];
    view3.backgroundColor = [UIColor blueColor];
    
    
    [view1 addSubview:view2];
    [view1 addSubview:view3];
    
    [view1 rx_fillAllWithSubview:view2];
    
    [view1 rx_fillWithSubview:view3 top:10 left:40 bottom:10 right:10];
    
    [self.view addSubview:view1];
    
}


- (void)test3
{
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 100, 100)];
    view1.backgroundColor = [UIColor redColor];
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectZero];
    view2.backgroundColor = [UIColor greenColor];
    
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectZero];
    view3.backgroundColor = [UIColor blueColor];
    
    
    [view1 addSubview:view2];
    [view1 addSubview:view3];
    
    [view2 rx_fillWithSuperview:view1 top:0 left:10 bottom:0 right:20];
    
//    [view1 rx_fillWithSubview:view3 top:10 left:10 bottom:10 right:10];
    
    [self.view addSubview:view1];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
