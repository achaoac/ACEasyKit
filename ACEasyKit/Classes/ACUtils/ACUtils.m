//
//  ACUtils.m
//  ACEasyKit
//
//  Created by achaoacwang on 2022/10/25.
//

#import "ACUtils.h"

@implementation ACUtils

void ac_main_async(dispatch_block_t block) {
    // 判断一下，就不会进入下一个 runloop
    if ([NSThread isMainThread]) {
        block();
    } else {
        dispatch_async(dispatch_get_main_queue(), block);
    }
}

NSString * appVersion(void) {
    return [[NSBundle mainBundle].infoDictionary valueForKey:@"CFBundleShortVersionString"];
}

NSString * appBuildNumber(void) {
    return [[NSBundle mainBundle].infoDictionary valueForKey:@"CFBundleVersion"];
}

NSString * appBundleIdentifier(void) {
    return [[NSBundle mainBundle].infoDictionary valueForKey:@"CFBundleIdentifier"];
}

+ (NSDictionary *)urlToDictionary:(NSString *)url {
    if (url.length <= 0) {
        return nil;
    }
    NSScanner *scanner = [NSScanner scannerWithString:url];
    [scanner setCharactersToBeSkipped:[NSCharacterSet characterSetWithCharactersInString:@"&?"]];
    if ([url containsString:@"?"]) {
        [scanner scanUpToString:@"?" intoString:nil];
    }
    NSString *tmpValue;
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    while ([scanner scanUpToString:@"&" intoString:&tmpValue]) {
        NSArray *components = [tmpValue componentsSeparatedByString:@"="];
        if (components.count >= 2) {
            NSString *key = [components[0] stringByRemovingPercentEncoding];
            NSString *value = [components[1] stringByRemovingPercentEncoding];
            if (key && value) {
                [dictionary setObject:value forKey:key];
            }
        }
    }
    return dictionary;
}

NSString * ac_urlEncode(NSString *string) {
    NSString *charaters = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";
    NSCharacterSet *set = [[NSCharacterSet characterSetWithCharactersInString:charaters] invertedSet];
    return [string stringByAddingPercentEncodingWithAllowedCharacters:set];
}

NSString * ac_urlDecode(NSString *string) {
    return [string stringByRemovingPercentEncoding];
}

NSString * ac_HEXEncode(NSString *string) {
    NSData *myD = [string dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[myD bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[myD length];i++) {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        if([newHexStr length]==1) {
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        } else {
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
        }
    }
    return hexStr;
}

NSString * ac_HEXDecode(NSString *hexString) {
    char *myBuffer = (char *)malloc((int)[hexString length] / 2 + 1);
    bzero(myBuffer, [hexString length] / 2 + 1);
    for (int i = 0; i < [hexString length] - 1; i += 2) {
        unsigned int anInt;
        NSString * hexCharStr = [hexString substringWithRange:NSMakeRange(i, 2)];
        NSScanner * scanner = [[NSScanner alloc] initWithString:hexCharStr];
        [scanner scanHexInt:&anInt];
        myBuffer[i / 2] = (char)anInt;
    }
    NSString *unicodeString = [NSString stringWithCString:myBuffer encoding:4];
    return unicodeString;
}

NSString * ac_base64Encode(NSString *string) {
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSString *encodeStr = [data base64EncodedStringWithOptions:0];
    return encodeStr;
}

NSString * ac_base64Decode(NSString *base64String) {
    NSData *data = [[NSData alloc]initWithBase64EncodedString:base64String options:0];
    NSString *decodeStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    return decodeStr;
}

UIColor * colorWithHexString(NSString *hexString) {
    hexString = [[hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    UIColor *defaultColor = [UIColor clearColor];
    if (hexString.length < 6)
        return defaultColor;
    if ([hexString hasPrefix:@"#"])
        hexString = [hexString substringFromIndex:1];
    if ([hexString hasPrefix:@"0X"])
        hexString = [hexString substringFromIndex:2];
    if (hexString.length != 6)
        return defaultColor;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    unsigned int hexNumber;
    if (![scanner scanHexInt:&hexNumber]) {
        return defaultColor;
    }
    if (hexNumber > 0xFFFFFF) {
        return defaultColor;
    }
    CGFloat red = ((hexNumber >> 16) & 0xFF) / 255.0;
    CGFloat green = ((hexNumber >> 8) & 0xFF) / 255.0;
    CGFloat blue = (hexNumber & 0xFF) / 255.0;
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    return color;
}

NSString * ac_randomString(int length) {
    NSString *sourceStr = @"0123456789abcdefghijklmnopqrstuvwxyz";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    for (int i = 0; i < length; i++) {
        unsigned index = arc4random() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}

@end
