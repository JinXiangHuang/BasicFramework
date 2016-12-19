//关于UIScrollView不能响应UITouch事件的解决办法
//不管那个类有没有调用都重写了（这个方法全局都重写了）

#import "UIScrollView+UITouch.h"

@implementation UIScrollView (UITouch)



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self nextResponder] touchesBegan:touches withEvent:event];//父控件,也就是其SuperView或是UIViewConterller
//    [super touchesBegan:touches withEvent:event];//父类 -> 默认做法让父控件操作
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self nextResponder] touchesMoved:touches withEvent:event];
    [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self nextResponder] touchesEnded:touches withEvent:event];
    [super touchesEnded:touches withEvent:event];
}


@end
