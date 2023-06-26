//
//  ACFileTools.h
//  ACEasyKit
//
//  Created by achaoacwang on 2022/2/18.
//  Copyright © 2022 achaoacwang All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ACFileTools : NSObject

/// 获得缓存文件夹
+ (NSString *)getLocalCacheDir;

/// 获得缓存文件夹：如果不存在自动创建
/// - Parameter dirName: 文件夹名称
+ (NSString *)getLocalFileDir:(NSString *)dirName;

/// 获取文件路径：如果不存在则创建
/// - Parameter fileName: 文件名
+ (NSString *)getLocalCacheFileWith:(NSString *)fileName;

/// 是否存在文件
/// @param name 文件名
/// @param isDir 是否是文件夹
+ (BOOL)fileExistsWith:(NSString *)name isDir:(BOOL)isDir;

/// 写入数据
/// @param jsonStr 要写入的数据
/// @param moduleId 模块名称
/// @param cateId 分类名称
+ (void)saveDataWith:(NSString *)jsonStr moduleId:(NSString *)moduleId cateId:(NSString *)cateId;

/// 获取数据
/// @param moduleId 模块名称
/// @param cateId 分类名称
+ (NSString *)getDataWithModuleId:(NSString *)moduleId cateId:(NSString *)cateId;

/// 把数据写入临时文件夹
/// @param data 数据
/// @param fileName 文件名
+ (NSString *)writeDataToTmpDirectoryWith:(NSData *)data andFileName:(NSString *)fileName;

@end

NS_ASSUME_NONNULL_END
