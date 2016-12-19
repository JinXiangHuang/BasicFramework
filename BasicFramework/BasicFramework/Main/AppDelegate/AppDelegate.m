//
//  AppDelegate.m
//  BasicFramework
//
//  Created by Rainy on 16/8/18.
//  Copyright © 2016年 Rainy. All rights reserved.


#import "AppDelegate.h"
#import "RootViewController.h"
#import <AudioToolbox/AudioServices.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
#pragma mark 后台获取数据 1.Capabilities 勾选 Background Modes 中的 Background fetch  2.设定时间间隔 3.运行程序后， Debug 菜单中的 Simulate Background Fetch||，修改 Scheme 或新建一个 Scheme ，在 Scheme 设置的 Options 标签下选中 Background Fetch
    /*注意
     后台获取并不是无限制的，系统在激活你的应用之后会给大概30秒的时间用于处理网络数据，所以应该尽量减少数据获取量并避免更新UI，更好的方式是在后台获取少量数据并存储然后在下次进入应用时再更新必要的UI变化
     后台调用具有不确定性，所以不要用于需要准确性的功能，比如定时提醒
     在不需要后台获取时将获取间隔设为 UIApplicationBackgroundFetchIntervalNever ，避免不必要的消耗
     不要一味的将获取间隔设为最小值，根据你的应用的需求来设置，比如只会每天变化的数据就应该设置成24*3600秒
   */
    //    [[UIApplication sharedApplication] setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalMinimum];
    
#pragma mark 网络监控打开 当前网络状态，取 kNetworkType 值。
    [[AppSingle Shared]setReachability];
    
    
    //1
    /**
     1.在工程配置中移除关联 删除 Main Interface中的Main
     2.移除Main.storyboard中的关联关系,删除Main.storyboard文件
     3.[self setMyWindowAndRootViewController];
     */
    
    
    //2
    //    [self setMyWindowAndRootViewController];//保留Main.storyboard文件
    
    //3
    /*
     UIStoryboard * storyBoard = [UIStoryboard storyboardWithName:@"Main2" bundle:nil];
     UIViewController * vc2 = [storyBoard instantiateInitialViewController];
     //    UIViewController * vc2 = [storyBoard instantiateViewControllerWithIdentifier:@"HomeNvc"];
     AppDelegate * application = [UIApplication sharedApplication].delegate;
     application.window.rootViewController = vc2;*/
    
     //4 Main.storyboard(root)
    
    self.window.backgroundColor = [UIColor whiteColor];
    

    
    //  __block?? __weak
    //   afnetworking??
    //   NSProgress
    //强制转换
    //uicollectionView controller
    
    

    
    
    
    
    
    
    
    
    
    return YES;
}
-(void)setMyWindowAndRootViewController
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[RootViewController alloc]init];
    [self.window makeKeyAndVisible];
}
//获取网络数据
- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
    __block UIBackgroundFetchResult result = UIBackgroundFetchResultFailed;
    [[AFHTTPSessionManager manager] GET:@"http://pic1.5442.com/2013/0830/05/03.jpg" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"%@,*progress*",downloadProgress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         NSLog(@"%@,*success*",task);
        if (responseObject)
            result = UIBackgroundFetchResultNewData;
        else
            result = UIBackgroundFetchResultNoData;
        
        completionHandler(result);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@,*error*",error);
        result = UIBackgroundFetchResultFailed;
        completionHandler(result);
    }];

    
       AudioServicesPlaySystemSound(1012);
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
/*
 
 MV(X）系列概要
 Models--负责主要的数据或者操作数据的数据访问层，可以想象 Perspn 和 PersonDataProvider 类。
 Views--负责展示层（GUI），对于iOS环境可以联想一下以 UI 开头的所有类。
 Controller/Presenter/ViewModel--负责协调 Model 和 View，通常根据用户在View上的动作在Model上作出对应的更改，同时将更改的信息返回到View上。
 
 http://images.cnitblog.com/blog/302680/201411/122131544912180.jpg
 
 */
@end
