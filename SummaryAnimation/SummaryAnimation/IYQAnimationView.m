//
//  IYQAnimationView.m
//  SummaryAnimation
//
//  Created by chmtech003 on 16/8/12.
//  Copyright © 2016年 gongyouqiang. All rights reserved.
//

#import "IYQAnimationView.h"
#import "IYQCircleLayer.h"

// 16进制颜色转换
#define HexColor(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface IYQAnimationView ()

@property (strong, nonatomic) IYQCircleLayer *circleLayer;

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

#pragma mark - animation
- (void)addCircleLayer {

    [self.layer addSublayer:self.circleLayer];

    [_circleLayer expand];

    [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(wobbleCircleLayer) userInfo:nil repeats:NO];
}

- (void)wobbleCircleLayer
{
    [_circleLayer wobbleAnimation];
}

@end
