//
//  NSFileManager+RXUtility.h
//  RXCategory
//
//  Created by Rush.D.Xzj on 16/2/16.
//  Copyright © 2016年 Rush.D.Xzj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (RXUtility)

+ (NSString *)rx_documentPath;




// 给一个文件夹添加禁止云同步,递归遍历该文件夹下的所有文件
+ (BOOL)rx_addSkipBackupAttributeToItemAtFileDirectory:(NSString *)fileDirectory;



// 给一个文件添加禁止云同步
+ (BOOL)rx_addSkipBackupAttributeToItemAtFilePath:(NSString *)filePath;

@end
