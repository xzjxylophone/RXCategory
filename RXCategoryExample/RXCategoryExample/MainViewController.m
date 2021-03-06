//
//  MainViewController.m
//  RXCategoryExample
//
//  Created by Rush.D.Xzj on 15/11/16.
//  Copyright © 2015年 Rush.D.Xzj. All rights reserved.
//

#import "MainViewController.h"
#import "RXCategoryHeader.h"
#import <objc/runtime.h>
#import "TestView.h"
@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.edgesForExtendedLayout = UIRectEdgeNone;
//    [self test1];
    
    
//    [self test2];
    
//    [self test3];
    
//    [self test4];
    
//    [self test5];
    
    [self test6];
    
    TestView *tv = [[TestView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    tv.backgroundColor = [UIColor redColor];
    [self.view addSubview:tv];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Test

- (void)test6
{
    
    NSString *a = @"a";
    NSString *b = [[a mutableCopy] copy];
    NSLog(@"%p %p %@", a, b, object_getClass(b));
    
    
//    
//    
//    NSDictionary *dic = @{@"data":@"abcdefghi"};
//    
//    
//    
//    
//    
////    NSString *jsonString = @"{\"data\"=abcdefghi}";
//    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
//    
//    NSDictionary *dic2 = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    
    
    
//    char *c = "abctest";
    char *c = "123456abctest";
    CFStringRef str = CFStringCreateWithCString(NULL, c, kCFStringEncodingASCII);
    NSString *string = (__bridge NSString *)str;
    NSString *str1 = [string stringByReplacingOccurrencesOfString:@"o" withString:@"123"];
    NSLog(@"str1:%@", str1);
}

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

- (void)test4
{
    NSArray *fileNameArray = @[@"1", @"1.1", @"2", @"2.1", @"3", @"3.1", @"4"];
    NSArray *fileExtArray = @[@"jpg", @"png", @"png", @"jpg", @"png", @"png", @"jpg"];
    
    
    fileNameArray = @[@"1", @"2", @"3", @"4"];
    fileExtArray = @[@"jpg", @"png", @"png", @"jpg"];
    
    NSMutableArray *imageArray = [NSMutableArray array];
    for (NSInteger i = 0; i < fileNameArray.count; i++) {
        NSString *fileName = fileNameArray[i];
        NSString *fileExt = fileExtArray[i];
        UIImage *image = nil;
        if ([fileExt isEqualToString:@"png"]) {
            image = [UIImage imageNamed:fileName];
        } else {
            NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:fileExt];
            image = [UIImage imageWithContentsOfFile:filePath];
        }
        
        if (image != nil) {
            [imageArray addObject:image];
            
            
            NSData *data = UIImagePNGRepresentation(image);
            NSLog(@"fileName:%@, fileExt:%@, size:%@, length:%zd", fileName, fileExt, NSStringFromCGSize(image.size), data.length);
        } else {
            NSLog(@"fileName:%@, fileExt:%@ image is nil", fileName, fileExt);

        }
    }
    
    
    for (UIImage *image in imageArray) {
        NSData *data = UIImagePNGRepresentation(image);
        NSLog(@"size:%@, length:%zd, imageOrientation:%zd", NSStringFromCGSize(image.size), data.length, image.imageOrientation);
        if (image.imageOrientation != UIImageOrientationUp) {
            UIImage *newImage = [image rx_rotateWithImageOrientation:UIImageOrientationUp];
            NSData *newData = UIImagePNGRepresentation(newImage);
            NSLog(@"newImage size:%@, length:%zd, imageOrientation:%zd", NSStringFromCGSize(newImage.size), newData.length, newImage.imageOrientation);
        }
    }
    NSLog(@"-----------------------");
    
    UIImage *image = imageArray[3];
    
    BOOL compressionOK = NO;
    NSData *data = [image rx_compressionWithMaxLength:30 * 1024 compressionOK:&compressionOK];
    
    NSLog(@"data length:%zd, compressionOK:%zd", data.length, compressionOK);
    
    
    
}

- (void)test5
{
    NSDate *now = [NSDate new];
    NSString *string = [now rx_dateStringWithFormatter:kE_RX_DateFormatterDate];
    
    NSDate *date = [NSDate rx_dateFromString:string formatter:kE_RX_DateFormatterDate];
    
    NSString *string2 = [date rx_dateStringWithFormatter:kE_RX_DateFormatterDate2];
    
    NSLog(@"string:%@, string2:%@", string, string2);
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
