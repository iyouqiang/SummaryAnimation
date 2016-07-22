//
//  IYQSuspensionBtn.m
//  SummaryAnimation
//
//  Created by chmtech003 on 16/7/8.
//  Copyright © 2016年 gongyouqiang. All rights reserved.
//

#import "IYQSuspensionVC.h"
#import "IYQSuspensionBtnView.h"

@interface IYQSuspensionVC ()

@property (nonatomic, strong) NSMutableArray    *btnArray;
@property (nonatomic, strong) IYQSuspensionBtnView *btnView;

@end

@implementation IYQSuspensionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self.view addSubview:self.btnView];
    
    // 创建其他功能按钮
    [self createFunctionBtn];
}

- (IYQSuspensionBtnView *)btnView{

    if (!_btnView) {

        _btnView = [[IYQSuspensionBtnView alloc] initWithFrame:CGRectMake(0.f, 64.f, 40.f, 40.f)];
    }

    return _btnView;
}


#pragma mark - 创建附带按钮
- (void)createFunctionBtn
{
    _btnArray=[[NSMutableArray alloc] init];
    
    [self createBtn:@[@"chooser-moment-icon-camera.png",
                      @"chooser-moment-icon-music.png",
                      @"chooser-moment-icon-sleep.png",
                      @"chooser-moment-icon-thought.png",
                      @"chooser-moment-icon-place.png"]];
    
    [_btnView showBtnArray:_btnArray clickIndex:^(NSInteger index) {
       
        NSLog(@"index : %ld", index);
    }];
}

- (void)createBtn:(NSArray *)btnImageName{
    
    for (int i = 0 ; i < btnImageName.count; i++) {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.userInteractionEnabled = YES;
        btn.frame=CGRectMake(0,0, 30, 30);
        btn.backgroundColor=[UIColor colorWithRed:247/255.0 green:251/255.0 blue:242/255.0 alpha:1];
        btn.layer.cornerRadius=30/2.0f;
        [btn setImage:[UIImage imageNamed:btnImageName[i]] forState:UIControlStateNormal];
        [_btnArray addObject:btn];
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
