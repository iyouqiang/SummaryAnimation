//
//  IYQCircleLayer.m
//  SummaryAnimation
//
//  Created by chmtech003 on 16/8/12.
//  Copyright © 2016年 gongyouqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IYQCircleLayer.h"
#import "UIColor+Hex.h"
@interface IYQCircleLayer ()

@property (strong, nonatomic) UIBezierPath *circleSmallPath;
@property (strong, nonatomic) UIBezierPath *circleBigPath;
@property (strong, nonatomic) UIBezierPath *circleVerticalSquishPath;
@property (strong, nonatomic) UIBezierPath *circleHorizontalSquishPath;

@end

static const NSTimeInterval KAnimationDuration = 0.3;
static const NSTimeInterval KAnimationBeginTime = 0.0;

@implementation IYQCircleLayer

- (instancetype)init
{
    self = [super init];

    if (self) {
        self.fillColor = [UIColor colorWithHexString:@"#da70d6"].CGColor;
        self.path      = self.circleSmallPath.CGPath;
    }

    return self;
}

// 父视 宽高100 适配后面的动画界面 视图下移15.0f

- (UIBezierPath *)circleSmallPath
{
    if (!_circleSmallPath) {

        _circleSmallPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(50.0f, 50.0f, 0.0f, 0.0)];
    }

    return _circleSmallPath;
}

- (UIBezierPath *)circleBigPath
{
    if (!_circleBigPath) {

        _circleBigPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(2.5, 17.5, 95.0, 95.0f)];
    }

    return _circleBigPath;
}

- (UIBezierPath *)circleVerticalSquishPath
{
    if (!_circleVerticalSquishPath) {

        _circleVerticalSquishPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(2.5, 20.0f, 95.0f, 90.f)];
    }

    return _circleVerticalSquishPath;
}

- (UIBezierPath *)circleHorizontalSquishPath
{
    if (!_circleHorizontalSquishPath) {

        _circleHorizontalSquishPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(5.0f, 20.0f, 90.0f, 90.9)];
    }

    return _circleHorizontalSquishPath;
}

- (void)expand
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.fromValue         = (__bridge id _Nullable)(self.circleSmallPath.CGPath);
    animation.toValue           = (__bridge id _Nullable)(self.circleBigPath.CGPath);
    animation.duration          = KAnimationDuration;
    animation.fillMode          = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    [self addAnimation:animation forKey:nil];
}

- (void)wobbleAnimation
{
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"path"];
    animation1.fromValue = (__bridge id _Nullable)(self.circleBigPath.CGPath);
    animation1.toValue   = (__bridge id _Nullable)(self.circleVerticalSquishPath.CGPath);
    animation1.beginTime = KAnimationBeginTime;
    animation1.duration  = KAnimationDuration;

    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"path"];
    animation2.fromValue = (__bridge id _Nullable)(self.circleVerticalSquishPath.CGPath);
    animation2.toValue   = (__bridge id _Nullable)(self.circleHorizontalSquishPath.CGPath);
    animation2.beginTime = animation1.beginTime + animation1.duration;
    animation2.duration  = KAnimationDuration;

    CABasicAnimation *animation3 = [CABasicAnimation animationWithKeyPath:@"path"];
    animation3.fromValue = (__bridge id _Nullable)(self.circleHorizontalSquishPath.CGPath);
    animation3.toValue   = (__bridge id _Nullable)(self.circleVerticalSquishPath.CGPath);
    animation3.beginTime = animation2.beginTime + animation2.duration;
    animation3.duration  = KAnimationDuration;

    CABasicAnimation *animation4 = [CABasicAnimation animationWithKeyPath:@"path"];
    animation4.fromValue = (__bridge id _Nullable)(self.circleVerticalSquishPath.CGPath);
    animation4.toValue   = (__bridge id _Nullable)(self.circleBigPath.CGPath);
    animation4.beginTime = animation3.beginTime + animation3.duration;
    animation4.duration  = KAnimationDuration;

    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = @[animation1, animation2, animation3, animation4];
    groupAnimation.duration = 4 * KAnimationDuration;
    groupAnimation.repeatCount = 2;
    [self addAnimation:groupAnimation forKey:@"groupAnimation"];

}

- (void)contract
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.fromValue         = (__bridge id _Nullable)(self.circleBigPath.CGPath);
    animation.toValue           = (__bridge id _Nullable)(self.circleSmallPath.CGPath);
    animation.duration          = KAnimationDuration;
    animation.fillMode          = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    [self addAnimation:animation forKey:nil];
}

@end
