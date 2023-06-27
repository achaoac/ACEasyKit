//
//  ACUtils+Device.m
//  ACEasyKit
//
//  Created by achaoacwang on 2022/10/25.
//

#import "ACUtils+Device.h"
#import <sys/sysctl.h>

@implementation ACUtils (Device)

BOOL ac_isIpadSeries(void) {
    BOOL rtv = NO;
    NSString *deviceType = [UIDevice currentDevice].model;
    if ([deviceType isEqualToString:@"iPad"]) {
        rtv = YES;
    }
    return rtv;
}

BOOL ac_isIphoneXSeries(void) {
    BOOL rtv = NO;
//    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
//        return rtv;
//    }
    if (@available(iOS 11.0, *)) {
        UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
        if (window.safeAreaInsets.bottom > 0.0) {
            rtv = YES;
        }
    }
    return rtv;
}

NSString * ac_deviceUUID(void) {
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

NSString * ac_devicePlatform(void) {
    static NSString *platform = nil;
    if (platform == nil) {
        size_t size;
        sysctlbyname("hw.machine", NULL, &size, NULL, 0);
        char *machine = (char *)malloc(size);
        sysctlbyname("hw.machine", machine, &size, NULL, 0);
        if(machine == NULL){
            platform = @"i386";
        }else {
            platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
        }
        free(machine);
    }
    return platform;
}

@end
