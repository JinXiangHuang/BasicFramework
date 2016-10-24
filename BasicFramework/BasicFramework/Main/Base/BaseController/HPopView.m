//
//  HPopView.m
//  BasicFramework
//
//  Created by mr-tech on 16/10/17.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import "HPopView.h"
#import <QuartzCore/QuartzCore.h>
@interface HPopView()
@property (strong, nonatomic) UILabel * titleLabel;
@property (strong, nonatomic) UIDynamicAnimator *animator;
@property (strong, nonatomic)UIAttachmentBehavior * panAttachmentBehaviour;
@end
@implementation HPopView

//-(id)init{
//    if (self = [super init]) {
//        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
//        _titleLabel.backgroundColor = [UIColor blackColor];
//         [self addSubview:_titleLabel];
//    }
//    
//    return self;
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)show
{

    [self addSubviewsWithOverlay:YES];
    [self addToSuperview];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hide) name:@"TAlertViewHideAllNotificationKey" object:nil];
    
    [self becomeFirstResponder];
    
     _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self];
    
     UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[_titleLabel]];
    [_animator addBehavior:gravityBehavior];
    
    UICollisionBehavior *groundCollisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[_titleLabel]];
    [groundCollisionBehavior addBoundaryWithIdentifier:@"ground"
                                             fromPoint:CGPointMake(CGRectGetMinX(self.frame), CGRectGetMidY(self.frame))
                                               toPoint:CGPointMake(CGRectGetMaxX(self.frame), CGRectGetMidY(self.frame))];
    [_animator addBehavior:groundCollisionBehavior];
    
    UICollisionBehavior *wall1CollisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[_titleLabel]];
    [wall1CollisionBehavior addBoundaryWithIdentifier:@"wall1"
                                            fromPoint:CGPointMake(0, 0)
                                              toPoint:CGPointMake(0, CGRectGetMaxY(self.frame))];
    [_animator addBehavior:wall1CollisionBehavior];
    
    UICollisionBehavior *wall2CollisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[_titleLabel]];
    [wall2CollisionBehavior addBoundaryWithIdentifier:@"wall2"
                                            fromPoint:CGPointMake(CGRectGetMaxX(self.frame), 0)
                                              toPoint:CGPointMake(CGRectGetMaxX(self.frame), CGRectGetMaxY(self.frame))];
    [_animator addBehavior:wall2CollisionBehavior];
    
    UIDynamicItemBehavior *alertViewBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[_titleLabel]];
    alertViewBehavior.elasticity = 0.10;
    CGFloat angularVelocity = (((float)rand() / RAND_MAX)-0.5f)*0.4f;
    [alertViewBehavior addAngularVelocity:angularVelocity forItem:_titleLabel];
    [_animator addBehavior:alertViewBehavior];
    
    UIPushBehavior *pushBehavior = [[UIPushBehavior alloc] initWithItems:@[_titleLabel] mode:UIPushBehaviorModeInstantaneous];
    pushBehavior.pushDirection = CGVectorMake(0.0f, 15.0f);
    [_animator addBehavior:pushBehavior];
    pushBehavior.active = YES;
    
    [UIView animateWithDuration:0.4f
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.alpha = 1.0f;
                     }
                     completion:^(BOOL finished) { }];
    __weak HPopView *weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf hide];
    });
    
}

-(void)addSubviewsWithOverlay:(BOOL)withOverlay
{
    
    UIColor *titleColor = [UIColor blackColor];
    NSString *defaultTitle = nil;
    
 
    titleColor = [UIColor redColor];
    defaultTitle = @"Oops...";

    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = withOverlay ? [UIColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:0.6f] : [UIColor clearColor];
    
    CGFloat insideHorisontalMargin = self.frame.size.width/15.0f;
    CGFloat insideVerticalMargin = self.frame.size.height/75.0f;
    CGFloat outsideMargin = self.frame.size.width/12.0f;
    
    CGRect aletViewFrame = CGRectMake(outsideMargin, outsideMargin * 4, self.frame.size.width - (2*outsideMargin), 0);
    
    _titleLabel = [[UILabel alloc] initWithFrame:aletViewFrame];
    _titleLabel.backgroundColor = [UIColor whiteColor];
    _titleLabel.layer.cornerRadius = 5;
     [_titleLabel setText:@"文字效果"];
    [_titleLabel addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(aletViewPanGesture:)]];
    [self addSubview:_titleLabel];
    
    CGFloat yPos = insideVerticalMargin;
    
    aletViewFrame.size.height = yPos;
    _titleLabel.frame = aletViewFrame;
    
}

-(void)addToSuperview
{
    id appDelegate = [[UIApplication sharedApplication] delegate];
    if ([appDelegate respondsToSelector:@selector(window)]) {
        UIWindow * window = (UIWindow *) [appDelegate performSelector:@selector(window)];
        [window addSubview:self];
    }
}

-(BOOL)canBecomeFirstResponder {
    return YES;
}
-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    
    if(event.type == UIEventTypeMotion && event.subtype == UIEventSubtypeMotionShake)
        [self shake];
}

-(void)shake
{
    CGFloat angularVelocity = ((float)rand()/RAND_MAX)-0.5f;
    UIDynamicItemBehavior *alertViewBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[_titleLabel]];
    [alertViewBehavior addAngularVelocity:angularVelocity forItem:_titleLabel];
    [_animator addBehavior:alertViewBehavior];
    
    UIPushBehavior *pushBehavior = [[UIPushBehavior alloc] initWithItems:@[_titleLabel] mode:UIPushBehaviorModeInstantaneous];
    pushBehavior.magnitude = 0.0f;
    pushBehavior.angle = 0.0f;
    [_animator addBehavior:pushBehavior];
    pushBehavior.pushDirection = CGVectorMake((((float)rand()/RAND_MAX)-0.5f)*20.0f, -10.0f -((float)rand()/RAND_MAX)*10.0f);
    pushBehavior.active = YES;
}

-(void)aletViewPanGesture:(UIPanGestureRecognizer*)gestureRecognizer
{

        CGPoint location = [gestureRecognizer locationInView:self];
        if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
            for (id behavior in [_animator behaviors]) {
                if ([behavior isKindOfClass:[UICollisionBehavior class]]) {
                    [_animator removeBehavior:behavior];
                }
            }
            CGPoint pointWithinAnimatedView = [gestureRecognizer locationInView:gestureRecognizer.view];
            UIOffset offset = UIOffsetMake(pointWithinAnimatedView.x - gestureRecognizer.view.bounds.size.width / 2.0,
                                           pointWithinAnimatedView.y - gestureRecognizer.view.bounds.size.height / 2.0);
            _panAttachmentBehaviour = [[UIAttachmentBehavior alloc] initWithItem:_titleLabel offsetFromCenter:offset attachedToAnchor:location];
            _panAttachmentBehaviour.damping = 0.5;
            [_animator addBehavior:_panAttachmentBehaviour];
        } else if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
            _panAttachmentBehaviour.anchorPoint = location;
        } else if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
            [_animator removeBehavior:_panAttachmentBehaviour];
            CGPoint velocity = [gestureRecognizer velocityInView:self];
            UIPushBehavior *pushBehavior = [[UIPushBehavior alloc] initWithItems:@[_titleLabel] mode:UIPushBehaviorModeInstantaneous];
            pushBehavior.pushDirection = CGVectorMake(velocity.x/80.0f, velocity.y/80.0f);
            [_animator addBehavior:pushBehavior];
            pushBehavior.active = YES;
            
            [self hide];
        }
    
}
-(void)hide
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self resignFirstResponder];
    
  
        for (id behavior in [_animator behaviors]) {
            if ([behavior isKindOfClass:[UICollisionBehavior class]]) {
                [_animator removeBehavior:behavior];
            }
        }
        [UIView animateWithDuration:0.4f
                              delay:0.3f
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             self.alpha = 0.0f;
                         } completion:^(BOOL finished) {
                             [self removeFromSuperview];
                         }];
    
    
}

@end
