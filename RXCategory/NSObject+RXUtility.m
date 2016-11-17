//
//  NSObject+RXUtitlity.m
//  RXCategory
//
//  Created by Rush.D.Xzj on 15/12/7.
//  Copyright © 2015年 Rush.D.Xzj. All rights reserved.
//

#import "NSObject+RXUtility.h"
#import <objc/runtime.h>

@implementation NSObject (RXUtility)
- (id)rx_data
{
    return objc_getAssociatedObject(self, @"rx_data");
}

- (void)setRx_data:(id)rx_data
{
    objc_setAssociatedObject(self, @"rx_data", rx_data, OBJC_ASSOCIATION_RETAIN);
}


- (NSString *)rx_jsonString
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
    if (!jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
    
}
@end
