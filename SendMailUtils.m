//
//  SendMailUtils.m
//  eigacom2
//
//  Created by 李定祐 on 2014/04/17.
//  Copyright (c) 2014年 jlee. All rights reserved.
//

#import "SendMailUtils.h"
#import "ShareDataStore.h"
#import "DeviceUtils.h"
#import "RandomUtils.h"

#import "SendContactIdApiHandler.h"

@interface SendMailUtils ()
@property (nonatomic,weak) id opener;
@end

@implementation SendMailUtils

#pragma mark - Singleton
+ (instancetype)sharedInstance:(id)opener
{
    static SendMailUtils* instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[SendMailUtils alloc] initSharedInstance];
    });
    instance.opener = opener;
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

#pragma mark - Action methods
- (void)sendShareMail
{
    //送信可能かをチェック
    if (![MFMailComposeViewController canSendMail]) {
        ALERT(@"", @"メール設定を確認してください。", LSTR(@"Ok"));
        return;
    }
	NSString *messageBody = STRING_F(@"%@ %@", [[ShareDataStore sharedInstance] shareText], [[ShareDataStore sharedInstance] shareLink]);
	MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];
	controller.mailComposeDelegate = self;
    [controller setMessageBody:[self getMessageWithSignature:messageBody] isHTML:NO];
	[self.opener presentModalViewController:controller animated:YES];
}


#pragma mark - MFMailComposeViewControllerDelegate
- (void)mailComposeController:(MFMailComposeViewController*)controller
		  didFinishWithResult:(MFMailComposeResult)result
						error:(NSError*)error
{
    switch (result) {
        case MFMailComposeResultCancelled:
            break;
        case MFMailComposeResultSaved:
            break;
	    case MFMailComposeResultSent:
            ALERT(@"", @"メールを送信しました。", LSTR(@"Ok"));
            break;
        case MFMailComposeResultFailed:
            ALERT(@"", @"メールの送信に失敗しました。", LSTR(@"Ok"));
            break;
    };
    [[self.opener parentViewController] dismissViewControllerAnimated:YES completion:^(void){}];
}


#pragma mark - Private methods
- (NSString*)getMessageWithSignature:(NSString* message)
{
    NSString *appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];
    NSString *appVersion = APP_VERSION_NAME;
    UIDevice *device = [UIDevice currentDevice];
    NSString *deviceName = [device model];
    NSString *OSName = [device systemName];
    NSString *OSVersion = [device systemVersion];
    NSString *locale = [[NSLocale currentLocale] localeIdentifier];
    
	NSString *messageBody
    = [NSString stringWithFormat:@"%@\n\n ※回答受信のため@eiga.comからのメールを許可してください。\n +------------------+\n %@ %@ \n %@ %@\n %@ %@\n %@\n ContactID：%@\n +------------------+",
       message,
       appName,
       appVersion,
       OSName,
       OSVersion,
       deviceName,
       locale,
       [DeviceUtils platform],
       [self getAndsendContactId]];
    return messageBody;
}

@end
