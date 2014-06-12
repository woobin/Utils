//
//  SortUtils.m
//  eigacom2
//
//  Created by 李定祐 on 2014/03/20.
//  Copyright (c) 2014年 jlee. All rights reserved.
//

#import "SortUtils.h"

@implementation SortUtils

+ (NSArray *)sortWithKey:(NSString *)key
                   target:(NSArray *)array
               ascending:(BOOL)ascending{
    @try {
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:key ascending:ascending];
        return [array sortedArrayUsingDescriptors:@[sortDescriptor]];
    }
    @catch (NSException *exception) {
        if (exception && DEV_FLAG) DebugLog(@"%@", [exception description]);
        return  array;
    }
}

@end
