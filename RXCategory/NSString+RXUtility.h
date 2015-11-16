//
//  NSString+RXUtility.h
//  A2A
//
//  Created by Rush.D.Xzj on 15/4/17.
//  Copyright (c) 2015年 Rush.D.Xzj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (RXUtility)



- (NSString *)rx_hiddenMobileFormatString;


- (BOOL)rx_isChinaMobileFormat;
- (NSString *)rx_md5;
// 是否是纯数字的字符串
- (BOOL)rx_isPureInt;
// 大于零的整数
- (BOOL)rx_isNoZeorIntValue;

- (BOOL)rx_isTwoDoubleIntValueWithString:(NSString *)str;

- (BOOL)rx_isValidateEmail;

- (NSString *)rx_transformToPinyin;

// 得到一个对象, 如果是字符串的长度是否为0,如果为0,返回空字符串
+ (NSString *)rx_validStringWithObj:(id)obj;


@end
