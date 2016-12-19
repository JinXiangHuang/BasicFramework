//
//  CAShapeLayerViewController.m
//  BasicFramework
//
//  Created by mr-tech on 16/10/26.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import "CAShapeLayerViewController.h"
#define   DEGREES(degrees)  ((M_PI * (degrees))/ 180.f)
@interface CAShapeLayerViewController ()
@property (nonatomic, strong) UIView        *showView;
@property (nonatomic, strong) CAShapeLayer  *maskLayer;

@end

@implementation CAShapeLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"base"];
    [self.view addSubview:imageView];
    
     _maskLayer = [CAShapeLayer layer];
    
    // 利用贝塞尔曲线创建一个圆
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(0, 0)
                                                        radius:100
                                                    startAngle:DEGREES(0)
                                                      endAngle:DEGREES(360)
                                                     clockwise:YES];
    
    // 获取path
    _maskLayer.path     = path.CGPath;
    _maskLayer.position = CGPointMake(_showView.bounds.size.width/2.f,
                                      _showView.bounds.size.height/2.f);
    
    _maskLayer.fillColor = [UIColor whiteColor].CGColor;
    _maskLayer.position = self.view.center;
    
    UIView *blurView = [[UIView alloc] initWithFrame:self.view.bounds];
    blurView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:blurView];
    // 只显示圆形部分
    blurView.layer.mask = _maskLayer;
    blurView.layer.contents = (__bridge id)([[UIImage imageNamed:@"backgroud"] imgWithBlur].CGImage);
    
    /*
     透明的View,用于maskView中的ShapeLayer的参考View(用于拖拽)
     */
    _showView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    _showView.backgroundColor = [UIColor clearColor];
    _showView.center = self.view.center;
    [self.view addSubview:_showView];
    
    UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [_showView addGestureRecognizer:recognizer];
    
}
- (void)handlePan:(UIPanGestureRecognizer *)recognizer
{
    // 拖拽
    CGPoint translation = [recognizer translationInView:self.view];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                         recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
    
    // 关闭CoreAnimation的隐式动画，如果开启隐式动画，会出现卡顿现象。
    [CATransaction setDisableActions:YES];
    _maskLayer.position = recognizer.view.center;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
