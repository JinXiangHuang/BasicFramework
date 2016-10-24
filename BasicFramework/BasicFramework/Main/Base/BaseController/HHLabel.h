//
//  HHLabel.h
//  BasicFramework
//
//  Created by mr-tech on 16/10/18.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHLabel : UILabel {
    NSTimer *animationTimer;
    CGFloat gradientLocations[3];
    int animationTimerCount;
    BOOL _animated;
}

@property (nonatomic, assign, getter = isAnimated) BOOL animated;
-(void)addLabel:(UIView *)view :(NSString *)text;
@end
