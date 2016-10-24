//
//  bViewControllerLanguage.m
//  BasicFramework
//
//  Created by mr-tech on 16/10/18.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import "bViewControllerLanguage.h"

#define ChangeLanguageNotificationName @"changeLanguage"

@interface bViewControllerLanguage ()
@property (weak, nonatomic) IBOutlet UIImageView *worldImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation bViewControllerLanguage

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    //注册通知，用于接收改变语言的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage) name:ChangeLanguageNotificationName object:nil];
    
    [self setWorldImageViewAnimation];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:ChangeLanguageNotificationName object:nil];
    
//    [self changeLanguage];
}

//设置动画
- (void)setWorldImageViewAnimation {
    NSArray *array = [NSArray arrayWithObjects:
                      [UIImage imageNamed:@"world_1"],
                      [UIImage imageNamed:@"world_2"],
                      [UIImage imageNamed:@"world_3"],
                      [UIImage imageNamed:@"world_4"],
                      nil];
    [_worldImageView setAnimationImages:array];
    [_worldImageView setAnimationDuration:1.5];
    [_worldImageView startAnimating];
}

//改变语言界面刷新
- (void)changeLanguage {
//    self.title = kLocalizedString(@"home",@"首页");
//    
//    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:kLocalizedString(@"preference",@"偏好") style:UIBarButtonItemStyleDone target:self action:@selector(gotoPreferenceViewController)];
//    self.navigationItem.rightBarButtonItem = item;
//    
//    _titleLabel.text = kLocalizedString(@"welcome",@"你好 世界!");
    
    
    
    
    self.title = NSLocalizedString(@"home", @"备注");
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"preference",@"偏好")  style:UIBarButtonItemStyleDone target:self action:@selector(gotoPreferenceViewController)];
    self.navigationItem.rightBarButtonItem = item;
    
    _titleLabel.text = NSLocalizedString(@"welcome",@"你好 世界!");
  
    NSLog(@"%@",NSLocaleLanguageCode);
    
    NSLog(@"%@",NSLocalizedDescriptionKey);
    

    
}

#pragma mark - goto

//去偏好设置界面
- (void)gotoPreferenceViewController {
//    HXPreferenceViewController *vc = [HXPreferenceViewController new];
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
//    [self.navigationController presentViewController:nav animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
//    [[NSNotificationCenter defaultCenter] removeObserver:self forKeyPath:ChangeLanguageNotificationName];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
