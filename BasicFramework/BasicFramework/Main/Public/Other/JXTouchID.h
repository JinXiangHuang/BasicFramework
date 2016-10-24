//
//  JXTouchID.h
//  BasicFramework
//
//  Created by mr-tech on 16/10/18.
//  Copyright © 2016年 Rainy. All rights reserved.
//
#import <LocalAuthentication/LocalAuthentication.h>
#if TARGET_IPHONE_SIMULATOR
#define JXNotice(Chinese,English) [[[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"] objectAtIndex:0] isEqualToString:@"zh-Hans-US"] ? Chinese : English
#elif TARGET_OS_IPHONE
#define JXNotice(Chinese,English) [[[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"] objectAtIndex:0] isEqualToString:@"zh-Hans-CN"] ? Chinese : English
#endif

@class JXTouchID;

@protocol JXTouchIDDelegate <NSObject>

@required

- (void)JXTouchIDAuthorize:(NSString *)code;

@end

@interface JXTouchID : LAContext
@property (nonatomic, weak) id<JXTouchIDDelegate> delegate;

/**
 *  发起TouchID验证 (Initiate TouchID validation)
 *
 *  @param message 提示框需要显示的信息 默认为：输入密码 (Fallback button title. Default is "Enter Password")
 */
+ (void)startJXTouchIDWithMessage:(NSString *)message fallbackTitle:(NSString *)fallbackTitle delegate:(id<JXTouchIDDelegate>)delegate;
@end
