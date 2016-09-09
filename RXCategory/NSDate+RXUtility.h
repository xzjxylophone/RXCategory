//
//  NSDate+RXUtility.h
//  RXCategoryExample
//
//  Created by ceshi on 16/8/5.
//  Copyright © 2016年 Rush.D.Xzj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (RXUtility)

+ (NSDate *)rx_dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second;

- (NSInteger)rx_weekdayIndex;

+ (NSString *)rx_weekdayStringWithWeek:(NSInteger)week;



@end
