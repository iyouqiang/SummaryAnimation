//
//  IYQMaskVC.m
//  SummaryAnimation
//
//  Created by chmtech003 on 2016/11/23.
//  Copyright © 2016年 gongyouqiang. All rights reserved.
//

#import "IYQMaskVC.h"

@interface IYQMaskVC ()

@property (nonatomic, strong) UIView *movedView;
@property (nonatomic, strong) UIView *movingView;

@end

@implementation IYQMaskVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
    imageView.image = [UIImage imageNamed:@"2"];
    [self.view addSubview:imageView];

    _movedView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    _movedView.layer.cornerRadius = 50.0;
    _movedView.backgroundColor = [UIColor redColor];
    _movedView.clipsToBounds = YES;
    [self.view addSubview:_movedView];
    imageView.layer.mask = _movedView.layer;

    _movingView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [self.view addSubview:_movingView];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [_movingView addGestureRecognizer:tap];

    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [self.view addGestureRecognizer:tap1];

    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [_movingView addGestureRecognizer:pan];

    UIPanGestureRecognizer *pan2 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.view addGestureRecognizer:pan2];
}

- (void)pan:(UIPanGestureRecognizer *)rcongnizer
{

}

- (void)tap:(UITapGestureRecognizer *)rcongnizer
{
    // 判断矩形是否相等
    if (CGRectEqualToRect(_movingView.frame, _movedView.frame)) {


    }
}

@end
