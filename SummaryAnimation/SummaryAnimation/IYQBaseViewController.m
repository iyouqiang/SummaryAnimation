//
//  IYQBaseViewController.m
//  SummaryAnimation
//
//  Created by chmtech003 on 2016/11/10.
//  Copyright © 2016年 gongyouqiang. All rights reserved.
//

#import "IYQBaseViewController.h"
#import "IYQMainView.h"
#import "IYQMainModel.h"
#import "AppDelegate.h"
@interface IYQBaseViewController ()

@property (nonatomic, retain)IYQMainView *suspendView;
@property (nonatomic, strong) UIButton *cancelBtn;

@end

@implementation IYQBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithHexString:@"#FFABA7"]; //#FFABA7 #40e0b0
    _suspendView =[[IYQMainView alloc]init];
    _suspendView.userInteractionEnabled = YES;
    _suspendView.center =  [IYQMainModel shareIYQMainModelManager].popCenter;
    _suspendView.bounds = CGRectMake(0,0, CGRectGetWidth(self.view.frame), 64.0f);
    _suspendView.suspendimgView.image = [IYQMainModel shareIYQMainModelManager].showimgView.suspendimgView.image;
    _suspendView.suspendLabel.text    = [IYQMainModel shareIYQMainModelManager].showimgView.suspendLabel.text;
    [self.view addSubview:_suspendView];

    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelBtn.frame = CGRectMake(0 ,0 ,100 ,64);
    [_cancelBtn setTitle:@"返回" forState:UIControlStateNormal];
    _cancelBtn.userInteractionEnabled = YES;
    [_cancelBtn setEnabled:YES];
    [_cancelBtn setTitleColor:[UIColor colorWithHexString:@"#40e0b0"] forState:UIControlStateNormal];
    _cancelBtn.backgroundColor = [UIColor clearColor];
    [_cancelBtn addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_cancelBtn];

    [self expandCoop];
}

 // 缩小或放大
- (void)expandCoop
{
    CGRect rect = CGRectInset(_suspendView.frame, -600, -600);
    CGPathRef startPath = CGPathCreateWithEllipseInRect(_suspendView.frame, NULL);
    CGPathRef endPath   = CGPathCreateWithEllipseInRect(rect, NULL);

    CAShapeLayer *masklayer = [[CAShapeLayer alloc] init];
    masklayer.path = endPath;
    self.view.layer.mask = masklayer;

    CABasicAnimation *pingAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    pingAnimation.fromValue = (__bridge id)(startPath);
    pingAnimation.toValue   = (__bridge id)(endPath);
    pingAnimation.duration  = 1;
    pingAnimation.delegate = self;
    [pingAnimation setValue:@"animate1" forKey:@"animate1"];
    pingAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

    [masklayer addAnimation:pingAnimation forKey:@"pingInvert1"];

    CGPathRelease(startPath);
    CGPathRelease(endPath);
}

//缩小的圈圈*/
- (void)scalaCoop
{
    CGRect rect = CGRectInset(_suspendView.frame, -600, -600);
    CGPathRef startPath = CGPathCreateWithEllipseInRect(rect, NULL);
    CGPathRef endPath   = CGPathCreateWithEllipseInRect(_suspendView.frame, NULL);

    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.path = endPath;

    self.view.layer.mask = maskLayer;

    CABasicAnimation *pingAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    pingAnimation.delegate = self;
    [pingAnimation setValue:@"animate2" forKey:@"animate2"];

    pingAnimation.fromValue = (__bridge id)(startPath);
    pingAnimation.toValue   = (__bridge id)(endPath);
    pingAnimation.duration  = 1;
    pingAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [maskLayer addAnimation:pingAnimation forKey:@"pingInvert2"];

    CGPathRelease(startPath);
    CGPathRelease(endPath);
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if ([[anim valueForKey:@"animate1"] isEqualToString:@"animate1"]) {

        [self removeImage];

    }else if([[anim valueForKey:@"animate2"] isEqualToString:@"animate2"])
    {
         [self animation];
    }
}

- (void)removeImage
{
    [[IYQMainModel shareIYQMainModelManager].showimgView removeFromSuperview];
}

- (void)animation
{
    IYQMainView *showImgview = [IYQMainModel shareIYQMainModelManager].showimgView;

    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.view.alpha = 0;

    } completion:^(BOOL finished) {

        [UIView animateWithDuration:0.5 animations:^{
            showImgview.bounds = CGRectMake(0, 0, 110, 110);
            showImgview.layer.shadowOffset = CGSizeMake(4, 4);
            showImgview.layer.shadowRadius = 30;
            showImgview.layer.shadowColor = [UIColor blackColor].CGColor;
            showImgview.layer.shadowOpacity = 0.9;
            showImgview.center = [IYQMainModel shareIYQMainModelManager].pushCenter;

        } completion:^(BOOL finished) {

            [UIView animateWithDuration:0.2 animations:^{
                showImgview.bounds = CGRectMake(0,0, 100, 100);

            } completion:^(BOOL finished) {
                showImgview.layer.shadowOffset = CGSizeMake(0, 0);
                showImgview.layer.shadowRadius = 0;
                showImgview.layer.shadowColor = [UIColor clearColor].CGColor;
                [showImgview removeFromSuperview];

                [self.navigationController popViewControllerAnimated:NO];

            }];
        }];
    }];
}

- (void)addImage
{
    [UIView animateWithDuration:0.3 animations:^{
        [_cancelBtn removeFromSuperview];
        CGFloat dx = (CGRectGetWidth(self.view.frame) - 110)/2.0;
        _suspendView.frame = CGRectMake(dx, 0, 110, 110);
        [IYQMainModel shareIYQMainModelManager].showimgView.frame = CGRectMake(dx, 0, 110, 110);
    }];

    AppDelegate *appdele = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appdele.window addSubview: [IYQMainModel shareIYQMainModelManager].showimgView];
}

- (void)goBack:(UIButton *)sender
{
    sender.enabled = NO;
    [self addImage];
    [self scalaCoop];
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
