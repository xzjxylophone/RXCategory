//
//  UIApplication+RXUtility.m
//  RXCategoryExample
//
//  Created by Rush.D.Xzj on 16/3/10.
//  Copyright © 2016年 Rush.D.Xzj. All rights reserved.
//

#import "UIApplication+RXUtility.h"

@implementation UIApplication (RXUtility)


+ (void)rx_priaseWithAppId:(NSString *)appId
{
    NSString *str = [NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@", appId];
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7.0)){
        str = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/%@", appId];
    }
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}


@end
