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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
