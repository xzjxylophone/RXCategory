//
//  UIView+RXUtility.h
//  RXCategory
//
//  Created by Rush.D.Xzj on 15-3-30.
//  Copyright (c) 2015年 Rush.D.Xzj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (RXUtility)




@property (nonatomic, readwrite) CGFloat left;
@property (nonatomic, readwrite) CGFloat top;
@property (nonatomic, readwrite) CGFloat right;
@property (nonatomic, readwrite) CGFloat bottom;
@property (nonatomic, readwrite) CGFloat centerX;
@property (nonatomic, readwrite) CGFloat centerY;
@property (nonatomic, readwrite) CGFloat width;
@property (nonatomic, readwrite) CGFloat height;
@property (nonatomic, readwrite) CGPoint origin;
@property (nonatomic, readwrite) CGSize size;


@property (nonatomic, strong) UITapGestureRecognizer *rx_tgr;

// 使整个UIView 变成圆形,  当且只有width = height 的时候才是圆形
- (void)rx_makeRound;
- (void)rx_makeRoundWithRectCorner:(UIRectCorner)rectCorner cornerRadii:(CGSize)cornerRadii bounds:(CGRect)bounds;

- (void)rx_makeRoundWithRectCorner:(UIRectCorner)rectCorner cornerRadii:(CGSize)cornerRadii;

// 是UIView 左右变成半圆形
- (void)rx_makeLeftRightRound;

- (void)rx_removeAllSubviews;
- (UIImage *)rx_imageFromView;
- (UIImage *)rx_imageByRenderingView;

- (id)rx_clsViewFromCls:(Class)cls;

- (UIViewController *)rx_viewController;

- (void)rx_addGestureRecognizerWithTarget:(id)target action:(SEL)action;
- (void)rx_removeGestureRecognizer;


- (void)rx_addAppDidEnterBgNotification;
- (void)rx_removeAppDidEnterBgNotification;



#pragma mark - Constraint
// 上下满的,左右满的
- (void)rx_fillAllWithSubview:(UIView *)subview;
// 上下居中,左右满的
- (void)rx_fillWithSubview:(UIView *)subview top:(CGFloat)top;
// 左右居中,上下慢的
- (void)rx_fillWithSubview:(UIView *)subview left:(CGFloat)left;
// 上下居中,左右居中
- (void)rx_fillWithSubview:(UIView *)subview top:(CGFloat)top left:(CGFloat)left;
// 任意位置
- (void)rx_fillWithSubview:(UIView *)subview top:(CGFloat)top left:(CGFloat)left bottom:(CGFloat)bottom right:(CGFloat)right;



- (void)rx_fillAllWithSuperview:(UIView *)superview;
- (void)rx_fillWithSuperview:(UIView *)superview top:(CGFloat)top;
- (void)rx_fillWithSuperview:(UIView *)superview left:(CGFloat)left;
- (void)rx_fillWithSuperview:(UIView *)superview top:(CGFloat)top left:(CGFloat)left;
- (void)rx_fillWithSuperview:(UIView *)superview top:(CGFloat)top left:(CGFloat)left bottom:(CGFloat)bottom right:(CGFloat)right;

+ (void)rx_fillWithSuperview:(UIView *)superview subview:(UIView *)subview top:(CGFloat)top left:(CGFloat)left bottom:(CGFloat)bottom right:(CGFloat)right;


#pragma mark - Debug
// 只有在 Debug 模式的情况下有效,方便调试用
+ (void)rx_setDefaultColorsInViews:(NSArray *)views;
+ (void)rx_setColors:(NSArray *)colors inViews:(NSArray *)views;

// 只有在 Debug 模式的情况下有效,方便调试用
+ (void)setDefaultColorsInViews:(NSArray *)views;
+ (void)setColors:(NSArray *)colors inViews:(NSArray *)views;


@end
