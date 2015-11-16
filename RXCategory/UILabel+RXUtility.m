//
//  UILabel+RXUtility.m
//  A2A
//
//  Created by Rush.D.Xzj on 15/4/18.
//  Copyright (c) 2015年 Rush.D.Xzj. All rights reserved.
//

#import "UILabel+RXUtility.h"

@implementation UILabel (RXUtility)

- (void)rx_setAttributedTextWithStringAry:(NSArray *)stringAry fontAry:(NSArray *)fontAry colorAry:(NSArray *)colorAry
{
    [self rx_setAttributedTextWithStringAry:stringAry fontAry:fontAry colorAry:colorAry underlineAry:nil];
}

- (void)rx_setAttributedTextWithStringAry:(NSArray *)stringAry fontAry:(NSArray *)fontAry colorAry:(NSArray *)colorAry underlineAry:(NSArray *)underlineAry
{
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:[stringAry componentsJoinedByString:@""]];
    int startIndex = 0;
    for (int i = 0; i < stringAry.count; i++) {
        NSString *tmp = [stringAry objectAtIndex:i];
        UIColor *textColor = i < colorAry.count ? colorAry[i] : [NSNull null];
        UIFont *font = i < fontAry.count ? fontAry[i] : [NSNull null];
        NSNumber *underline = i < underlineAry.count ? underlineAry[i] : [NSNull null];
        NSRange range = NSMakeRange(startIndex, tmp.length);
        if (![textColor isKindOfClass:[NSNull class]]) {
            [attStr addAttribute:NSForegroundColorAttributeName value:textColor range:range];
        }
        if (![font isKindOfClass:[NSNull class]]) {
            [attStr addAttribute:NSFontAttributeName value:font range:range];
        }
        if (![underline isKindOfClass:[NSNull class]]) {
            [attStr addAttribute:NSUnderlineStyleAttributeName value:underline range:range];
        }
        startIndex += tmp.length;
    }
    self.attributedText = attStr;
}





















































@end
