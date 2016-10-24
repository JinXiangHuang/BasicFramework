//
//  RootViewController.m
//  Dome
//
//  Created by Rainy on 16/8/18.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import "RootViewController.h"
#import "aViewController.h"
#import "testModel.h"
#import "BasicMainNC.h"
#import "BasicMainVC_one.h"

#import "BasicFramework-swift.h"
//在OC需要用到的swift文件中 导入文件 "Product Module Name -Swift.h"  因为 Product Module Name 默认是工程的名字 所以直接导入 #import "工程名-Swift.h"

#import "BasicMainWebNC.h"
#include <mach/mach.h>
@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
      [self setItems];
//    [self NSStringNSDatachar];
//    [self getFreeDiskspace];
//    [self NSKeyedArchiverarchiveRootObject];
      [self test3];
    
      [self swiftLearn];
    
    
 
    
}

-(void)swiftLearn{

    CGSize size = [@"swiftLearn" sizeWithFont:[UIFont systemFontOfSize:18]];//xcode 8 -> 2个字的宽度是24，现在2个字需要27的宽度来显示了。
    UIButton * button = [[UIButton alloc]initWithFrame: CGRectMake(20,44, size.width, size.height)];
    [button setBackgroundColor:kMainFontColor];
    [button setTitle:@"swiftLearn" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(goNvc3) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}
-(void)goNvc3{
    //oc 调用swift3.0
    commixOCq * coc2 = [[commixOCq alloc]init];
    [coc2 logMe];
    
    commixOCViewController * coc = [[commixOCViewController alloc] init];
    BasicMainWebNC * web = [[BasicMainWebNC alloc]initWithRootViewController:coc];
    [self presentViewController:web animated:YES completion:nil];
    
    
}

-(void)test3{
    
    UIButton * button = [[UIButton alloc]initWithFrame: CGRectMake(50, 100, 100, 50)];
    [button  setTitleColor:kMainFontColor forState:UIControlStateNormal];
    [button setTitle:@"goLanguages" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(goNvc1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton * button2 = [[UIButton alloc]initWithFrame:CGRectMake(50, 200, 100, 50)];
    
//     UIButton * button2 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button2 setTitle:@"goPopview" forState:UIControlStateNormal];
    [button2 setTitleColor:kMainFontColor forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(goPopview) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    NSLog(@"%@",[[UIDevice currentDevice]modelIdentifier]);
    
    [self addBtn];
}

-(void)addBtn{
    
    UIButton * button = [[UIButton alloc]initWithFrame: CGRectMake(50, 300, 100, 50)];
    [button  setTitleColor:kMainFontColor forState:UIControlStateNormal];
    [button setTitle:@"goaaaa" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(goNvc1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

-(void)goNvc1{
    
    aViewController * a = [[aViewController alloc]init];
    BasicMainNC * b = [[BasicMainNC alloc]initWithRootViewController:a];
    [self presentViewController:b animated:YES completion:nil];
    
}
-(void)goPopview{
    
    BasicMainVC_one * one = [[BasicMainVC_one alloc]init];
    UINavigationController * nvc = [[UINavigationController alloc]initWithRootViewController:one];
    [self presentViewController:nvc animated:YES completion:nil];
}














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

-(void)setItems{
    [[UINavigationBar appearance]setBackgroundImage:[UIImage createImageWithColor:kThemeColor] forBarMetrics:UIBarMetricsDefault];
     NSDictionary *dic = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    [[UINavigationBar appearance] setTitleTextAttributes:dic];
    [[UINavigationBar appearance]setTintColor:[UIColor whiteColor]];
    [[UIBarButtonItem appearance]setTitleTextAttributes:dic forState:UIControlStateNormal];
    //    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    UIImage *backItemImage = [[UIImage createImageWithColor:kButtonBackColorForNormal] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 0, 0) resizingMode:UIImageResizingModeStretch];
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setBackButtonBackgroundImage:backItemImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    self.view.backgroundColor = [UIColor brownColor];
}






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
    
    NSString* StrData= [[NSString alloc] initWithData:DataStr   encoding:NSASCIIStringEncoding];
    
    //char* <-> NSData //NSString <-> char*
    
    const char *cstr = [StrData cStringUsingEncoding:NSUTF8StringEncoding];//char* 不能含有 '\0'
    
    NSData *dataC = [NSData dataWithBytes:cstr length:strlen(cstr)];
    
    const char *cdata = [DataStr bytes];//char* 不能含有 '\0'
    
    NSString * strC = [NSString stringWithUTF8String:cdata];
    
    NSLog(@"%@",strC);
}


@end
