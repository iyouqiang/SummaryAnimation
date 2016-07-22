//
//  IYQLoadAnimationVC.m
//  SummaryAnimation
//
//  Created by chmtech003 on 16/7/22.
//  Copyright © 2016年 gongyouqiang. All rights reserved.
//

#import "IYQLoadAnimationVC.h"
#import "IYQLoadViewOne.h"

@interface IYQLoadAnimationVC ()


@end

@implementation IYQLoadAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self loadingView1];
}

- (void)loadingView1
{
    IYQLoadViewOne *oneView = [[IYQLoadViewOne alloc] initWithFrame:CGRectMake(10.0f, 64.f, 50.0f, 50.0f)];
    [self.view addSubview:oneView];
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
