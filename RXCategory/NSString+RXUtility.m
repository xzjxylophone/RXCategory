//
//  NSString+RXUtility.m
//  A2A
//
//  Created by Rush.D.Xzj on 15/4/17.
//  Copyright (c) 2015年 Rush.D.Xzj. All rights reserved.
//

#import "NSString+RXUtility.h"

#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>
#import <CommonCrypto/CommonCryptor.h>

@implementation NSString (RXUtility)

- (BOOL)rx_isValidateEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
    return [emailTest evaluateWithObject:self];
    
}


- (NSString *)rx_hiddenMobileFormatString
{
    NSRange range;
    range.location = 3;
    range.length = 4;
    return [self stringByReplacingCharactersInRange:range withString:@"****"];
}

- (BOOL)rx_isChinaMobileFormat
{
    NSString *regex = @"^1\\d{10}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}
- (NSString *)rx_md5
{
    return [self rx_transform_MD5];
    
}

- (BOOL)rx_isPureInt
{
    NSScanner* scan = [NSScanner scannerWithString:self];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}
// 非0的正整数
- (BOOL)rx_isNoZeorIntValue
{
    NSRange range = [self rangeOfString:@"."];
    if (range.length > 0) {
        return NO;
    }
    
    int value = [self intValue];
    NSString *str = [NSString stringWithFormat:@"%d", value];
    if (value <= 0) {
        return NO;
    }
    if (![str isEqualToString:self]) {
        return NO;
    }
    return YES;

}


- (BOOL)rx_isTwoDoubleIntValueWithString:(NSString *)str
{
    double value = [str doubleValue];
    
    if (value <= 0) {
        return NO;
    }
    NSRange range = [str rangeOfString:@"."];
    NSString *str2 = [str substringFromIndex:range.location];
    
    if (str2.length > 3) {
        return NO;
    }
    return YES;
    
}

- (NSString *)rx_transformToPinyin
{
    return [self rx_transform_Phoneticize];
}

+ (NSString *)rx_validStringWithObj:(id)obj
{
    if ([obj isKindOfClass:[NSString class]]) {
        NSString *tmp = obj;
        return tmp.length > 0 ? tmp : @"";
    } else if ([obj isKindOfClass:[NSNull class]]) {
        return @"";
    } else {
        NSString *result = [NSString stringWithFormat:@"%@", obj];
        return result;
    }
}




#pragma mark - Phoneticize
- (NSString *)rx_transform_Phoneticize
{
    NSMutableString *mutableString = [NSMutableString stringWithString:self];
    CFStringTransform((CFMutableStringRef)mutableString, NULL, kCFStringTransformToLatin, false);
    CFStringTransform((CFMutableStringRef)mutableString, NULL, kCFStringTransformStripDiacritics, false);
    NSString *result = [NSString stringWithFormat:@"%@", mutableString];
    result = [result stringByReplacingOccurrencesOfString:@" " withString:@""];
    return result;
}


#pragma mark - Base64 Encode/Decode
- (NSString *)rx_transform_Base64Encode
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSString *resultString = [data base64EncodedStringWithOptions:0];
    return resultString;
}

- (NSString *)rx_transform_Base64Decode
{
    NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:0];
    NSString *resultString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return resultString;
}


#pragma mark - URL Encode/Decode
- (NSString *)rx_transform_URLEncode
{
    CFStringEncoding encoding = CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding);
    CFStringRef stringRef = CFURLCreateStringByAddingPercentEscapes(NULL, (__bridge CFStringRef)self, NULL, (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ", encoding);
    return  (__bridge_transfer NSString *)stringRef;
}

- (NSString *)rx_transform_URLDecode
{
    CFStringEncoding encoding = CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding);
    CFStringRef stringRef = CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef)self, CFSTR(""), encoding);
    return  (__bridge_transfer NSString *)stringRef;
}

#pragma mark - MD5
- (NSString *)rx_transform_MD5
{
    const char *input = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    NSMutableString *resultString = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [resultString appendFormat:@"%02x", result[i]];
    }
    return [resultString lowercaseString];
}




#pragma mark - AES Encrypt/Decrypt
#pragma mark Public
- (NSString *)rx_transform_AESEncryptWithKey:(NSString *)key
{
    NSData *secretData = [self dataUsingEncoding:NSASCIIStringEncoding];
    // You can use md5 to make sure key is 16 bits long
    NSData *encryptedData = [NSString encrypt:secretData key:key];
    return [NSString hex:encryptedData useLower:YES];
}
- (NSString *)rx_transform_AESDecryptWithKey:(NSString *)key
{
    NSData *hexData = [self hex];
    NSData *data = [NSString decrypt:hexData key:key];
    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
}
#define kChosenCipherBlockSize	kCCBlockSizeAES128
#define kChosenCipherKeySize	kCCKeySizeAES128
CCOptions _padding = kCCOptionPKCS7Padding;
#pragma mark - Private
+ (NSData *)encrypt:(NSData *)plainText key:(NSString *)key
{
    return [self doCipher:plainText key:key context:kCCEncrypt];
}
+ (NSData *)decrypt:(NSData *)plainText key:(NSString *)key
{
    return [self doCipher:plainText key:key context:kCCDecrypt];
}
+ (NSData *)doCipher:(NSData *)plainText key:(NSString *)key context:(CCOperation)encryptOrDecrypt
{
    CCCryptorStatus ccStatus = kCCSuccess;
    // Symmetric crypto reference.
    CCCryptorRef thisEncipher = NULL;
    // Cipher Text container.
    NSData * cipherOrPlainText = nil;
    // Pointer to output buffer.
    uint8_t * bufferPtr = NULL;
    // Total size of the buffer.
    size_t bufferPtrSize = 0;
    // Remaining bytes to be performed on.
    size_t remainingBytes = 0;
    // Number of bytes moved to buffer.
    size_t movedBytes = 0;
    // Length of plainText buffer.
    size_t plainTextBufferSize = 0;
    // Placeholder for total written.
    size_t totalBytesWritten = 0;
    // A friendly helper pointer.
    uint8_t * ptr;
    CCOptions *pkcs7;
    pkcs7 = &_padding;
    NSData *aSymmetricKey = [key dataUsingEncoding:NSUTF8StringEncoding];
    
    // Initialization vector; dummy in this case 0's.
    uint8_t iv[kChosenCipherBlockSize];
    memset((void *) iv, 0x0, (size_t) sizeof(iv));
    
    plainTextBufferSize = [plainText length];
    
    // We don't want to toss padding on if we don't need to
    if (encryptOrDecrypt == kCCEncrypt) {
        if(*pkcs7 != kCCOptionECBMode) {
            *pkcs7 = kCCOptionPKCS7Padding;
        }
    } else if (encryptOrDecrypt != kCCDecrypt) {
        NSLog(@"Invalid CCOperation parameter [%d] for cipher context.", *pkcs7 );
    }
    
    // Create and Initialize the crypto reference.
    CCCryptorCreate(encryptOrDecrypt, kCCAlgorithmAES128, *pkcs7, (const void *)[aSymmetricKey bytes], kChosenCipherKeySize, (const void *)iv, &thisEncipher);
    
    // Calculate byte block alignment for all calls through to and including final.
    bufferPtrSize = CCCryptorGetOutputLength(thisEncipher, plainTextBufferSize, true);
    
    // Allocate buffer.
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t) );
    
    // Zero out buffer.
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    // Initialize some necessary book keeping.
    ptr = bufferPtr;
    
    // Set up initial size.
    remainingBytes = bufferPtrSize;
    
    // Actually perform the encryption or decryption.
    CCCryptorUpdate(thisEncipher, (const void *) [plainText bytes], plainTextBufferSize, ptr, remainingBytes, &movedBytes);
    
    // Handle book keeping.
    ptr += movedBytes;
    remainingBytes -= movedBytes;
    totalBytesWritten += movedBytes;
    
    // Finalize everything to the output buffer.
    ccStatus = CCCryptorFinal(thisEncipher, ptr, remainingBytes, &movedBytes);
    
    totalBytesWritten += movedBytes;
    
    if(thisEncipher) {
        (void) CCCryptorRelease(thisEncipher);
        thisEncipher = NULL;
    }
    
    if (ccStatus == kCCSuccess)
        cipherOrPlainText = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)totalBytesWritten];
    else
        cipherOrPlainText = nil;
    
    if(bufferPtr) free(bufferPtr);
    
    return cipherOrPlainText;
}
+ (NSString *)hex:(NSData *)data useLower:(BOOL)isOutputLower
{
    static const char HexEncodeCharsLower[] = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f' };
    static const char HexEncodeChars[] = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F' };
    char *resultData;
    // malloc result data
    resultData = malloc([data length] * 2 +1);
    // convert imgData(NSData) to char[]
    unsigned char *sourceData = ((unsigned char *)[data bytes]);
    uint length = (uint)[data length];
    
    if (isOutputLower) {
        for (uint index = 0; index < length; index++) {
            // set result data
            resultData[index * 2] = HexEncodeCharsLower[(sourceData[index] >> 4)];
            resultData[index * 2 + 1] = HexEncodeCharsLower[(sourceData[index] % 0x10)];
        }
    } else {
        for (uint index = 0; index < length; index++) {
            // set result data
            resultData[index * 2] = HexEncodeChars[(sourceData[index] >> 4)];
            resultData[index * 2 + 1] = HexEncodeChars[(sourceData[index] % 0x10)];
        }
    }
    resultData[[data length] * 2] = 0;
    // convert result(char[]) to NSString
    NSString *result = [NSString stringWithCString:resultData encoding:NSASCIIStringEncoding];
    sourceData = nil;
    free(resultData);
    return result;
}
- (NSData *)hex
{
    static const unsigned char HexDecodeChars[] =
    {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 1, //49
        2, 3, 4, 5, 6, 7, 8, 9, 0, 0, //59
        0, 0, 0, 0, 0, 10, 11, 12, 13, 14,
        15, 0, 0, 0, 0, 0, 0, 0, 0, 0,  //79
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 10, 11, 12,   //99
        13, 14, 15
    };
    
    // convert data(NSString) to CString
    const char *source = [self cStringUsingEncoding:NSUTF8StringEncoding];
    // malloc buffer
    unsigned char *buffer;
    uint length =(uint)strlen(source) / 2;
    buffer = malloc(length);
    for (uint index = 0; index < length; index++) {
        buffer[index] = (HexDecodeChars[source[index * 2]] << 4) + (HexDecodeChars[source[index * 2 + 1]]);
    }
    // init result NSData
    NSData *result = [NSData dataWithBytes:buffer length:length];
    free(buffer);
    source = nil;
    
    return  result;
}

@end
