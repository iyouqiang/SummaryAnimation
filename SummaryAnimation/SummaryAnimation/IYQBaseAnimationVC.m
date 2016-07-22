//
//  IYQBaseAnimationVC.m
//  SummaryAnimation
//
//  Created by chmtech003 on 16/7/7.
//  Copyright © 2016年 gongyouqiang. All rights reserved.
//

#import "IYQBaseAnimationVC.h"

@interface IYQBaseAnimationVC ()

@property (nonatomic, strong) UIView *shakeOBView;

@end

@implementation IYQBaseAnimationVC

- (void)viewDidLoad {

    [super viewDidLoad];
    // Do any additional setup after loading the view.

    _shakeOBView = [[UIView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 60)/2.f, 300.f, 60.f, 60.f)];
    _shakeOBView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_shakeOBView];
    /**
     * rotation.x
     * rotation.y
     * rotation.z
     * rotation
     * scale.x
     * scale.y
     * scale.z
     * scale
     * translation.x
     * translation.y
     * translation.z
     * translation
     * position
     * backgroundColor  // 背景色动画
     * opacity          // 透明度动画
     */

    /*
     CAAnimation可分为四种：

     1.CABasicAnimation
     通过设定起始点，终点，时间，动画会沿着你这设定点进行移动。可以看做特殊的CAKeyFrameAnimation
     2.CAKeyframeAnimation
     Keyframe顾名思义就是关键点的frame，你可以通过设定CALayer的始点、中间关键点、终点的frame，时间，动画会沿你设定的轨迹进行移动
     3.CAAnimationGroup
     Group也就是组合的意思，就是把对这个Layer的所有动画都组合起来。PS：一个layer设定了很多动画，他们都会同时执行，如何按顺序执行我到时候再讲。
     4.CATransition
     这个就是苹果帮开发者封装好的一些动画
     */

    /*
     http://www.cnblogs.com/wengzilin/p/4250957.html
     演员--->CALayer，规定电影的主角是谁
     剧本--->CAAnimation，规定电影该怎么演，怎么走，怎么变换
     开拍--->AddAnimation，开始执行
     */

    // 心跳动画
    [self heartAnimation];

    // 组合动画
    [self groupAnimation];

    // 关键帧动画
    [self cakeyframeAnimation];

    // 抖动动画
    [self shakeAnimation];

    // 透明度动画
    [self opacityAniamtion];

    // 背景色动画
    [self backgroundAnimation];
}

- (void)heartAnimation
{
    // 演员初始化
    CALayer *scaleLayer = [[CALayer alloc] init];
    scaleLayer.backgroundColor = [UIColor redColor].CGColor;
    scaleLayer.frame = CGRectMake(20, 80, 50, 50);
    scaleLayer.cornerRadius = 10.f;
    [self.view.layer addSublayer:scaleLayer];

    // 设置剧本
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    scaleAnimation.toValue = [NSNumber numberWithFloat:1.5];
    scaleAnimation.autoreverses = YES;
    scaleAnimation.fillMode = kCAFillModeForwards;
    scaleAnimation.repeatCount = MAXFLOAT;
    scaleAnimation.duration = 0.8;

    // 开演
    [scaleLayer addAnimation:scaleAnimation forKey:@"scaleAnimation"];
}

- (void)groupAnimation
{
    CALayer *groupLayer = [[CALayer alloc] init];
    groupLayer.frame = CGRectMake(20.f, 150.f, 50, 50);
    groupLayer.cornerRadius = 10.f;
    groupLayer.backgroundColor = [UIColor orangeColor].CGColor;
    [self.view.layer addSublayer:groupLayer];

    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    scaleAnimation.toValue = [NSNumber numberWithFloat:1.5];
    scaleAnimation.autoreverses = YES;
    scaleAnimation.repeatCount = MAXFLOAT;
    scaleAnimation.duration = 0.8;

    CABasicAnimation *moveAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    moveAnimation.fromValue = [NSValue valueWithCGPoint:groupLayer.position];
    moveAnimation.toValue   = [NSValue valueWithCGPoint:CGPointMake([UIScreen mainScreen].bounds.size.width - 20.f, groupLayer.position.y)];
    moveAnimation.autoreverses = YES;
    moveAnimation.repeatCount = MAXFLOAT;
    moveAnimation.duration = 2.0;

    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    rotateAnimation.fromValue = [NSNumber numberWithFloat:0.0];
    rotateAnimation.toValue = [NSNumber numberWithFloat:6.0 * M_PI];
    rotateAnimation.autoreverses = YES;
    rotateAnimation.repeatCount = MAXFLOAT;
    rotateAnimation.duration = 2.0f;

    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.duration = 2;
    groupAnimation.autoreverses = YES;
    groupAnimation.animations = @[moveAnimation, scaleAnimation, rotateAnimation];
    groupAnimation.repeatCount = MAXFLOAT;

    [groupLayer addAnimation:groupAnimation forKey:@"groupAnimation"];
}

- (void)cakeyframeAnimation
{
    // 小黑点画方框
    [self darkdot];

    // 抛物线动画
    [self throwLineAnimation];
}

- (void)darkdot
{
    CALayer *rectLayer = [[CALayer alloc] init];
    rectLayer.frame = CGRectMake(20, 200, 30, 30);
    rectLayer.cornerRadius = 15.f;
    rectLayer.backgroundColor = [UIColor blackColor].CGColor;
    [self.view.layer addSublayer:rectLayer];
    CGFloat screenWith = [UIScreen mainScreen].bounds.size.width;
    CAKeyframeAnimation *rectRunAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];

    /*
     （1）values属性

     values属性指明整个动画过程中的关键帧点，例如上例中的A-E就是通过values指定的。需要注意的是，起点必须作为values的第一个值。

     （2）path属性

     作用与values属性一样，同样是用于指定整个动画所经过的路径的。需要注意的是，values与path是互斥的，当values与path同时指定时，path会覆盖values，即values属性将被忽略。
     */

    // 使用value
    rectRunAnimation.values = @[[NSValue valueWithCGPoint:rectLayer.position],
                                [NSValue valueWithCGPoint:CGPointMake(screenWith - 20.0f,rectLayer.position.y)],
                                [NSValue valueWithCGPoint:CGPointMake(screenWith - 20.0f,rectLayer.position.y + 100)],
                                [NSValue valueWithCGPoint:CGPointMake(20, rectLayer.position.y + 100)],
                                [NSValue valueWithCGPoint:rectLayer.position]];

    // 使用path会覆盖上面的value
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, rectLayer.position.x , rectLayer.position.y);
    CGPathAddLineToPoint(path, NULL, screenWith - 20, rectLayer.position.y);
    CGPathAddLineToPoint(path, NULL, screenWith - 20, rectLayer.position.y + 100);
    CGPathAddLineToPoint(path, NULL, 20, rectLayer.position.y + 100);
    CGPathAddLineToPoint(path, NULL, rectLayer.position.x, rectLayer.position.y);
    rectRunAnimation.path = path;
    CGPathRelease(path);

    /*
     keyTimes属性

     该属性是一个数组，用以指定每个子路径(AB,BC,CD)的时间。如果你没有显式地对keyTimes进行设置，则系统会默认每条子路径的时间为：ti=duration/(5-1)，即每条子路径的duration相等，都为duration的1\4。当然，我们也可以传个数组让物体快慢结合。例如，你可以传入{0.0, 0.1,0.6,0.7,1.0}，其中首尾必须分别是0和1，因此tAB=0.1-0, tCB=0.6-0.1, tDC=0.7-0.6, tED=1-0.7.....
     */

    rectRunAnimation.keyTimes = @[[NSNumber numberWithFloat:0.0],
                                  [NSNumber numberWithFloat:0.6],
                                  [NSNumber numberWithFloat:0.7],
                                  [NSNumber numberWithFloat:0.8],
                                  [NSNumber numberWithFloat:1]];
    /*
     timeFunctions属性

     这个属性用以指定时间函数，类似于运动的加速度，有以下几种类型。上例子的AB段就是用了淡入淡出效果。记住，这是一个数组，你有几个子路径就应该传入几个元素

     1 kCAMediaTimingFunctionLinear//线性
     2 kCAMediaTimingFunctionEaseIn//淡入
     3 kCAMediaTimingFunctionEaseOut//淡出
     4 kCAMediaTimingFunctionEaseInEaseOut//淡入淡出
     5 kCAMediaTimingFunctionDefault//默认
     */
    rectRunAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],
                                         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],
                                         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];

    /*
     calculationMode属性

     该属性决定了物体在每个子路径下是跳着走还是匀速走，跟timeFunctions属性有点类似

     1 const kCAAnimationLinear//线性，默认
     2 const kCAAnimationDiscrete//离散，无中间过程，但keyTimes设置的时间依旧生效，物体跳跃地出现在各个关键帧上
     3 const kCAAnimationPaced//平均，keyTimes跟timeFunctions失效
     4 const kCAAnimationCubic//平均，同上
     5 const kCAAnimationCubicPaced//平均，同上
     */
    rectRunAnimation.calculationMode = kCAAnimationLinear;

    rectRunAnimation.repeatCount = MAXFLOAT;
    rectRunAnimation.autoreverses = NO;
    rectRunAnimation.duration = 4;
    [rectLayer addAnimation:rectRunAnimation forKey:@"rectRunAnimation"];
}

// 动画的暂停与开始
- (void)pauseLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed = 0.0;
    // 记录动画的暂停时间
    layer.timeOffset = pausedTime;
}

- (void)resumeLayer:(CALayer*)layer
{
    CFTimeInterval pauseTime = [layer timeOffset];
    layer.speed = 1.0;
    layer.timeOffset = 0.0;
    layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pauseTime;
    layer.beginTime = timeSincePause;
}

// 抛物线动画
- (void)throwLineAnimation
{
    CALayer *throwLayer = [[CALayer alloc] init];
    throwLayer.frame = CGRectMake(20.f, 300.f, 30.f, 30.f);
    throwLayer.cornerRadius = 15.f;
    throwLayer.backgroundColor = [UIColor purpleColor].CGColor;
    [self.view.layer addSublayer:throwLayer];

    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, throwLayer.position.x, throwLayer.position.y);
    CGPoint endPoint = CGPointMake([UIScreen mainScreen].bounds.size.width - 50.f, throwLayer.position.y + 100);
    CGFloat cpx = (throwLayer.position.x + endPoint.x)/2.f;
    CGFloat cpy = - 100.f;
    CGPathAddQuadCurveToPoint(path, NULL, cpx, cpy, endPoint.x, endPoint.y);

    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = path;
    CFRelease(path);

    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.autoreverses = YES;
    scaleAnimation.toValue = [NSNumber numberWithFloat:(CGFloat)((arc4random() % 4) + 4) / 15.0];

    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.repeatCount = MAXFLOAT;
    groupAnimation.duration = 2.0f;
    groupAnimation.removedOnCompletion = NO;
    groupAnimation.animations = @[scaleAnimation, animation];
    [throwLayer addAnimation:groupAnimation forKey:@"positionscale"];
}

- (void)shakeAnimation
{
    CAKeyframeAnimation *anima = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    NSValue *value1 = [NSNumber numberWithFloat:-M_PI/180*4];
    NSValue *value2 = [NSNumber numberWithFloat:M_PI/180*4];
    NSValue *value3 = [NSNumber numberWithFloat:-M_PI/180*4];
    anima.values = @[value1,value2,value3];
    anima.repeatCount = MAXFLOAT;
    [self.shakeOBView.layer addAnimation:anima forKey:@"shakeAnimation"];
}

-(void)backgroundAnimation{
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    anima.beginTime = CACurrentMediaTime()+2.0;
    anima.toValue =(id) [UIColor greenColor].CGColor;
    anima.duration = 1.0f;
    [self.shakeOBView.layer addAnimation:anima forKey:@"backgroundAnimation"];
}

-(void)opacityAniamtion{
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"opacity"];
    anima.beginTime = CACurrentMediaTime()+1.0;
    anima.fromValue = [NSNumber numberWithFloat:0.2f];
    anima.toValue = [NSNumber numberWithFloat:1.0f];
    anima.duration = 1.0f;
    [self.shakeOBView.layer addAnimation:anima forKey:@"opacityAniamtion"];
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
