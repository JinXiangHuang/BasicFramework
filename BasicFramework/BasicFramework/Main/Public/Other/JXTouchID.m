//
//  JXTouchID.m
//  BasicFramework
//
//  Created by mr-tech on 16/10/18.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import "JXTouchID.h"

@interface JXTouchID ()

@end

@implementation JXTouchID

+ (void)startJXTouchIDWithMessage:(NSString *)message fallbackTitle:(NSString *)fallbackTitle delegate:(id<JXTouchIDDelegate>)delegate {
    
    LAContext *context = [[LAContext alloc]init];
    
    JXTouchID *touchid = [[JXTouchID alloc]init];
    
    context.localizedFallbackTitle = fallbackTitle;
    
//    context.localizedFallbackTitle = @"";//取消一个按钮 由LAContext的localizedFallbackTitle属性设置(LAContext目前只有这一个属性),如果不设置的话,默认是”Enter Password”.值得注意的是,如果该属性设置为@“”(空字符串),该按钮会被隐藏！    
    NSError *error = nil;
    
    touchid.delegate = delegate;
    
    NSAssert(touchid.delegate != nil, JXNotice(@"设备语言是中文，代理不能空", @"设备语言不是中文，代理不能空"));
    
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:message == nil ? JXNotice(@"默认提示信息", @"The Default Message") : message reply:^(BOOL success, NSError * _Nullable error) {
            if ([touchid.delegate respondsToSelector:@selector(JXTouchIDAuthorize:)]) {
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    if (success) {
                        [touchid.delegate JXTouchIDAuthorize:JXNotice(@"TouchID验证成功", @"Authorize Success")];
                        
                    } else if (error) {
                        
                        switch (error.code) {
                                
                            case LAErrorAuthenticationFailed: {
                                
                                [touchid.delegate JXTouchIDAuthorize:JXNotice(@"TouchID验证失败", error.localizedDescription)];
                            }
                                break;
                                
                            case LAErrorUserCancel: {
                                
                                
                                [touchid.delegate JXTouchIDAuthorize:JXNotice(@"取消TouchID验证 (用户点击了取消)", error.localizedDescription)];
                                
                            }
                                break;
                                
                            case LAErrorUserFallback: {
                                
                                [touchid.delegate JXTouchIDAuthorize:JXNotice(@"在TouchID对话框中点击输入密码按钮", error.localizedDescription)];

                            }
                                break;
                                
                            case LAErrorSystemCancel:{
                                
                                [touchid.delegate JXTouchIDAuthorize:JXNotice(@"在验证的TouchID的过程中被系统取消", error.localizedDescription)];

                            }
                                break;
                                
                            case LAErrorTouchIDNotEnrolled: {
                                
                                [touchid.delegate JXTouchIDAuthorize:JXNotice(@"设备没有录入TouchID,无法启用TouchID", error.localizedDescription)];

                            }
                                break;
                                
                            case LAErrorPasscodeNotSet: {
                                
                                [touchid.delegate JXTouchIDAuthorize:JXNotice(@"无法启用TouchID,设备没有设置密码", error.localizedDescription)];

                                
                            }
                                break;
                                
                            case LAErrorTouchIDNotAvailable: {
                                
                                [touchid.delegate JXTouchIDAuthorize:JXNotice(@"该设备的TouchID无效", error.localizedDescription)];
 
                            }
                                break;
                                
                            case LAErrorTouchIDLockout: {
                                
                                [touchid.delegate JXTouchIDAuthorize:JXNotice(@"多次连续使用Touch ID失败，Touch ID被锁，需要用户输入密码解锁", error.localizedDescription)];

                            }
                                break;
                                
                            case LAErrorAppCancel:  {
                                
                                [touchid.delegate JXTouchIDAuthorize:JXNotice(@"当前软件被挂起取消了授权", error.localizedDescription)];
 
                            }
                                break;
                                
                            case LAErrorInvalidContext: {
                                
                                [touchid.delegate JXTouchIDAuthorize:JXNotice(@"当前软件被挂起取消了授权", error.localizedDescription)];

                            }
                                break;
                        }
                    }
                }];
            }
         
        }];
        
    } else {
        
        if ([touchid.delegate respondsToSelector:@selector(JXTouchIDAuthorize:)]) {
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
              [touchid.delegate JXTouchIDAuthorize:JXNotice(@"当前设备不支持指纹识别", error.localizedDescription)];
                
            }];
        }
    }
}

@end
