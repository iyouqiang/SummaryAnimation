//
//  IYQFragmentViewController.m
//  SummaryAnimation
//
//  Created by chmtech003 on 2016/11/11.
//  Copyright © 2016年 gongyouqiang. All rights reserved.
//

#import "IYQFragmentViewController.h"
#import "IYQCollapseSecondVC.h"
#import "IYQCollapseAnimator.h"
@interface IYQFragmentViewController ()

@end

@implementation IYQFragmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 100, 100.0, 100.0);
    btn.center = self.view.center;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:@"戳我" forState:UIControlStateNormal];

    [btn addTarget:self action:@selector(transition) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)transition {

    IYQCollapseSecondVC *secView = [[IYQCollapseSecondVC alloc] init];
    secView.transitioningDelegate = self;
    [self presentViewController:secView animated:YES completion:nil];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {

    IYQCollapseAnimator *animator = [[IYQCollapseAnimator alloc] init];
    //animator.duration = 1;
    //animator.sideLength = 8;
    return animator;
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
