//
//  aViewController.m
//  BasicFramework
//
//  Created by mr-tech on 16/9/12.
//  Copyright © 2016年 Rainy. All rights reserved.
//  国际化 两种 1，根据手机的语言变化app语言（NSLocalizedString）
/*  获取系统偏好语言数组
    [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"]
    [NSLocale preferredLanguages];\\/数组第一位的是用户当前使用的语言。\\[defaults setObject:currentLanguage forKey:@"user_lang_string"];//设置用户当前语言为当前系统语言。
    1.判断当前语言，使用string JXNotice(Chinese,English) [[[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"] objectAtIndex:0] isEqualToString:@"zh-Hans-CN"] ? Chinese : English
 
    2.NSLocalizedString(key, comment‘备注’) 使用系统路径  @"Localizable.strings"
      NSLocalizedString(key,comment)，用这个函数时，key不能一些动态字符串，否则用上面的命令会报错。
    3.app名字 随系统  新建InfoPlist.strings 文件
 
 获取地区代码
 NSLocale *locale = [NSLocale currentLocale];
 [locale localeIdentifier];
 
 btn.titleLabel.adjustsFontSizeToFitWidth = YES;
*/
//   2, 在app上选择语言

#import "aViewController.h"
#import "JXTouchID.h"
#import "HHLabel.h"
#import "bViewControllerLanguage.h"
@interface aViewController ()<JXTouchIDDelegate>

@end

@implementation aViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     self.title = @"nvc1_v1";
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"destroy_nvc1" style:UIBarButtonItemStylePlain target:self action:@selector(disMissNvc)];
    
    NSLog(@"设备加载过的语言，第一个为当前语言%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"] );
    
    [self addButton1];
    [self addButton2];
    [self addButton3];

}
-(void)addButton1{
    UIButton * button = [[UIButton alloc]initWithFrame: CGRectMake(20, 20, 100, 50)];
    [button setTitleColor:kMainFontColor forState:UIControlStateNormal];
    [button setTitle:@"goSetting" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(goSetting) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
-(void)addButton2{
    UIButton * button = [[UIButton alloc]initWithFrame: CGRectMake(20, 100, 250, 50)];
    [button setTitleColor:kMainFontColor forState:UIControlStateNormal];
    [button setTitle:@"指纹（国际化1）" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(指纹) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
-(void)addButton3{
    UIButton * button = [[UIButton alloc]initWithFrame: CGRectMake(20, 200, 250, 50)];
    [button setTitleColor:kMainFontColor forState:UIControlStateNormal];
    [button setTitle:@"国际化2" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(LanguageManager) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
-(void)指纹{
    [JXTouchID startJXTouchIDWithMessage:JXNotice(@"点我" ,@"touch Me") fallbackTitle:nil delegate:self];
}
-(void)LanguageManager{
     UIStoryboard * storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
     bViewControllerLanguage * bv = [storyBoard instantiateInitialViewController];
//     bViewControllerLanguage * bv = [storyBoard instantiateViewControllerWithIdentifier:@"HomeNvc"];
    [self.navigationController pushViewController:bv animated:YES];
}
-(void)JXTouchIDAuthorize:(NSString *)code{
    HHLabel * la  = [[HHLabel alloc]init];
    [la addLabel:self.view :code];
}
-(void)goSetting{
    
    NSURL *url = [NSURL URLWithString:@"prefs:root=LOCATION_SERVICES"];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {//真机可以
        [[UIApplication sharedApplication] openURL:url];
    }
}
/*//调出iphone中“设置”定位服务选项，由用户手动设置，调用系统“设置”中定位服务相关代码如下：
 About ? prefs:root=General&path=About
 Accessibility ? prefs:root=General&path=ACCESSIBILITY
 Airplane Mode On ? prefs:root=AIRPLANE_MODE
 Auto-Lock ? prefs:root=General&path=AUTOLOCK
 Brightness ? prefs:root=Brightness
 Bluetooth ? prefs:root=General&path=Bluetooth
 Date & Time ? prefs:root=General&path=DATE_AND_TIME
 FaceTime ? prefs:root=FACETIME
 General ? prefs:root=General
 Keyboard ? prefs:root=General&path=Keyboard
 iCloud ? prefs:root=CASTLE
 iCloud Storage & Backup ? prefs:root=CASTLE&path=STORAGE_AND_BACKUP
 International ? prefs:root=General&path=INTERNATIONAL
 Location Services ? prefs:root=LOCATION_SERVICES
 Music ? prefs:root=MUSIC
 Music Equalizer ? prefs:root=MUSIC&path=EQ
 Music Volume Limit ? prefs:root=MUSIC&path=VolumeLimit
 Network ? prefs:root=General&path=Network
 Nike + iPod ? prefs:root=NIKE_PLUS_IPOD
 Notes ? prefs:root=NOTES
 Notification ? prefs:root=NOTIFICATIONS_ID
 Phone ? prefs:root=Phone
 Photos ? prefs:root=Photos
 Profile ? prefs:root=General&path=ManagedConfigurationList
 Reset ? prefs:root=General&path=Reset
 Safari ? prefs:root=Safari
 Siri ? prefs:root=General&path=Assistant
 Sounds ? prefs:root=Sounds
 Software Update ? prefs:root=General&path=SOFTWARE_UPDATE_LINK
 Store ? prefs:root=STORE
 Twitter ? prefs:root=TWITTER
 Usage ? prefs:root=General&path=USAGE
 VPN ? prefs:root=General&path=Network/VPN
 Wallpaper ? prefs:root=Wallpaper
 Wi-Fi ? prefs:root=WIFI*/
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)disMissNvc{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
