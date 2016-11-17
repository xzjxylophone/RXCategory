//
//  NSDate+RXUtility.h
//  RXCategoryExample
//
//  Created by ceshi on 16/8/5.
//  Copyright © 2016年 Rush.D.Xzj. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, E_RX_DateFormatter) {
    kE_RX_DateFormatterAllFormat1       =       100,        // yyyy年MM月dd日 HH时mm分
    kE_RX_DateFormatterAllFormat2       =       101,        // yyyy.MM.dd HH:mm
    kE_RX_DateFormatterAllFormat3       =       103,        // yyyy-MM-dd HH:mm:ss
    kE_RX_DateFormatterFormat1          =       200,        // HH:mm
    kE_RX_DateFormatterFormat2          =       201,        // M月d日
    kE_RX_DateFormatterFormat3          =       202,        // HH:mm:ss
    kE_RX_DateFormatterDate             =       300,        // yyyy-MM-dd
    kE_RX_DateFormatterDate2            =       301,        // yyyy年MM月dd日
    kE_RX_DateFormatterDate3            =       302,        // yyyyMMdd
    kE_RX_DateFormatterDate4            =       304,        // yyyyMM
    kE_RX_DateFormatterDate5            =       305,        // M月yyyy年
    kE_RX_DateFormatterDate6            =       306,        // yyyyMMddHHmm
    kE_RX_DateFormatterDate7            =       307,        // yyyy.M.d HH:mm
    kE_RX_DateFormatterDate8            =       308,        // yyyy.MM.dd
    kE_RX_DateFormatterDate9            =       309,        // yyyy年M月d日
    kE_RX_DateFormatterDate10           =       310,        // yyyy年M月
    kE_RX_DateFormatterDate11           =       311,        // yyyy年MM月dd日 HH:mm:ss
    kE_RX_DateFormatterDate12           =       312,        // MM.dd
    kE_RX_DateFormatterDate13           =       313,        // yyyy.MM
    kE_RX_DateFormatterDate14           =       314,        // yyyy年
};




@interface NSDate (RXUtility)

+ (NSDate *)rx_dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second;

- (NSInteger)rx_weekdayIndex;

+ (NSString *)rx_weekdayStringWithWeek:(NSInteger)week;






+ (NSDate *)rx_dateFromMilliSecond:(long long)milliSecond;
+ (NSDate *)rx_dateFromSecond:(long long)second;


#pragma mark - NSDate & NSString
- (NSString *)rx_dateStringWithFormatter:(E_RX_DateFormatter)formatter;
- (NSString *)rx_dateStringWithFormatterString:(NSString *)string;
+ (NSDate *)rx_dateFromString:(NSString *)string formatter:(E_RX_DateFormatter)formatter;
+ (NSDate *)rx_dateFromString:(NSString *)string formatterString:(NSString *)formatterString;














@end
