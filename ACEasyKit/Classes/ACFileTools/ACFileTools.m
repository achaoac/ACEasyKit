//
//  ACFileTools.m
//  ACEasyKit
//
//  Created by achaoacwang on 2022/2/18.
//  Copyright © 2022 achaoacwang All rights reserved.
//

#import "ACFileTools.h"
#import <CommonCrypto/CommonDigest.h>

static NSString * const kLocalCacheDir = @"LocalCacheDir";

@interface NSString (ACFileToolsAdditions)

@end

@implementation NSString (ACFileToolsAdditions)

- (NSString *)ac_file_tools_md5 {
    const char* str =[self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    CC_MD5(str, (CC_LONG)strlen(str), result);
#pragma clang diagnostic pop
    NSMutableString* ret = [NSMutableString stringWithCapacity: CC_MD5_DIGEST_LENGTH];
    for(int i=0; i< CC_MD5_DIGEST_LENGTH; i++){
        [ret appendFormat:@"%02x", result[i]];
    }
    return ret;
}

@end

@implementation ACFileTools

+ (void)addSkipBackupAttributeToItemAtPath:(NSString *)filePathString {
    NSURL *URL = [NSURL fileURLWithPath:filePathString];
    if ([[NSFileManager defaultManager] fileExistsAtPath:[URL path]]) {
        NSError *error = nil;
        BOOL success =
        [URL setResourceValue:[NSNumber numberWithBool:YES] forKey:NSURLIsExcludedFromBackupKey error:&error];
        if (!success) {
            NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
        }
    }
}

+ (NSString *)getLocalCacheDir {
    NSString *str = nil;
    //获取document路径
    NSString *homePath =
    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    //拼接完整目录路径
    NSString *dirPath =
    [homePath stringByAppendingPathComponent:kLocalCacheDir];
    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL isDirectory = YES;
    BOOL exists = [fm fileExistsAtPath:dirPath isDirectory:&isDirectory];
    if (!exists) {
        BOOL ret = [fm createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
        if (ret) {
            [ACFileTools addSkipBackupAttributeToItemAtPath:dirPath];
            str = dirPath;
        }
    } else {
        str = dirPath;
    }
#if DEBUG
    NSLog(@"file path：%@",str);
#endif
    return str;
}

+ (NSString *)getLocalFileDir:(NSString *)dirName {
    NSString *str = nil;
    //获取document路径
    NSString *homePath = [ACFileTools getLocalCacheDir];
    //拼接完整目录路径
    NSString *dirPath =
    [homePath stringByAppendingPathComponent:dirName];
    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL isDirectory = YES;
    BOOL exists = [fm fileExistsAtPath:dirPath isDirectory:&isDirectory];
    if (!exists) {
        BOOL ret = [fm createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
        if (ret) {
            str = dirPath;
        }
    } else {
        str = dirPath;
    }
    return str;
}

+ (NSString *)getLocalCacheFileWith:(NSString *)fileName {
    NSString *str = nil;
    //获取文件夹
    NSString *dirPath = [ACFileTools getLocalCacheDir];
    //拼接完整文件路径
    NSString *filePath = [dirPath stringByAppendingPathComponent:fileName];
    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL isDirectory = NO;
    BOOL exists = [fm fileExistsAtPath:filePath isDirectory:&isDirectory];
    if (!exists) {
        //创建文件
        BOOL ret = [fm createFileAtPath:filePath contents:nil attributes:nil];
        if (ret) {
            str = filePath;
        }
    } else {
        str = filePath;
    }
    return str;
}

+ (BOOL)fileExistsWith:(NSString *)name isDir:(BOOL)isDir {
    //获取document路径
    NSString *homePath = [ACFileTools getLocalCacheDir];
    //拼接完整目录路径
    NSString *dirPath = [homePath stringByAppendingPathComponent:name];
    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL isDirectory = isDir;
    BOOL exists = [fm fileExistsAtPath:dirPath isDirectory:&isDirectory];
    return exists;
}

+ (NSString *)getFilePathWith:(NSString *)moduleId cateId:(NSString *)cateId{
    NSString *fileName = [NSString stringWithFormat:@"%@_%@",moduleId, cateId];
    fileName = [fileName ac_file_tools_md5];
    NSString *path = [ACFileTools getLocalCacheFileWith:fileName];
    return path;
}

+ (void)saveDataWith:(NSString *)jsonStr moduleId:(NSString *)moduleId cateId:(NSString *)cateId{
    NSString *path = [ACFileTools getFilePathWith:moduleId cateId:cateId];
    [jsonStr writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

+ (NSString *)getDataWithModuleId:(NSString *)moduleId cateId:(NSString *)cateId{
    NSString *path = [ACFileTools getFilePathWith:moduleId cateId:cateId];
    NSString *jsonStr = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    return jsonStr;
}

+ (NSString *)writeDataToTmpDirectoryWith:(NSData *)data andFileName:(NSString *)fileName {
    NSString *path = nil;
    NSString *filePath = [NSTemporaryDirectory() stringByAppendingPathComponent:fileName];
    path = [data writeToFile:filePath atomically:YES]?filePath:path;
    return path;
}

@end
