//
//  IYQDynamicDemoVC.m
//  SummaryAnimation
//
//  Created by chmtech003 on 2016/11/30.
//  Copyright © 2016年 gongyouqiang. All rights reserved.
//

#import "IYQDynamicDemoVC.h"
#import "IYQDynamicBaseView.h"
#import "IYQSnapView.h"
#import "IYQPushView.h"
#import "IYQAttachmentView.h"
#import "IYQSpringView.h"
#import "IYQCollisionView.h"

@interface IYQDynamicDemoVC()
{
    UIDynamicAnimator *_animator;
    UIView *_headerView;
    UIAttachmentBehavior *_leaderAttach;

}

@end

@implementation IYQDynamicDemoVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    // 双击fan'hui
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapPop)];
    [tap setNumberOfTapsRequired:2];
    [self.view addGestureRecognizer:tap];

    IYQDynamicBaseView *baseView = nil;

    // 根据不同的功能类型选择不同的视图
    switch (self.function) {
        case kDemoFunctionSnap:
            baseView = [[IYQSnapView alloc] init];
            break;

        case kDemoFunctionPush:
            baseView = [[IYQPushView alloc] init];
            break;
            
        case kDemoFunctionAttachment:
            baseView = [[IYQAttachmentView alloc] init];
            break;

        case kDemoFunctionSpring:
            baseView = [[IYQSpringView alloc] init];
            break;

        case kDemoFunctionCollision:
            baseView = [[IYQCollisionView alloc] init];
            break;

        case kDemoFunctionmultiObject:
            [self multiObject];

        default:
            break;
    }

    baseView.frame = self.view.bounds;
    [self.view addSubview:baseView];
}

- (void)multiObject
{
    // 1. 定义小圆球的frame
    CGFloat width = 20;
    CGFloat height = width;
    CGFloat startX = 100;
    CGFloat y = 0;

    // 创建一个可变数组用来存放小圆球
    NSMutableArray *roundArrM = [NSMutableArray array];

    // 2. 循环创建小圆球
    for (NSInteger i = 0; i < 9; i ++) {

        // 2.1 实例化并设置frame
        CGFloat x = startX + i * width;
        UIView *roundV = [[UIView alloc] init];

        // 2.2 设置小球颜色
        roundV.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1.0];

        // 2.3 设置圆角
        roundV.layer.cornerRadius = 10;

        // 最后一个需要设置为大球
        if (i == 8) {

            width = 40;
            height = width;
            roundV.layer.cornerRadius = 20;
            _headerView = roundV;
        }
        roundV.frame = CGRectMake(x, y, width, height);
        // 2.4 添加到当前view
        [self.view addSubview:roundV];

        // 2.5 添加到数组中
        [roundArrM addObject:roundV];
    }

    // 3. 创建仿真者
    UIDynamicAnimator *animater = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    _animator = animater;

    // 4. 添加重力行为
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:roundArrM];
    [animater addBehavior:gravity];

    // 5. 添加边缘碰撞检测
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:roundArrM];
    collision.translatesReferenceBoundsIntoBoundary = YES;
    [animater addBehavior:collision];

    // 6. 添加多元素的附着行为
    for (NSInteger i = 0; i < roundArrM.count - 1; i++) {

        // 给每个元素都添加一个一个附着行为，并添加到仿真者 锚点位中心点
        UIAttachmentBehavior *attachment = [[UIAttachmentBehavior alloc] initWithItem:roundArrM[i] attachedToItem:roundArrM[i + 1]];
        [animater addBehavior:attachment];
    }

    // 7. 添加手势识别器
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [self.view addGestureRecognizer:pan];
}

- (void)panAction:(UIPanGestureRecognizer *)pan {

    // 获取触摸点
    CGPoint loc = [pan locationInView:self.view];

    if (pan.state == UIGestureRecognizerStateBegan) {

        // 与headerView建立附着关系
        _leaderAttach = [[UIAttachmentBehavior alloc] initWithItem:_headerView attachedToAnchor:loc];
        [_animator addBehavior:_leaderAttach];

    } else if (pan.state == UIGestureRecognizerStateChanged) {

        // 如果拖拽正在进行，就转换附着点
        _leaderAttach.anchorPoint = loc;

    } else if (pan.state == UIGestureRecognizerStateEnded) {

        // 如果拖拽结束，就移除附着行为
        [_animator removeBehavior:_leaderAttach];
    }
}


- (void)doubleTapPop
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
