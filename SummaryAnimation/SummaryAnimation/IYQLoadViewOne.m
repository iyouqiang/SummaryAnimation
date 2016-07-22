//
//  IYQLoadViewOne.m
//  SummaryAnimation
//
//  Created by chmtech003 on 16/7/22.
//  Copyright © 2016年 gongyouqiang. All rights reserved.
//

#import "IYQLoadViewOne.h"
@interface IYQLoadViewOne ()
//定义内外圈
@property (nonatomic, strong) CAShapeLayer *outerLayer;
@property (nonatomic, strong) CAShapeLayer *interLayer;
@end

@implementation IYQLoadViewOne

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    if (self) {

        [self camelLoadingAnimation];
    }

    return self;
}

- (void)camelLoadingAnimation
{
    CGFloat outerRadius = 25;
    CGFloat interRadius = 20;

    CGFloat startAngle  = 0.0;
    CGFloat endAngle    = 2*M_PI;

    CGFloat startAngle2 = -M_PI;
    CGFloat endAngle2   = M_PI;

    CGPoint center      = self.center;

    UIBezierPath *outerPath = [UIBezierPath bezierPathWithArcCenter:center radius:outerRadius startAngle:startAngle2 endAngle:endAngle2 clockwise:YES];
    UIBezierPath *interPath = [UIBezierPath bezierPathWithArcCenter:center radius:interRadius startAngle:startAngle endAngle:endAngle clockwise:YES];
    self.outerLayer.path = outerPath.CGPath;//(__bridge CGPathRef _Nullable)(outerPath);
    self.interLayer.path = interPath.CGPath;//(__bridge CGPathRef _Nullable)(interPath);

    [self.layer addSublayer:self.outerLayer];
    [self.layer addSublayer:self.interLayer];

    [self LoadingAnimation];

}

- (void)LoadingAnimation
{
    CABasicAnimation *innertrailAnimation = [self animationKeyPath:@"strokeStart" Duration:1.f FromeValue:@(0.0) toValue:@(0.3) BeginTime:0.0];
    CABasicAnimation *innerHeadAnimation  = [self animationKeyPath:@"strokeEnd" Duration:1.f FromeValue:@(0.0) toValue:@(1.0) BeginTime:0.0];
    CABasicAnimation *innerEndAnimation = [self animationKeyPath:@"strokeStart" Duration:1.f FromeValue:@(0.3) toValue:@(1) BeginTime:1.f];

    CAAnimationGroup *innerAnimationGroup = [CAAnimationGroup animation];
    [innerAnimationGroup setDuration:2.f];
    innerAnimationGroup.removedOnCompletion = NO;
    [innerAnimationGroup setAnimations:@[innertrailAnimation, innerHeadAnimation, innerEndAnimation]];
    innerAnimationGroup.repeatCount = MAXFLOAT;

    [self.outerLayer addAnimation:innerAnimationGroup forKey:nil];
    [self.interLayer addAnimation:innerAnimationGroup forKey:nil];
}

- (CABasicAnimation *)animationKeyPath:(NSString *)keyPath Duration:(CFTimeInterval)duration FromeValue:(NSNumber *)fromeValue toValue:(NSNumber *)toValue BeginTime:(CFTimeInterval)beginTime
{
    CABasicAnimation *Animation = [CABasicAnimation animation];
    Animation.keyPath = keyPath;
    Animation.duration = duration;
    Animation.fromValue = fromeValue;
    Animation.toValue = toValue;
    Animation.beginTime = beginTime;
    Animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    return Animation;
}

- (CALayer*)outerLayer
{
    if (!_outerLayer) {

        _outerLayer = [CAShapeLayer layer];
        _outerLayer.lineWidth = 2.0;
        _outerLayer.lineCap = kCALineCapRound;
        _outerLayer.strokeColor = [UIColor orangeColor].CGColor;
        _outerLayer.fillColor = [UIColor clearColor].CGColor;
    }

    return _outerLayer;
}

- (CALayer*)interLayer
{
    if (!_interLayer) {

        _interLayer = [CAShapeLayer layer];
        _interLayer.lineWidth = 2.0;
        _interLayer.lineCap = kCALineCapRound;
        _interLayer.strokeColor = [UIColor redColor].CGColor;
        _interLayer.fillColor = [UIColor clearColor].CGColor;
    }
    
    return _interLayer;
}


@end
