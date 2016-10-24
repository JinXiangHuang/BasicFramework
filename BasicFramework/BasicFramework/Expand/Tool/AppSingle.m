
//

#define kSaveStatic [NSUserDefaults standardUserDefaults]

#import "AppSingle.h"
#import "MJRefresh.h"
@implementation AppSingle
+(instancetype)Shared
{
    static AppSingle *_appSingle = nil;
    static dispatch_once_t onceToke;
    dispatch_once(&onceToke, ^{
        _appSingle = [[self alloc]init];
    });
    return _appSingle;
}
- (id)init
{
    if (self = [super init]) {
       
    }
    return self;
}
-(NSMutableAttributedString *)getOtherColorString:(NSString *)string Color:(UIColor *)Color font:(CGFloat)font inStr:(NSString *)instr
{
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]init];
    
    if (![NSString isBlankString:instr]) {
        
        NSMutableString *temp = [NSMutableString stringWithString:instr];
        
        NSRange range = [temp rangeOfString:string];
        
        str = [[NSMutableAttributedString alloc] initWithString:temp];
        [str addAttribute:NSForegroundColorAttributeName value:Color range:range];
        if (font) {
            
            [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:font] range:range];
        }
        
    }
    return str;
    
    
}
-(void)addBorderOnView:(UIView *)view cornerRad:(CGFloat)cornerRad lineCollor:(UIColor *)collor lineWidth:(CGFloat)lineWidth
{
    view.layer.borderWidth = lineWidth;
    view.cornerRad = cornerRad;
    view.layer.borderColor = collor.CGColor;
    
}

-(void)addFooderPullOnView:(UIScrollView *)View waitTime:(CGFloat)waitTime action:(void (^)())action
{
    [View addFooterWithCallback:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(waitTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            action();
            
            
        });
    }];
}
-(void)footerEndRefreshingOnView:(UIScrollView *)view
{
    [view footerEndRefreshing];
}
-(void)removeFooterOnView:(UIScrollView *)view
{
    [view removeFooter];
}

-(void)addHeaderPullOnView:(UIScrollView *)View waitTime:(CGFloat)waitTime action:(void (^)())action
{
    [View addHeaderWithCallback:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(waitTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            action();

        });
    }];
}
- (void)headerEndRefreshing:(UIScrollView *)scroll
{
    [scroll headerEndRefreshing];

}
- (void)headerBeginRefreshing:(UIScrollView *)scroll
{
    [scroll headerBeginRefreshing];

}
-(void)headerEndRefreshingOnView:(UIScrollView *)view
{
    [view headerEndRefreshing];
}
-(void)reachabilityAction
{
    
    UIApplication *application = [UIApplication sharedApplication];
    
    NSArray *chlidrenArray = [[[application valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    
    NSInteger netType =0;
    
    for (id  child in chlidrenArray) {
        
        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            
            netType = [[child valueForKeyPath:@"dataNetworkType"] integerValue];
            
        }
    }
    
    switch (netType) {
        case 0:
            
            [[AppSingle Shared]saveInMyLocalStoreForValue:@"0" atKey:kReachability];
            
            break;
        case 1:
            
            [[AppSingle Shared]saveInMyLocalStoreForValue:@"2G" atKey:kReachability];
            
            break;
        case 2:
            
            [[AppSingle Shared]saveInMyLocalStoreForValue:@"3G" atKey:kReachability];
            
            break;
        case 3:
            
            [[AppSingle Shared]saveInMyLocalStoreForValue:@"4G" atKey:kReachability];
            
            break;
        case 5:
            
            [[AppSingle Shared]saveInMyLocalStoreForValue:@"WIFE" atKey:kReachability];
            
            break;
            
        default:
            break;
    }
    
}
-(void)saveInMyLocalStoreForValue:(id)value atKey:(NSString *)key
{
    [kSaveStatic setValue:value forKey:key];
    [kSaveStatic synchronize];
}
-(id)getValueInMyLocalStoreForKey:(NSString *)key
{
    return [kSaveStatic objectForKey:key];
}
-(void)DeleteValueInMyLocalStoreForKey:(NSString *)key
{
    [kSaveStatic removeObjectForKey:key];
    [kSaveStatic synchronize];
}

#pragma mark 关于测试连接网络状态相关方法
-(void)setReachability
{
    
    Reachability * reach = [Reachability reachabilityWithHostname:@"www.baidu.com"];
    reach.reachableBlock = ^(Reachability*reach) {
        NSLog(@"网络可用!");
    };
    reach.unreachableBlock = ^(Reachability*reach) {
        NSLog(@"网络不可用!");
    };
    [reach startNotifier];// 开始监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityAction) name:kReachabilityChangedNotification object:nil];
     NSLog(@"%@",kNetworkType);
}

/*iOS 常用基础框架
 框架名称
 
 功能
 
 Foundation
 
 提供OC的基础类（像NSObject）、基本数据类型等
 
 UIKit
 
 创建和管理应用程序的用户界面
 
 QuartzCore
 
 提供动画特效以及通过硬件进行渲染的能力
 
 CoreGraphics
 
 提供2D绘制的基于C的API
 
 SystemConfiguration
 
 检测当前网络是否可用和硬件设备状态
 
 AVFoundation
 
 提供音频录制和回放的底层API，同时也负责管理音频硬件
 
 CFNetwork
 
 访问和配置网络，像HTTP、FTP和Bonjour Services
 
 CoreFoundation
 
 提供抽象的常用数据类型，如Unicode strings、XML、URL等
 
 CoreLocation
 
 使用GPS和WIFI获取位置信息
 
 
 
 
 
 GameKit
 
 为游戏提供网络功能：点对点互联和游戏中的语音交流
 
 AddressBook
 
 提供访问用户联系人信息的功能
 
 AddressBookUI
 
 提供一个用户界面，用于显示存储在地址簿中的联系人信息
 
 AudioToolBox
 
 提供音频录制和回放的底层API，同时也负责管理音频硬件
 
 AudioUnit
 
 提供一个接口，让我们的应用程序可以对音频进行处理
 
 MapKit
 
 为应用程序提供内嵌地图的接口
 
 MediaPlayer
 
 提供播放视频和音频的功能
 
 MessageUI
 
 提供视图控制接口用以处理E-mail和短信
 
 OpenGLES
 
 提供动画特效以及通过硬件进行渲染的能力
 
 StoreKit
 
 为应用程序提供在程序运行中消费的支持
 
  警告:object file was built for newer iOS version (8.3) than being linked (7.0)一般在一些第三方中, 可能会对iOS系统支持版本最低有要求, 最低支持版本高于你目前项目的版本. 
 解决方案
 1. 将 Deployment Target 改为 7.1
 2. 或者在Build Settings -> other lingkr Flags 中添加-w 就可以解决了  #pragma clang diagnostic ignored "-Wdeprecated-declarations"
 
 局部warning控制，最常见的就是 unused-variable 有时候
 #pragma clang diagnostic push
 #pragma clang diagnostic ignore "unused-variable"
 ......
 ......
 #pragma clang diagnostic pop
 
 
  
 
 
 */


@end
