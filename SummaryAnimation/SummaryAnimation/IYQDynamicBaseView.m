//
//  IYQDynamicBaseView.m
//  SummaryAnimation
//
//  Created by chmtech003 on 2016/11/30.
//  Copyright © 2016年 gongyouqiang. All rights reserved.
//

#import "IYQDynamicBaseView.h"
#import <UIKit/UIKit.h>

@implementation IYQDynamicBaseView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    if (self) {

        // 设置背景
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"BackgroundTile"]];

        // 设置方块
        UIImageView *boxView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Box1"]];
        boxView.center = CGPointMake(200, 220);
        [self addSubview:boxView];
        self.boxView = boxView;

        // 初始化仿真者
        UIDynamicAnimator *animator = [[UIDynamicAnimator alloc] initWithReferenceView:self];
        self.animator = animator;
    }

    return self;
}

@end
