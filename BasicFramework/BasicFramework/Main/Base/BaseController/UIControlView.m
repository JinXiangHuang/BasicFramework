//
//  UIControlView.m
//  BasicFramework
//
//  Created by mr-tech on 16/10/26.
//  Copyright © 2016年 Rainy. All rights reserved.
//
/*SizeClass：在自适应布局中，苹果提出了Size Class（尺寸类型）的概念，用于在概念上表示水平或垂直方向的大小。共有3种类型尺寸，大的称之为Regular（标准尺寸类型，简记为+），小的称之为Compact（紧凑尺寸类型，简记为-），任意的称之为Any（Regular和Compact任意）。所有的iPad不管什么方位都是[+, +]
 
 所有的iPhone在竖屏时都是[-, +]
 
 在横屏时只有iPhone 6 Plus和6s Plus是[+, -]，其余的iPhone都是[-, -]。当设计人员给出了不同设备上的界面设计稿之后，作为开发人员的我们应该首先总结出最通用的自动布局方案，将其作为任意尺寸类型的自动布局（基类）；把差异化的布局放在某个特定尺寸类型的自动布局（子类）。使用的时候一定要确保Use Auto Layout复选框和Use Size Classes复选框都已选中*/
#import "UIControlView.h"
#import "BasicMainVC_one.h"
#import "CAShapeLayerViewController.h"
@interface UIControlView ()

@end

@implementation UIControlView
-(void)back{
  
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor brownColor];
    [self addBtn:CGPointMake(20, 44) andName:@"goPopview" andS:@selector(goPopview)];
    [self addBtn:CGPointMake(20, 144) andName:@"back" andS:@selector(back)];
    [self addBtn:CGPointMake(20, 244) andName:@"addMaskViewAnimate" andS:@selector(addMaskView)];
    
    [self addBtn:CGPointMake(20, 344) andName:@"CAGradientLayerDemo" andS:@selector(CAGradientLayerDemo)];
    [self addBtn:CGPointMake(20, 444) andName:@"CAShapeLayerDemo" andS:@selector(CAShapeLayerDemo)];
    [self addLabel:CGPointMake(220, 44) andName:@"code Label Label Label"];
    [self viewview];
}
-(void)CAShapeLayerDemo{
    CAShapeLayerViewController * slvc = [[CAShapeLayerViewController alloc]init];
    [self presentViewController:slvc animated:YES completion:nil];
}
#pragma mark maskView配合CAGradientLayer使用
-(void)CAGradientLayerDemo{
    self.view.backgroundColor = [UIColor grayColor];
    // 渐变Layer
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    [self.view.layer addSublayer:gradientLayer];
    
    gradientLayer.frame = CGRectMake(0, 400, self.view.Sw, 64);
    gradientLayer.colors = @[
                             (__bridge id)[UIColor blackColor].CGColor,
                             (__bridge id)[UIColor whiteColor].CGColor,
                             (__bridge id)[UIColor blackColor].CGColor,
                            ];
    gradientLayer.locations = @[@0.25,@0.5,@0.75];
    
    // 添加部分
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"locations"];
    basicAnimation.fromValue = @[@0, @0, @0.25];
    basicAnimation.toValue = @[@0.75, @1, @1];
    basicAnimation.duration = 2.5;
    basicAnimation.repeatCount = HUGE;
    [gradientLayer addAnimation:basicAnimation forKey:nil];
    //水平
    gradientLayer.startPoint = CGPointMake(0, 0.5);
    gradientLayer.endPoint = CGPointMake(1, 0.5);
    
    // 第二次添加部分
    UILabel *unlock = [[UILabel alloc] initWithFrame:gradientLayer.bounds];
    // 必需要强引用保存unlock，此句也可以用[self.view addSubview:unlock]来替代;
    [self.view addSubview:unlock];
    unlock.alpha = 0.5;
    unlock.text = @"滑动来解锁 >>";
    unlock.textAlignment = NSTextAlignmentCenter;
    unlock.font = [UIFont boldSystemFontOfSize:30];
    gradientLayer.mask = unlock.layer;
    // ***?*阿尔法通道(Alpha Channel) 阿尔法通道是一个8位的灰度通道，该通道用256级灰度来记录图像中！！的透明度信息，定义透明、不透明和半透明区域，其中黑表示透明，白表示不透明，灰表示半透明**?***。
}
#pragma mark 基础控件UIButton:UIControl

-(void)addBtn:(CGPoint)point andName:(NSString *)name andS:(SEL)sel{
    
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    //     NSLog(@"%ld",button.buttonType);  //按钮形状类型 (readonly)
    
    button.showsTouchWhenHighlighted = YES;
    
    [button setBackgroundColor:kMainFontColor];
    //    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    [button setTintColor:[UIColor whiteColor]];
    
    [button setTitle:name forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateNormal];
    
    [button setTitle:name forState:UIControlStateSelected];
    [button setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateSelected];
    
    //    [button setBackgroundImage:[UIImage imageNamed:@"选中"] forState:UIControlStateNormal];//imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ]
    //事件通知  UIControl类提供了一个标准机制，来进行事件登记和接收
    [button addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
    
    /*
     1，setBackgroundImage， 图片不会随着按钮的大小改变而改变会变压缩会拉伸。
     button.buttonType -> UIButtonTypeCustom( font-size: 18.00pt, TitleColor: whiteColor)，UIButtonTypeSystem( font-size: 15.00pt,TitleColor: blueColor):图片 色调色调不变化 else -> 不显示图片
     
     2，setImage 图片不会随着按钮的大小改变而改变,会变压缩不会拉伸
     button.buttonType -> UIButtonTypeCustom:图片色调不变化 else -> 图片色调随背景颜色变化
     */
   
    //创建btn 1 首先给按钮赋一个初始的frame，按钮最终的frame是根据文字内容决定的 让按钮自适应文字内容。
    [button setFrame:CGRectMake(point.x, point.y, 100, 100)];
    [button sizeToFit];//button.frame.size = button.intrinsicContentSize 决定按钮大小
    
    // NSLog(@"%@",NSStringFromCGSize([button sizeThatFits:CGSizeMake(1, 10)]));//返回“最佳”的大小，以适应给定的大小。不实际调整视图。默认是返回现有视图大小
    //创建btn 2 给按钮一个位置结合视图内容大小
    //        [button setFrame:CGRectMake(point.x, point.y, button.intrinsicContentSize.width, button.intrinsicContentSize.height)];
    //创建btn 3 给按钮一个位置结合文字大小
    //获取文字大小1:
    //    [button setFrame:CGRectMake(point.x, point.y, [name sizeWithFont:[UIFont systemFontOfSize:18]].width, [@"goGit" sizeWithFont:[UIFont systemFontOfSize:18]].height)];
    //获取文字大小2:
    //    CGSize titleSize = [name sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:button.titleLabel.font.fontName size:button.titleLabel.font.pointSize]}];
    //    CGSize titleSize = [name sizeWithAttributes:@{NSFontAttributeName: button.titleLabel.font}];
    //    [button setFrame:CGRectMake(point.x, point.y, titleSize.width, titleSize.height)];
    
    
    /**
     7     UIControlStateFocused NS_ENUM_AVAILABLE_IOS(9_0) = 1 << 3,  // 聚焦状态 （iOS新加入 应该和3D Touch有关）
     8     UIControlStateApplication  = 0x00FF0000,    // 当用做应用标志时
     9     UIControlStateReserved     = 0xFF000000     // 框架预留 无意义*/
    
    /*
     //绘制
     - (CGRect)backgroundRectForBounds:(CGRect)bounds;      // 返回背景绘制区域
     - (CGRect)contentRectForBounds:(CGRect)bounds;         // 返回内容绘制区域
     - (CGRect)titleRectForContentRect:(CGRect)contentRect; // 返回标题绘制区域
     - (CGRect)imageRectForContentRect:(CGRect)contentRect; // 返回图片绘制区域*/
    
    
    NSLog(@"%@",button.titleLabel.font);
    
    NSLog(@"%@",button.currentAttributedTitle);//currentTitle,currentTitleColor,titleLabel,imageView... (readonly)
    
    NSLog(@"%@",[button attributedTitleForState:UIControlStateNormal]);
    
    NSLog(@"%@,%@",button.imageView,button.titleLabel);//return title and image views. will always create them if necessary. always returns nil for system buttons( UIButtonTypeDetailDisclosure, UIButtonTypeInfoLight, UIButtonTypeInfoDark, UIButtonTypeContactAdd,)
    NSLog(@"%@",[button imageForState:UIControlStateNormal]);
    
    
    
    [self.view addSubview:button];
    
    //    button.opaque = YES;
    
    //    button.layer.opacity = 0.2;
    
    
    
    /*而UIControl派生自UIView类
     UIControl是UIView的子类，当然也是UIResponder的子类。UIControl是诸如UIButton、UISwitch、UITextField等控件的父类，它本身也包含了一些属性和方法，但是不能直接使用UIControl类，它只是定义了子类都需要使用的方法。
     
     UIControl把复杂的触摸事件封装成了简单的易于使用的控件事件
     属性
     enabled
     控件默认是启用的。要禁用控件，可以将enabled属性设置为NO，这将导致控件忽略任何触摸事件。被禁用后，控件还可以用不同的方式显示自己，比如变成灰色不可用。虽然是由控件的子类完成的，这个属性却存在于UIControl中。
     selected
     当用户选中控件时，UIControl类会将其selected属性设置为YES。子类有时使用这个属性来让控件选择自身，或者来表现不同的行为方式。
     contentVerticalAlignment/contentHorizontalAlignment
     控件如何在垂直方向/水平对齐上布置自身的内容
     UIControlEventTouchDown
     单点触摸按下事件：用户点触屏幕，或者又有新手指落下的时候。
     UIControlEventTouchDownRepeat
     多点触摸按下事件，点触计数大于1：用户按下第二、三、或第四根手指的时候。
     UIControlEventTouchDragInside
     当一次触摸在控件窗口内拖动时。
     UIControlEventTouchDragOutside
     当一次触摸在控件窗口之外拖动时。
     UIControlEventTouchDragEnter
     当一次触摸从控件窗口之外拖动到内部时。
     UIControlEventTouchDragExit
     当一次触摸从控件窗口内部拖动到外部时。
     UIControlEventTouchUpInside
     所有在控件之内触摸抬起事件。
     UIControlEventTouchUpOutside
     所有在控件之外触摸抬起事件(点触必须开始与控件内部才会发送通知)。
     UIControlEventTouchCancel
     所有触摸取消事件，即一次触摸因为放上了太多手指而被取消，或者被上锁或者电话呼叫打断。
     UIControlEventTouchChanged
     当控件的值发生改变时，发送通知。用于滑块、分段控件、以及其他取值的控件。你可以配置滑块控件何时发送通知，在滑块被放下时发送，或者在被拖动时发送。
     UIControlEventEditingDidBegin
     当文本控件中开始编辑时发送通知。
     UIControlEventEditingChanged
     当文本控件中的文本被改变时发送通知。
     UIControlEventEditingDidEnd
     当文本控件中编辑结束时发送通知。
     UIControlEventEditingDidOnExit
     当文本控件内通过按下回车键（或等价行为）结束编辑时，发送通知。
     UIControlEventAlltouchEvents
     通知所有触摸事件。
     UIControlEventAllEditingEvents
     通知所有关于文本编辑的事件。
     UIControlEventAllEvents
     通知所有事件。
     
     除了默认事件以外，自定义控件类还可以用0x0F000000到0x0FFFFFFF之间的值，来定义他们自己的时间。
     
     不直接创建这个类的实例。该控件的类是子类化一点，将实现自定义控件。也可以子类现有的控件类来扩展或修改它们的行为。例如，您可能会重写此类的方法来跟踪触摸事件本身或确定控件的状态更改时的状态。
     - (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(nullable UIEvent *)event;
     - (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(nullable UIEvent *)event;
     - (void)endTrackingWithTouch:(nullable UITouch *)touch withEvent:(nullable UIEvent *)event;
     - (void)cancelTrackingWithEvent:(nullable UIEvent *)event;
     
     button.selected = YES;//UIButtonTypeSystems 失效
     
     //button.tracking该值指示控件是否当前跟踪触摸事件,当跟踪一个触摸事件正在进行中时，控件将此属性的值设置为“YES”。当跟踪结束或取消任何原因，它将此属性设置为NO
     
     //button.touchInside,该值指示是否跟踪的触摸事件是目前在控制的范围内。虽然跟踪一个触摸事件正在进行中，控制更新这个属性的值，以指示是否最近的触摸仍然在控制的范围内。控件使用此信息触发特定事件。例如，触摸事件进入或退出一个控制触发适当的拖动事件。
     
     */
    NSLog(@"//*/*/*%ld,%d,%d",button.state,button.tracking,button.touchInside);
    

}

#pragma mark 基础控件UIView
-(void)viewview{
    
//
    //1.Initializing a View Object
    UIView * v = [[UIView alloc]initWithFrame: CGRectMake(100, 100, 100, 100)];
    [self.view addSubview:v];
    
    //2.Configuring a View’s Visual Appearance
    v.backgroundColor =[UIColor redColor];
    //    v.hidden = YES;//效果是一样的，使用hidden性能较高。
    //    v.alpha = 0.5;//更改alpha，默认是有动画效果的
    //    v.opaque = NO;//（UIView的默认值是YES，但UIButton等子类的默认值都是NO。）（它却决定不了当前UIView是不是不透明）.R = S + D * ( 1 – Sa )当UIView的opaque属性被设为YES以后Sa = 1,GPU将不会做任何的计算合成，不需要考虑它下方的任何东西(因为都被它遮挡住了)，而是简单从这个层拷贝。这节省了GPU相当大的工作量。由此看来，opaque属性的真实用处是给绘图系统提供一个性能优化开关！(动态下优化)为了程序的性能，尽可能的将view设置为opaque = YES! alpha ＝ 1 -> opaque = YES  opaque = NO -> alpha < 1.0
    //    v.layer.opacity = 0.5;//1、opacity会影响自己的透明度，同时也会影响subLayer的透明度。  2??opacity设为空之后，CALayer不会从响应者链中移除，仍然可以收到event。
//    v.clipsToBounds = YES;//是否裁剪超出边界的视图
    
    //    v.tintColor = [UIColor redColor];//想指定整个App的tint color，则可以通过设置window的tint color。这样同一个window下的所有子视图都会继承此tint color。可以在自定义视图中重写tintColorDidChange方法来执行我们想要的操作。
    //    v.tintAdjustmentMode = UIViewTintAdjustmentModeDimmed;
    v.clearsContextBeforeDrawing = NO;//是否清除缓冲区中不可见内容，默认为YES，如果在一个滚动操作频繁的视图中，应该设为NO，以避免重新渲染，提升性能
    
    /*
     
     1.当一个view设置了maskView后，那么它只会显示与maskView重叠部分，即在此图中只会显示maskView部分(maskView跟view没有层次，可以理解maskView嵌在View里)
     
     2.可以这样理解，是将maskView每个point的alpha赋值给View的重叠部分相对应的point，这样view的重叠每个point都有个alpha值了，view重叠部分就可能显示多种透明色。由于maskView颜色的alpha为1.0，那么与view重叠部分的alpha也应该为1.0(即重叠部分没变化即白色)
     
     只透 Alpha？
     */
    
//    v.maskView  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];//// maskView并不能用addSubview来添加遮罩,这点千万注意
//    v.maskView.alpha = 0.1;
//    v.maskView.backgroundColor = [UIColor grayColor];
    
    
    
   //3. Configuring the Event-Related Behavior 改变这个属性可以动画。
   //v.userInteractionEnabled//在一个动画中，在动画中所涉及的所有视图都暂时禁用了用户交互，而不管这个属性中的值是。你可以通过指定UIViewAnimationOptionAllowUserInteraction允许用户在动画的同时与视图进行交互。。
    v.multipleTouchEnabled = YES;//当设置为“是”时，接收器接收与多个触摸序列相关联的所有触摸。当设置为NO时，接收器只接收一个多触摸序列中的第一个触摸事件。（多点交互）
    v.exclusiveTouch = YES;//将此属性设置为“是”会导致接收器阻止在同一窗口中的其他视图的触摸事件的传递。此属性的默认值是否定的。(排它)
    
    //Configuring the Bounds and Frame Rectangles
    
//    v.frame //在它的父视图坐标系统视图的位置和大小。  use bounds + center(父视图坐标系统0,0) instead.(中心点不会发生改变)
//    v.bounds//在自己的坐标系统中的视图的位置和大小。 bounds改变位置时(子视图的父视图坐标系统改变)，改变的是子视图的位置，自身没有影响；其实就是改变了本身的坐标系原点，默认本身坐标系的原点是左上角 bounds的大小改变时，当前视图的中心点不会发生改变，当前视图的大小发生改变，看起来效果就想缩放一样
    
    NSLog(@"%@",NSStringFromCGRect(v.bounds));
    
    NSLog(@"%@",NSStringFromCGRect(v.frame));
    
    NSLog(@"%@",NSStringFromCGPoint(v.center));

    [v addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeBounds:)]];
    
    
    //4.Managing the View Hierarchy
    //  - bringSubviewToFront:将指定的视图，it appears on top of its siblings.to the end of the array of views in the subviews
    //  - sendSubviewToBack:Moves the specified subview so that it appears behind its siblings.the beginning of the array of views in the subviews
    
    //  - insertSubview:atIndex:在其子视图属性插入数组的索引视图。视图索引从0开始，不能大于子视图的数量。
    
    //  - insertSubview:aboveSubview:It’s removed from its superview if it’s not a sibling of siblingSubview.
    
     NSLog(@"%d",[v isDescendantOfView:self.view]); //是否是self.view的后代
     NSLog(@"%ld",self.view.subviews.count);
    

    
    //4.Configuring the Resizing Behavior
    
//    v.contentMode = UIViewContentModeBottom;
    /*
     UIViewContentModeScaleAspectFit : 图片拉伸至完全显示在UIImageView里面为止（图片不会变形）
     UIViewContentModeScaleAspectFill :
     图片拉伸至 图片的宽度等于UIImageView的宽度 或者 图片的高度等于UIImageView的高度 为止
     
     UIViewContentModeRedraw : 调用了setNeedsDisplay方法时，就会将图片重新渲染
     
     UIViewContentModeCenter : 居中显示
     UIViewContentModeTop,
     UIViewContentModeBottom,
     UIViewContentModeLeft,
     UIViewContentModeRight,
     UIViewContentModeTopLeft,
     UIViewContentModeTopRight,
     UIViewContentModeBottomLeft,
     UIViewContentModeBottomRight,
     
     经验规律：
     1.凡是带有Scale单词的，图片会拉伸
     2.凡是带有Aspect单词的，图片会保持原来的宽高比，图片不会变形
     3.fill(没有空白)
     4.fit(完全显示)
     */
    
    
//    UIImageView *imv        = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"base"]];
//    NSLog(@"%@",NSStringFromCGRect(imv.frame));
//    imv.bounds              = CGRectMake(0, 0, 100, 100);//(中心点(123.5,130)不会发生改变)
//    [v addSubview:imv];

//    {
//        UIImageView *imv = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"base"]];
//        imv.frame = CGRectMake(0, 0, 300, 300);
//        imv.contentMode = UIViewContentModeBottomLeft;
//        [v addSubview:imv];
//    }
    
//    v.autoresizesSubviews   = NO;//操作imv (父视图autoresizesSubviews与autoresizingMask)
//    imv.autoresizesSubviews = NO;//default YES
//    imv.autoresizingMask    = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    
    /*
         UIViewAutoresizingNone:就是不自动调整。
    
         UIViewAutoresizingFlexibleLeftMargin: 自动调整与superView左边的距离，保证与superView右边的距离不变。
    
         UIViewAutoresizingFlexibleRightMargin: 自动调整与superView的右边距离，保证与superView左边的距离不变。
    
         UIViewAutoresizingFlexibleTopMargin: 自动调整与superView顶部的距离，保证与superView底部的距离不变。
    
         UIViewAutoresizingFlexibleBottomMargin: 自动调整与superView底部的距离，也就是说，与superView顶部的距离不变。
    
         UIViewAutoresizingFlexibleWidth: 自动调整自己的宽度，保证与superView左边和右边的距离不变。
    
         UIViewAutoresizingFlexibleHeight: 自动调整自己的高度，保证与superView顶部和底部的距离不变。
    
         UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin: 自动调整与superView左边的距离，保证与左边的距离和右边的距离和原来距左边和右边的距离的比例不变。比如原来距离为20，30，调整后的距离应为68，102，即68/20=102/30。
     
     (1)、autoresizingMask缩放比例是UIKit内部计算的，开发者无法指定缩放比例的精确值。
     (2)、变化规则只能基于父子视图，无法解决兄弟视图之间的位置关系。所以在iOS6推出自动布局（Auto Layout）技术后，autoresizingMask成为一项鸡肋技术。可以用食之无味，弃之可惜来形容。
     
     */
    
    
    
    /*
    
     sizeToFit会自动调用sizeThatFits方法；不会改变控件的原始frame
     
     sizeToFit不应该在子类中被重写，应该重写sizeThatFits
     
     sizeThatFits传入的参数是receiver当前的size，返回一个适合的size
     
     sizeToFit可以被手动直接调用 会改变控件的原始frame 
     
     sizeToFit和sizeThatFits方法都没有递归，对subviews也不负责，只负责自己
     */

    
//Laying out Subviews
    //    layoutSubViews,setNeedsLayout,layoutIfNeeded -> HPopView
    
      NSLog(@"%d",[UIView requiresConstraintBasedLayout]);
    

//Managing the View’s Constraints
    
    //    constraints - addConstraint: - addConstraints: - removeConstraint: - removeConstraints://这种方法将在未来的版本中被弃用，应该避免。
    
    //   Instead set NSLayoutConstraint's active property to YES.    use +[NSLayoutConstraint activateConstraints:].   use +[NSLayoutConstraint deactivateConstraints:].
    
//  Triggering Auto Layout -> HPopView ????
/*
    //苹果代码实现Autolayout 1. layoutIfNeeded(立即更新，（手动调动，自动执行->))  2. setNeedsUpdateConstraints 标记需要更新，然后系统决定更新时机。（不会立即执行） -> updateConstraints（更新）->layout->display(显示，通过调用setNeedsDisplay触发)
    //第一步  默认的autoresizingMask代码和自动布局约束会冲突，设置为no，程序只有自动布局约束代码，避免冲突。
     v.translatesAutoresizingMaskIntoConstraints = NO;//Default YES -> 视图的autoresizingMask转化为自动布局约束。IB = NO
  
    //Autolayout里有两个词，约束，参照 要想显示一个控件，需要两个东西，位置，尺寸
    //第二步：设置约束，为了唯一确定视图的位置，我添加了四个约束  "view1.attr1 = view2.attr2 * multiplier(倍数) + constant(差值)"
  
    //优先级的范围是0~1000，数字越大，优先级越高，在不设置的情况下默认为1000 当优先级高的被抹除，优先级低的将实现  ->layoutIfNeeded
   
    NSLayoutConstraint *logoViewtopConstraint   = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTopMargin multiplier:1.0f constant:280];
    
    NSLayoutConstraint *logoViewcenterConstaint = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeftMargin multiplier:1.0f constant:0];
    
    NSLayoutConstraint *logoViewwidthConstaint  = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:0.5f constant:100];
    
    NSLayoutConstraint *logoViewhightConstaint  = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:kNilOptions multiplier:1.0f constant:100];
    
    
    // 第三步：添加约束
    
    logoViewtopConstraint.active   = YES;
    
    logoViewcenterConstaint.active = YES;
    
    logoViewwidthConstaint.active  = YES;
    
    logoViewhightConstaint.active  = YES;*/
    
    
    /*
     //创建redView第一个约束，相对self.view的左边缘间距20
     NSLayoutConstraint * redLeftLc = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeLeftMargin relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0f constant:20.0];
     //只有在没有参照控件的情况下，约束才加到自身，不然加到父控件上
     [self.view addConstraint:redLeftLc];
     //创建redView第二个约束，相对self。view的底边缘间距20
     NSLayoutConstraint *redBottomLc = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottomMargin multiplier:1.0f constant:-20];//由于是redview相对self.view往上减20，所以是-20
     //添加约束
     [self.view addConstraint:redBottomLc];
     //创建redView第三个约束，设置自身宽，宽可以参照其他控件设置，比如是self.view宽的一半,则应该这样写
     
     //     [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:0.5f constant:0.0];
     
     //这里直接设置自身宽为50
     NSLayoutConstraint * redWLc = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:kNilOptions multiplier:1.0f constant:250.0f];
     //由于没有参照物，所以约束添加于自身身上
     [v addConstraint:redWLc];
     //创建最后一个约束，自身的高
     NSLayoutConstraint * redHLc = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:kNilOptions multiplier:1.0f constant:250];
     //由于没有参照物，所以约束添加于自身身上
     [v addConstraint:redHLc];
     
     */

    
    /*
//    VFL:Visual Format Language,可视化格式语言,能直观又简单的创建约束,缺点是不能表达所有的约束。用法举例：
    
//    第一步：autoresizingMask设置为NO。
    
      v.translatesAutoresizingMaskIntoConstraints = NO;
    
//    第二步：使用VFL添加约束
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-80-[v]" options:NSLayoutFormatAlignAllLeft metrics:nil views:@{@"v":v}]];
    
//    语法是这样的，H表示横向 V表示竖向 | 表示父视图 [视图名字]表示视图 -表示 间距  -间距- 表示设置其他间距 [视图名字(设置视图的宽高)]
    
//    参数含义如下 : VisualFormat:VFL语句 options:基于哪一个选项（基于哪个方向去计算布局） metrics：绑定数值（NSNumber） 与字符串 views：绑定视图 与字符串
    
//    NSDictionaryOfVariableBindings：是一个宏，方便我们构建字典，NSDictionaryOfVariableBindings(logoView)就等于@{@”logoView”: logoView}。
    
//    另外需要注意一些精简写法（1）、省略：也就是说如果间距为0则不用明确写出，所以@”H:|-0-[logoView]-0-|”可以精简为@”H:|[logoView]|”
    
//    （2）、合并：例如@"H:[password]-20-[tfPassword]"和@"[tfPassword]-40-|"可以合并为@"H:[password]-20-[tfPassword]-40-|"
    */
    
//    Masonry：第一步：声明为__weak,因为我们后面要使用block，以防内存问题。
    
//    __weak typeof(self) weakself = self;
    
//    第二步：添加约束。
    
//    NSLog(@"***%@",[v mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.centerX.equalTo(weakself.view);
//        
//        make.top.mas_equalTo(20).mas_equalTo(10).mas_equalTo(300);
//        
//        make.width.mas_equalTo(weakself.view.bounds.size.width*0.5);
//        
//        make.height.mas_equalTo(weakself.view.bounds.size.height*0.5); }]);
    
    
//    Masonry用法比较简单，需要注意的地方主要有两点 注意点（1)： 使用 mas_makeConstraints方法的元素必须事先添加到父元素的中，例如[self.view addSubview:view];  注意点（2)： masequalTo 和 equalTo 区别：masequalTo 比equalTo多了类型转换操作，一般来说，大多数时候两个方法都是 通用的，但是对于数值元素使用mas_equalTo。对于对象或是多个属性的处理，使用equalTo。特别是多个属性时，必须使用equalTo,例如 make.left.and.right.equalTo(self.view);另外，在Masonry中，and,with都没有具体操作，仅仅是为了提高程序的可读性
    
    
      NSLog(@"%ld",v.constraints.count);
      NSLog(@"%ld",self.view.constraints.count);
    /*
    //原本需要一个空的UIView占位的地方，现在只需要用UILayoutGuide去替代它就可以了。iOS9
      UIView * v2 = [[UIView alloc]init];
      UILayoutGuide * layoutGuideA = [[UILayoutGuide alloc]init];
      UILayoutGuide * layoutGuideB = [[UILayoutGuide alloc]init];
     [self.view addSubview:v2];
      [v2 addLayoutGuide:layoutGuideA];
      [v2 addLayoutGuide:layoutGuideB];
    
      [layoutGuideA.heightAnchor constraintEqualToConstant:300].active = YES;
      [layoutGuideA.widthAnchor constraintEqualToConstant:100].active = YES;
      [layoutGuideA.bottomAnchor constraintEqualToAnchor:layoutGuideB.bottomAnchor constant:10].active = YES;
      [layoutGuideA.centerXAnchor constraintEqualToAnchor:layoutGuideB.centerXAnchor constant:10].active = YES;
      NSLog(@"%@",NSStringFromCGRect(layoutGuideA.layoutFrame));*/
    
    
    //iOS9开始我们可以使用一些简短紧凑的语法来描述AutoLayout，我们把关注点从约束转移到了描述约束关系的属性。Creating Constraints Using Layout Anchors
     v.translatesAutoresizingMaskIntoConstraints = NO;
    
     NSLog(@"%@",self.view.bottomAnchor);

    [v.heightAnchor constraintEqualToConstant: 100].active = YES;
    [v.widthAnchor constraintEqualToConstant: 10].active  = YES;
    
    [v.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:0].active = YES;
    
//  [v.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:10].active = YES;
//
    [v.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-25].active = YES;
    
    
    /*
     （2）内边距和内边界——margins和margins guides
     内边距就是view的边界到子视图的最小距离，这个不多说。
     UIViewController有两个与内边距有关的属性，一个叫layoutMargins，一个叫layoutMarginsGuide。layoutMargins就是内边距的大小。layoutMarginsGuide指的就是内边界。
     在写约束的时候，通常都是相对于内边界。默认的内边距大小是8个点。
     （3）文本边界——readable Content Guides
     UIViewController有一个与文本的边界有关的属性readableContentGuide。指的就是文本可以显示的最大的区域的边界。通常情况下，这个边界和内边界不会有太大的区别，只有在pad横屏的时候会有比较明显的区别。必要时，可以选择让布局相对于这个文本边界，而不相对于内边界。
     （1）不用view的frame、bounds、center来指定view的形状
     （2）尽可能地使用stackView来布局
     （3）约束尽量建立在view和其相邻view之间
     （4）避免给view指定固定的长和宽
     （5）自动更新view的frame时要留心，尤其是对于约束条件不足的view。
     （6）view的命名要有意义，方便布局时认得它们。
     （7）使用leading和trailing约束，不要用left和right。
     （8）在写相对于view边界的约束的时候，分两种情况：
     水平方向上的约束：对于大多数的控件，约束应该相对于根视图的内边界
     对于像小说阅读器这样文字布满屏幕的情况，约束应该相对于文本边界。
     对于需要铺满根视图宽度的视图，约束可以相对于根视图的边界。
     垂直方向上的约束：如果根视图有被导航栏、tabBar等部分遮挡了，那么约束应该相对于top margin和bottom margin。
     （9）在使用autolayout来布局那些用代码创建的view的时候，要把他们的translatesAutoresizingMaskIntoConstraints属性设置为NO。这个属性如果设为YES，系统会自动为这些view生成一些约束，这些约束可能会和我们设置的约束产生冲突。
     
     */
    NSLog(@"%@",NSStringFromCGRect(v.frame));
    
    NSLog(@"%ld",v.constraints.count);
    
    NSLog(@"%ld",self.view.constraints.count);
    
    NSLog(@"%@",self.view.readableContentGuide);
    
    NSLog(@"%@",NSStringFromCGSize([self.view systemLayoutSizeFittingSize:CGSizeZero]));
    
    NSLog(@"%@",NSStringFromCGSize(self.view.intrinsicContentSize));
    
    NSLog(@"%@",NSStringFromCGRect([[UIScreen mainScreen]applicationFrame]));
}

-(void)changeBounds:(UITapGestureRecognizer *)tap{
    
      [UIView animateWithDuration:15.f animations:^{
        tap.view.bounds = CGRectMake(0, 0, 200, 200);
        NSLog(@"%@",NSStringFromCGRect(tap.view.frame));//tap.view.frame发生变化
        
//        [NSLayoutConstraint constraintWithItem:tap.view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:0.1f constant:100].active = YES;

        //主要用于形变，位移和旋转，可用于动画展示
        /*
         以下三点结论基于未旋转的情况：
         1.当参数x>0 && x<=M_PI时,为顺时针
         2.当参数x>-M_PI && x<0时,为逆时针
         3.若参数x<M_PI || x>2.0*M_PI时,则旋转方向等同于x%2的旋转方向
         总结：旋转方向就是向最短路径方向旋转
         */
//        tap.view.transform = CGAffineTransformMakeRotation(M_PI);// 顺时针旋转180度
        
//        tap.view.transform = CGAffineTransformMakeScale(0.2, 0.2);
//
//        tap.view.transform = CGAffineTransformMakeTranslation(4, 6);//xy移动距离
//        
//          tap.view.transform = CGAffineTransformMake(0, 1, 6, 1, 2, 1);//自定义形变,参数自拟，下边会详细描述
    } completion:^(BOOL finished) {
        // 如果形变后想恢复可使用
        tap.view.transform = CGAffineTransformIdentity;
    }];
    
   

}
- (void)addMaskView {

    /*
     CGFloat width = 60;
     
     UIImageView *addImageView= [[UIImageView alloc] initWithFrame:CGRectMake(200, 200 , width, width)];
     
     [self.view addSubview: addImageView];
     
     addImageView.image = [UIImage imageNamed:@"选中"];
     
     UIImageView *mask = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, width)];
     
     mask.image = [UIImage imageNamed:@"world_1"];
     
     addImageView.maskView = mask;*/
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *baseGround = [[UIImageView alloc] initWithFrame:CGRectMake(20, 350, 200, 200)];
    baseGround.image        = [UIImage imageNamed:@"base"];
    [self.view addSubview: baseGround];
    
    
    UIImageView *upGround   = [[UIImageView alloc] initWithFrame:baseGround.frame];
    upGround.image          = [UIImage imageNamed:@"background"];
    [self.view addSubview:upGround];
    
    
    UIView *mask            = [[UIView alloc] initWithFrame:upGround.bounds];
    upGround.maskView       = mask;
    
//    UIImageView *picOne     = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
//    picOne.image            = [UIImage createImageWithColor:[UIColor whiteColor]];
//    [mask addSubview:picOne];
    
    
    
    UIImageView *picOne     = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 400)];
    picOne.image            = [UIImage imageNamed:@"mask1"];
    [mask addSubview:picOne];
    
    UIImageView *picTwo     = [[UIImageView alloc] initWithFrame:CGRectMake(100, -200, 100, 400)];
    picTwo.image            = [UIImage imageNamed:@"mask"];
    [mask addSubview:picTwo];

    [UIView animateWithDuration:5.f delay:5.f options:0 animations:^{
//        upGround.alpha = 0;
//        mask.alpha = 0.0;
        picOne.Y -= 400;
        picTwo.Y += 400;
    } completion:^(BOOL finished) {
        
    }];

//    mask默认色为透明(clearColor),如果picOne和picTwo不存在时，由于mask是透明，切mask又是upGround的maskView，则upGround也会透明，即效果图只会看到baseGround
    

}
#pragma mark 基础控件UILabel
-(void)addLabel:(CGPoint)point andName:(NSString *)name{
    
    {
        UILabel *label                  = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        label.layer.borderWidth         = 1.f;
        CGPoint point                   = self.view.center;
        point.y                         = 200;
        point.x                         = 260;
        label.center                    = point;
        label.text                      = @"YouXianMing NoZuoNoDie";
        //        label.textAlignment             = NSTextAlignmentCenter;
        label.highlightedTextColor      = [UIColor whiteColor];//default is nil
        label.highlighted               = YES;//default is NO
        label.adjustsFontSizeToFitWidth = YES;
        label.baselineAdjustment        = UIBaselineAdjustmentNone;
        //        label.lineBreakMode             = NSLineBreakByCharWrapping;//***!!!
        // UIBaselineAdjustmentAlignBaselines = 0, 默认值文本最上端于label中线对齐
        // UIBaselineAdjustmentAlignCenters,//文本中线于label中线对齐
        // UIBaselineAdjustmentNone,//文本最低端与label中线对齐
        [self.view addSubview:label];
    }
    
    {
        UILabel * label                 = [[UILabel alloc]initWithFrame:CGRectMake(point.x, point.y, 30, 30)];
        label.text                      = name;
        label.backgroundColor           = kMainFontColor;
        
        
        label.highlightedTextColor      = [UIColor whiteColor];//default is nil
        label.highlighted               = YES;//default is NO
        
        //        label.textAlignment             = NSTextAlignmentCenter;
        //        label.adjustsFontSizeToFitWidth =YES;
        //        label.baselineAdjustment        = UIBaselineAdjustmentAlignCenters;
        
        //    label.minimumScaleFactor = 1;
        label.numberOfLines             = 4;
        
        label.lineBreakMode             = NSLineBreakByWordWrapping;//default is NSLineBreakByTruncatingTail. used for single and multiple lines of text
        [label sizeToFit];
        [self.view addSubview:label];
        NSLog(@"%@",label.font);//(system font 17 plain)
        
        NSLog(@"%@",NSStringFromCGSize(label.shadowOffset));//default is CGSizeMake(0, -1) -- a top shadow
        
        NSLog(@"%ld",label.textAlignment);//default is NSTextAlignmentNatural (before iOS 9, the default was NSTextAlignmentLeft)
        
        /*
         当文本内容很多，label无法全部显示时label会将文本内容以省略号的方式代替，下面说一下label文本省略方式的设置
         // NSParagraphStyle
         typedef NS_ENUM(NSInteger, NSLineBreakMode) {
         NSLineBreakByWordWrapping = 0,     	// width>Word保留单词 else换行（不到一个单词移除）
         NSLineBreakByCharWrapping,		// Wrap at character boundaries保留整个字符(不到一个字符移除)
         NSLineBreakByClipping,		// Simply clip 以边界为止
         NSLineBreakByTruncatingHead,	// Truncate at head of line: "...wxyz"
         NSLineBreakByTruncatingTail,	// Truncate at tail of line: "abcd..."
         NSLineBreakByTruncatingMiddle	// Truncate middle of line:  "ab...yz"
         } NS_ENUM_AVAILABLE(10_0, 6_0);
         
         当需要设置的行数为不限数量的时候可以用numberOfLines=0实现
         当label大小使用sizeToFit方法，调整大小时会考虑到该属性中存储的值。例如，如果此属性设置为3，sizeToFit方法会调整label使它大到足以显示三行文本。
         
         实现文本多行显示
         Label.lineBreakMode = NSLineBreakByCharWrapping;
         Label.numberOfLines = 0;
         
         文本自动根据label大小自动调整字体尺寸
         label.numberOfLines =1;
         label.adjustsFontSizeToFitWidth =YES;
         label.minimumScaleFactor = 0.0;
         adjustFontSizeToFitWidth方法可实现文本自动根据label大小自动调整字体尺寸，直到文本的大小达到了自己设置的label文本尺寸最大、最小值与字符串的最大最小值，要是用这个方法还有一个很大的限制就是只有在numberOfLines设置为1时才能用,label.lineBreakMode对baselineAdjustment有影响
         
         
         #pragma mark=====UILabel的另一种展现形式--富文本====  NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithString:text];
         
         这个属性是用来设置多行label的最大宽度的
         当自动布局的时候约束这个label的时候这个属性会起作用
         在自动布局添加约束中，若文本超过了指定的最大宽度的时候 文本会另起一行 从而增加了label的高度
         label.preferredMaxLayoutWidth = 20;
         
         allowsDefaultTighteningForTruncation??
         
         */
        
    }
}
-(void)goPopview{
    
    BasicMainVC_one * one = [[BasicMainVC_one alloc]init];
    UINavigationController * nvc = [[UINavigationController alloc]initWithRootViewController:one];
    [self presentViewController:nvc animated:YES completion:nil];
}

@end
