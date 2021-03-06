//
//  UIDevice+RXUtility.m
//  RXCategory
//
//  Created by Rush.D.Xzj on 15/10/30.
//  Copyright © 2015年 Rush.D.Xzj. All rights reserved.
//

#import "UIDevice+RXUtility.h"
#import <dlfcn.h>

#import <sys/sysctl.h>
#define PRIVATE_PATH "/System/Library/PrivateFrameworks/CoreTelephony.framework/CoreTelephony"


@implementation UIDevice (RXUtility)

//+ (NSString *)rx_imei
//{
//    void *kit = dlopen(PRIVATE_PATH, RTLD_LAZY);
//    NSString *imsi = @"";
//    
//    int (*CTSIMSupportCopyMobileSubscriberIdentity)() = dlsym(kit, "CTSIMSupportCopyMobileSubscriberIdentity");
//    imsi = (NSString *)CTSIMSupportCopyMobileSubscriberIdentity(nil);
//    dlclose(kit);
//    
//    return imsi;
//    
//}

+ (NSString *)rx_identifier  {
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

+ (NSString *)rx_createUDID {
    NSString *key = @"com.device_rxutility_uuid";
    NSString *id = [[NSUserDefaults standardUserDefaults] objectForKey:key];    //获取标识为"UUID"的值
    if(id == nil)  {
        if([[[UIDevice currentDevice] systemVersion] floatValue] > 6.0) {
            NSString *identifierNumber = [[NSUUID UUID] UUIDString];                //ios 6.0 之后可以使用的api
            [[NSUserDefaults standardUserDefaults] setObject:identifierNumber forKey:key];  //保存为UUID
            [[NSUserDefaults standardUserDefaults] synchronize];
        } else {
            CFUUIDRef uuid = CFUUIDCreate(NULL);
            CFStringRef uuidString = CFUUIDCreateString(NULL, uuid);                    //ios6.0之前使用的api
            NSString *identifierNumber = [NSString stringWithFormat:@"%@", uuidString];
            [[NSUserDefaults standardUserDefaults] setObject:identifierNumber forKey:key];
            [[NSUserDefaults standardUserDefaults] synchronize];
            CFRelease(uuidString);
            CFRelease(uuid);
        }
        return [[NSUserDefaults standardUserDefaults] objectForKey:key];
    }
    return id;
}


+ (NSString *)rx_currentPhoneNumber
{
    NSString *num = [[NSUserDefaults standardUserDefaults] stringForKey:@"SBFormattedPhoneNumber"];
    return num;
}


+ (NSString *)rx_currentDeviceModel
{
    int mib[2];
    size_t len;
    char *machine;
    
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G (A1203)";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G (A1241/A1324)";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS (A1303/A1325)";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4 (A1349)";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S (A1387/A1431)";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5 (A1428)";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5 (A1429/A1442)";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c (A1456/A1532)";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c (A1507/A1516/A1526/A1529)";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s (A1453/A1533)";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s (A1457/A1518/A1528/A1530)";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus (A1522/A1524)";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6 (A1549/A1586)";
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone7";
    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone7Plus";
    
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G (A1213)";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G (A1288)";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G (A1318)";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G (A1367)";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G (A1421/A1509)";
    
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G (A1219/A1337)";
    
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2 (A1395)";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2 (A1396)";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2 (A1397)";
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2 (A1395+New Chip)";
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G (A1432)";
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G (A1454)";
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G (A1455)";
    
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3 (A1416)";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3 (A1403)";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3 (A1430)";
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4 (A1458)";
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4 (A1459)";
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4 (A1460)";
    
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air (A1474)";
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air (A1475)";
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air (A1476)";
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G (A1489)";
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G (A1490)";
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G (A1491)";
    
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    return platform;
}







































@end
