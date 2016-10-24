//
//  HHLabel.m
//  BasicFramework
//
//  Created by mr-tech on 16/10/18.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import "HHLabel.h"
#import <QuartzCore/QuartzCore.h>

#define FRAMES_PER_SEC 10
static const CGFloat gradientWidth = 0.2;
static const CGFloat gradientDimAlpha = 0.5;
@interface HHLabel(){
     CAGradientLayer *gradient;
}

- (void) setGradientLocations:(CGFloat)leftEdge;
- (void) startTimer;
- (void) stopTimer;

@end

@implementation HHLabel
@synthesize animated = _animated;

- (BOOL) isAnimated {
    return _animated;
}

- (void) setAnimated:(BOOL)animated {
    if (_animated != animated) {
        _animated = animated;
        if (_animated) {
            [self startTimer];
        } else {
            [self stopTimer];
        }
    }
}

// animationTimer methods
- (void)animationTimerFired:(NSTimer*)theTimer {
    // Let the timer run for 2 * FPS rate before resetting.
    // This gives one second of sliding the highlight off to the right, plus one
    // additional second of uniform dimness
    if (++animationTimerCount == (2 * FRAMES_PER_SEC)) {
        animationTimerCount = 0;
    }
    
    // Update the gradient for the next frame
    [self setGradientLocations:((CGFloat)animationTimerCount/(CGFloat)FRAMES_PER_SEC)];
}

- (void) startTimer {
    if (!animationTimer) {
        animationTimerCount = 0;
        [self setGradientLocations:0];
        animationTimer = [NSTimer
                          scheduledTimerWithTimeInterval:1.0/FRAMES_PER_SEC
                          target:self
                          selector:@selector(animationTimerFired:)
                          userInfo:nil
                          repeats:YES];
    }
}

- (void) stopTimer {
    if (animationTimer) {
        [animationTimer invalidate];
        animationTimer = nil;
    }
}

- (void)drawLayer:(CALayer *)theLayer inContext:(CGContextRef)theContext
{
    // Note: due to use of kCGEncodingMacRoman, this code only works with Roman alphabets!
    // In order to support non-Roman alphabets, you need to add code generate glyphs,
    // and use CGContextShowGlyphsAtPoint
    //CGContextSelectFont(theContext, [self.font.fontName UTF8String], self.font.pointSize, kCGEncodingMacRoman);
    
    // Set Text Matrix
    CGContextSetTextMatrix(theContext, CGAffineTransformMake(1.0,  0.0,
                                                             0.0, -1.0,
                                                             0.0,  0.0));
    
    // Set Drawing Mode to clipping path, to clip the gradient created below
    CGContextSetTextDrawingMode (theContext, kCGTextClip);
    
    // Draw the label's text
    // 不支持中文
    //	const char *text = [self.text cStringUsingEncoding:NSMacOSRomanStringEncoding];
    //	CGContextShowTextAtPoint(theContext,
    //                             0,
    //                             (size_t)self.font.ascender,
    //                             text,
    //                             strlen(text));
    
    UIGraphicsPushContext(theContext);
    if ([[UIScreen mainScreen] bounds].size.height > 480.0f) {
        //        [self.text drawAtPoint:CGPointMake(0, (size_t)self.font.leading) withFont:[UIFont systemFontOfSize:self.font.pointSize]];
        NSDictionary *attrsDictionary =[NSDictionary dictionaryWithObjectsAndKeys:self.font,NSFontAttributeName,[NSNumber numberWithFloat:1.0], NSBaselineOffsetAttributeName, nil];
        [self.text drawAtPoint:CGPointMake(0, (size_t)self.font.leading) withAttributes:attrsDictionary];
    }else{
        //        [self.text drawAtPoint:CGPointMake(0, (size_t)self.font.leading-18) withFont:[UIFont systemFontOfSize:self.font.pointSize]];
        NSDictionary *attrsDictionary =[NSDictionary dictionaryWithObjectsAndKeys:self.font,NSFontAttributeName,[NSNumber numberWithFloat:1.0], NSBaselineOffsetAttributeName, nil];
        [self.text drawAtPoint:CGPointMake(0, (size_t)self.font.leading-18) withAttributes:attrsDictionary];
    }
    
    //NSFont *font = [NSFont fontWithName:@"Palatino-Roman" size:14.0];
    
    UIGraphicsPopContext();
    
    // Calculate text width
    CGPoint textEnd = CGContextGetTextPosition(theContext);
    
    // Get the foreground text color from the UILabel.
    // Note: UIColor color space may be either monochrome or RGB.
    // If monochrome, there are 2 components, including alpha.
    // If RGB, there are 4 components, including alpha.
    CGColorRef textColor = self.textColor.CGColor;
    const CGFloat *components = CGColorGetComponents(textColor);
    size_t numberOfComponents = CGColorGetNumberOfComponents(textColor);
    BOOL isRGB = (numberOfComponents == 4);
    CGFloat red = components[0];
    CGFloat green = isRGB ? components[1] : components[0];
    CGFloat blue = isRGB ? components[2] : components[0];
    CGFloat alpha = isRGB ? components[3] : components[1];
    
    // The gradient has 4 sections, whose relative positions are defined by
    // the "gradientLocations" array:
    // 1) from 0.0 to gradientLocations[0] (dim)
    // 2) from gradientLocations[0] to gradientLocations[1] (increasing brightness)
    // 3) from gradientLocations[1] to gradientLocations[2] (decreasing brightness)
    // 4) from gradientLocations[3] to 1.0 (dim)
    size_t num_locations = 3;
    
    // The gradientComponents array is a 4 x 3 matrix. Each row of the matrix
    // defines the R, G, B, and alpha values to be used by the corresponding
    // element of the gradientLocations array
    CGFloat gradientComponents[12];
    for (int row = 0; row < num_locations; row++) {
        int index = 4 * row;
        gradientComponents[index++] = red;
        gradientComponents[index++] = green;
        gradientComponents[index++] = blue;
        gradientComponents[index] = alpha * gradientDimAlpha;
    }
    
    // If animating, set the center of the gradient to be bright (maximum alpha)
    // Otherwise it stays dim (as set above) leaving the text at uniform
    // dim brightness
    if (animationTimer) {
        gradientComponents[7] = alpha;
    }
    
    // Load RGB Colorspace
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    
    // Create Gradient
    CGGradientRef gradient = CGGradientCreateWithColorComponents (colorspace, gradientComponents,
                                                                  gradientLocations, num_locations);
    // Draw the gradient (using label text as the clipping path)
    CGContextDrawLinearGradient (theContext, gradient, self.bounds.origin, textEnd, 0);
    
    // Cleanup
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorspace);
    
    
}

- (void) setGradientLocations:(CGFloat) leftEdge {
    // Subtract the gradient width to start the animation with the brightest
    // part (center) of the gradient at left edge of the label text
    leftEdge -= gradientWidth;
    
    //position the bright segment of the gradient, keeping all segments within the range 0..1
    gradientLocations[0] = leftEdge < 0.0 ? 0.0 : (leftEdge > 1.0 ? 1.0 : leftEdge);
    gradientLocations[1] = MIN(leftEdge + gradientWidth, 1.0);
    gradientLocations[2] = MIN(gradientLocations[1] + gradientWidth, 1.0);
    
    // Re-render the label text
    [self.layer setNeedsDisplay];
}
-(void)addLabel:(UIView *)view :(NSString *)text{
    // 创建UILabel
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    [label sizeToFit];
    label.center = CGPointMake(200, 100);
    // 疑问：label只是用来做文字裁剪，能否不添加到view上。
    // 必须要把Label添加到view上，如果不添加到view上，label的图层就不会调用drawRect方法绘制文字，也就没有文字裁剪了。
    // 如何验证，自定义Label,重写drawRect方法，看是否调用,发现不添加上去，就不会调用
    [view addSubview:label];
    
    
    // 创建渐变层
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    
    gradientLayer.frame = label.frame;
    // 设置渐变层的颜色，随机颜色渐变
    UIColor *randColor = [UIColor colorWithRed:arc4random()%255/256.0 green:arc4random()%255/256.0 blue:arc4random()%255/256.0 alpha:1];
    gradientLayer.colors = @[(id)randColor.CGColor, (id)randColor.CGColor,(id)randColor.CGColor];
    // 疑问:渐变层能不能加在label上
    // 不能，mask原理：默认会显示mask层底部的内容，如果渐变层放在mask层上，就不会显示了
    
    // 添加渐变层到控制器的view图层上
    [view.layer addSublayer:gradientLayer];
    
    
    // mask层工作原理:按照透明度裁剪，只保留非透明部分，文字就是非透明的，因此除了文字，其他都被裁剪掉，这样就只会显示文字下面渐变层的内容，相当于留了文字的区域，让渐变层去填充文字的颜色。
    // 设置渐变层的裁剪层
    gradientLayer.mask = label.layer;
    // 注意:一旦把label层设置为mask层，label层就不能显示了,会直接从父层中移除，然后作为渐变层的mask层，且label层的父层会指向渐变层，这样做的目的：以渐变层为坐标系，方便计算裁剪区域，如果以其他层为坐标系，还需要做点的转换，需要把别的坐标系上的点，转换成自己坐标系上点，判断当前点在不在裁剪范围内，比较麻烦。
    
    
    // 父层改了，坐标系也就改了，需要重新设置label的位置，才能正确的设置裁剪区域。
    label.frame = gradientLayer.bounds;
    // 利用定时器，快速的切换渐变颜色，就有文字颜色变化效果
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(textColorChange)];
    
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    // 随机颜色方法
    //这样就可以控制方向了
    gradientLayer.endPoint = CGPointMake(0, 0);
    
    
    gradient = gradientLayer;
}
-(UIColor *)randomColor{
    CGFloat r = arc4random_uniform(256) / 255.0;
    CGFloat g = arc4random_uniform(256) / 255.0;
    CGFloat b = arc4random_uniform(256) / 255.0;
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}
-(void)textColorChange {
    gradient.colors = @[(id)[self randomColor].CGColor,
                        (id)[self randomColor].CGColor,
                        (id)[self randomColor].CGColor,
                        (id)[self randomColor].CGColor,
                        (id)[self randomColor].CGColor];
}
@end

