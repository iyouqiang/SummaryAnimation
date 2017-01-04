//
//  IYQAttachmentView.m
//  SummaryAnimation
//
//  Created by chmtech003 on 2016/11/30.
//  Copyright © 2016年 gongyouqiang. All rights reserved.
//

#import "IYQAttachmentView.h"
@interface IYQAttachmentView ()
{
    // 附着点图片框
    UIImageView *_anchorImgViwe;

    // 参考图片框 (boxView 内部)
    UIImageView *_offsetImgView;
}
@end

@implementation IYQAttachmentView

- (instancetype)init
{
    self = [super init];

    if (self) {

        //1.设置boxView 的中心点
        self.boxView.center = CGPointMake(200, 200);

        //2.添加附着点
        CGPoint anchorPoint = CGPointMake(200, 100);
        UIOffset offset = UIOffsetMake(20, 20); // 中心点偏移量

        //3.添加附着行为
        UIAttachmentBehavior *attachment = [[UIAttachmentBehavior alloc] initWithItem:self.boxView offsetFromCenter:offset attachedToAnchor:anchorPoint];
        [self.animator addBehavior:attachment];
        self.attachment = attachment;

        //4.设置附着图片
        UIImage *image = [UIImage imageNamed:@"AttachmentPoint_Mask"];
        UIImageView *anchorImgView = [[UIImageView alloc] initWithImage:image];
        anchorImgView.center = anchorPoint;
        [self addSubview:anchorImgView];
        _anchorImgViwe = anchorImgView;

        //5.设置参考点
        _offsetImgView = [[UIImageView alloc] initWithImage:image];
        CGFloat x = self.boxView.bounds.size.width * 0.5 + offset.horizontal;
        CGFloat y = self.boxView.bounds.size.height * 0.5 + offset.vertical;
        _offsetImgView.center = CGPointMake(x, y);
        [self.boxView addSubview:_offsetImgView];

        //6.增加拖拽手势
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
        [self addGestureRecognizer:pan];
    }

    return self;
}

// 拖拽的时候会调用的方法
- (void)panAction:(UIPanGestureRecognizer *)pan {

    // 1. 获取触摸点
    CGPoint loc = [pan locationInView:self];


    // 2. 修改附着行为的附着点
    _anchorImgViwe.center = loc;
    self.attachment.anchorPoint = loc;

    // 3. 进行重绘
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {

    // 1. 获取路径
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];

    // 2. 划线
    [bezierPath moveToPoint:_anchorImgViwe.center];

    CGPoint p = [self convertPoint:_offsetImgView.center fromView:self.boxView];
    [bezierPath addLineToPoint:p];

    bezierPath.lineWidth = 6;

    // 3. 渲染
    [bezierPath stroke];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
