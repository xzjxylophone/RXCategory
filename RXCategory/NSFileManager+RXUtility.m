//
//  NSFileManager+RXUtility.m
//  RXCategory
//
//  Created by Rush.D.Xzj on 16/2/16.
//  Copyright © 2016年 Rush.D.Xzj. All rights reserved.
//

#import "NSFileManager+RXUtility.h"

@implementation NSFileManager (RXUtility)


+ (NSString *)rx_documentPath
{
    NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docPath = [docPaths objectAtIndex:0];
    return docPath;
}







+ (BOOL)rx_addSkipBackupAttributeToItemAtFileDirectory:(NSString *)fileDirectory
{
    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL isDir = NO;
    BOOL isDirExist = [fm fileExistsAtPath:fileDirectory isDirectory:&isDir];
    if (isDir && isDirExist) {
        NSArray *fileList = [fm contentsOfDirectoryAtPath:fileDirectory error:nil];
        for (NSString *fileName in fileList) {
            NSString *path = [NSString stringWithFormat:@"%@/%@", fileDirectory, fileName];
            // 有可能是一个文件
            [self rx_addSkipBackupAttributeToItemAtFilePath:path];
            
            // 有可能是一个文件夹
            [self rx_addSkipBackupAttributeToItemAtFileDirectory:path];
        }
        return YES;
        
    } else {
        // Do Nothing
        return NO;
    }
}


+ (BOOL)rx_addSkipBackupAttributeToItemAtFilePath:(NSString *)filePath;
{
    NSURL *url = [NSURL fileURLWithPath:filePath];
    if(![[NSFileManager defaultManager] fileExistsAtPath:[url path]]) {
        return NO;
    }
    NSError *error = nil;
    BOOL success = [url setResourceValue:@(YES) forKey: NSURLIsExcludedFromBackupKey error: &error];
    if(!success) {
        NSLog(@"Error excluding %@ from backup %@", [url lastPathComponent], error);
    }
    return success;
}


@end
