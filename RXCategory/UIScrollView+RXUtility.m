//
//  UIScrollView+RXUtility.m
//  A2A
//
//  Created by Rush.D.Xzj on 15/5/5.
//  Copyright (c) 2015年 Rush.D.Xzj. All rights reserved.
//

#import "UIScrollView+RXUtility.h"

@implementation UIScrollView (RXUtility)

- (void)rx_printScrollViewAttentionProperty
{
    NSString *str1 = [NSString stringWithFormat:@"class:%@", NSStringFromClass([self class])];
    NSString *str2 = [NSString stringWithFormat:@"frame:%@", NSStringFromCGRect(self.frame)];

    NSString *str3 = [NSString stringWithFormat:@"contentSize:%@", NSStringFromCGSize(self.contentSize)];
    NSString *str4 = [NSString stringWithFormat:@"cotentOffset:%@", NSStringFromCGPoint(self.contentOffset)];
    NSString *str5 = [NSString stringWithFormat:@"contentInset:%@", NSStringFromUIEdgeInsets(self.contentInset)];
    
    NSArray *ary = @[str1, str2, str3, str4, str5];
    
    NSString *str = [ary componentsJoinedByString:@"\n"];
    
    NSLog(@"\n%@", str);
}


@end
