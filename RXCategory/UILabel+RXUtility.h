//
//  UILabel+RXUtility.h
//  RXCategory
//
//  Created by Rush.D.Xzj on 15/4/18.
//  Copyright (c) 2015年 Rush.D.Xzj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (RXUtility)

- (void)rx_setAttributedTextWithStringAry:(NSArray *)stringAry fontAry:(NSArray *)fontAry colorAry:(NSArray *)colorAry;

- (void)rx_setAttributedTextWithStringAry:(NSArray *)stringAry fontAry:(NSArray *)fontAry colorAry:(NSArray *)colorAry underlineAry:(NSArray *)underlineAry;

- (void)rx_setAttributedTextWithStringAry:(NSArray *)stringAry fontAry:(NSArray *)fontAry colorAry:(NSArray *)colorAry underlineAry:(NSArray *)underlineAry underlineColorAry:(NSArray *)underlineColorAry;









@end
