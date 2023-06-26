//
//  ACUtils.h
//  ACEasyKit
//
//  Created by achaoacwang on 2022/10/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 基础工具函数类
@interface ACUtils : NSObject

/// 主线程操作
/// @param block 需要执行的代码块
void ac_main_async(dispatch_block_t block);

/// 获取app版本号
NSString * appVersion(void);

/// 获取app Build 号
NSString * appBuildNumber(void);

/// 获取app BundleID
NSString * appBundleIdentifier(void);

/// 将url携带的query参数转化为dictionary
/// @param url 需要转化的url
+ (NSDictionary *)urlToDictionary:(NSString *)url;

#pragma mark - 字符串编解码操作
/// 将字符串进行 URL 编码
/// @param string 需要编码的字符串
NSString * ac_urlEncode(NSString *string);

/// 将字符串进行 URL 解码
/// @param string 需要解码的字符串
NSString * ac_urlDecode(NSString *string);

/// 将字符串编码为16进制 HEX 字符串
/// @param string 需要 HEX 编码的字符串参数
NSString * ac_HEXEncode(NSString *string);

/// 将16进制 HEX 编码的字符串转换为普通字符串
/// @param hexString 需要解码的 HEX 编码字符串
NSString * ac_HEXDecode(NSString *hexString);

/// 将字符串编码为 base64 字符串
/// @param string 需要编码的字符串
NSString * ac_base64Encode(NSString *string);

/// 将 base64 字符串解码
/// @param string 需要解码的的字符串
NSString * ac_base64Decode(NSString *string);

/// 将16进制字符串转换为 UIColor
/// @param hexString 16进制字符串
UIColor * colorWithHexString(NSString *hexString);


/// 获得随机字符串
/// @param length 字符串长度
NSString * ac_randomString(int length);

@end

NS_ASSUME_NONNULL_END
