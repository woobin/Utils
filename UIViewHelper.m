//
//  UIViewHelper.m
//  eigacom2
//
//  Created by 李定祐 on 2014/03/17.
//  Copyright (c) 2014年 jlee. All rights reserved.
//

#import "UIViewHelper.h"
#import "AppDelegate.h"

@implementation UIViewHelper

static int const NetworkErrTag = 2015;

#pragma mark - Singleton
+ (instancetype)sharedInstance
{
    static UIViewHelper* instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[UIViewHelper alloc] initSharedInstance];
    });
    return instance;
}
- (id)initSharedInstance
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (id)init
{
    [self doesNotRecognizeSelector:_cmd];//initを使えなくする　_cmdは自身のセレクタ for Singleton
    return nil;
}


#pragma mark - HtmlString
+ (NSString*)textToEscapeHtml:(NSString*)htmlString
{
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"&"  withString:@"&amp;"];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"<"  withString:@"&lt;"];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@">"  withString:@"&gt;"];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"""" withString:@"&quot;"];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"'"  withString:@"&#039;"];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"\n" withString:@"<br>"];
    return htmlString;
}


#pragma mark - Toast
- (void)showNetworkErr
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UIView *view = delegate.window;
    UIView *oldToast = [view viewWithTag:NetworkErrTag];
    if (oldToast) return;
    
    UILabel * toast = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, -60.0f, SCREEN_RECT.size.width -20.0f, 60.0f)];
    [toast setText:@"ネットワーク環境を確認してください。"];
    [toast setBackgroundColor:[UIColor blackColor]];
    [toast setTag:NetworkErrTag];
    [toast setAlpha:0.2f];
    [toast setNumberOfLines:0];
    [toast setTextAlignment:NSTextAlignmentCenter];
    [toast setFont:[UIFont systemFontOfSize:14]];
    [toast setTextColor:[UIColor redColor]];
    [view addSubview:toast];
    
    CGRect frame = toast.frame;
    frame.origin.y = frame.origin.y + 180.0f;
    [UIView animateWithDuration:0.2f
                     animations:^{
                         [toast setFrame:frame];
                         [toast setAlpha:0.8f];
                     }
                     completion:nil];
}

- (void)removeNetworkErr
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UIView *view = delegate.window;
    UIView * toast = [view viewWithTag:NetworkErrTag];
    if (toast) {
        if(DEV_FLAG) DebugLog(@"Remove toast network err");
        CGRect frame = toast.frame;
        frame.origin.y = frame.origin.y - 180.0f;
        [UIView animateWithDuration:0.2f
                         animations:^{
                             [toast setFrame:frame];
                         }
                         completion:^(BOOL finished){
                             [toast removeFromSuperview];
                         }];
    }
}

@end
