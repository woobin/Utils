//
//  DateUtils.h
//  eigacom2
//
//  Created by 李定祐 on 2014/04/09.
//  Copyright (c) 2014年 jlee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateUtils : NSObject

+ (NSDate *)convertStringToDate:(NSString *)date format:(NSString *)inputFormat;
+ (NSString *)convertDateToString:(NSDate *)date format:(NSString *)outFormat;


+ (NSString *)convertDateWithFormat:(NSString *)input format:(NSString *)output date:(NSString *)target;
+ (NSString *)convertIso8601WithFormat:(NSString *)output date:(NSString *)target;

@end
