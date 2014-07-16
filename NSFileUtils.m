//
//  NSFileUtils.m
//  eigacom2
//
//  Created by 李定祐 on 2014/03/31.
//  Copyright (c) 2014年 jlee. All rights reserved.
//

#import "NSFileUtils.h"

@implementation NSFileUtils

static NSString *gBundleIdentifier;

// NSUserDefaultsの保存ファイル- > NSFileProtectionComplete
// TODO dst 대신에 basePath 폴더 전체의 속성을 바꾸는 것은 어떤가?
+ (void)setProtectionCompleteToNSUserDefaults
{
    NSFileManager* fileManager = [NSFileManager defaultManager];
    NSError* error = nil;

    // destination
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *basePath = [NSString stringWithFormat:@"%@/Preferences",[paths lastObject]];
    NSString* dst = [basePath stringByAppendingPathComponent:STRING_F(@"%@.%@",[NSFileUtils bundleIdentifier],@"plist")];
    
    if(DEV_FLAG) DebugLog(@"dst before: %@", [fileManager attributesOfItemAtPath:dst error:&error]);
    // set attributes
    NSDictionary* attributes = [NSDictionary dictionaryWithObject:NSFileProtectionComplete
                                                           forKey:NSFileProtectionKey];
    if (![fileManager setAttributes:attributes
                       ofItemAtPath:dst
                              error:&error]) {
        if(DEV_FLAG) DebugLog(@"setProtectionCompleteToNSUserDefaults Err:%@", error);
    }
    if(DEV_FLAG) DebugLog(@"dst after: %@", [fileManager attributesOfItemAtPath:dst error:&error]);
}

+ (NSString *)bundleIdentifier
{
    if (!gBundleIdentifier) {
        NSBundle* bundle = [NSBundle mainBundle];
        gBundleIdentifier = [bundle bundleIdentifier];
    }
    return gBundleIdentifier;
}

@end
