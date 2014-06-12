//
//  UIViewHelper.h
//  eigacom2
//
//  Created by 李定祐 on 2014/03/17.
//  Copyright (c) 2014年 jlee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIViewHelper : NSObject

+ (instancetype)sharedInstance;

+ (NSString*)textToEscapeHtml:(NSString*)htmlString;
#pragma mark - Toast
- (void)showNetworkErr;
- (void)removeNetworkErr;

@end
