//
//  HPopView.m
//  BasicFramework
//
//  Created by mr-tech on 16/10/17.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import "HPopView.h"
#import <QuartzCore/QuartzCore.h>
@interface HPopView(){
    UILabel * label;
    NSString * labelName;
}

@property (strong, nonatomic) UIDynamicAnimator *animator;
@property (strong, nonatomic)UIAttachmentBehavior * panAttachmentBehaviour;
@end
@implementation HPopView
-(BOOL)canBecomeFirstResponder {
    return YES;
}
-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    
//    if(event.type == UIEventTypeMotion && event.subtype == UIEventSubtypeMotionShake)
//        [self shake];
}




// 只有在添加了约束的情况下，系统才会自动调用 -updateConstraints 方法，如果把所有的约束放在 updateConstraints中，那么系统将会不知道你的布局方式是基于约束的，所以 重写+requiresConstraintBasedLayout 返回YES就是明确告诉系统：虽然我之前没有添加约束,但我确实是基于约束的布局！这样可以保证系统一定会调用 -updateConstraints 方法 从而正确添加约束.
+ (BOOL)requiresConstraintBasedLayout//1
{
    return NO;
}
//-(BOOL)needsUpdateConstraints{//2
//    return YES;
//}

// 1.initFrame -> requiresConstraintBasedLayout
// 2.yes : addSubView:self -> updateConstraints (needsUpdateConstraints = yes no)
//   no  : addSubView:self ->needsUpdateConstraints(no) -> requiresConstraintBasedLayout -> updateConstraints
//   no  : addSubView:self ->needsUpdateConstraints(yes) -> requiresConstraintBasedLayout -> updateConstraints


-(void)updateConstraints{//3
    //code...
    NSLog(@"updateConstraints");
    [super updateConstraints];
}





/**
 刷新子对象布局
 任何时候，当视图的布局发生改变时，UIKit 会激活每个视图的自动尺寸调整行为，然后调用各自的 layoutSubviews 方法，使您有机会进一步调整子视图的几何尺寸。
 
 当我们在某个类的内部调整子视图位置时，需要调用 layoutSubviews在以下情况下会被调用：
 
 
 1、init初始化不会触发layoutSubviews。
 
 2、addSubview会触发layoutSubviews。
 
 3、设置view的Frame会触发layoutSubviews，当然前提是frame的值设置前后发生了变化。
 
 4、滚动一个UIScrollView会触发layoutSubviews。
 
 5、旋转Screen会触发父UIView上的layoutSubviews事件。
 
 6、改变一个UIView大小的时候也会触发父UIView上的layoutSubviews事件。
 
 7、直接调用setLayoutSubviews。标记为需要重新布局，异步调用layoutIfNeeded刷新布局，不立即刷新,但layoutSubviews一定会被调用
 
 8、直接调用setNeedsLayout。如果有需要刷新的标记，立即调用layoutSubviews进行布局（如果没有标记，不会调用layoutSubviews）
 
 ***立即刷新，要先调用[view setNeedsLayout]，把标记设为需要布局，然后马上调用[view layoutIfNeeded]，实现布局.在视图第一次显示之前，标记总是“需要刷新”的，可以直接调用[view layoutIfNeeded]
 */

-(void)layoutSubviews{//4
    //-layoutSubviews方法：这个方法，默认没有做任何事情，需要子类进行重写
    [super layoutSubviews];
    label.backgroundColor = [UIColor yellowColor];
    labelName = [NSString stringWithFormat:@"%@->layoutSubviews",labelName];
    label.text = labelName;
    label.frame = CGRectMake(0, 0, 150, 30);
    [label sizeToFit];
    NSLog(@"调用了layoutSubviews 方法");
}

/*  drawRect在以下情况下会被调用：
 
 1***、如果在UIView初始化时没有设置rect大小，将直接导致drawRect不被自动调用。drawRect 调用是在Controller->loadView, Controller->viewDidLoad 两方法之后掉用的.所以不用担心在 控制器中,这些View的drawRect就开始画了.这样可以在控制器中设置一些值给View(如果这些View draw的时候需要用到某些变量值).
 2、该方法在调用sizeToFit后被调用，所以可以先调用sizeToFit计算出size。然后系统自动调用drawRect:方法。
 
 3、通过设置contentMode属性值为UIViewContentModeRedraw。那么将在每次设置或更改frame的时候自动调用drawRect:。
 
 4、直接调用setNeedsDisplay，或者setNeedsDisplayInRect:触发drawRect:，但是有个前提条件是rect不能为0。
 
 -setNeedsDisplay方法：标记为需要重绘，异步调用drawRect
 -setNeedsDisplayInRect:(CGRect)invalidRect方法：标记为需要局部重绘
 以上1,2推荐；而3,4不提倡
 
 
 drawRect方法使用注意点：
 
 1、 若使用UIView绘图，只能在drawRect：方法中获取相应的contextRef并绘图。如果在其他方法中获取将获取到一个invalidate 的ref并且不能用于画图。drawRect：方法不能手动显示调用，必须通过调用setNeedsDisplay 或者 setNeedsDisplayInRect，让系统自动调该方法。
 
 2、若使用calayer绘图，只能在drawInContext: 中（类似drawRect）绘制，或者在delegate中的相应方法绘制。同样也是调用setNeedDisplay等间接调用以上方法
 
 3、若要实时画图，不能使用gestureRecognizer，只能使用touchbegan等方法来掉用setNeedsDisplay实时刷新屏幕
 
 layoutSubviews对subviews重新布局
 layoutSubviews方法调用先于drawRect
 setNeedsLayout在receiver标上一个需要被重新布局的标记，在系统runloop的下一个周期自动调用layoutSubviews
 layoutIfNeeded遍历的不是superview链，应该是subviews链
 drawRect是对receiver的重绘，能获得context
 setNeedDisplay在receiver标上一个需要被重新绘图的标记，在下一个draw周期自动重绘，iphone device的刷新频率是60hz，也就是1/60秒后重绘
 An empty implementation adversely affects performance during animation.
 */
- (void)drawRect:(CGRect)rect {//5
    // Drawing code
    labelName = [NSString stringWithFormat:@"%@->drawRect",labelName];
    label.text = labelName;
    NSLog(@"drawRect");
    label.frame = CGRectMake(0, 0, 150, 40);
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.backgroundColor = [UIColor whiteColor];
        label = [[UILabel alloc] init];
        labelName = @"initWithFrame";
        [self addSubview:label];
    }
    
    return self;
}
-(id)init{
    self = [super init];
    if (self) {

        self.backgroundColor = [UIColor whiteColor];
        label = [[UILabel alloc] init];
        labelName = @"initWithFrame";
        [self addSubview:label];
    }
    
    return self;
}

-(void)show{
    [self addToSuperview];
}
//    [self addSubviewsWithOverlay:YES];
//
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hide) name:@"TAlertViewHideAllNotificationKey" object:nil];
//    
//    [self becomeFirstResponder];
//    
//     _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self];
//    
//     UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[_titleLabel]];
//    [_animator addBehavior:gravityBehavior];
//    
//    UICollisionBehavior *groundCollisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[_titleLabel]];
//    [groundCollisionBehavior addBoundaryWithIdentifier:@"ground"
//                                             fromPoint:CGPointMake(CGRectGetMinX(self.frame), CGRectGetMidY(self.frame))
//                                               toPoint:CGPointMake(CGRectGetMaxX(self.frame), CGRectGetMidY(self.frame))];
//    [_animator addBehavior:groundCollisionBehavior];
//    
//    UICollisionBehavior *wall1CollisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[_titleLabel]];
//    [wall1CollisionBehavior addBoundaryWithIdentifier:@"wall1"
//                                            fromPoint:CGPointMake(0, 0)
//                                              toPoint:CGPointMake(0, CGRectGetMaxY(self.frame))];
//    [_animator addBehavior:wall1CollisionBehavior];
//    
//    UICollisionBehavior *wall2CollisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[_titleLabel]];
//    [wall2CollisionBehavior addBoundaryWithIdentifier:@"wall2"
//                                            fromPoint:CGPointMake(CGRectGetMaxX(self.frame), 0)
//                                              toPoint:CGPointMake(CGRectGetMaxX(self.frame), CGRectGetMaxY(self.frame))];
//    [_animator addBehavior:wall2CollisionBehavior];
//    
//    UIDynamicItemBehavior *alertViewBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[_titleLabel]];
//    alertViewBehavior.elasticity = 0.10;
//    CGFloat angularVelocity = (((float)rand() / RAND_MAX)-0.5f)*0.4f;
//    [alertViewBehavior addAngularVelocity:angularVelocity forItem:_titleLabel];
//    [_animator addBehavior:alertViewBehavior];
//    
//    UIPushBehavior *pushBehavior = [[UIPushBehavior alloc] initWithItems:@[_titleLabel] mode:UIPushBehaviorModeInstantaneous];
//    pushBehavior.pushDirection = CGVectorMake(0.0f, 15.0f);
//    [_animator addBehavior:pushBehavior];
//    pushBehavior.active = YES;
//    
//    [UIView animateWithDuration:0.4f
//                          delay:0
//                        options:UIViewAnimationOptionCurveEaseIn
//                     animations:^{
//                         self.alpha = 1.0f;
//                     }
//                     completion:^(BOOL finished) { }];
//    __weak HPopView *weakSelf = self;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [weakSelf hide];
//    });
//    
//}
//-(void)addSubviewsWithOverlay:(BOOL)withOverlay{
//    
//    UIColor *titleColor = [UIColor blackColor];
//    NSString *defaultTitle = nil;
//    
// 
//    titleColor = [UIColor redColor];
//    defaultTitle = @"Oops...";
//
//    self.frame = [UIScreen mainScreen].bounds;
//    self.backgroundColor = withOverlay ? [UIColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:0.6f] : [UIColor clearColor];
//    
//    CGFloat insideHorisontalMargin = self.frame.size.width/15.0f;
//    CGFloat insideVerticalMargin = self.frame.size.height/75.0f;
//    CGFloat outsideMargin = self.frame.size.width/12.0f;
//    
//    CGRect aletViewFrame = CGRectMake(outsideMargin, outsideMargin * 4, self.frame.size.width - (2*outsideMargin), 0);
//    
//    _titleLabel = [[UILabel alloc] initWithFrame:aletViewFrame];
//    _titleLabel.backgroundColor = [UIColor whiteColor];
//    _titleLabel.layer.cornerRadius = 5;
//     [_titleLabel setText:@"文字效果"];
//    [_titleLabel addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(aletViewPanGesture:)]];
//    [self addSubview:_titleLabel];
//    
//    CGFloat yPos = insideVerticalMargin;
//    
//    aletViewFrame.size.height = yPos;
//    _titleLabel.frame = aletViewFrame;
//    
//}
-(void)addToSuperview{
    id appDelegate = [[UIApplication sharedApplication] delegate];
    if ([appDelegate respondsToSelector:@selector(window)]) {
        UIWindow * window = (UIWindow *) [appDelegate performSelector:@selector(window)];
        [window addSubview:self];
    }
}
//
//-(void)shake{
//    CGFloat angularVelocity = ((float)rand()/RAND_MAX)-0.5f;
//    UIDynamicItemBehavior *alertViewBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[_titleLabel]];
//    [alertViewBehavior addAngularVelocity:angularVelocity forItem:_titleLabel];
//    [_animator addBehavior:alertViewBehavior];
//    
//    UIPushBehavior *pushBehavior = [[UIPushBehavior alloc] initWithItems:@[_titleLabel] mode:UIPushBehaviorModeInstantaneous];
//    pushBehavior.magnitude = 0.0f;
//    pushBehavior.angle = 0.0f;
//    [_animator addBehavior:pushBehavior];
//    pushBehavior.pushDirection = CGVectorMake((((float)rand()/RAND_MAX)-0.5f)*20.0f, -10.0f -((float)rand()/RAND_MAX)*10.0f);
//    pushBehavior.active = YES;
//}
//-(void)aletViewPanGesture:(UIPanGestureRecognizer*)gestureRecognizer{
//
//        CGPoint location = [gestureRecognizer locationInView:self];
//        if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
//            for (id behavior in [_animator behaviors]) {
//                if ([behavior isKindOfClass:[UICollisionBehavior class]]) {
//                    [_animator removeBehavior:behavior];
//                }
//            }
//            CGPoint pointWithinAnimatedView = [gestureRecognizer locationInView:gestureRecognizer.view];
//            UIOffset offset = UIOffsetMake(pointWithinAnimatedView.x - gestureRecognizer.view.bounds.size.width / 2.0,
//                                           pointWithinAnimatedView.y - gestureRecognizer.view.bounds.size.height / 2.0);
//            _panAttachmentBehaviour = [[UIAttachmentBehavior alloc] initWithItem:_titleLabel offsetFromCenter:offset attachedToAnchor:location];
//            _panAttachmentBehaviour.damping = 0.5;
//            [_animator addBehavior:_panAttachmentBehaviour];
//        } else if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
//            _panAttachmentBehaviour.anchorPoint = location;
//        } else if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
//            [_animator removeBehavior:_panAttachmentBehaviour];
//            CGPoint velocity = [gestureRecognizer velocityInView:self];
//            UIPushBehavior *pushBehavior = [[UIPushBehavior alloc] initWithItems:@[_titleLabel] mode:UIPushBehaviorModeInstantaneous];
//            pushBehavior.pushDirection = CGVectorMake(velocity.x/80.0f, velocity.y/80.0f);
//            [_animator addBehavior:pushBehavior];
//            pushBehavior.active = YES;
//            
//            [self hide];
//        }
//    
//}
//-(void)hide{
//    
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//    [self resignFirstResponder];
//    
//  
//        for (id behavior in [_animator behaviors]) {
//            if ([behavior isKindOfClass:[UICollisionBehavior class]]) {
//                [_animator removeBehavior:behavior];
//            }
//        }
//        [UIView animateWithDuration:0.4f
//                              delay:0.3f
//                            options:UIViewAnimationOptionCurveEaseOut
//                         animations:^{
//                             self.alpha = 0.0f;
//                         } completion:^(BOOL finished) {
//                             [self removeFromSuperview];
//                         }];
//    
//    
//}

@end
