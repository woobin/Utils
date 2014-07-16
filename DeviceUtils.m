//
//  DeviceUtils.m
//  eigacom2
//
//  Created by 李定祐 on 2014/05/23.
//  Copyright (c) 2014年 jlee. All rights reserved.
//

#import "DeviceUtils.h"
#include <sys/types.h>
#include <sys/sysctl.h>

@implementation DeviceUtils

static NSString *platform;

static bool highPlatform;

#pragma mark - Device platform
+ (NSString *)platform
{
    if ( !platform  || platform.length == 0 ) {
        size_t size;
        sysctlbyname("hw.machine", NULL, &size, NULL, 0);
        char *machine = malloc(size);
        sysctlbyname("hw.machine", machine, &size, NULL, 0);
        /*
         　　Possible values:
         　　"i386" = iPhone Simulator // add
         　　"iPhone1,1" = iPhone 1G
         　　"iPhone1,2" = iPhone 3G
         　　"iPhone2,1" = iPhone 3GS
         　　"iPhone3,1" = iPhone 4 // add
         　　"iPod1,1" = iPod touch 1G
         　　"iPod2,1" = iPod touch 2G
         　　"iPod3,1" = iPod touch 3G // add
         　　"iPod4,1" = iPod touch 4G // add
         　　*/
        //NSString *platform = [NSString stringWithCString: machine ];
        platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
        free(machine);
    }
    return platform;
}

+ (BOOL)ishighPlatform
{
    if ( !( [@"iPhone1,1" isEqualToString:[self platform]]
        || [@"iPhone1,2" isEqualToString:[self platform]]
        || [@"iPhone2,1" isEqualToString:[self platform]]
        || [@"iPhone3,1" isEqualToString:[self platform]]
        || [@"iPod1,1" isEqualToString:[self platform]]
        || [@"iPod1,1" isEqualToString:[self platform]]
        || [@"iPod3,1" isEqualToString:[self platform]]
        ) ){
        highPlatform = YES;
    }
    return highPlatform;

}

@end
