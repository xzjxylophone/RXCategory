//
//  UIImage+RXUtility.h
//  RXCategory
//
//  Created by Rush.D.Xzj on 15-3-30.
//  Copyright (c) 2015年 Rush.D.Xzj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (RXUtility)
- (UIImage *)rx_scaleToSize:(CGSize)newSize;


// 有问题:!!!!!!!
// 翻转UIImage
- (UIImage *)rx_rotateWithImageOrientation:(UIImageOrientation)imageOrientation;

- (UIImage *)rx_rotatedByDegrees:(CGFloat)degrees;

- (UIImage *)rx_fixOrientationToUp;
- (UIImage *)rx_cropWithRect:(CGRect)rect;




// 需要加入很多的东西





@end
