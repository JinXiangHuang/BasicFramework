//
//  UIViewController+BackButton.h
//  smartHome
//
//  Created by mr-tech on 16/5/6.
//  Copyright © 2016年 mrtech. All rights reserved.
//


#import <UIKit/UIKit.h>

@protocol BackButtonHandlerProtocol <NSObject>//在Cocoa里有两个NSObject，一个是类，一个是协议。NSObject的类和协议在Objective-c中存在于不同的命名空间。你可以同时拥有相同命名的类和协议，但是他们在编程语言上是不相关联的。

@optional
// Override this method in UIViewController derived class to handle 'Back' button click
-(BOOL)navigationShouldPopOnBackButton;
@end

@interface UIViewController (BackButton) <BackButtonHandlerProtocol>

@end

/**
 1.建立proxy对象的目是为了预留大多数未实现的方法，使用forwardInvocation:方法来转发。如果把NSObject作为子类则可能会引入更多包，那样容易导致冲突。而NSProxy通过提供了一个不含多余内容的简洁超类来避免此类发生。
 
 */