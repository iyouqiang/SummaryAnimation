//
//  IYQPraiseViewController.m
//  SummaryAnimation
//
//  Created by chmtech003 on 16/7/22.
//  Copyright © 2016年 gongyouqiang. All rights reserved.
//

#import "IYQPraiseViewController.h"
#import "IYQPraiseBtn.h"

@interface IYQPraiseViewController ()
@property (nonatomic, strong) IYQPraiseBtn *praise;
@end

@implementation IYQPraiseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self.view addSubview:self.praise];
}

- (IYQPraiseBtn *)praise
{
    if (!_praise) {
        _praise = [IYQPraiseBtn buttonWithType:UIButtonTypeCustom];
        _praise.frame = CGRectMake(0, 0, 50.f, 50.f);
        [_praise setImage:[UIImage imageNamed:@"Like-Blue"] forState:UIControlStateSelected];
        [_praise setImage:[UIImage imageNamed:@"Like"] forState:UIControlStateNormal];
        [_praise addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        _praise.center =  CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
    }
    return _praise;
}

- (void)clickAction:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (sender.selected) {
        [_praise animate];
        [_praise popOutsideWithDuration:0.5];
    }else {

        [_praise popInsideWithDuration:0.4];
    }

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
