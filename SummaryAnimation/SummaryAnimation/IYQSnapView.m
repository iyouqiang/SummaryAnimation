//
//  IYQSnapView.m
//  SummaryAnimation
//
//  Created by chmtech003 on 2016/11/30.
//  Copyright © 2016年 gongyouqiang. All rights reserved.
//

#import "IYQSnapView.h"
@interface IYQSnapView ()
@property (nonatomic, assign) CGPoint locPoint;
@end

@implementation IYQSnapView

- (instancetype)init
{
    self = [super init];

    if (self) {

        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
        [self addGestureRecognizer:pan];

        _locPoint = self.boxView.center;
    }

    return self;
}

- (void)panAction:(UIPanGestureRecognizer*)pan
{
    if (pan.state == UIGestureRecognizerStateBegan) {

        //0. 触摸之前要清零之前的吸附时间
        [self.animator removeAllBehaviors];

    }else if (pan.state == UIGestureRecognizerStateChanged) {

        CGPoint point = [pan locationInView:self];
        self.boxView.center = point;
        
    }else if (pan.state == UIGestureRecognizerStateEnded) {

        //1.添加吸附事件
        UISnapBehavior *snap = [[UISnapBehavior alloc] initWithItem:self.boxView snapToPoint:_locPoint];

        //2.改变震动幅度，0表示振幅最大，1振幅最小
        snap.damping = 0.5;
        
        //3.将吸附事件添加到仿真者行为中
        [self.animator addBehavior:snap];
    }else {

        NSLog(@"失败");
    }
}

/*
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //0. 触摸之前要清零之前的吸附时间
    [self.animator removeAllBehaviors];

    //1.获取触摸对象
    UITouch *touch = [touches anyObject];

    //2.获取触摸点
    CGPoint loc = [touch locationInView:self];

    //3.添加吸附事件
    UISnapBehavior *snap = [[UISnapBehavior alloc] initWithItem:self.boxView snapToPoint:loc];

    //改变震动幅度，0表示振幅最大，1振幅最小
    snap.damping = 0.5;

    //4.将吸附事件添加到仿真者行为中
    [self.animator addBehavior:snap];
}
*/
@end
