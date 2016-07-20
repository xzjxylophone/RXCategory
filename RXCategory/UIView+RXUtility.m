//
//  UIView+RXUtility.m
//  RXCategory
//
//  Created by Rush.D.Xzj on 15-3-30.
//  Copyright (c) 2015年 Rush.D.Xzj. All rights reserved.
//

#import "UIView+RXUtility.h"
#import <objc/runtime.h>
#import "NSObject+RXUtility.h"

@implementation UIView (RXUtility)

#pragma mark - Property
- (id)rx_tgr
{
    return objc_getAssociatedObject(self, @"rx_tgr");
}

- (void)setRx_tgr:(id)rx_tgr
{
    objc_setAssociatedObject(self, @"rx_tgr", rx_tgr, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (CGFloat)left
{
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = ceilf(x);
    self.frame = frame;
}

- (CGFloat)top
{
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = ceilf(y);
    self.frame = frame;
}

- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = ceilf(right - frame.size.width);
    self.frame = frame;
}

- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = ceilf(bottom - frame.size.height);
    self.frame = frame;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX
{
    self.center = CGPointMake(ceilf(centerX), self.center.y);
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY
{
    self.center = CGPointMake(self.center.x, ceilf(centerY));
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = ceilf(width);
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = ceilf(height);
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (void)rx_makeRound
{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = self.width / 2.0f;
}



- (void)rx_makeRoundWithRectCorner:(UIRectCorner)rectCorner cornerRadii:(CGSize)cornerRadii bounds:(CGRect)bounds
{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bounds byRoundingCorners:rectCorner cornerRadii:cornerRadii];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

- (void)rx_makeRoundWithRectCorner:(UIRectCorner)rectCorner cornerRadii:(CGSize)cornerRadii
{
    [self rx_makeRoundWithRectCorner:rectCorner cornerRadii:cornerRadii bounds:self.bounds];
}

- (void)rx_makeLeftRightRound
{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = self.height / 2.0f;
}

- (void)rx_removeAllSubviews
{
    for (UIView *subview in self.subviews) {
        [subview removeFromSuperview];
    }
}

- (UIImage *)rx_imageFromView
{
    
// 高清
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.0);

    
//    UIGraphicsBeginImageContext(self.bounds.size);
    CGContextRef currnetContext = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:currnetContext];
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    
    
//    UIGraphicsBeginImageContext(self.bounds.size);
//    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return image;
}

- (UIImage *)rx_imageByRenderingView
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0.0f);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}



- (id)rx_clsViewFromCls:(Class)cls
{
    UIView *v = self;
    id result = nil;
    do {
        if ([v isKindOfClass:cls]) {
            result = v;
            break;
        } else {
            v = v.superview;
        }
    } while (v != nil);
    return result;
}

- (UIViewController *)rx_viewController
{
    for (UIView *next = self.superview; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}



- (void)rx_addGestureRecognizerWithTarget:(id)target action:(SEL)action
{
    if (self.rx_tgr != nil) {
        [self removeGestureRecognizer:self.rx_tgr];
    }
    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    tgr.numberOfTapsRequired = 1;
    self.rx_tgr = tgr;
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:self.rx_tgr];
}

- (void)rx_removeGestureRecognizer
{
    if (self.rx_tgr != nil) {
        [self removeGestureRecognizer:self.rx_tgr];
    }
}












- (void)rx_addAppDidEnterBgNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(uiapplicationDidEnterBackgroundNotification:) name:UIApplicationDidEnterBackgroundNotification object:nil];
}
- (void)rx_removeAppDidEnterBgNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
}

- (void)uiapplicationDidEnterBackgroundNotification:(id)sender
{
    [self rx_removeAppDidEnterBgNotification];
    if ([self isKindOfClass:[UIAlertView class]]) {
        UIAlertView *av = (UIAlertView *)self;
        [av dismissWithClickedButtonIndex:0 animated:YES];
        
    } else if ([self isKindOfClass:[UIActionSheet class]]) {
        UIActionSheet *as = (UIActionSheet *)self;
        [as dismissWithClickedButtonIndex:0 animated:YES];
    } else {
        if ([self respondsToSelector:@selector(close)]) {
            [self performSelector:@selector(close)];
        } else {
            // Do Nothing
        }
    }
}



#pragma mark - Constraint

- (void)rx_fillAllWithSubview:(UIView *)subview
{
    [self rx_fillWithSubview:subview top:0 left:0 bottom:0 right:0];
}

- (void)rx_fillWithSubview:(UIView *)subview top:(CGFloat)top
{
    [self rx_fillWithSubview:subview top:top left:0 bottom:top right:0];
}
- (void)rx_fillWithSubview:(UIView *)subview left:(CGFloat)left
{
    [self rx_fillWithSubview:subview top:0 left:left bottom:0 right:left];
}
- (void)rx_fillWithSubview:(UIView *)subview top:(CGFloat)top left:(CGFloat)left
{
    [self rx_fillWithSubview:subview top:top left:left bottom:top right:left];
}
- (void)rx_fillWithSubview:(UIView *)subview top:(CGFloat)top left:(CGFloat)left bottom:(CGFloat)bottom right:(CGFloat)right
{
    [UIView rx_fillWithSuperview:self subview:subview top:top left:left bottom:bottom right:right];
}





- (void)rx_fillAllWithSuperview:(UIView *)superview
{
    [self rx_fillWithSuperview:superview top:0 left:0 bottom:0 right:0];
}
- (void)rx_fillWithSuperview:(UIView *)superview top:(CGFloat)top
{
    [self rx_fillWithSuperview:superview top:top left:0 bottom:top right:0];
}
- (void)rx_fillWithSuperview:(UIView *)superview left:(CGFloat)left
{
    [self rx_fillWithSuperview:superview top:0 left:left bottom:0 right:left];
}
- (void)rx_fillWithSuperview:(UIView *)superview top:(CGFloat)top left:(CGFloat)left
{
    [self rx_fillWithSuperview:superview top:top left:left bottom:top right:left];
}
- (void)rx_fillWithSuperview:(UIView *)superview top:(CGFloat)top left:(CGFloat)left bottom:(CGFloat)bottom right:(CGFloat)right
{
    [UIView rx_fillWithSuperview:superview subview:self top:top left:left bottom:bottom right:right];
}



+ (void)rx_fillWithSuperview:(UIView *)superview subview:(UIView *)subview top:(CGFloat)top left:(CGFloat)left bottom:(CGFloat)bottom right:(CGFloat)right
{
    [subview setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSLayoutConstraint *lc1 = [NSLayoutConstraint constraintWithItem:subview attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:superview attribute:NSLayoutAttributeLeading multiplier:1 constant:left];
    NSLayoutConstraint *lc2 = [NSLayoutConstraint constraintWithItem:subview attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:superview attribute:NSLayoutAttributeTop multiplier:1 constant:top];
    NSLayoutConstraint *lc3 = [NSLayoutConstraint constraintWithItem:superview attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:subview attribute:NSLayoutAttributeTrailing multiplier:1 constant:right];
    NSLayoutConstraint *lc4 = [NSLayoutConstraint constraintWithItem:superview attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:subview attribute:NSLayoutAttributeBottom multiplier:1 constant:bottom];
    [superview addConstraints:@[lc1, lc2, lc3, lc4]];
}


#pragma mark - Debug

+ (void)rx_setDefaultColorsInViews:(NSArray *)views
{
    [self setColors:@[[UIColor redColor], [UIColor greenColor], [UIColor blueColor]] inViews:views];
}
+ (void)rx_setColors:(NSArray *)colors inViews:(NSArray *)views
{
#if DEBUG
    NSArray *tmpColors = colors;
    if (tmpColors.count == 0) {
        tmpColors = @[[UIColor redColor], [UIColor greenColor], [UIColor blueColor]];
    }
    
    NSInteger tmpCount = tmpColors.count;
    for (NSInteger i = 0; i < views.count; i++) {
        NSInteger remain = i % tmpCount;
        UIColor *color = tmpColors[remain];
        UIView *view = views[i];
        view.backgroundColor = color;
    }
#endif
}


+ (void)setDefaultColorsInViews:(NSArray *)views
{
    return [self rx_setDefaultColorsInViews:views];
}

+ (void)setColors:(NSArray *)colors inViews:(NSArray *)views
{
    return [self rx_setColors:colors inViews:views];
}
@end
