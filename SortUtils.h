//
//  SortUtils.h
//  eigacom2
//
//  Created by 李定祐 on 2014/03/20.
//  Copyright (c) 2014年 jlee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SortUtils : NSObject

+ (NSArray *)sortWithKey:(NSString *)key target:(NSArray *)array ascending:(BOOL)ascending;
@end
