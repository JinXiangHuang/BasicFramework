//
//  TBFirstViewController.m
//  TheBackgrounder
//
//  Copyright (c) 2013 Gustavo Ambrozio. All rights reserved.
//

#import "TBFirstViewController.h"
#import "AppDelegate.h"
#import <AudioToolbox/AudioToolbox.h> 
/*
 
 */

//    CAStreamBasicDescription dstFormat;
//    dstFormat.mSampleRate = myInfo.mDataFormat.mSampleRate;
//    dstFormat.mChannelsPerFrame = myInfo.mDataFormat.mChannelsPerFrame;
//    dstFormat.mFormatID = kAudioFormatLinearPCM;
//    dstFormat.mFormatFlags = kLinearPCMFormatFlagIsPacked | kLinearPCMFormatFlagIsSignedInteger; // little-endian
//    dstFormat.mBitsPerChannel = 16;
//    dstFormat.mBytesPerPacket = dstFormat.mBytesPerFrame = 2 * dstFormat.mChannelsPerFrame;
//    dstFormat.mFramesPerPacket = 1;


#import <AVFoundation/AVFoundation.h>
@interface TBFirstViewController ()

@end

@implementation TBFirstViewController
-(void)didTapPlayPause:(id)sender{

    /*
     AVAudioPlayer在AVFoundation框架下，所以我们要导入AVFoundation.framework。 AVAudioPlayer类封装了播放单个声音的能力。播放器可以用NSURL或者NSData来初始化，要注意的是NSURL并不可以是网络url而必须是本地文件URL，因为AVAudioPlayer不具备播放网络音频的能力
     一个AVAudioPlayer只能播放一个音频，如果你想混音你可以创建多个AVAudioPlayer实例，每个相当于混音板上的一个轨道。
     因为AVAudioPlayer只能播放一个完整的文件，并不支持流式播放，所以必须是缓冲完才能播放，所以如果网络文件过大抑或是网速不够岂不是要等很久？所以播放网络音频我们一般用音频队列。**/
    
    /*
     //????
     NSError *err;
     AVAudioPlayer* musicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath: [[NSBundle mainBundle]pathForResource: @"IronBacon" ofType:@"mp3"]] error:&err ];//使用本地URL创建
     
     [musicPlayer prepareToPlay];
     musicPlayer.volume = 1;
     musicPlayer.numberOfLoops = -1;//-1表示一直循环
     NSLog(@"%d",musicPlayer.playing);
     [musicPlayer play];
     //    musicPlayer.currentTime = 15.0;//可以指定从任意位置开始播放
     NSLog(@"%d,%@",musicPlayer.playing,[[NSBundle mainBundle]pathForResource: @"IronBacon" ofType:@"mp3"]);*/
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    self.title = NSLocalizedString(@"Audio", @"Audio");
    
//     self.tabBarItem = [[UITabBarItem alloc]initWithTabBarSystemItem:UITabBarSystemItemDownloads tag:22];
      
    self.tabBarItem.image = [UIImage imageNamed:@"first"];
      
  }
  return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}
void SoundFinished(SystemSoundID soundID,void* sample){
    /*播放全部结束，因此释放所有资源 */
    AudioServicesDisposeSystemSoundID(soundID);
    CFRelease(sample);
    CFRunLoopStop(CFRunLoopGetCurrent());
}

- (IBAction)backRootAction:(UIButton *)sender {
    AppDelegate * app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [app setMyWindowAndRootViewController];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
