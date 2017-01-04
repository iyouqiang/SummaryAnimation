//
//  IYQCollisionView.m
//  SummaryAnimation
//
//  Created by chmtech003 on 2016/12/1.
//  Copyright © 2016年 gongyouqiang. All rights reserved.
//

#import "IYQCollisionView.h"

@implementation IYQCollisionView

- (instancetype)init
{
    self = [super init];

    if (self) {

        self.boxView.center = CGPointMake(190, 0);

        // 1.添加重力行为
        UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[self.boxView]];
        [self.animator addBehavior:gravity];

        // 2.边缘检测
        UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:@[self.boxView]];
        // 让碰撞的行为生效
        collision.translatesReferenceBoundsIntoBoundary = YES;
        collision.collisionDelegate = self;

        // 3.添加一个红色view
        UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(0, 350, 180, 30)];
        redView.backgroundColor = [UIColor redColor];
        [self addSubview:redView];

        // 4.手动添加边界
        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRect:redView.frame];
        [collision addBoundaryWithIdentifier:@"redboundary" forPath:bezierPath];
        [self.animator addBehavior:collision];

         // 5.物体的属性行为
        UIDynamicItemBehavior *item = [[UIDynamicItemBehavior alloc] initWithItems:@[self.boxView]];

        // 设置物体弹性，振幅
        item.elasticity = 0.8;
        [self.animator addBehavior:item];
    }

    return self;
}

#pragma mark - UICollisionBehaviorDelegate
// 在碰撞的时候调用
- (void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p {

    NSLog(@"%@", NSStringFromCGPoint(p));

    //    UIView *view = (UIView *)item;
    //    view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
