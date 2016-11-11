//
//  IYQSandClockView.m
//  SummaryAnimation
//
//  Created by chmtech003 on 16/8/23.
//  Copyright © 2016年 gongyouqiang. All rights reserved.
//

#import "IYQSandClockView.h"

CGFloat const ksideLength = 30.0f;
CGFloat const kduration   = 3.5;

@interface IYQSandClockView ()

@property (nonatomic, strong) CAShapeLayer *containerLayer;
@property (nonatomic, strong) CAShapeLayer *topLayer;
@property (nonatomic, strong) CAShapeLayer *bottomLayer;
@property (nonatomic, strong) CAShapeLayer *lineLayer;

@property (nonatomic, strong) CAKeyframeAnimation *topAnimation;
@property (nonatomic, strong) CAKeyframeAnimation *lineAnimation;
@property (nonatomic, strong) CAKeyframeAnimation *bottomAnimation;
@property (nonatomic, strong) CAKeyframeAnimation *contrainAnimaton;

@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) BOOL isShowing;

@end

@implementation IYQSandClockView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    if (self) {

        [self configDefaultData];

        [self.layer addSublayer:self.containerLayer];
        [self.containerLayer addSublayer:self.topLayer];
        [self.containerLayer addSublayer:self.lineLayer];
        [self.containerLayer addSublayer:self.bottomLayer];
    }

    return self;
}

- (void)configDefaultData
{
    _width  = sqrtf(ksideLength * ksideLength + ksideLength * ksideLength);
    _height = sqrtf(ksideLength * ksideLength - (_width/2.0) * (_width/2.0));
}

#pragma mark - lazy init
- (CAShapeLayer *)containerLayer
{
    if (!_containerLayer) {

        _containerLayer             = [CAShapeLayer layer];
        _containerLayer.frame       = CGRectMake(0.0f, 0.0f, _width, 2 * _height);
        _containerLayer.anchorPoint = CGPointMake(0.5, 0.5);
        _containerLayer.position    = CGPointMake(_width/2.0f, _height);
    }
    return _containerLayer;
}

- (CAShapeLayer *)topLayer
{
    if (!_topLayer) {

        UIBezierPath *topPath = [UIBezierPath bezierPath];
        [topPath moveToPoint:CGPointMake(0.0, 0.0)];
        [topPath addLineToPoint:CGPointMake(_width, 0.0)];
        [topPath addLineToPoint:CGPointMake(_width/2.0, _height)];
        [topPath addLineToPoint:CGPointMake(0.0, 0.0)];
        [topPath closePath];

        _topLayer = [CAShapeLayer layer];
        _topLayer.frame       = CGRectMake(0.0, 0.0, _width, _height);
        _topLayer.anchorPoint = CGPointMake(0.5, 1);
        _topLayer.position    = CGPointMake(_width/2.0, _height);
        _topLayer.path        = topPath.CGPath;
        _topLayer.fillColor   = [UIColor yellowColor].CGColor;
        _topLayer.strokeColor = [UIColor yellowColor].CGColor;
        _topLayer.lineWidth   = 0.0f;
    }

    return _topLayer;
}

- (CAShapeLayer *)bottomLayer
{
    if (!_bottomLayer) {

        UIBezierPath *bottomPath = [UIBezierPath bezierPath];
        [bottomPath moveToPoint:CGPointMake(_width/2.0, 0.0)];
        [bottomPath addLineToPoint:CGPointMake(_width, _height)];
        [bottomPath addLineToPoint:CGPointMake(0.0, _height)];
        [bottomPath addLineToPoint:CGPointMake(_width/2.0, 0.0)];
        [bottomPath closePath];

        _bottomLayer = [CAShapeLayer layer];
        _bottomLayer.frame       = CGRectMake(0.0, _height, _width, _height);
        _bottomLayer.anchorPoint = CGPointMake(0.5, 1);
        _bottomLayer.position    = CGPointMake(_width/2.0, 2*_height);
        _bottomLayer.path        = bottomPath.CGPath;
        _bottomLayer.fillColor   = [UIColor yellowColor].CGColor;
        _topLayer.strokeColor = [UIColor yellowColor].CGColor;
        _bottomLayer.lineWidth   = 0.0f;
        _bottomLayer.transform = CATransform3DMakeScale(0, 0, 0);
    }

    return _bottomLayer;
}

- (CAShapeLayer *)lineLayer
{
    if (!_lineLayer) {

        UIBezierPath *linePath = [UIBezierPath bezierPath];
        [linePath moveToPoint:CGPointMake(_width/2.0f, _height)];
        [linePath addLineToPoint:CGPointMake(_width/2.0f, _height * 2.0f)];
        [linePath closePath];

        _lineLayer = [CAShapeLayer layer];
        _lineLayer.path = linePath.CGPath;
        _lineLayer.fillColor = [UIColor yellowColor].CGColor;
        _lineLayer.strokeColor = [UIColor yellowColor].CGColor;
        _lineLayer.lineJoin = kCALineJoinMiter;
        _lineLayer.strokeEnd = 0.0;
        _lineLayer.lineWidth = 1.0;
        _lineLayer.lineDashPhase = 3.0f;
        _lineLayer.lineDashPattern = [NSArray arrayWithObjects:[NSNumber numberWithInteger:1.0], [NSNumber numberWithInteger:1.0], nil];
    }

    return _lineLayer;
}

#pragma mark - Animation
- (CAKeyframeAnimation *)topAnimation
{
    if (!_topAnimation) {

        _topAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
        _topAnimation.duration = kduration;
        _topAnimation.repeatCount = HUGE_VAL;
        _topAnimation.keyTimes = @[@0.0, @0.9, @1.0];
        _topAnimation.values   = @[@1.0, @0.0, @0.0];
    }

    return _topAnimation;
}

- (CAKeyframeAnimation *)lineAnimation
{
    if (!_lineAnimation) {

        _lineAnimation = [CAKeyframeAnimation animationWithKeyPath:@"strokeEnd"];
        _lineAnimation.duration = kduration;
        _lineAnimation.repeatCount = HUGE_VAL;
        _lineAnimation.keyTimes = @[@0.0, @0.1, @0.9, @1.0];
        _lineAnimation.values   = @[@0.0, @1.0, @1.0, @1.0];
    }

    return _lineAnimation;
}

- (CAKeyframeAnimation *)bottomAnimation
{
    if (!_bottomAnimation) {

        _bottomAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
        _bottomAnimation.duration = kduration;
        _bottomAnimation.repeatCount = HUGE_VAL;
        _bottomAnimation.keyTimes = @[@0.1, @0.9, @1.0];
        _bottomAnimation.values   = @[@0.0, @1.0, @1.0];
    }

    return _bottomAnimation;
}

- (CAKeyframeAnimation *)contrainAnimaton
{
    if (!_contrainAnimaton) {

        _contrainAnimaton = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
        _contrainAnimaton.duration = kduration;
        _contrainAnimaton.repeatCount = HUGE_VAL;
        _contrainAnimaton.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        _contrainAnimaton.keyTimes = @[@0.8, @1.0];
        _contrainAnimaton.values   = @[[NSNumber numberWithInteger:0.0], [NSNumber numberWithInteger:M_PI]];
    }

    return _contrainAnimaton;
}

#pragma mark - public Animation
- (void)showAnimation
{
    if (_isShowing) {
        return;
    }

    _isShowing = YES;

    [_topLayer addAnimation:self.topAnimation forKey:@"TopAnimation"];
    [_lineLayer addAnimation:self.lineAnimation forKey:@"lineAnimation"];
    [_bottomLayer addAnimation:self.bottomAnimation forKey:@"bottomAniamtion"];
    [_containerLayer addAnimation:self.contrainAnimaton forKey:@"containAniamtion"];
}

- (void)dismissAnimation
{
    if (!_isShowing) {

        return;
    }

    _isShowing = NO;
}

@end
