//
//  NSDictionary+RXUtility.m
//  RXExample
//
//  Created by Rush.D.Xzj on 15/10/9.
//  Copyright © 2015年 Rush.D.Xzj. All rights reserved.
//

#import "NSDictionary+RXUtility.h"

@implementation NSDictionary (RXUtility)


+ (NSString *)rx_keyValueStringFromDictionary:(NSDictionary *)dictionary
{
    if (dictionary == nil) {
        return @"";
    }
    NSMutableArray *ary = [NSMutableArray array];
    for (NSString *key in dictionary.allKeys) {
        NSString *value = dictionary[key];
        [ary addObject:[NSString stringWithFormat:@"%@=%@", key, value]];
    }
    NSString *result = [ary componentsJoinedByString:@"&"];
    return result;
}

@end
