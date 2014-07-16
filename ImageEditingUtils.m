//
//  CoreImageUtils.m
//  eigacom2
//
//  Created by 李定祐 on 2014/03/25.
//  Copyright (c) 2014年 jlee. All rights reserved.
//

#import "ImageEditingUtils.h"

@implementation ImageEditingUtils

+ (UIImage *)convertToBackgroundImage:(UIImage *)image
{
    return [ImageEditingUtils applyCIColorControls:[ImageEditingUtils applyCIGaussianBlur:image]];
}


+ (UIImage *)applyCIColorControls:(UIImage *)image
{
    /*
     CIColorControls
     inputImage(kCIInputImageKey)
     処理対象の CIImage オブジェクト。
     
     inputSaturation
     彩度の調整量を指定するスカラー値（NSNumber）。デフォルト値は 1.0 です。範囲は 0.0 ～ 3.0 です。
     
     inputBrightness
     輝度の調整量を指定するスカラー値（NSNumber）。デフォルト値は 0.0 です。範囲は -1.0 ～ 1.0 です。
     
     inputContrast
     コントラストの調整量を指定するスカラー値（NSNumber）。デフォルト値は 1.0 です。範囲は 0.25 ～ 4.0 です。
     */
    CIImage *ciImage = [[CIImage alloc] initWithImage:image];
    CIFilter *ciFilter = [CIFilter filterWithName:@"CIColorControls"
                                    keysAndValues:kCIInputImageKey, ciImage,
                          @"inputSaturation", [NSNumber numberWithFloat:0.2f],
                          @"inputBrightness", [NSNumber numberWithFloat:-0.6f],
                          @"inputContrast", [NSNumber numberWithFloat:0.7f],
                          nil ];
    CIContext *ciContext = [CIContext contextWithOptions:nil];
    CGImageRef cgimg = [ciContext createCGImage:[ciFilter outputImage] fromRect:[[ciFilter outputImage] extent]];
    UIImage* tmpImage = [UIImage imageWithCGImage:cgimg scale:1.0f orientation:UIImageOrientationUp];
    CGImageRelease(cgimg);
    
    return [ImageEditingUtils applyCIGaussianBlur:tmpImage];
}

//ぼかし
+ (UIImage *)applyCIGaussianBlur:(UIImage*)image
{
    /*
     inputImage
     処理対象の CIImage オブジェクト。
     
     inputImage
     処理対象の CIImage オブジェクト。
     
     inputRadius
     ガウス分布の標準偏差を指定する値（NSNumber）。デフォルト値は 10.0 です。範囲は 0.0 ～ 100.0 です。
     */
    CIContext *ciContext = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [CIImage imageWithCGImage:image.CGImage];
    
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    [filter setValue:[NSNumber numberWithFloat:1.0f] forKey:@"inputRadius"];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    
    CGImageRef cgImage = [ciContext createCGImage:result fromRect:[inputImage extent]];
    
    UIImage *returnImage = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);//release CGImageRef because ARC doesn't manage this on its own.
    
    return returnImage;
}
//ぼかし
+ (UIImage *)applyCIBloom:(UIImage*)image
{
    /*
     inputImage
     処理対象の CIImage オブジェクト。
     
     inputRadius
     フィルタ処理の対象となる領域の半径を指定する値（NSNumber）。デフォルト値は 10 です。範囲は 0 ～ 100 です。
     
     inputIntensity
     フィルタ出力とオリジナル画像の線形のブレンドを指定するスカラー値（NSNumber）。デフォルト値は 1 です。範囲は 0 ～ 1 です。
     */
    CIContext *ciContext = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [CIImage imageWithCGImage:image.CGImage];
    
    CIFilter *filter = [CIFilter filterWithName:@"CIBloom"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    [filter setValue:[NSNumber numberWithFloat:15.0f] forKey:@"inputRadius"];
    [filter setValue:[NSNumber numberWithFloat:1.0f] forKey:@"inputIntensity"];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    
    CGImageRef cgImage = [ciContext createCGImage:result fromRect:[inputImage extent]];
    
    UIImage *returnImage = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);//release CGImageRef because ARC doesn't manage this on its own.
    
    return returnImage;
}


+ (UIImage *)applyCIGlassDistortion:(UIImage*)image
{
    /*
     CIGlassDistortion
     inputImage
     処理対象の CIImage オブジェクト。
     
     inputTexture
     テクスチャを指定する CIImage オブジェクト。このテクスチャの用意の方法については、「置き換え歪み」を参照してください。
     
     inputCenter
     フィルタ処理する領域の中心を x および y 座標で指定する CIVector オブジェクト。
     
     inputScale
     テクスチャに対して使用するスケーリングを指定する値（NSNumber）。範囲は 0.001 ～ 500.0 です。デフォルト値は 200.0 です。値 2.0 はテクスチャをオリジナルのサイズで使用することを指定します。これよりも低い値は、テクスチャを拡大して使用することを指定します。
     */
    CIContext *ciContext = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [CIImage imageWithCGImage:image.CGImage];
    
    CIFilter *filter = [CIFilter filterWithName:@"CIGlassDistortion"];
    [filter setDefaults];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    
    CGImageRef cgImage = [ciContext createCGImage:result fromRect:[inputImage extent]];
    
    UIImage *returnImage = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);//release CGImageRef because ARC doesn't manage this on its own.
    
    return returnImage;
}


+ (UIImage *)applyCIGammaAdjust:(UIImage *)image
{
    /*
     CIGammaAdjust パラメータ
     inputImage(kCIInputImageKey)
     処理対象の CIImage オブジェクト。
     
     inputPower
     出力に対する入力のマッピングに使用するべき乗関数の指数（ガンマ値ともいう）を指定するスカラー値（NSNumber）。デフォルト値は 0.75 です。範囲は 0.1 ～ 3.0 です。
     */
    CIImage *ciImage = [[CIImage alloc] initWithImage:image];
    CIFilter *ciFilter = [CIFilter filterWithName:@"CIGammaAdjust"
                                    keysAndValues:kCIInputImageKey, ciImage,
                          @"inputPower", [NSNumber numberWithFloat:3.0f],
                          nil ];
    CIContext *ciContext = [CIContext contextWithOptions:nil];
    CGImageRef cgimg = [ciContext createCGImage:[ciFilter outputImage] fromRect:[[ciFilter outputImage] extent]];
    UIImage* tmpImage = [UIImage imageWithCGImage:cgimg scale:1.0f orientation:UIImageOrientationUp];
    CGImageRelease(cgimg);
    
    return tmpImage;
}

@end
