//
//  IYQPushView.m
//  SummaryAnimation
//
//  Created by chmtech003 on 2016/11/30.
//  Copyright © 2016年 gongyouqiang. All rights reserved.
//

#import "IYQPushView.h"

@interface IYQPushView ()
{
    UIImageView *_smallview;
    UIPushBehavior *_push;
    CGPoint _firstPoint;
    CGPoint _currentPoint;
}

@end

@implementation IYQPushView

- (instancetype)init {

    self = [super init];

    if (self) {

        //1.添加蓝色View
        UIView *blueView = [[UIView alloc] initWithFrame:CGRectMake(150, 300, 20, 20)];
        blueView.backgroundColor = [UIColor blueColor];
        [self addSubview:blueView];

        //2.添加图片框，拖拽起点
        UIImageView *smallView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"AttachmentPoint_Mask"]];
        smallView.hidden = YES;
        [self addSubview:smallView];
        _smallview = smallView;

        //3.添加推动行为
        UIPushBehavior *push = [[UIPushBehavior alloc] initWithItems:@[self.boxView] mode:UIPushBehaviorModeInstantaneous];
        [self.animator addBehavior:push];
        _push = push;

        //4.增加碰撞检测
        UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:@[blueView, self.boxView]];
        collision.translatesReferenceBoundsIntoBoundary = YES;
        [self.animator addBehavior:collision];

        //5.添加拖拽手势
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
        [self addGestureRecognizer:pan];
    }

    return self;
}

// 监听开始拖拽的方法
- (void)panAction:(UIPanGestureRecognizer *)pan
{
    // 如果刚开始拖拽，设置起点处的小圆球
    if (pan.state == UIGestureRecognizerStateBegan) {

        _firstPoint = [pan locationInView:self];
        _smallview.center = _firstPoint;
        _smallview.hidden = NO;
    }else if (pan.state == UIGestureRecognizerStateChanged) {

        _currentPoint = [pan locationInView:self];
        [self setNeedsDisplay];
    }else if (pan.state == UIGestureRecognizerStateEnded) {

        //1.计算偏移量
        CGPoint offset = CGPointMake(_currentPoint.x - _firstPoint.x, _currentPoint.y - _firstPoint.y);

        //2.计算角度 函数atan2(y,x)中参数的顺序是倒置的，atan2(y,x)计算的值相当于点(x,y)的角度值。 atan2 返回的是方位角，也可以理解为计算复数 x+yi 的幅角
        CGFloat angle  = atan2(offset.y, offset.x);

        //3.计算距离  计算直角三角形的斜边长。
        CGFloat distance = hypot(offset.y, offset.x);

        //4.设置推动力的大小、角度
        _push.magnitude = distance;
        _push.angle = angle;

        //5.是单次推动为有效
        _push.active = YES;

        //6.将拖拽的现隐藏
        _firstPoint = CGPointZero;
        _currentPoint = CGPointZero;

        //7.将起点的小圆隐藏
        _smallview.hidden = YES;
        [self setNeedsDisplay];
    }
}

- (void)drawRect:(CGRect)rect
{
    //1.开启上下文
    CGContextRef ctxRef = UIGraphicsGetCurrentContext();

    //2.创建路径对象
    CGContextMoveToPoint(ctxRef, _firstPoint.x, _firstPoint.y);
    CGContextAddLineToPoint(ctxRef, _currentPoint.x, _currentPoint.y);

    //3.设置线宽和颜色
    CGContextSetLineWidth(ctxRef, 10);
    CGContextSetLineJoin(ctxRef, kCGLineJoinRound);
    CGContextSetLineCap(ctxRef, kCGLineCapRound);
    [[UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1.0] setStroke];

    //4.渲染
    CGContextStrokePath(ctxRef);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
