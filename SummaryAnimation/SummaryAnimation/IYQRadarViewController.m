//
//  IYQRadarViewController.m
//  SummaryAnimation
//
//  Created by chmtech003 on 16/8/11.
//  Copyright © 2016年 gongyouqiang. All rights reserved.
//

#import "IYQRadarViewController.h"

@interface IYQRadarViewController ()

@property (nonatomic, strong) UIView *radarView;

@end

@implementation IYQRadarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self radarAnimation];

    [self drawLine];
}

- (UIView *)radarView
{
    if (!_radarView) {

        _radarView = [[UIView alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.view.frame) - 100.0f)/2.0f, 200.0f, 100.0f, 100.0f)];
        _radarView.clipsToBounds = YES;
    }

    return _radarView;
}

// 雷达波纹
- (void)radarAnimation
{
    [self.view addSubview:self.radarView];
    CAShapeLayer *radarShapeLayer = [CAShapeLayer layer];
    radarShapeLayer.frame = _radarView.bounds;
    radarShapeLayer.path = [UIBezierPath bezierPathWithOvalInRect:_radarView.bounds].CGPath;
    radarShapeLayer.fillColor = [UIColor redColor].CGColor;
    radarShapeLayer.opacity = 0.0;

    // 复制layer
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.instanceCount = 4;
    replicatorLayer.instanceDelay = 1;
    [replicatorLayer addSublayer:radarShapeLayer];
    [self.radarView.layer addSublayer:replicatorLayer];

    // 透明度变化
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = @(0.3);
    opacityAnimation.toValue = @(0.0);

    //3d 放大
    CABasicAnimation *transformAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    transformAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 0, 0, 0)];
    transformAnimation.toValue   = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 1, 1, 0)];

    // 组动画
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = @[opacityAnimation, transformAnimation];
    groupAnimation.duration = 4.0;
    groupAnimation.repeatCount = MAXFLOAT;
    groupAnimation.autoreverses = NO;
    [radarShapeLayer addAnimation:groupAnimation forKey:@"radarAnimation"];
}

// 画线
- (void)drawLine
{
    CGFloat wh = 150.0f;
    CGFloat screenw = CGRectGetWidth(self.view.frame);
    /*
    CGPoint path1 = CGPointMake((screenw - wh)/2.0f, 100.0f);
    CGPoint path2 = CGPointMake((screenw - wh)/2.0f, 100.0f + wh);
    CGPoint path3 = CGPointMake((screenw - wh)/2.0f + wh, 100.0f + wh);
    CGPoint path4 = CGPointMake((screenw - wh)/2.0f + wh, 100.0f);

    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:path1];
    [path addLineToPoint:path2];
    [path addLineToPoint:path3];
    [path addLineToPoint:path4];
    [path addLineToPoint:path1];
     */
    CGPoint topcenter = CGPointMake(screenw/2.0f, 100.0f);
    CGPoint bottomcenter = CGPointMake(screenw/2.0f, 150 + wh);

    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:topcenter];
    [path addQuadCurveToPoint:bottomcenter controlPoint:CGPointMake(-60.0f, 40.0f)];
    [path addQuadCurveToPoint:topcenter controlPoint:CGPointMake(screenw + 60.0f, 40.f)];

    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = CGRectMake(0, 64.0f, 150.0f, 150.f);
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.path = path.CGPath;
    [self.view.layer addSublayer:shapeLayer];

    CABasicAnimation *strokeAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeAnimation.fromValue = @(0.0);
    strokeAnimation.toValue   = @(1.0);
    strokeAnimation.duration = 4.0f;
    strokeAnimation.repeatCount = MAXFLOAT;
    strokeAnimation.autoreverses = NO;
    [shapeLayer addAnimation:strokeAnimation forKey:@"strokeAnimation"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
