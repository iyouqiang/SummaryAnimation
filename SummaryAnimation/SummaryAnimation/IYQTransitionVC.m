//
//  IYQTransitionVC.m
//  SummaryAnimation
//
//  Created by chmtech003 on 16/7/22.
//  Copyright © 2016年 gongyouqiang. All rights reserved.
//

#import "IYQTransitionVC.h"

@interface IYQTransitionVC ()

@property (nonatomic, strong) UIView *transitonView;
@property (nonatomic, strong) UIView *transitonSubView;

@end

@implementation IYQTransitionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self.view addSubview:self.transitonView];
    [self.view addSubview:self.transitonSubView];

    CGFloat btnwidth  = 60.f;
    CGFloat btnheight = 30.f;
    CGFloat gapwidth  = ([UIScreen mainScreen].bounds.size.width - 4 * btnheight - 40.f)/3.0f;
    NSArray * operateTitleArray = @[@"fade",
                                    @"moveIn",
                                    @"push",
                                    @"reveal",
                                    @"cube",
                                    @"suck",
                                    @"oglFlip",
                                    @"ripple",
                                    @"Curl",
                                    @"UnCurl",
                                    @"caOpen",
                                    @"caClose"];

    for (int i = 0, j = 0; i < operateTitleArray.count; i ++ ) {

        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        if (i % 3 == 0) {
            j = 0;
        }
        btn.frame = CGRectMake(20.f + j*(gapwidth + btnwidth), (i/3) * (btnheight + 10) + 400.0f, btnwidth, btnheight);
        j ++;
        btn.backgroundColor = [UIColor lightGrayColor];
        [btn setTitle:operateTitleArray[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        [self.view addSubview:btn];
    }
}

- (UIView *)transitonView
{
    if (!_transitonView) {

        _transitonView = [[UIView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 200.0f)/2.0f, 70.0f, 200.0f, 320)];
        _transitonView.backgroundColor = [UIColor whiteColor];
    }

    return _transitonView;
}

- (UIView *)transitonSubView
{
    if (!_transitonSubView) {

        _transitonSubView = [[UIView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 200.0f)/2.0f, 70.0f, 200.0f, 320)];
        _transitonSubView.backgroundColor = [UIColor purpleColor];
        [_transitonSubView setHidden:YES];
    }

    return _transitonSubView;
}


- (void)clickBtn : (UIButton *)btn{
    switch (btn.tag) {
        case 0:
            [self fadeAnimation];
            break;
        case 1:
            [self moveInAnimation];
            break;
        case 2:
            [self pushAnimation];
            break;
        case 3:
            [self revealAnimation];
            break;
        case 4:
            [self cubeAnimation];
            break;
        case 5:
            [self suckEffectAnimation];
            break;
        case 6:
            [self oglFlipAnimation];
            break;
        case 7:
            [self rippleEffectAnimation];
            break;
        case 8:
            [self pageCurlAnimation];
            break;
        case 9:
            [self pageUnCurlAnimation];
            break;
        case 10:
            [self cameraIrisHollowOpenAnimation];
            break;
        case 11:
            [self cameraIrisHollowCloseAnimation];
            break;
        default:
            break;
    }
}

/**
 *  逐渐消失
 */
- (void)fadeAnimation{

    //[self changeView:YES];

    [self testChangeView];

    CATransition *anima = [CATransition animation];
    anima.type = kCATransitionFade;//设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    //anima.startProgress = 0.3;//设置动画起点
    //anima.endProgress = 0.8;//设置动画终点
    anima.duration = 1.0f;

    [self.view.layer addAnimation:anima forKey:@"fadeAnimation"];
}

- (void)moveInAnimation{
    [self changeView:YES];
    CATransition *anima = [CATransition animation];
    anima.type = kCATransitionMoveIn;       //设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;

    [_transitonView.layer addAnimation:anima forKey:@"moveInAnimation"];
}

- (void) pushAnimation{
    [self changeView:YES];
    CATransition *anima = [CATransition animation];
    anima.type = kCATransitionPush;//设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;

    [_transitonView.layer addAnimation:anima forKey:@"pushAnimation"];
}

- (void)revealAnimation{
    [self changeView:YES];
    CATransition *anima = [CATransition animation];
    anima.type = kCATransitionReveal;      //设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;

    [_transitonView.layer addAnimation:anima forKey:@"revealAnimation"];
}

//-----------------------------private api------------------------------------
/*
	Don't be surprised if Apple rejects your app for including those effects,
	and especially don't be surprised if your app starts behaving strangely after an OS update.
 */


/**
 *  立体翻滚效果
 */
- (void)cubeAnimation{
    [self changeView:YES];
    CATransition *anima = [CATransition animation];
    anima.type = @"cube";                   //设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;

    [_transitonView.layer addAnimation:anima forKey:@"revealAnimation"];
}


- (void)suckEffectAnimation{
    [self changeView:YES];
    CATransition *anima = [CATransition animation];
    anima.type = @"suckEffect";             //设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;

    [_transitonView.layer addAnimation:anima forKey:@"suckEffectAnimation"];
}

-   (void)oglFlipAnimation{
    [self changeView:YES];
    CATransition *anima = [CATransition animation];
    anima.type = @"oglFlip";                //设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;

    [_transitonView.layer addAnimation:anima forKey:@"oglFlipAnimation"];
}

- (void)rippleEffectAnimation{
    [self changeView:YES];
    CATransition *anima = [CATransition animation];
    anima.type = @"rippleEffect";           //设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;

    [_transitonView.layer addAnimation:anima forKey:@"rippleEffectAnimation"];
}

- (void)pageCurlAnimation{
    [self changeView:YES];
    CATransition *anima = [CATransition animation];
    anima.type = @"pageCurl";               //设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;

    [_transitonView.layer addAnimation:anima forKey:@"pageCurlAnimation"];
}

- (void)pageUnCurlAnimation{
    [self changeView:YES];
    CATransition *anima = [CATransition animation];
    anima.type = @"pageUnCurl";             //设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;

    [_transitonView.layer addAnimation:anima forKey:@"pageUnCurlAnimation"];
}

- (void)cameraIrisHollowOpenAnimation{
    [self changeView:YES];
    CATransition *anima = [CATransition animation];
    anima.type = @"cameraIrisHollowOpen";   //设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;

    [_transitonView.layer addAnimation:anima forKey:@"cameraIrisHollowOpenAnimation"];
}

- (void)cameraIrisHollowCloseAnimation{
    [self changeView:YES];
    CATransition *anima = [CATransition animation];
    anima.type = @"cameraIrisHollowClose";  //设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;

    [_transitonView.layer addAnimation:anima forKey:@"cameraIrisHollowCloseAnimation"];
}

/**
 *   设置view的值
 */
-(void)changeView : (BOOL)isUp{

    NSArray *colors = [NSArray arrayWithObjects:[UIColor cyanColor],[UIColor magentaColor],[UIColor orangeColor],[UIColor purpleColor], [UIColor greenColor], [UIColor blueColor], [UIColor magentaColor], [UIColor brownColor], nil];
    _transitonView.backgroundColor = [colors objectAtIndex:arc4random_uniform(8)];
}

NSInteger count;
- (void)testChangeView
{
    count ++;
    if (count % 2 == 0) {

        [_transitonView setHidden:YES];
        [_transitonSubView setHidden:NO];
    }else {

        [_transitonView setHidden:NO];
        [_transitonSubView setHidden:YES];
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
