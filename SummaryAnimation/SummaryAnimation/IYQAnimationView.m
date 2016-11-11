//
//  IYQAnimationView.m
//  SummaryAnimation
//
//  Created by chmtech003 on 16/8/12.
//  Copyright © 2016年 gongyouqiang. All rights reserved.
//

#import "IYQAnimationView.h"
#import "IYQCircleLayer.h"
#import "IYQTriangleLayer.h"
#import "IYQRectangleLayer.h"
#import "IYQWaterwaveLayer.h"
// 16进制颜色转换
#define HexColor(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface IYQAnimationView ()

@property (strong, nonatomic) IYQCircleLayer    *circleLayer;
@property (strong, nonatomic) IYQTriangleLayer  *triangleLayer;
@property (strong, nonatomic) IYQRectangleLayer *rectangleLayer;
@property (strong, nonatomic) IYQRectangleLayer *blueRectangleLayer;
@property (strong, nonatomic) IYQWaterwaveLayer *waterWaveLayer;

@end

@implementation IYQAnimationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    if (self) {

        [self addCircleLayer];
    }

    return self;
}

- (IYQCircleLayer *)circleLayer
{
    if (!_circleLayer) {

        _circleLayer = [[IYQCircleLayer alloc] init];
    }

    return _circleLayer;
}

- (IYQTriangleLayer *)triangleLayer
{
    if (!_triangleLayer) {

        _triangleLayer = [[IYQTriangleLayer alloc] init];
    }

    return _triangleLayer;
}

- (IYQRectangleLayer *)rectangleLayer
{
    if (!_rectangleLayer) {

        _rectangleLayer = [[IYQRectangleLayer alloc] init];
    }

    return _rectangleLayer;
}

- (IYQRectangleLayer *)blueRectangleLayer {

    if (!_blueRectangleLayer) {

        _blueRectangleLayer = [[IYQRectangleLayer alloc] init];
    }
    return _blueRectangleLayer;
}

- (IYQWaterwaveLayer *)waterWaveLayer
{
    if (!_waterWaveLayer) {

        _waterWaveLayer = [[IYQWaterwaveLayer alloc] init];
        _waterWaveLayer.fillColor = HexColor(0x40e0b0).CGColor;
    }

    return _waterWaveLayer;
}

#pragma mark - animation
- (void)addCircleLayer {

    [self.layer addSublayer:self.circleLayer];

    [_circleLayer expand];

    [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(wobbleCircleLayer) userInfo:nil repeats:NO];
}

- (void)wobbleCircleLayer
{
    [_circleLayer wobbleAnimation];

    [self.layer addSublayer:self.triangleLayer];

    [NSTimer scheduledTimerWithTimeInterval:0.9 target:self selector:@selector(showTriangleAnimation) userInfo:nil repeats:NO];
}

- (void)showTriangleAnimation {

    [_triangleLayer triangleAnimate];

    [NSTimer scheduledTimerWithTimeInterval:0.9 target:self selector:@selector(transformAnima) userInfo:nil repeats:NO];
}

- (void)transformAnima {

    [self transformRotationZ];

    [_circleLayer contract];

    [NSTimer scheduledTimerWithTimeInterval:0.4 target:self selector:@selector(drawRedRectangleAnimation) userInfo:nil repeats:NO];
    [NSTimer scheduledTimerWithTimeInterval:0.8 target:self selector:@selector(drawBlueRectangleAnimation) userInfo:nil repeats:NO];
}

- (void)drawRedRectangleAnimation {
    [self.layer addSublayer:self.rectangleLayer];
    [_rectangleLayer strokeChangeWithColor:HexColor(0xda70d6)];

}

- (void)drawBlueRectangleAnimation {
    [self.layer addSublayer:self.blueRectangleLayer];
    [_blueRectangleLayer strokeChangeWithColor:HexColor(0x40e0b0)];
    [NSTimer scheduledTimerWithTimeInterval:0.4 target:self selector:@selector(drawWaveAnimation) userInfo:nil repeats:NO];
}

- (void)transformRotationZ {
    self.layer.anchorPoint = CGPointMake(0.5, 0.65);
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = @(M_PI * 2);
    rotationAnimation.duration = 0.45;
    rotationAnimation.removedOnCompletion = true;
    [self.layer addAnimation:rotationAnimation forKey:nil];
}

- (void)expandView {

    [_waterWaveLayer stopAnimation];

    self.backgroundColor = HexColor(0x40e0b0);
    self.frame = CGRectMake(self.frame.origin.x - self.blueRectangleLayer.lineWidth,
                            self.frame.origin.y - self.blueRectangleLayer.lineWidth,
                            self.frame.size.width + self.blueRectangleLayer.lineWidth * 2,
                            self.frame.size.height + self.blueRectangleLayer.lineWidth * 2);
    self.layer.sublayers = nil;
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.frame = self.parentFrame;

    } completion:^(BOOL finished) {
        if (_delegate && [_delegate respondsToSelector:@selector(completeAnimation)]) {
            [_delegate completeAnimation];
        }
    }];
}

- (void)drawWaveAnimation {
    
    [self.layer addSublayer:self.waterWaveLayer];
    [_waterWaveLayer waveAnimation];
    [NSTimer scheduledTimerWithTimeInterval:0.9 target:self selector:@selector(expandView) userInfo:nil repeats:NO];
}

@end
