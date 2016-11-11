//
//  IYQWaterwaveLayer.m
//  SummaryAnimation
//
//  Created by chmtech003 on 16/8/16.
//  Copyright © 2016年 gongyouqiang. All rights reserved.
//

#import "IYQWaterwaveLayer.h"

@interface IYQWaterwaveLayer ()
{
    CGFloat waveAmplitude;  // 波纹振幅
    CGFloat waveCycle;      // 波纹周期
    CGFloat waveSpeed;      // 波纹速度
    CGFloat waveGrowth;     // 波纹上升速度

    CGFloat waterWaveHeight;
    CGFloat waterWaveWidth;
    CGFloat offsetX;           // 波浪x位移
    CGFloat currentWavePointY; // 当前波浪上升高度Y（高度从大到小 坐标系向下增长）
}

@property (nonatomic, strong) CADisplayLink *waveDisplaylink;

@end

static const CGFloat KWidth  = 100.0f;
static const CGFloat KHeight = 100.0f;

@implementation IYQWaterwaveLayer

- (instancetype)init
{
    self = [super init];

    if (self) {

        [self setProperty];
    }

    return self;
}

- (void)setProperty
{
    waterWaveHeight   = KHeight;
    waterWaveWidth    = KWidth;

    // 当前水波高度
    currentWavePointY =  KHeight;

    // 波纹上升速度
    waveGrowth        = 1.5;
    // 移动速度
    waveSpeed         = 0.2/M_PI;
    // 周期
    waveCycle         = 1.29 * M_PI / waterWaveWidth;
    // 振幅
    waveAmplitude     = 5;
    // 偏移量
    offsetX           = 0;
}

- (void)waveAnimation
{
    _waveDisplaylink = [CADisplayLink displayLinkWithTarget:self selector:@selector(waterUpdateAnimation)];
    [_waveDisplaylink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)waterUpdateAnimation
{
    CGMutablePathRef path = CGPathCreateMutable();
    CGFloat y = currentWavePointY;
    CGPathMoveToPoint(path, nil, 0, y);
    for (float x = 0.0f; x <=  waterWaveWidth ; x++) {
        // 正弦波浪公式
        y = waveAmplitude * sin(waveCycle * x + offsetX) + currentWavePointY;
        CGPathAddLineToPoint(path, nil, x, y);
    }

    CGPathAddLineToPoint(path, nil, waterWaveWidth, KHeight);
    CGPathAddLineToPoint(path, nil, 0, KHeight);
    CGPathCloseSubpath(path);

    self.path = path;
    CGPathRelease(path);

    // 波纹上升速度
    currentWavePointY -= waveGrowth;

    // 波浪位移
    offsetX += waveSpeed;

}

- (void)stopAnimation
{
    [_waveDisplaylink invalidate];
    _waveDisplaylink = nil;
}

@end
