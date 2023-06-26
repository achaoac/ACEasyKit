//
//  ACUtils+Device.h
//  ACEasyKit
//
//  Created by achaoacwang on 2022/10/25.
//

#import "ACUtils.h"

NS_ASSUME_NONNULL_BEGIN

@interface ACUtils (Device)

// 是否iPad系列设备
BOOL IsIpadSeries(void);

// 是否iPhoneX系列设备 包括iphonex/xr/xs/xsmax等带刘海机型
BOOL IsIphoneXSeries(void);

// 获取设备的 UUID
NSString * ac_deviceUUID(void);

// 设备架构
NSString * ac_devicePlatform(void);

@end

NS_ASSUME_NONNULL_END
