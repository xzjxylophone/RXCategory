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



// 翻转UIImage, Need to test
- (UIImage *)rx_rotateWithImageOrientation:(UIImageOrientation)imageOrientation;

- (UIImage *)rx_rotatedByDegrees:(CGFloat)degrees;

- (UIImage *)rx_fixOrientationToUp;

// It have change to orientationUp auto
- (UIImage *)rx_cropWithRect:(CGRect)rect;


- (NSData *)rx_compressionWithMaxLength:(NSInteger)length compressionOK:(BOOL *)compressionOK;




// 需要加入很多的东西
- (NSString *)rx_transform_base64String;






@end
