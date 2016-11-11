//
//  IYQLauchTool.m
//  SummaryAnimation
//
//  Created by chmtech003 on 16/8/12.
//  Copyright © 2016年 gongyouqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IYQLauchTool.h"
#import "IYQAnimationView.h"
// 16进制颜色转换
#define HexColor(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface IYQLauchTool ()<AnimatiomViewDelegate>

@property (nonatomic, strong) UIWindow *window;

@end

@implementation IYQLauchTool

///在load 方法中，启动监听，可以做到无注入
+ (void)load
{
    [self shareInstance];
}

+ (instancetype)shareInstance
{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];

    if (self) {

        [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {

            ///要等DidFinished方法结束后才能初始化UIWindow，不然会检测是否有rootViewController
            dispatch_async(dispatch_get_main_queue(), ^{

                [self checkView];
            });
        }];

        /*
        ///进入后台
        [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidEnterBackgroundNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {

        }];
        ///后台启动,二次开屏
        [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationWillEnterForegroundNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {

        }];
         */
    }

    return self;
}

- (void)checkView
{
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];

    [self showWindowView:window];

    window.windowLevel = UIWindowLevelStatusBar + 1;

    window.hidden = NO;

    window.backgroundColor = [UIColor colorWithRed:221 green:250 blue:242 alpha:1.0f];
    /*
    window.alpha = 0.0;

    [UIView animateWithDuration:0.3 animations:^{

        window.alpha = 1.0;
    }];
     */
    self.window = window;
}

- (void)showWindowView:(UIWindow *)window
{
    CGFloat size = 100.0;
    IYQAnimationView *lauchAnimation = [[IYQAnimationView alloc] initWithFrame:CGRectMake(CGRectGetWidth(window.frame)/2 - size/2, CGRectGetHeight(window.frame)/2 - size/2, size, size)];
    lauchAnimation.delegate = self;
    lauchAnimation.parentFrame = window.bounds;
    [window addSubview:lauchAnimation];
}

- (void)completeAnimation
{
    UILabel *label = [[UILabel alloc] initWithFrame:self.window.frame];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:50.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"Welcome";
    label.transform = CGAffineTransformScale(label.transform, 0.25, 0.25);
    [self.window addSubview:label];

    [UIView animateWithDuration:0.4 delay:0.0 usingSpringWithDamping:0.7 initialSpringVelocity:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{

        label.transform = CGAffineTransformScale(label.transform, 4.0, 4.0);

    } completion:^(BOOL finished) {

        ///给非UIControl的子类，增加点击事件
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
        [self.window addGestureRecognizer:tap];
    }];
}

// 隐藏
- (void)hide
{
    ///来个渐显动画
    [UIView animateWithDuration:0.3 animations:^{
        self.window.alpha = 0;
    } completion:^(BOOL finished) {
        [self.window.subviews.copy enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
        self.window.hidden = YES;
        self.window = nil;
    }];
}

@end
