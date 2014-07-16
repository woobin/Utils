//
//  DateUtils.m
//  eigacom2
//
//  Created by 李定祐 on 2014/04/09.
//  Copyright (c) 2014年 jlee. All rights reserved.
//

#import "DateUtils.h"

@implementation DateUtils

+ (NSDate *)convertStringToDate:(NSString *)date format:(NSString *)inputFormat
{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:inputFormat];
    return [inputFormatter dateFromString:date];
}

+ (NSString *)convertDateToString:(NSDate *)date format:(NSString *)outFormat
{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:outFormat];
    return [outputFormatter stringFromDate:date];
}

/**
 * input : ex1)yyyy-MM-dd'T'HH:mm:ss ex2)yyyy年MM月dd日（EEE）
 * output : ex)yyyy年MM月dd日
 */
+ (NSString *)convertDateWithFormat:(NSString *)input format:(NSString *)output date:(NSString *)target
{
    NSString *result;
    @try {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"]];
        [dateFormatter setDateFormat:input];
        
        NSDate *inputDate = [dateFormatter dateFromString:target];
        
        [dateFormatter setDateFormat:output];
        result = [dateFormatter stringFromDate:inputDate];
    }
    @catch (NSException *exception) {
        if(DEV_FLAG) {
            DebugLog(@"%@",[exception description]);
        }
        result = @"";
    }
    @finally {
        return result;
    }
}


/**
 * input : yyyy-MM-dd'T'HH:mm:ss+ZZ:ZZ
 */
+ (NSString *)convertIso8601WithFormat:(NSString *)output date:(NSString *)target
{
    NSString *result;
    @try {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"]];
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
        NSDate *inputDate = [dateFormatter dateFromString:
                                 [[target componentsSeparatedByString:@"+"] objectAtIndex:0]];
        
        [dateFormatter setDateFormat:output];
        result = [dateFormatter stringFromDate:inputDate];
    }
    @catch (NSException *exception) {
        if(DEV_FLAG) {
            DebugLog(@"%@",[exception description]);
        }
        result = @"";
    }
    @finally {
        return result;
    }
}
@end

