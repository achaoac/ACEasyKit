//
//  ACUtils+Time.m
//  ACEasyKit
//
//  Created by achaoacwang on 2022/10/25.
//

#import "ACUtils+Time.h"

@implementation ACUtils (Time)

int32_t currentTimeInterval(void) {
    return [[NSDate date] timeIntervalSince1970];
}

@end
