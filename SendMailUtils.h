//
//  SendMailUtils.h
//  eigacom2
//
//  Created by 李定祐 on 2014/04/17.
//  Copyright (c) 2014年 jlee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface SendMailUtils : NSObject <MFMailComposeViewControllerDelegate>

#pragma mark - Singleton
+ (instancetype)sharedInstance:(id)opener;

#pragma mark - Action methods
- (void)sendShareMail;

@end
