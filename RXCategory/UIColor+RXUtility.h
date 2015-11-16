//
//  UIColor+RXUtility.h
//  TestURL
//
//  Created by Rush.D.Xzj on 15-3-30.
//  Copyright (c) 2015年 Rush.D.Xzj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (RXUtility)

//以#开头的字符串（不区分大小写），如：#ffFFff，若需要alpha，则传#abcdef255，不传默认为1
+ (UIColor *)rx_colorWithString:(NSString *)name;
+ (UIColor *)rx_colorWithSameRGB:(CGFloat)rgb;


// UIColor 得到图片
- (UIImage *)rx_imageWithSize:(CGSize)size;


@end
