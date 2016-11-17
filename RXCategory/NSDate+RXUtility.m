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

+ (NSDate *)rx_dateFromMilliSecond:(long long)milliSecond
{
    return [self rx_dateFromSecond:milliSecond / 1000];
}
+ (NSDate *)rx_dateFromSecond:(long long)second
{
    return [NSDate dateWithTimeIntervalSince1970:second];
}


#pragma mark - NSDate & NSString

+ (NSDictionary *)rx_DateFormatterDictionary
{
    static NSDictionary *result = nil;
    if (result == nil) {
        result = @{    @(kE_RX_DateFormatterAllFormat1):@"yyyy年MM月dd日 HH时mm分",
                       @(kE_RX_DateFormatterAllFormat2):@"yyyy.MM.dd HH:mm",
                       @(kE_RX_DateFormatterAllFormat3):@"yyyy-MM-dd HH:mm:ss",
                       @(kE_RX_DateFormatterFormat1):@"HH:mm",
                       @(kE_RX_DateFormatterFormat2):@"M月d日",
                       @(kE_RX_DateFormatterFormat3):@"HH:mm:ss",
                       @(kE_RX_DateFormatterDate):@"yyyy-MM-dd",
                       @(kE_RX_DateFormatterDate2):@"yyyy年MM月dd日",
                       @(kE_RX_DateFormatterDate3):@"yyyyMMdd",
                       @(kE_RX_DateFormatterDate4):@"yyyyMM",
                       @(kE_RX_DateFormatterDate5):@"M月yyyy年",
                       @(kE_RX_DateFormatterDate6):@"yyyyMMddHHmm",
                       @(kE_RX_DateFormatterDate7):@"yyyy.M.d HH:mm",
                       @(kE_RX_DateFormatterDate8):@"yyyy.MM.dd",
                       @(kE_RX_DateFormatterDate9):@"yyyy年M月d日",
                       @(kE_RX_DateFormatterDate10):@"yyyy年M月",
                       @(kE_RX_DateFormatterDate11):@"yyyy年MM月dd日 HH:mm:ss",
                       @(kE_RX_DateFormatterDate12):@"MM.dd",
                       @(kE_RX_DateFormatterDate13):@"yyyy.MM",
                       @(kE_RX_DateFormatterDate14):@"yyyy年"};
    }
    return result;

}

- (NSString *)rx_dateStringWithFormatter:(E_RX_DateFormatter)formatter
{
    NSString *formatterStr = [NSDate rx_DateFormatterDictionary][@(formatter)];
    return [self rx_dateStringWithFormatterString:formatterStr];
}
- (NSString *)rx_dateStringWithFormatterString:(NSString *)string
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setDateFormat:string];
    NSString *result = [formatter stringFromDate:self];
    return result;
}
+ (NSDate *)rx_dateFromString:(NSString *)string formatter:(E_RX_DateFormatter)formatter
{
    NSString *formatterStr = [NSDate rx_DateFormatterDictionary][@(formatter)];
    return [self rx_dateFromString:string formatterString:formatterStr];
}
+ (NSDate *)rx_dateFromString:(NSString *)string formatterString:(NSString *)formatterString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatterString];
    NSDate *date = [dateFormatter dateFromString:string];
    return date;
}



@end
