//
//  UIDevice+RXUtility.h
//  RXCategory
//
//  Created by Rush.D.Xzj on 15/10/30.
//  Copyright © 2015年 Rush.D.Xzj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (RXUtility)
+ (NSString *)rx_identifier;
+ (NSString *)rx_createUDID;
+ (NSString *)rx_currentPhoneNumber;
+ (NSString *)rx_currentDeviceModel;

@end
