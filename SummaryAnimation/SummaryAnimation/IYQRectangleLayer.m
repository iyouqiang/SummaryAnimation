//
//  IYQRectangle.m
//  SummaryAnimation
//
//  Created by chmtech003 on 16/8/16.
//  Copyright © 2016年 gongyouqiang. All rights reserved.
//

#import "IYQRectangleLayer.h"

@interface IYQRectangleLayer ()

@property (nonatomic, strong) UIBezierPath *fullRectangle;

@end

static const CGFloat KLineWidth = 5.0;

@implementation IYQRectangleLayer

- (instancetype)init
{
    self = [super init];

    if (self) {

        self.fillColor = [UIColor clearColor].CGColor;
        self.lineWidth = KLineWidth;
        self.path = self.fullRectangle.CGPath;
    }

    return self;
}

- (UIBezierPath *)fullRectangle
{
    if (!_fullRectangle) {

        _fullRectangle = [UIBezierPath bezierPath];
        [_fullRectangle moveToPoint:CGPointMake(0.0, 100.0f)];
        [_fullRectangle addLineToPoint:CGPointMake(0.0, - KLineWidth)];
        [_fullRectangle addLineToPoint:CGPointMake(100.0f, -KLineWidth)];
        [_fullRectangle addLineToPoint:CGPointMake(100.0f, 100.0f)];
        [_fullRectangle addLineToPoint:CGPointMake(- KLineWidth/2.f, 100.0)];
    }

    return _fullRectangle;
}

- (void)strokeChangeWithColor:(UIColor *)color
{
    self.strokeColor = color.CGColor;
    CABasicAnimation *strokeAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeAnimation.fromValue = @0.0;
    strokeAnimation.toValue = @1.0;
    strokeAnimation.duration = 0.4;
    [self addAnimation:strokeAnimation forKey:nil];
}

@end
