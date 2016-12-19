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
 
*/
//   2, 在app上选择语言

#import "aViewController.h"
#import "JXTouchID.h"
#import "HHLabel.h"
#import "bViewControllerLanguage.h"

#import "testModel.h"
#include <mach/mach.h>
@interface aViewController ()<JXTouchIDDelegate>

@end

@implementation aViewController


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

-(void)goGit{
    
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/JinXiangHuang/BasicFramework.git"]];
    
    /*
     
     https://git-scm.com/book/zh/v2
     
     　其中check out 等同于git 命令行中的clone指令，用于把远程仓库下载到本地。
     
     　　commit 等同于git命令行中的commit指令（无差别），用于把更改提交到本地git版本库。
     
     　　push等同于git命令行中的push指令（无差别），用于把更改提交到远程的git仓库中。
     
     　　pull指令等同于git命令行中pull指令（无差别），用于获取得到最新的远程仓库信息。
     
     # 显示隐藏文件   $ defaults write com.apple.finder AppleShowAllFiles Yes && killall Finder
     
     # 不显示隐藏文件$ defaults write com.apple.finder AppleShowAllFiles No && killall Finder
     
     在创建时没有添加，你也可以在以后任何时候为它手动添加源:
     打开Terminal窗口
     下面切换到新项目的目录
     git init 
     git add . 
     git commit -m 'Initial commit'
     
     
     
     
     
     基本操作
     1.初始化仓库
     
     。git init
     
     2.配置用户信息
     
     。git config --global user.name "username"
     
     。git config --global user.email tom@qq.com
     
     3.查看配置信息
     
     。git config --list
     
     4.获取帮助
     
     。git help verb
     
     比如要学习config命令可以怎么用，运行
     
     。git help config
     
     5.添加文件到暂存区
     
     。git add filename
     
     。git add *(添加所以文件到暂存区)
     
     。git add --all (添加所以文件到暂存区)
     
     6.移除文件
     
     。git rm filename
     
     7.重命名一个文件
     
     。git mv oldfilename newfilename
     
     8.提交到暂存区
     
     。git commit -m "message" 只会提交暂存区（staged）里面的内容
     
     9.查看工作目录状态
     
     。git status
     
     10.查看提交历史记录
     
     。git log
     
     11.查看文件的改变
     
     。git diff
     
     撤销操作
     1.撤销加入到暂存区的操作
     
     。git reset HEAD file
     
     2.撤销修改的操作
     
     。git checkout -- file
     
     3.将本地的修改放进回收站
     
     。git stash
     
     4.从回收站中回复本地的修改
     
     。git stash apply
     
     tag 操作
     1.查看tag
     
     。git tag
     
     2.创建tag
     
     。git tag -a v1.0 -m "my version 1.0"
     
     3.显示tag信息
     
     。git show v1.0
     
     4.对之前的提交打tag
     
     。git tag -a v0.1 -m "version 0.1"
     
     分支操作
     1.查看分支
     
     。git branch
     
     2.创建分支
     
     git branch branchname
     
     3.删除分支
     
     git branch -d branchname
     
     4.切换分支
     
     。git checkout branchname
     
     5.创建并切换分支
     
     。git checkout -b branchname
     
     远端仓库操作
     1.克隆一个远端仓库
     
     。git clone url
     
     2.添加远端仓库
     
     。git remote add name url
     
     3.更新远端仓库的分支和数据
     
     。git fetch name
     
     4.获取并合并远端仓库的分支到当前分支
     
     。git pull reponame branchname
     
     5.上传本地分支和数据到远端仓库
     
     git push reponame branchname
     
     6.跟踪远端分支上的分支
     
     。git checkout --track origin/testbrancj
     
     。git checkout -b test origin/testbranch
     
     
     **/
}



-(void)指纹{
    [JXTouchID startJXTouchIDWithMessage:JXNotice(@"点我" ,@"touch Me") fallbackTitle:nil delegate:self];
}
-(void)LanguageManager{
     UIStoryboard * storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//     bViewControllerLanguage * bv = [storyBoard instantiateInitialViewController];
     bViewControllerLanguage * bv = [storyBoard instantiateViewControllerWithIdentifier:@"b"];
    [self.navigationController pushViewController:bv animated:YES];
}
-(void)JXTouchIDAuthorize:(NSString *)code{
    HHLabel * la  = [[HHLabel alloc]init];
    [la addLabel:self.view :code];
}
-(void)goSetting{
    
    NSURL *url = [NSURL URLWithString:@"mailto:apple@mac.com?Subject=hello"];//@"prefs:root=LOCATION_SERVICES"
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
#pragma mark getFreeDiskspace

//存储内存
- (float)getFreeDiskspace{
    float totalSpace;
    float totalFreeSpace=0.f;
    NSError *error = nil;
    NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error: &error];
    if (dictionary) {
        NSNumber *fileSystemSizeInBytes = [dictionary objectForKey: NSFileSystemSize];
        NSNumber *freeFileSystemSizeInBytes = [dictionary objectForKey:NSFileSystemFreeSize];
        totalSpace = [fileSystemSizeInBytes floatValue]/1024.0f/1024.0f/1024.0f;
        totalFreeSpace = [freeFileSystemSizeInBytes floatValue]/1024.0f/1024.0f/1024.0f;
        NSLog(@"Memory Capacity of %f GB with %f GB Free memory available.", totalSpace, totalFreeSpace);
    }else {
        NSLog(@"Error Obtaining System Memory Info: Domain = %@, Code = %ld", [error domain], [error code]);
    }
    NSLog(@"----%f,%f,%f",[self getAvailableBytes],[self getAvailableKiloBytes],[self getAvailableMegaBytes]);
    return totalFreeSpace;
}
//可用运行内存
- (double)getAvailableBytes
{
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount =HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vmStats, &infoCount);
    
    if (kernReturn != KERN_SUCCESS)
    {
        return NSNotFound;
    }
    
    return (vm_page_size * vmStats.free_count) + (vmStats.inactive_count * vm_page_size);
}

- (double)getAvailableKiloBytes
{
    return [self getAvailableBytes] / 1024.0;
}

- (double)getAvailableMegaBytes
{
    return [self getAvailableKiloBytes] / 1024.0;
}







#pragma mark - NSKeyedArchiverarchiveRootObject
-(void)NSKeyedArchiverarchiveRootObject{
    
    testModel * tm = [[testModel alloc]init];
    tm.Did = @"1";
    tm.User = @"1";
    tm.Psw = @"1";
    tm.ServIp = @"1";
    
    testModel * tm2 = [[testModel alloc]init];
    tm2.Did = @"2";
    tm2.User = @"2";
    tm2.Psw = @"2";
    tm2.ServIp = @"2";
    
    tm.muarr = [[NSMutableArray alloc]init];
    [tm.muarr addObject:tm2];
    [tm.muarr addObject:tm2];
    [tm.muarr addObject:tm2];
    
    // 2.归档模型对象
    // 2.1.获得Documents的全路径
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    // 2.2.获得文件的全路径
    NSString *path = [doc stringByAppendingPathComponent:@"tm.data"];
    // 2.3.将对象归档
    [NSKeyedArchiver archiveRootObject:tm toFile:path];
    
    [self read];
    
}

- (void)read {
    // 1.获得Documents的全路径
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    // 2.获得文件的全路径
    NSString *path = [doc stringByAppendingPathComponent:@"tm.data"];
    // 3.从文件中读取对象
    testModel * tm  = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    NSLog(@"%@ %@ %@",tm.Did, tm.ServIp ,tm.muarr);
}






-(void)NSStringNSDatachar{
    
    //IOS开发之----NSString、NSData、char* 类型之间的转换
    //NSString <-> NSData ** 去掉\0 需要转char*
    NSData* DataStr = [@"testdata\0" dataUsingEncoding:NSUTF8StringEncoding];
    
    //    NSString* StrData= [[NSString alloc] initWithData:DataStr   encoding:NSASCIIStringEncoding];
    
    //char* <-> NSData //NSString <-> char*
    
    //    const char *cstr = [StrData cStringUsingEncoding:NSUTF8StringEncoding];//char* 不能含有 '\0'
    
    //    NSData *dataC = [NSData dataWithBytes:cstr length:strlen(cstr)];
    
    const char *cdata = [DataStr bytes];//char* 不能含有 '\0'
    
    NSString * strC = [NSString stringWithUTF8String:cdata];
    
    NSLog(@"%@",strC);
    

}


-(void)disMissNvc{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)CGRect{
    
     CGRect r  = CGRectFromString(@"{{10,20},{30,40}}");//字符串恢复出矩形
     NSLog(@"%@",NSStringFromCGRect(r));
    
    //CGRectIntersectsRect 确定两个矩形是否相交
    CGRect r1 = CGRectMake(100, 100, 100, 100);
    CGRect r2 = CGRectMake(150, 150, 100, 100);
    if (CGRectIntersectsRect(r1, r2)) NSLog(@"intersecting");
    
   //CGRectOffset使用从源CGRect偏移的原点来创建矩形
    float offset = 25.0;
    CGRect r3 = CGRectOffset(r1, offset, offset);
    NSLog(@"%@",NSStringFromCGRect(r3));
    
    
    CGRect r4 = CGRectUnion(r1, r2);
    NSLog(@"%@",NSStringFromCGRect(r4));
    //Inset `rect' by `(dx, dy)' -- i.e., offset its origin by `(dx, dy)', and decrease its size by `(2*dx, 2*dy)'.
    CGRect r5 = CGRectInset(r4, 1, 1);
    NSLog(@"%@",NSStringFromCGRect(r5));//function:-[aViewController CGRect] line:429 content:{{101, 101}, {148, 148}}
    
    CGRect r6 = CGRectOffset(r4, 1, 1);
    NSLog(@"%@",NSStringFromCGRect(r6));//function:-[aViewController CGRect] line:429 content:{{101, 101}, {150, 150}}沿x轴和y轴偏移
    
//    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];//隐藏状态栏?
    
//    //把plist文件中的数据赋给数组
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"States" ofType:@"plist"];
//    NSArray *array = [NSArray arrayWithContentsOfFile:path];
//    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:plistPath];
//    获取Documents目录
//     NSString *documentsDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    
    
    //汉字转码
    NSString *oriString = @"\u67aa\u738b";
    NSString *escapedString = [oriString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",escapedString);
    
//    scrollRectToVisible调用这个方法就会滚到rect所在的那个区域去
    
    //设置日期格式
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.locale = [NSLocale currentLocale];
    dateFormatter.calendar = [NSCalendar autoupdatingCurrentCalendar];
    dateFormatter.timeZone = [NSTimeZone defaultTimeZone];
    dateFormatter.dateStyle = NSDateFormatterShortStyle;
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSLog(@"%@",[dateFormatter stringFromDate:[NSDate date]]);
    
    //加载大量图片的时候，可以使用
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"icon" ofType:@"png"];
    UIImage *myImage = [UIImage imageWithContentsOfFile:imagePath];
    

    
    
    
    NSString *originalString = @"(123)1231-1232*/*23abc";
    NSMutableString *strippedString = [NSMutableString stringWithCapacity:originalString.length];
    NSScanner *scanner = [NSScanner scannerWithString:originalString];
    NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    
    while ([scanner isAtEnd] == NO) {
        NSString *buffer;
        if ([scanner scanCharactersFromSet:numbers intoString:&buffer]) {
            [strippedString appendString:buffer];
        }else {
            scanner.scanLocation = [scanner scanLocation] + 1;
        }
    }
    NSLog(@"%@",strippedString);//1231231123223
    
    /*
    NSString *myString = @"1234";
    NSString *regex = @"[a-z][A-Z][0-9]";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    
    if ([predicate evaluateWithObject:myString]) {
      
    }else{
    
    }*/
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"nvc1_v1";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"destroy_nvc1" style:UIBarButtonItemStylePlain target:self action:@selector(disMissNvc)];
    
    NSLog(@"设备加载过的语言，第一个为当前语言%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"] );
    NSLog(@"%@",[[UIDevice currentDevice]modelIdentifier]);
    
    [self addBtn:CGPointMake(20, 50) andName:@"goGit" andS:@selector(goGit)];
    [self addBtn:CGPointMake(20, 150) andName:@"goSetting" andS:@selector(goSetting)];
    [self addBtn:CGPointMake(20, 250) andName:@"指纹（国际化1）" andS:@selector(指纹)];
    [self addBtn:CGPointMake(20, 350) andName:@"国际化2" andS:@selector(LanguageManager)];
    
    [self addBtn:CGPointMake(220, 50) andName:@"NSStringNSDatachar" andS:@selector(NSStringNSDatachar)];
    [self addBtn:CGPointMake(220, 150) andName:@"getFreeDiskspace" andS:@selector(getFreeDiskspace)];
    [self addBtn:CGPointMake(220, 250) andName:@"NSKeyedArchiverarchiveRootObject" andS:@selector(NSKeyedArchiverarchiveRootObject)];
    
    [self CGRect];
    
}

@end
