//
//  NSDate+RXUtility.m
//  RXCategoryExample
//
//  Created by ceshi on 16/8/5.
//  Copyright © 2016年 Rush.D.Xzj. All rights reserved.
//

#import "NSDate+RXUtility.h"
#define NSCalendarUnitsKeys111 @{ @(NSCalendarUnitEra): @"era", @(NSCalendarUnitYear): @"year", @(NSCalendarUnitMonth): @"month", @(NSCalendarUnitDay): @"day", @(NSCalendarUnitHour): @"hour", @(NSCalendarUnitMinute): @"minute", @(NSCalendarUnitSecond): @"second", @(NSCalendarUnitWeekday): @"weekday", @(NSCalendarUnitWeekdayOrdinal): @"weekdayOrdinal", @(NSCalendarUnitQuarter): @"quarter", @(NSCalendarUnitWeekOfMonth): @"weekOfMonth", @(NSCalendarUnitWeekOfYear): @"weekOfYear", @(NSCalendarUnitYearForWeekOfYear): @"yearForWeekOfYear" }


@implementation NSDate (RXUtility)


+ (NSDate *)rx_dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second
{
    NSDateComponents *comp = [[NSDateComponents alloc]init];
    [comp setYear:year];
    [comp setMonth:month];
    [comp setDay:day];
    [comp setHour:hour];
    [comp setMinute:minute];
    [comp setSecond:second];
    
    NSCalendar *myCal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *date = [myCal dateFromComponents:comp];
    return date;
}

- (NSInteger)rx_weekdayIndex
{
    NSCalendarUnit calendarUnits = 0;
    for (NSNumber *calendarUnit in NSCalendarUnitsKeys111.allKeys)
    {
        calendarUnits |= [calendarUnit unsignedIntegerValue];
    }
    NSInteger weekday = [[[NSCalendar.autoupdatingCurrentCalendar components:calendarUnits fromDate:self] valueForKey:NSCalendarUnitsKeys111[@(NSCalendarUnitWeekday)]] integerValue];

    NSInteger result = weekday - 2;
    if (result < 0) {
        return 6;
    } else {
        return result;
    }
}

+ (NSString *)rx_weekdayStringWithWeek:(NSInteger)week
{
    NSString *result = @"";
    switch (week) {
        case 0:
            result = @"一";
            break;
        case 1:
            result = @"二";
            break;
        case 2:
            result = @"三";
            break;
        case 3:
            result = @"四";
            break;
        case 4:
            result = @"五";
            break;
        case 5:
            result = @"六";
            break;
        case 6:
        default:
            result = @"日";
            break;
    }
    return result;
}


@end
