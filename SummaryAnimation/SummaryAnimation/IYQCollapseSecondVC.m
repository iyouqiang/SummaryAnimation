//
//  IYQCollapseSecondVC.m
//  SummaryAnimation
//
//  Created by chmtech003 on 2016/11/11.
//  Copyright © 2016年 gongyouqiang. All rights reserved.
//

#import "IYQCollapseSecondVC.h"

@interface IYQCollapseSecondVC ()

@end

@implementation IYQCollapseSecondVC

- (void)viewDidLoad {

    [super viewDidLoad];
    UIImageView *image = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    image.image        = [UIImage imageNamed:@"IMG_0227"];
    [self.view addSubview:image];

    UITapGestureRecognizer *tapToClose = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close)];
    [self.view addGestureRecognizer:tapToClose];
}

- (void)close {

    [self dismissViewControllerAnimated:YES completion:nil];
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
