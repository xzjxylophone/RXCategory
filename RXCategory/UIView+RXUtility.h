//
//  UIView+RXUtility.h
//  TestURL
//
//  Created by Rush.D.Xzj on 15-3-30.
//  Copyright (c) 2015年 Rush.D.Xzj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (RXUtility)


@property (nonatomic, retain) id data;


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


@property (nonatomic, strong) UITapGestureRecognizer *tgr;

// 使整个UIView 变成圆形,  当且只有width = height 的时候才是圆形
- (void)rx_makeRound;

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


@end
