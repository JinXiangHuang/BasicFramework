//
//  BasicMainVC_one.m
//  BasicFramework
//
//  Created by mr-tech on 16/9/19.
//  Copyright © 2016年 Rainy. All rights reserved.
//  expr (void)[0x7fde6c484640 setBackgroundColor:[UIColor redColor]] 视图调试

#import "BasicMainVC_one.h"
#import "BasicMainVC_two.h"
#import "HPopView.h"
#import "HHLabel.h"
@interface BasicMainVC_one ()
@property (nonatomic,retain) HHLabel * label;

@end

@implementation BasicMainVC_one

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBar];
    [self setView];
    [self addNotifications];
    NSLog(@"获取当前最顶层的ViewController%@",[self topViewController]);
    [self addLabel1];
    [self addLabel2];
    [self aboutEvent:self.view];
    
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [self.view addGestureRecognizer:pan];
   
    
    
    /*
    CATransition *myTransition=[CATransition animation];//创建CATransition
    myTransition.duration=0.3;//持续时长0.3秒
    myTransition.timingFunction=UIViewAnimationCurveEaseInOut;//计时函数，从头到尾的流畅度
    myTransition.type=kCATransitionPush;//动画类型
    myTransition.subtype=kCATransitionFromLeft;//子类型
    //要令一个转场生效，组要将动画添加到将要变为动画视图所附着的图层。例如在两个视图控制器之间进行转场，那就将动画添加到窗口的图层中：
    [[self.view.superview layer]addAnimation:myTransition forKey:nil ];
    //如果是将控制器内的子视图转场到另一个子视图，就将动画加入到视图控制器的图层。还有一种选择，用视图控制器内部的视图作为替代，将你的子视图作为主视图的子图层：
    [ self.view.layer addAnimation:myTransition forKey:nil ];
//    [ self.view addSubview:newView ];
//    [oldView removeFromSuperview];
    //如果你使用的是导航控制器，可以将动画加到导航控制器的视图图层中。
//    [ navigationController.view.layer addAnimation:myTransition forKey:nil  ];*/
    
}

-(void)aboutEvent:(UIView *)view{
    
    UIButton * button = [[UIButton alloc]initWithFrame: CGRectMake(0, 300, 100, 100)];
    [button setBackgroundColor:kMainFontColor];
    [button setTitle:@"v1" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(v1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [self aboutEvent2:button];
    button.tag = 10;
    
}

-(void)aboutEvent2:(UIView *)view{
    
    UIButton * button = [[UIButton alloc]initWithFrame: CGRectMake(25, 25, 200, 200)];
    [button setBackgroundColor:[UIColor redColor]];
    button.alpha = 0.5;
    [button setTitle:@"v2" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(v2) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    UIButton * button2 = [[UIButton alloc]initWithFrame: CGRectMake(0, -25, 100, 100)];
    [button2 setBackgroundColor:[UIColor redColor]];
    button2.alpha = 0.5;
    [button2 setTitle:@"v3" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(v3) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button2];
    
    
    
    
    
//    button.userInteractionEnabled = NO;
//    父视图的titleLabel在last
//    超出父视图不接受响应
//    [view insertSubview:button aboveSubview:button.titleLabel];
//    [view insertSubview:button belowSubview:button.titleLabel];
//    [button.superview hitTest:<#(CGPoint)#> withEvent:<#(nullable UIEvent *)#>]
    NSLog(@"%@＊＊v1",button.superview);
    NSLog(@"%@＊＊v1",button.nextResponder);
    
    NSLog(@"%@＊＊view",button.superview.superview);
    
    NSLog(@"%@＊＊",button.superview.superview.superview);
    
    NSLog(@"%d＊＊",[button.superview.superview isKindOfClass:NSClassFromString(@"UIViewControllerWrapperView")]);


//    //nav为root UINavigationController
//    UIViewController *viewController = ((AppDelegate *)[UIApplication sharedApplication].delegate).nav.visibleViewController;
    
 
   
    /**
     
     一.//事件的传递是由 父视图->子视图 方向进行，根据hitTest和不接受的三种情况判断
     
    
     
     1.点击一个UIView或产生一个触摸事件A，这个触摸事件A会被添加到由UIApplication管理的事件队列中（即，首先接收到事件的是UIApplication）。
     2.UIApplication会从事件对列中取出最前面的事件（此处假设为触摸事件A），把事件A传递给应用程序的主窗口（keyWindow）。
     3.窗口会在视图层次结构中找到一个最合适的视图来处理触摸事件。（至此，第一步已完成）
     注 意: 如果父控件不能接受触摸事件，那么子控件就不可能接收到触摸事件
     
     应用如何找到最合适的控件来处理事件？
     1.首先判断主窗口（keyWindow）自己是否能接受触摸事件
     2.判断触摸点是否在自己身上
     {
     A.在  ->3
     B.不在 over
     }
     3.子控件数组中从后往前遍历子控件，重复前面的两个步骤（所谓从后往前遍历子控件，就是首先查找子控件数组中最后一个元素，然后执行1、2步骤）
     4.如果没有符合条件的子控件，那么就认为自己最合适处理这个事件，也就是自己是最合适的view。
     
     先传递事件，再根据事件在自己身上找更合适的view。
     
     UIView不能接收触摸事件的三种情况：
     不允许交互：userInteractionEnabled = NO
     隐藏：如果把父控件隐藏，那么子控件也会隐藏，隐藏的控件不能接受事件
     透明度：如果设置一个控件的透明度<0.01，会直接影响子控件的透明度。alpha：0.0~0.01为透明。
     注 意:默认UIImageView不能接受触摸事件，因为不允许交互，即userInteractionEnabled = NO，所以如果希望UIImageView可以交互，需要userInteractionEnabled = YES。

     UIApplication -> window ->  self.view(能接收触摸事件? -> (self.view)根据hitTest:withEvent:来判断触摸点是否在父视图身上) -> v1 -> v2
     
     二.
      a. 只要事件一传递给一个控件,这个控件就会调用他自己的hitTest：withEvent：方法 -> 寻找并返回最合适的view(能够响应事件的那个最合适的view)
     
      b. 拦截事件的处理:重写hitTest：withEvent：方法，返回指定的view作为最合适的view。
         (自定义控件中重写)ViewController中不能重写  - (nullable UIView *)hitTest:(CGPoint)point withEvent:(nullable UIEvent *)event
     
       c. 技巧：想让谁成为最合适的view就重写谁自己的父控件的hitTest:withEvent:方法返回指定的子控件，或者重写自己的hitTest:withEvent:方法 return self。但是，建议在父控件的hitTest:withEvent:中返回子控件作为最合适的view！第二种 ，当遍历想要的后在遍历真正的就无法得到想要的，所以不推荐
     
      d.- (BOOL)pointInside:(CGPoint)point withEvent:(nullable UIEvent *)event;YES，代表点在方法调用者的坐标系上;NO代表点不在方法调用者的坐标系上，那么方法调用者也就不能处理事件。
     
     响应者对象：能处理事件的对象，也就是继承自UIResponder的对象
     三. 响应链顺序是由 子视图->父视图 方向进行，根据三个touches方法，判断有没有调用父视图的相同方法。
     
    事件的响应。首先看initial view能否处理这个事件，如果不能则会将事件传递给其上级视图（inital view的superView）；如果上级视图仍然无法处理则会继续往上传递；一直传递到视图控制器view controller，首先判断视图控制器的根视图view是否能处理此事件；如果不能则接着判断该视图控制器能否处理此事件，如果还是不能则继续向上传 递；（对于第二个图视图控制器本身还在另一个视图控制器中，则继续交给父视图控制器的根视图，如果根视图不能处理则交给父视图控制器处理）；一直到 window，如果window还是不能处理此事件则继续交给application处理，如果最后application还是不能处理此事件则将其丢弃
     
     
     如果当前这个view是控制器的view,那么控制器就是上一个响应者,如果当前这个view不是控制器的view,那么父控件就是上一个响应者
     在视图层次结构的最顶级视图，如果也不能处理收到的事件或消息，则其将事件或消息传递给window对象进行处理
     如果window对象也不处理，则其将事件或消息传递给UIApplication对象
     如果UIApplication也不能处理该事件或消息，则将其丢弃
     
     */


}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
 
    [self.view endEditing:YES];
    
    NSLog(@"%@", self.nextResponder);//包含view controller 的view属性的封装视图。
    NSLog(@"%@", self.nextResponder.nextResponder);
    
     for (UITouch *touch in touches) {
          NSLog(@" - %f",touch.timestamp);
          NSLog(@" - %ld",touch.phase);
          NSLog(@" - %ld",touch.tapCount);
          NSLog(@" - %ld",touch.type);
          CGPoint touchPoint = [touch locationInView:self.view];//获取到的是手指点击屏幕实时的坐标点；
          NSLog(@"%@",NSStringFromCGPoint(touchPoint));
     }

}
-(void)pan:(UIPanGestureRecognizer *)pan{
     CGPoint transPoint = [pan translationInView:self.view];//获取到的是手指移动后，在相对坐标中的偏移量
     NSLog(@"%@",NSStringFromCGPoint(transPoint));
}
#pragma mark - 返回输入键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

-(void)v2{
    NSLog(@"click v2");
}
-(void)v1{
    NSLog(@"click v1");
}

-(void)v3{
    NSLog(@"click v3");
}
-(void)addLabel2{
    
    _label = [[HHLabel alloc] initWithFrame:CGRectMake(200, 350, 50, 50)];
    _label.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    _label.textColor = [self randomColor];
    //        _label.textAlignment = UITextal   UITextAlignmentCenter;
    _label.backgroundColor = [UIColor clearColor];
    _label.font = [UIFont systemFontOfSize:16];
    _label.text = @"Slide";
    _label.animated = YES;
    [self.view addSubview:_label];
}

-(void)addLabel1{
    
    HHLabel * la  = [[HHLabel alloc]init];
    [la addLabel:self.view :@"文字渐变效果"];
    
    
}
-(UIColor *)randomColor{
    CGFloat r = arc4random_uniform(256) / 255.0;
    CGFloat g = arc4random_uniform(256) / 255.0;
    CGFloat b = arc4random_uniform(256) / 255.0;
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}
-(void)setBar{
    
    self.title = @"nvc2_v1";
}
-(void)goV2{
   
    BasicMainVC_two * av = [[BasicMainVC_two alloc]init];
    [self.navigationController pushViewController:av animated:YES];
}
-(void)keyboardWillShow:(NSNotification *)aNotification{
     [DFYGProgressHUD showProgressHUDWithMode:ProgressHUDModeOnlyText withText:@"keyboardWillShow" isTouched:YES inView:self.view];
     NSLog(@"%ld",self.view.subviews.count);
}

-(void)keyboardDidShow:(NSNotification *)aNotification{
    [DFYGProgressHUD showProgressHUDWithMode:ProgressHUDModeOnlyText withText:@"keyboardDidShow" isTouched:YES inView:self.view];
     NSLog(@"%ld",self.view.subviews.count);
}
-(void)keyboardWillHide:(NSNotification *)aNotification{
    [DFYGProgressHUD showProgressHUDWithMode:ProgressHUDModeOnlyText withText:@"keyboardWillHide" isTouched:YES inView:self.view];
    [DFYGProgressHUD hideProgressHUDAfterDelay:3];
}
-(void)pop{
    
    HPopView * hp = [[HPopView alloc]initWithFrame:CGRectMake(10, 20, 300, 40)];

//    HPopView * hp = [[HPopView alloc]init];
    [hp show];
    
    hp.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *logoViewtopConstraint   = [NSLayoutConstraint constraintWithItem:hp attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTopMargin multiplier:1.0f constant:280];
    
    NSLayoutConstraint *logoViewcenterConstaint = [NSLayoutConstraint constraintWithItem:hp attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeftMargin multiplier:1.0f constant:0];
    
    NSLayoutConstraint *logoViewwidthConstaint  = [NSLayoutConstraint constraintWithItem:hp attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:0.5f constant:300];
    
    NSLayoutConstraint *logoViewhightConstaint  = [NSLayoutConstraint constraintWithItem:hp attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:kNilOptions multiplier:1.0f constant:40];
    
    // 第三步：添加约束
    
    logoViewtopConstraint.active   = YES;
    
    logoViewcenterConstaint.active = YES;
    
    logoViewwidthConstaint.active  = YES;
    
    logoViewhightConstaint.active  = YES;
    
    [hp addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeBounds:)]];
    
}
-(void)changeBounds:(UITapGestureRecognizer *)tap{
    

    [NSLayoutConstraint constraintWithItem:tap.view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1 constant:100].active = YES;

    
}
-(void)setView{
    UIButton * button = [[UIButton alloc]initWithFrame: CGRectMake(200, 0, 150, 150)];
    button.backgroundColor = [UIColor greenColor];
    [button setTitle:@"lookImage" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(goV2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    UIButton * buttonPop = [[UIButton alloc]initWithFrame: CGRectMake(200, 200, 100, 100)];
    buttonPop.backgroundColor = [UIColor greenColor];
    [buttonPop setTitle:@"pop" forState:UIControlStateNormal];
    [buttonPop addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonPop];
    
    
    NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"主题1",@"主题2",@"主题3",@"主题4",nil];
    //初始化UISegmentedControl
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    segmentedControl.frame = CGRectMake(30, 160, 300, 50);
    // 设置默认选择项索引
    segmentedControl.tintColor = [UIColor redColor];

    [self.view addSubview:segmentedControl];
    // 设置在点击后是否恢复原样
    segmentedControl.momentary = NO;
    
    /*
    [segmentedControl setTitle:@"two" forSegmentAtIndex:1];//设置指定索引的题目
    [segmentedControl setImage:[UIImage createImageWithColor:kMainFontColor] forSegmentAtIndex:3];//设置指定索引的图片
    // 在指定索引插入一个选项并设置图片
    [segmentedControl insertSegmentWithImage:[UIImage createImageWithColor:kThemeColor] atIndex:2 animated:NO];
    // 在指定索引插入一个选项并设置题目
    [segmentedControl insertSegmentWithTitle:@"insert" atIndex:3 animated:YES];
   */
    [segmentedControl addTarget:self action:@selector(didClicksegmentedControlAction:)forControlEvents:UIControlEventValueChanged];
    
    /*
    // 移除指定索引的选项
    [segmentedControl removeSegmentAtIndex:0 animated:NO];
    // 设置指定索引选项的宽度
    [segmentedControl setWidth:70.0 forSegmentAtIndex:2];
    // 设置选项中图片等的左上角的位置
    [segmentedControl setContentOffset:CGSizeMake(10.0,10.0) forSegmentAtIndex:4];
    
    //获取指定索引选项的图片imageForSegmentAtIndex：
    UIImageView *imageForSegmentAtIndex = [[UIImageViewalloc]initWithImage:[segmentedControl imageForSegmentAtIndex:1]];
    imageForSegmentAtIndex.frame = CGRectMake(60.0, 120.0, 30.0, 30.0);  ;
    
    //获取指定索引选项的标题titleForSegmentAtIndex
    UILabel *titleForSegmentAtIndex = [[UILabel alloc]initWithFrame:CGRectMake(100.0, 160.0, 30.0, 30.0)];
    titleForSegmentAtIndex.text = [segmentedControl titleForSegmentAtIndex:0];
    
    //获取总选项数segmentedControl.numberOfSegments
    UILabel *numberOfSegments = [[UILabel alloc]initWithFrame:CGRectMake(140.0, 170.0, 30.0, 30.0)];
    numberOfSegments.text = [NSString stringWithFormat:@"%d",segmentedControl.numberOfSegments];
    
    //获取指定索引选项的宽度widthForSegmentAtIndex：
    UILabel *widthForSegmentAtIndex = [[UILabel alloc]initWithFrame:CGRectMake(180.0, 210.0, 70.0, 30.0)];
    widthForSegmentAtIndex.text = [NSString stringWithFormat:@"%f",[segmentedControl widthForSegmentAtIndex:2]];
    
    // [segmentedControl setEnabled:NO forSegmentAtIndex:4];//设置指定索引选项不可选
    // BOOL enableFlag = [segmentedControl isEnabledForSegmentAtIndex:4];//判断指定索引选项是否可选
   
    

      */
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)didClicksegmentedControlAction:(UISegmentedControl *)Seg{
    NSInteger Index = Seg.selectedSegmentIndex;
    switch (Index) {
        case 0:
            [self setNavigationControllerAppearance:[UIColor yellowColor]];
            
            break;
        case 1:
            [self setNavigationControllerAppearance:[UIColor purpleColor]];
            break;
        case 2:
            [self setNavigationControllerAppearance:[UIColor cyanColor]];
            break;
        case 3:
            [self setNavigationControllerAppearance:[UIColor magentaColor]];
            break;
           
        default:
            break;
    }
}
//全局设置导航栏主题 appearance 后就显示[UINavigationBar appearance]
- (void)setNavigationControllerAppearance:(UIColor *)color {
    [UINavigationBar appearance].barStyle  = UIBarStyleBlack;
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithWhite:0.1 alpha:0.5]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage createImageWithColor:color] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage createImageWithColor:color] forBarMetrics:UIBarMetricsDefault];
}

/*
 通过最底层的ViewController依次向上寻找，直到找到最顶层的ViewController，也就是从UIApplication的keyWindow的rootViewController开始寻找（如果有多个UIWindow则要考虑UIWindow的选择问题。在寻找的过程中，要分别考虑当前ViewController是UITabBarController和UINavigationController的情况，同时还要考虑到当前ViewController是否通过presentViewController:animated:completion:模态展示了其他ViewController。*/
- (UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

- (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}

@end
