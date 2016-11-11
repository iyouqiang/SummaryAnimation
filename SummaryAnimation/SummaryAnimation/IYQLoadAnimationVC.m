//
//  IYQLoadAnimationVC.m
//  SummaryAnimation
//
//  Created by chmtech003 on 16/7/22.
//  Copyright © 2016年 gongyouqiang. All rights reserved.
//

#import "IYQLoadAnimationVC.h"
#import "IYQLoadViewOne.h"
#import "IYQSandClockView.h"
@interface IYQLoadAnimationVC ()


@end

@implementation IYQLoadAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadingCircle];

    [self loadingsandClockView];
}

- (void)loadingCircle
{
    IYQLoadViewOne *oneView = [[IYQLoadViewOne alloc] initWithFrame:CGRectMake(10.0f, 64.0-25.f, 50.0f, 50.0f)];
    [self.view addSubview:oneView];
}

- (void)loadingsandClockView
{
    IYQSandClockView *sandClockView = [[IYQSandClockView alloc] initWithFrame:CGRectMake(100.0f, 80.0f, 43.0f, 43.0f)];
    [sandClockView showAnimation];
    [self.view addSubview:sandClockView];
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
