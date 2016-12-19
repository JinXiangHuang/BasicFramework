//
//  RootViewController.m
//  Dome
//
//  Created by Rainy on 16/8/18.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import "RootViewController.h"
#import "aViewController.h"
#import "BasicMainNC.h"
#import "UIControlView.h"
#import "WebViewController.h"


#import "BasicFramework-swift.h"
//在OC需要用到的swift文件中 导入文件 "Product Module Name -Swift.h"  因为 Product Module Name 默认是工程的名字 所以直接导入 #import "工程名-Swift.h"

#import "BasicMainWebNC.h"


#import "TBFirstViewController.h"
#import "TBSecondViewController.h"
#import "TBThirdViewController.h"
#import "TBFourthViewController.h"
#import "TBFifthViewController.h"
//#import "AppDelegate.h"
@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setItems];
    [self addBtn:CGPointMake(20, 44) andName:@"swiftLearn" andS:@selector(swiftLearn)];
    [self addBtn:CGPointMake(20, 150) andName:@"goMore" andS:@selector(goMore)];
    [self addBtn:CGPointMake(220, 44) andName:@"goUILearn" andS:@selector(goUILearn)];
    [self addBtn:CGPointMake(220, 150) andName:@"MainWeb" andS:@selector(MainWeb)];
    [self addBtn:CGPointMake(20, 250) andName:@"TheBackgrounder" andS:@selector(TheBackgrounder)];

    
    
//    //GCD 并行队列，异步任务:开启多个线程，同时执行。
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_async(queue, ^{
//        for (int i =0; i<1000; i++) {
//            NSLog(@"AAAAA %d",i);
//        }
//    });
//    dispatch_async(queue, ^{
//        for (int i =0; i<1000; i++) {
//            NSLog(@"BBBBB %d",i);
//        }
//    });
//    dispatch_async(queue, ^{
//        for (int i =0; i<1000; i++) {
//            NSLog(@"CCCCC %d",i);
//        }
//    });
//    //串行队列，同步任务 :不开启线程，按顺序执行
//    dispatch_queue_t Cqueue = dispatch_queue_create("queueName", NULL);
//    dispatch_sync(Cqueue, ^{
//        for (int i =0; i<1000; i++) {
//            NSLog(@"DDDDD %d",i);
//        }
//    });
//    dispatch_sync(Cqueue, ^{
//        for (int i =0; i<1000; i++) {
//            NSLog(@"EEEEE %d",i);
//        }
//    });
//    dispatch_sync(Cqueue, ^{
//        for (int i =0; i<1000; i++) {
//            NSLog(@"FFFFF %d",i);
//        }
//    });
//

//    dispatch_queue_t Cqueue = dispatch_queue_create("queueName", NULL);
//    dispatch_async(Cqueue, ^{
//        for (int i =0; i<1000; i++) {
//            NSLog(@"DDDDD %d",i);
//        }
//    });
//    dispatch_async(Cqueue, ^{
//        for (int i =0; i<1000; i++) {
//            NSLog(@"EEEEE %d",i);
//        }
//    });
//    dispatch_async(Cqueue, ^{
//        for (int i =0; i<1000; i++) {
//            NSLog(@"FFFFF %d",i);
//        }
//    });
    
    
    
    //我们同时执行几个异步任务，他们执行完了，我们有时候还得知道一下，，怎么办呢，这时候，就得用到dispatch_group了，如下编代码这样弄，到最后执行 dispatch_group_notify ，便可
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, queue, ^{
        NSLog(@"开始执行1");
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"开始执行2");
    });
 
    dispatch_group_notify(group, queue, ^{
        NSLog(@"全部执行完成，必须在主线程更新UI!!!");
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"主线程更新UI完成。");
        });
    });
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"开始执行3");
        for (int i =0; i<1000; i++) {
            NSLog(@"执行DDDDD %d",i);
        }

    });
    
    dispatch_queue_t Cqueue = dispatch_queue_create("queueName", NULL);
    
   
    dispatch_group_async(group, Cqueue, ^{
        sleep(5);
        NSLog(@"开始执行3");
    });
}
-(void)TheBackgrounder{
    UIViewController *viewController1 = [[TBFirstViewController alloc] initWithNibName:@"TBFirstViewController" bundle:nil];
    UIViewController *viewController2 = [[TBSecondViewController alloc] initWithNibName:@"TBSecondViewController" bundle:nil];
    UIViewController *viewController3 = [[TBThirdViewController alloc] initWithNibName:@"TBThirdViewController" bundle:nil];
    UIViewController *viewController4 = [[TBFourthViewController alloc] initWithNibName:@"TBFourthViewController" bundle:nil];
    UIViewController *viewController5 = [[TBFifthViewController alloc] initWithNibName:@"TBFifthViewController" bundle:nil];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = @[viewController1, viewController2, viewController3, viewController4, viewController5];
    
    
    
    id appDelegate = [[UIApplication sharedApplication] delegate];
    if ([appDelegate respondsToSelector:@selector(window)]) {
        UIWindow * window = (UIWindow *) [appDelegate performSelector:@selector(window)];
         window.rootViewController = tabBarController;
    }
}
-(void)addBtn:(CGPoint)point andName:(NSString *)name andS:(SEL)sel{
    self.view.backgroundColor         = [UIColor brownColor];
     UIButton * button                = [UIButton buttonWithType:UIButtonTypeCustom];
     button.showsTouchWhenHighlighted = YES;
    [button setTitle:name forState:UIControlStateNormal];
    [button addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
    [button setFrame:CGRectMake(point.x, point.y, 100, 100)];
    [button sizeToFit];
    [self.view addSubview:button];

}
-(void)goMore{
    aViewController * a = [[aViewController alloc]init];
    BasicMainNC * b = [[BasicMainNC alloc]initWithRootViewController:a];
    [self presentViewController:b animated:YES completion:nil];
}

-(void)goUILearn{
    UIControlView * cv = [[UIControlView alloc]init];
    [self presentViewController:cv animated:YES completion:nil];
}
-(void)swiftLearn{
    //oc 调用swift3.0
    commixOCq * coc2 = [[commixOCq alloc]init];
    [coc2 logMe];
    
    commixOCViewController * coc = [[commixOCViewController alloc] init];
    BasicMainWebNC * web = [[BasicMainWebNC alloc]initWithRootViewController:coc];
    [self presentViewController:web animated:YES completion:nil];
}
-(void)MainWeb{

    WebViewController * coc = [[WebViewController alloc] init];
    BasicMainWebNC * web = [[BasicMainWebNC alloc]initWithRootViewController:coc];
    [self presentViewController:web animated:YES completion:nil];
}
-(void)OCLOG{
    NSLog(@"s dy");
}

#pragma mark -- setItems

-(void)setItems{
    [[UINavigationBar appearance]setBackgroundImage:[UIImage createImageWithColor:kThemeColor] forBarMetrics:UIBarMetricsDefault];
    NSDictionary *dic = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    [[UINavigationBar appearance] setTitleTextAttributes:dic];
    [[UINavigationBar appearance]setTintColor:[UIColor whiteColor]];
    [[UIBarButtonItem appearance]setTitleTextAttributes:dic forState:UIControlStateNormal];
    //    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    UIImage *backItemImage = [[UIImage createImageWithColor:kButtonBackColorForNormal] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 0, 0) resizingMode:UIImageResizingModeStretch];
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setBackButtonBackgroundImage:backItemImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
   
}

/**
 
 一、两种orientation
 了解屏幕旋转首先需要区分两种orientation
 
 1、device orientation
 设备的物理方向
 
 2、interface orientation
 界面显示的方向
 
 

 二、如何决定interface orientation
 1、全局控制:Info.plist文件中，有一个Supported interface orientations，可以配置整个应用的屏幕方向，此处为全局控制 == General
 2、UIWindow : - (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window  NS_AVAILABLE_IOS(6_0);该方法默认值为 Info.plist 中配置的 Supported interface orientations 项的值。
      iOS中通常只有一个 window，所以此处的控制也可以视为全局控制。
 3、controller
 只有以下两种情况：
 当前controller是window的rootViewController
 当前controller是modal模式的时，orientations相关方法才会起作用（才会被调用），当前controller及其所有的childViewController都在此作用范围内。
 
 4、最终支持的屏幕方向
 前面所述的3种控制规则的交集就是一个controller的最终支持的方向；
 
 如果最终的交集为空，在iOS6以后会抛出UIApplicationInvalidInterfaceOrientationException崩溃异常。
 
 
 三、orientations相关方法
 
 在iOS6之前我们可以直接用这个方法进行配置：- (BOOL)shouldAutorotateToInterfaceOrientation
 在iOS6之后，这个方法被NS_DEPRECATED_IOS，也就是废弃掉了。废弃了这个方法，苹果相应的也给出了新的方法来代替：
 // New Autorotation support.
 - (BOOL)shouldAutorotate NS_AVAILABLE_IOS(6_0) __TVOS_PROHIBITED;iOS6新增Api来控制旋转，需要注意的是顶层才是有效的
 - (UIInterfaceOrientationMask)supportedInterfaceOrientations NS_AVAILABLE_IOS(6_0) __TVOS_PROHIBITED;
 - (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation NS_AVAILABLE_IOS(6_0);
 第一个方法决定是否支持多方向旋转屏，如果返回NO则后面的两个方法都不会再被调用，而且只会支持默认的UIInterfaceOrientationMaskPortrait方向；
 
 第二个方法直接返回支持的旋转方向，该方法在iPad上的默认返回值是UIInterfaceOrientationMaskAll，iPhone上的默认返回值是UIInterfaceOrientationMaskAllButUpsideDown，详情见官方Q&A文档；
 
 第三个方法返回最优先显示的屏幕方向，比如同时支持Portrait和Landscape方向，但想优先显示Landscape方向，那软件启动的时候就会先显示Landscape，在手机切换旋转方向的时候仍然可以在Portrait和Landscape之间切换；
 
 'Supported orientations has no common orientation with the application, and [UIViewController shouldAutorotate] is returning YES'
 
 
 attemptRotationToDeviceOrientation方法
 + (void)attemptRotationToDeviceOrientation NS_AVAILABLE_IOS(5_0);
  该方法的使用场景是 interface orientation和device orientation 不一致，但希望通过重新指定 interface orientation 的值，立即实现二者一致；如果这时只是更改了支持的 interface orientation 的值，没有调用attemptRotationToDeviceOrientation，那么下次 device orientation 变化的时候才会实现二者一致，关键点在于能不能立即实现。
 
 
 四、强制屏幕旋转
 如果interface和device方向不一样，想强制将interface旋转成device的方向，可以通过attemptRotationToDeviceOrientation实现，但是如果想将interface强制旋转成任一指定方向，该方式就无能为力了。
 
 不过聪明的开发者们总能想到解决方式：
 
 1、私有方法
 [[UIDevice currentDevice] setOrientation:UIInterfaceOrientationPortrait];
 
 但是现在苹果已经将该方法私有化了，越狱开发的同学可以试试。
 
 2、旋转view的transform
 也可以通过旋转view的transform属性达到强制旋转屏幕方向的目的，但个人感觉这不是靠谱的思路，可能会带来某些诡异的问题。
 
 3、主动触发 orientation 机制
 要是能主动触发系统的 orientation 机制，调用 orientation 相关方法，使新设置的 orientation 值起作用就好了。这样只要提前设置好想要支持的 orientation，然后主动触发 orientation 机制，便能实现将 interface orientation旋转至任意方向的目的。
 */
 
 /*
 //重写view旋转
 - (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id )coordinator{
 [super viewWillTransitionToSize:size withTransitionCoordinator: coordinator];
 [coordinator animateAlongsideTransition: ^(id context)
 {
 //         1.旋转前的动作
 } completion: ^(id context) {
 //         2.旋转后的动作
 }];
 }
 */
//强制旋转 私有API iOS5 审核  kScreenHeight, kScreenWidth 自动调换   ->  默认的屏幕方向 - 横屏显示(viewDidAppear)后自动调换kScreenHeight, kScreenWidth
/*
 if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
 SEL selector = NSSelectorFromString(@"setOrientation:");
 NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
 [invocation setSelector:selector];
 [invocation setTarget:[UIDevice currentDevice]];
 int val = UIInterfaceOrientationLandscapeRight;
 [invocation setArgument:&val atIndex:2];
 [invocation invoke];
 }
 */








@end
