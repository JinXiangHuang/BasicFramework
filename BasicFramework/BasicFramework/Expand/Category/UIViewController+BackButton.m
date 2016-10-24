//
//  UIViewController+BackButton.m
//  smartHome
//
//  Created by mr-tech on 16/5/6.
//  Copyright © 2016年 mrtech. All rights reserved.
//  category重写方法！！！危险的事！！！ 不管那个类有没有调用都重写了（这个方法全局都重写了）
//  不同类别中不要存在同名方法！
#import "UIViewController+BackButton.h"

@implementation UIViewController (BackButton)

@end
@implementation UINavigationController (ShouldPopOnBackButton)

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {
    
    if([self.viewControllers count] < [navigationBar.items count]) {
        return YES;
       
    }
    
    BOOL shouldPop = YES;
    UIViewController* vc = [self topViewController];
    if([vc respondsToSelector:@selector(navigationShouldPopOnBackButton)]) {
        shouldPop = [vc navigationShouldPopOnBackButton];
    }
    
    if(shouldPop) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self popViewControllerAnimated:YES];
        });
    } else {
        // Workaround for iOS7.1. Thanks to @boliva - http://stackoverflow.com/posts/comments/34452906
        for(UIView *subview in [navigationBar subviews]) {
            if(0. < subview.alpha && subview.alpha < 1.) {
                [UIView animateWithDuration:.25 animations:^{
                    subview.alpha = 1.;
                }];
            }
        }
    }
    
    return NO;
}

/**
 
 删除  sudo find / -name ".DS_Store" -depth -exec rm {} \;
 禁止.DS_store生成.DS_Store文件defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool TRUE
 defaults write com.apple.desktopservices DSDontWriteNetworkStores true
 恢复.DS_store生成
 defaults delete com.apple.desktopservices DSDontWriteNetworkStores
 
 
 mac系统如何显示和隐藏文件 苹果Mac OS X操作系统下，隐藏文件是否显示有很多种设置方法，最简单的要算在Mac终端输入命令。显示/隐藏Mac隐藏文件命令如下(注意其中的空格并且区分大小写)： 显示Mac隐藏文件的命令：defaults write com.apple.finder AppleShowAllFiles -bool true 隐藏Mac隐藏文件的命令：defaults write com.apple.finder AppleShowAllFiles -bool false 或者 显示Mac隐藏文件的命令：defaults write com.apple.finder AppleShowAllFiles YES 隐藏Mac隐藏文件的命令：defaults write com.apple.finder AppleShowAllFiles NO 输完单击Enter键，退出终端，重新启动Finder就可以了 重启Finder：鼠标单击窗口左上角的苹果标志-->强制退出-->Finder-->重新启动 别的地方转来的*/
@end