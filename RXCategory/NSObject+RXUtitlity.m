//
//  NSObject+RXUtitlity.m
//  RXCategoryExample
//
//  Created by Rush.D.Xzj on 15/12/7.
//  Copyright © 2015年 Rush.D.Xzj. All rights reserved.
//

#import "NSObject+RXUtitlity.h"
#import <objc/runtime.h>

@implementation NSObject (RXUtitlity)
- (id)rx_data
{
    return objc_getAssociatedObject(self, @"rx_data");
}

- (void)setRx_data:(id)rx_data
{
    objc_setAssociatedObject(self, @"rx_data", rx_data, OBJC_ASSOCIATION_RETAIN);
}
@end
