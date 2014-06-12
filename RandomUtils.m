//
//  RandomUtils.m
//  eigacom2
//
//  Created by 李定祐 on 2014/05/23.
//  Copyright (c) 2014年 jlee. All rights reserved.
//

#import "RandomUtils.h"

@implementation RandomUtils

static NSMutableString * RandomField;

+ (NSString *)getRandString
{
    if ( !RandomField  || RandomField.length == 0 ) {
        int lenght = 16;
        static NSString *letters = @"0123456789abcdefghijklmnopqrstuvwxyz";
        RandomField = [NSMutableString stringWithCapacity: lenght];
        for (int i=0; i<lenght; i++) {
            [RandomField appendFormat: @"%C", [letters characterAtIndex: arc4random() % [letters length]]];
        }
    }
    return RandomField;
}

@end
