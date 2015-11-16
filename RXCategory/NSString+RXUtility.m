//
//  NSString+RXUtility.m
//  A2A
//
//  Created by Rush.D.Xzj on 15/4/17.
//  Copyright (c) 2015年 Rush.D.Xzj. All rights reserved.
//

#import "NSString+RXUtility.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (RXUtility)

- (BOOL)rx_isValidateEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
    return [emailTest evaluateWithObject:self];
    
}


- (NSString *)rx_hiddenMobileFormatString
{
    NSRange range;
    range.location = 3;
    range.length = 4;
    return [self stringByReplacingCharactersInRange:range withString:@"****"];
}

- (BOOL)rx_isChinaMobileFormat
{
    NSString *regex = @"^1\\d{10}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}
- (NSString *)rx_md5
{
    const char* string = [self UTF8String];
    unsigned char result[16];
    CC_MD5(string, (CC_LONG)strlen(string), result);
    NSString * hash = [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                       result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
                       result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]];
    
    return [hash lowercaseString];
    
}

- (BOOL)rx_isPureInt
{
    NSScanner* scan = [NSScanner scannerWithString:self];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}
// 非0的正整数
- (BOOL)rx_isNoZeorIntValue
{
    NSRange range = [self rangeOfString:@"."];
    if (range.length > 0) {
        return NO;
    }
    
    int value = [self intValue];
    NSString *str = [NSString stringWithFormat:@"%d", value];
    if (value <= 0) {
        return NO;
    }
    if (![str isEqualToString:self]) {
        return NO;
    }
    return YES;

}


- (BOOL)rx_isTwoDoubleIntValueWithString:(NSString *)str
{
    double value = [str doubleValue];
    
    if (value <= 0) {
        return NO;
    }
    NSRange range = [str rangeOfString:@"."];
    NSString *str2 = [str substringFromIndex:range.location];
    
    if (str2.length > 3) {
        return NO;
    }
    return YES;
    
}

- (NSString *)rx_transformToPinyin
{
    NSMutableString *mutableString = [NSMutableString stringWithString:self];
    CFStringTransform((CFMutableStringRef)mutableString, NULL, kCFStringTransformToLatin, false);
    CFStringTransform((CFMutableStringRef)mutableString, NULL, kCFStringTransformStripDiacritics, false);
    NSString *result = [NSString stringWithFormat:@"%@", mutableString];
    result = [result stringByReplacingOccurrencesOfString:@" " withString:@""];
    return result;
}
+ (NSString *)rx_validStringWithObj:(id)obj
{
    if ([obj isKindOfClass:[NSString class]]) {
        NSString *tmp = obj;
        return tmp.length > 0 ? tmp : @"";
    } else if ([obj isKindOfClass:[NSNull class]]) {
        return @"";
    } else {
        NSString *result = [NSString stringWithFormat:@"%@", obj];
        return result;
    }
}


@end
