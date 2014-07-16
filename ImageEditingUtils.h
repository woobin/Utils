//
//  CoreImageUtils.h
//  eigacom2
//
//  Created by 李定祐 on 2014/03/25.
//  Copyright (c) 2014年 jlee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreImage/CoreImage.h>

@interface ImageEditingUtils : NSObject

+ (UIImage *)convertToBackgroundImage:(UIImage *)image;

+ (UIImage *)applyCIColorControls:(UIImage *)image;
+ (UIImage *)applyCIGaussianBlur:(UIImage*)image;
+ (UIImage *)applyCIBloom:(UIImage*)image;

@end
