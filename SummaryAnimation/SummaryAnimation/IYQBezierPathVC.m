//
//  IYQBezierPathVC.m
//  SummaryAnimation
//
//  Created by chmtech003 on 2016/11/24.
//  Copyright © 2016年 gongyouqiang. All rights reserved.
//

#import "IYQBezierPathVC.h"
#import "UIColor+Hex.h"
const CGFloat pi = 3.14159265359;
#define   kDegreesToRadians(degrees)  ((pi * degrees)/ 180)

@interface IYQBezierPathVC ()

@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, assign) BOOL isAnimation;
@property (nonatomic, assign) NSInteger index;

@end

@implementation IYQBezierPathVC

/*
 我们先看看UIBezierPath类提供了哪些创建方式，这些都是工厂方法，直接使用即可。

 这个使用比较多，因为这个工厂方法创建的对象，我们可以根据我们的需要任意定制样式，可以画任何我们想画的图形。
 + (instancetype)bezierPath;

 这个工厂方法根据一个矩形画贝塞尔曲线。
 + (instancetype)bezierPathWithRect:(CGRect)rect;
 
 这个工厂方法根据一个矩形画内切曲线。通常用它来画圆或者椭圆。
 + (instancetype)bezierPathWithOvalInRect:(CGRect)rect;

 这个工厂方法是画矩形，但是这个矩形是可以画圆角的。第一个参数是矩形，第二个参数是圆角大小。
 + (instancetype)bezierPathWithRoundedRect:(CGRect)rect
 cornerRadius:(CGFloat)cornerRadius;
 
 这个工厂方法功能是一样的，但是可以指定某一个角画成圆角。像这种我们就可以很容易地给UIView扩展添加圆角的方法了。
 + (instancetype)bezierPathWithRoundedRect:(CGRect)rect
 byRoundingCorners:(UIRectCorner)corners
 cornerRadii:(CGSize)cornerRadii;
 
 这个工厂方法用于画弧，参数说明如下：
 center: 弧线中心点的坐标
 radius: 弧线所在圆的半径
 startAngle: 弧线开始的角度值
 endAngle: 弧线结束的角度值
 clockwise: 是否顺时针画弧线
 + (instancetype)bezierPathWithArcCenter:(CGPoint)center
 radius:(CGFloat)radius
 startAngle:(CGFloat)startAngle
 endAngle:(CGFloat)endAngle
 clockwise:(BOOL)clockwise;

 + (instancetype)bezierPathWithCGPath:(CGPathRef)CGPath;

 文／标哥的技术博客（简书作者）
 原文链接：http://www.jianshu.com/p/734b34e82135
 著作权归作者所有，转载请联系作者获得授权，并标注“简书作者”。
 */

/*
 演示使用CAShapeLayer, 线条样式由CAShapeLayer的样式属性决定
 使用 - (void)drawRectPath 线条样式使用 UIBezierPath 样式属性
 见画矩形方法
 */

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view.layer addSublayer:self.shapeLayer];

    // 动画开关
    UISwitch *animationSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [animationSwitch addTarget:self action:@selector(switchAnimation:) forControlEvents:UIControlEventValueChanged];
    animationSwitch.center = self.view.center;
    [self.view addSubview:animationSwitch];

    // 演示曲线按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(CGRectGetWidth(self.view.frame)/2.0 - 100.0f, 164.0f, 200.0, 44.0);
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:@"点击查看不同曲线" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(showBezierPath) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

    self.index = 0;
}

- (void)switchAnimation:(UISwitch *)sender
{
    if (sender.isOn) {

        self.isAnimation = YES;
    }else {

        self.isAnimation = NO;
    }
}

- (void)showBezierPath
{
    _index ++;
    switch (_index) {

        case 1:

            [self drawTriangle];
            break;

        case 2:

            [self drawRectangular];
            break;

        case 3:

            [self drawCircle];
            break;

        case 4:

            [self drawOval];
            break;

        case 5:

            [self drawOvalRectangular];
            break;

        case 6:

            [self customDrawOvalRectangular];
            break;

        case 7:

            [self drawCurve];
            break;

        case 8:

            [self drawSecondBezierPath];
            break;

        case 9:

            [self drawThirdBezierPath];
            break;

        case 10:

            [self drawSinPath];
            break;

        default:

            _index = 0;
            break;
    }

    if (self.isAnimation) {

        [self drawAnimation];
    }
}

// 画线演示动画
- (void)drawAnimation
{
    CABasicAnimation *strokeAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeAnimation.fromValue = @(0.0);
    strokeAnimation.toValue   = @(1.0);
    strokeAnimation.duration = 4.0f;
    strokeAnimation.repeatCount = 1;
    strokeAnimation.autoreverses = NO;
    [_shapeLayer addAnimation:strokeAnimation forKey:@"strokeAnimation"];
}

- (CAShapeLayer *)shapeLayer
{
    if (!_shapeLayer) {

        _shapeLayer = [CAShapeLayer layer];
        _shapeLayer.frame = self.view.frame;
        _shapeLayer.lineWidth = 5;
        _shapeLayer.fillColor = [UIColor clearColor].CGColor;
    }

    return _shapeLayer;
}

// 画三角形
- (void)drawTriangle
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(20, 84)];
    [path addLineToPoint:CGPointMake(CGRectGetWidth(self.view.frame) - 40.0f, 84.0f)];
    [path addLineToPoint:CGPointMake(CGRectGetWidth(self.view.frame)/2.0, 184.0)];

    //两种方式闭合
    //[path addLineToPoint:CGPointMake(20, 20)];
    [path closePath];

    _shapeLayer.strokeColor = [UIColor orangeColor].CGColor;
    _shapeLayer.path = path.CGPath;
}

// 画矩形
- (void)drawRectangular
{
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(20.0, 84.0, CGRectGetWidth(self.view.frame) - 40.0, CGRectGetHeight(self.view.frame) - 100)];

    // 设置此属性无效
    //path.lineWidth = 5;
    //path.lineCapStyle  = kCGLineCapRound;
    //path.lineJoinStyle = kCGLineJoinBevel;

    // 样式
    _shapeLayer.path = path.CGPath;
    _shapeLayer.lineJoin = kCALineJoinRound;

    _shapeLayer.fillColor = [UIColor colorWithHexString:@"#40e0b0"].CGColor;
    _shapeLayer.strokeColor = [UIColor redColor].CGColor;
}

// 画圆
- (void)drawCircle
{
    // 传正方形，为圆。 否则为椭圆
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(20.0, 84, CGRectGetWidth(self.view.frame) - 40.0, CGRectGetWidth(self.view.frame) - 40.0)];

    _shapeLayer.path = path.CGPath;
    _shapeLayer.strokeColor = [UIColor blackColor].CGColor;
}

// 画椭圆
- (void)drawOval
{
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(20.0, 84, CGRectGetWidth(self.view.frame) - 40.0, CGRectGetHeight(self.view.frame) - 100.0)];
    _shapeLayer.path = path.CGPath;
    _shapeLayer.fillColor   = [UIColor colorWithHexString:@"#40e0b0"].CGColor;
    _shapeLayer.strokeColor = [UIColor blackColor].CGColor;
}

// 画四个角带圆角的矩形
- (void)drawOvalRectangular
{
    // 当弧度为 宽/2 是为圆形
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(20.0, 84.0f, CGRectGetWidth(self.view.frame) - 40.0, CGRectGetWidth(self.view.frame) - 40.0) cornerRadius:20.0];

    _shapeLayer.path = path.CGPath;
    _shapeLayer.strokeColor = [UIColor blueColor].CGColor;
}

// 画指定圆角矩形
- (void)customDrawOvalRectangular
{
    /**
     *  画指定圆角
     *
     *  @param 1 传矩形
     *  @param 2 哪个方向画圆角
     *  @param 3 水平和垂直方向的半径的大小
     *
     */
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(20.0, 84.0f, CGRectGetWidth(self.view.frame) - 40.0, CGRectGetWidth(self.view.frame) - 40.0) byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(20, 20)];

    _shapeLayer.path = path.CGPath;
    _shapeLayer.strokeColor = [UIColor purpleColor].CGColor;
}

// 画弧 参考坐标系见该目录下图片
- (void)drawCurve
{
    /**
     *  center: 弧线中心点的坐标
     *  radius: 弧线所在圆的半径
     *  startAngle: 弧线开始的角度值
     *  endAngle: 弧线结束的角度值
     *  clockwise: 是否顺时针画弧线 YES 顺时针画弧  NO 逆时针画弧
     */

    CGPoint center = CGPointMake(CGRectGetWidth(self.view.frame)/2.0, CGRectGetHeight(self.view.frame)/2.0);
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:100 startAngle:0 endAngle:kDegreesToRadians(135) clockwise:YES];

    _shapeLayer.path = path.CGPath;
    _shapeLayer.strokeColor = [UIColor darkGrayColor].CGColor;
}

// 画二次贝塞尔曲线 参考系 见目录下图片
- (void)drawSecondBezierPath
{
    UIBezierPath *path = [UIBezierPath bezierPath];

    // 起点
    [path moveToPoint:CGPointMake(10.0f, CGRectGetHeight(self.view.frame) - 200)];

    // 添加二次曲线

    /**
     *  endPoint：终端点
     *
     *  controlPoint：控制点，对于二次贝塞尔曲线，只有一个控制点
     */

    [path addQuadCurveToPoint:CGPointMake(CGRectGetWidth(self.view.frame) - 20, CGRectGetHeight(self.view.frame) - 200)
                 controlPoint:CGPointMake(CGRectGetWidth(self.view.frame) / 2, 0)];
    _shapeLayer.lineJoin = kCALineJoinRound;
    _shapeLayer.path = path.CGPath;
    _shapeLayer.strokeColor = [UIColor cyanColor].CGColor;
}

// 画三次贝塞尔曲线 参考系见目录下图片
- (void)drawThirdBezierPath
{
    UIBezierPath *path = [UIBezierPath bezierPath];

    // 起点
    [path moveToPoint:CGPointMake(20.0f, 200.0f)];

    /**
     *  起始端点
     *
     *  控制点1
     *
     *  控制点2
     *
     *  终止端点
     */

    // 添加三次曲线
    [path addCurveToPoint:CGPointMake(CGRectGetWidth(self.view.frame) - 40.0f, 200.0f) controlPoint1:CGPointMake(100.0f, 84.0f) controlPoint2:CGPointMake(200.0f, 250.0f)];
    _shapeLayer.lineJoin = kCALineJoinRound;
    _shapeLayer.path = path.CGPath;
    _shapeLayer.strokeColor = [UIColor magentaColor].CGColor;
}

// 画正玄曲线
- (void)drawSinPath
{
    /**
     *  振幅   amplitude
     *  周期   cycle
     *  偏移量 offset
     *  高度   pointY
     */

    float y         = 0;
    float amplitude = 50;
    float cycle     = 1;
    float offset    = 0;
    float pointY    = 240;

    UIBezierPath *path = [UIBezierPath bezierPath];

    for(float x=20;x<(CGRectGetWidth(self.view.frame)-20.0);x++) {

        y = amplitude * sin(kDegreesToRadians(x) * cycle + offset) + pointY;

        [path addLineToPoint:CGPointMake(x, y)];

        [path moveToPoint:CGPointMake(x, y)];
    }

    _shapeLayer.path = path.CGPath;

    _shapeLayer.strokeColor = [UIColor blackColor].CGColor;
}

@end
