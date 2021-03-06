//
//  NSURL+RXUtility.m
//  RXCategory
//
//  Created by Rush.D.Xzj on 15-3-26.
//  Copyright (c) 2015年 Rush.D.Xzj. All rights reserved.
//

#import "NSURL+RXUtility.h"

@implementation NSURL (RXUtility)


- (NSDictionary *)rx_params
{
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    if (NSNotFound != [self.absoluteString rangeOfString:@"?"].location) {
        NSString *paramString = [self.absoluteString substringFromIndex:([self.absoluteString rangeOfString:@"?"].location + 1)];
        NSCharacterSet *delimiterSet = [NSCharacterSet characterSetWithCharactersInString:@"&"];
        NSScanner *scanner = [[NSScanner alloc] initWithString:paramString];
        while (![scanner isAtEnd]) {
            NSString *pairString = nil;
            [scanner scanUpToCharactersFromSet:delimiterSet intoString:&pairString];
            [scanner scanCharactersFromSet:delimiterSet intoString:NULL];
            NSArray *kvPair = [pairString componentsSeparatedByString:@"="];
            if (kvPair.count == 2) {
                NSString *key = [kvPair objectAtIndex:0];
                NSString *value = [kvPair objectAtIndex:1];
                [result setValue:value forKey:key];
            }
        }
    }
    return result;
}


+ (NSURL *)rx_URLWithString:(NSString *)string
{
    if (string.length == 0) {
        return nil;
    }
    NSURL *url = [NSURL URLWithString:string];
    if (url == nil) {
        NSString *tmpString =  [NSString stringWithString:[string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        url = [NSURL URLWithString:tmpString];
    }
    return url;
}

@end
