//
//  IYQPraiseBtn.m
//  SummaryAnimation
//
//  Created by chmtech003 on 16/7/22.
//  Copyright © 2016年 gongyouqiang. All rights reserved.
//

/*
 粒子效应
 在iOS 5中，苹果引入了一个新的CALayer子类叫做CAEmitterLayer。   CAEmitterLayer是一个高性能的粒子引擎，被用来创建实时例子动画如：烟雾，火，雨等等这些效果。
 CAEmitterLayer提供了一个基于Core Animation的粒子发射系统，粒子用CAEmitterCell来初始化。
 Propertiesnonatomic, nonatomic, :
 birthRate:粒子产生系数，默认1.0；
 emitterCells: 装着CAEmitterCell对象的数组，被用于把粒子投放到layer上；
 emitterDepth:决定粒子形状的深度联系：emitter shape

 emitterMode:发射模式
 NSString * const kCAEmitterLayerPoints;
 NSString * const kCAEmitterLayerOutline;
 NSString * const kCAEmitterLayerSurface;
 NSString * const kCAEmitterLayerVolume;

 emitterPosition:发射位置
 emitterShape:发射源的形状：
 NSString * const kCAEmitterLayerPoint;
 NSString * const kCAEmitterLayerLine;
 NSString * const kCAEmitterLayerRectangle;
 NSString * const kCAEmitterLayerCuboid;
 NSString * const kCAEmitterLayerCircle;
 NSString * const kCAEmitterLayerSphere;

 emitterSize:发射源的尺寸大；
 emitterZposition:发射源的z坐标位置；
 lifetime:粒子生命周期
 preservesDepth:（粒子是平展在层上）
 renderMode:渲染模式：
 NSString * const kCAEmitterLayerUnordered;
 NSString * const kCAEmitterLayerOldestFirst;
 NSString * const kCAEmitterLayerOldestLast;
 NSString * const kCAEmitterLayerBackToFront;
 NSString * const kCAEmitterLayerAdditive;

 scale:粒子的缩放比例：
 seed：用于初始化随机数产生的种子
 spin:自旋转速度
 velocity：粒子速度

 CAEmitterCell
 CAEmitterCell类是从CAEmitterLayer射出的粒子；
 emitter cell定义了粒子发射的方向。
 alphaRange:  一个粒子的颜色alpha能改变的范围；
 alphaSpeed:粒子透明度在生命周期内的改变速度；
 birthrate：粒子参数的速度乘数因子；
 blueRange：一个粒子的颜色blue 能改变的范围；

 blueSpeed: 粒子blue在生命周期内的改变速度；
 color:粒子的颜色
 contents：是个CGImageRef的对象,既粒子要展现的图片；
 contentsRect：应该画在contents里的子rectangle：
 emissionLatitude：发射的z轴方向的角度
 emissionLongitude:x-y平面的发射方向
 emissionRange；周围发射角度
 emitterCells：粒子发射的粒子
 enabled：粒子是否被渲染
 greenrange: 一个粒子的颜色green 能改变的范围；
 greenSpeed: 粒子green在生命周期内的改变速度；
 lifetime：生命周期
 lifetimeRange：生命周期范围
 magnificationFilter：不是很清楚好像增加自己的大小
 minificatonFilter：减小自己的大小
 minificationFilterBias：减小大小的因子
 name：粒子的名字
 redRange：一个粒子的颜色red 能改变的范围；
 redSpeed; 粒子red在生命周期内的改变速度；
 scale：缩放比例：
 scaleRange：缩放比例范围；
 scaleSpeed：缩放比例速度：
 spin：子旋转角度
 spinrange：子旋转角度范围
 style：不是很清楚：
 velocity：速度
 velocityRange：速度范围
 xAcceleration:粒子x方向的加速度分量
 yAcceleration:粒子y方向的加速度分量
 zAcceleration:粒子z方向的加速度分量
 Class Methods
 defauleValueForKey: 更具健获得值；
 
 emitterCell：初始化方法
 shouldArchiveValueForKey:是否归档莫键值

 */

#import "IYQPraiseBtn.h"

@interface IYQPraiseBtn ()

@property (strong, nonatomic) UIView         *praiseBgView;
@property (strong, nonatomic) NSArray        *emitterCells;
@property (strong, nonatomic) CAEmitterLayer *chargeLayer;     // 粒子引擎 发射cell
@property (strong, nonatomic) CAEmitterLayer *explosionLayer;

@end

@implementation IYQPraiseBtn

- (void)setup {
    self.clipsToBounds = NO;

    // 向外发射的粒子
    CAEmitterCell *explosionCell = [CAEmitterCell emitterCell];
    explosionCell.name = @"explosion";
    explosionCell.contents = (id)[[UIImage imageNamed:@"Sparkle"] CGImage];

    // 参数自己调试 birthRate初始为0,点击动画里面设置
    explosionCell.alphaRange = 0.20;
    explosionCell.alphaSpeed = -1.0;
    explosionCell.lifetime = 0.7;
    explosionCell.lifetimeRange = 0.3;
    explosionCell.birthRate = 0;
    explosionCell.velocity = 40.0;
    explosionCell.velocityRange = 10.0;
    explosionCell.scale = 0.05;
    explosionCell.scaleRange = 0.02;

    // 用于发射粒子的引擎
    _explosionLayer = [CAEmitterLayer layer];
    _explosionLayer.name = @"emitterLayer";
    _explosionLayer.emitterShape = kCAEmitterLayerCircle;
    _explosionLayer.emitterMode = kCAEmitterLayerOutline;
    _explosionLayer.emitterSize = CGSizeMake(25, 0);
    _explosionLayer.emitterCells = @[explosionCell];
    _explosionLayer.renderMode = kCAEmitterLayerOldestFirst;
    _explosionLayer.masksToBounds = NO;
    [self.layer addSublayer:_explosionLayer];

    // 向内发送的粒子
    CAEmitterCell *chargeCell = [CAEmitterCell emitterCell];
    chargeCell.name = @"charge";
    chargeCell.contents = (id)[[UIImage imageNamed:@"Sparkle"] CGImage];
    chargeCell.alphaRange = 0.20;
    chargeCell.alphaSpeed = -1.0;
    chargeCell.lifetime = 0.3;
    chargeCell.lifetimeRange = 0.1;
    chargeCell.birthRate = 0;
    chargeCell.velocity = -40.0;
    chargeCell.velocityRange = 0.00;
    chargeCell.scale = 0.05;
    chargeCell.scaleRange = 0.02;

    _chargeLayer = [CAEmitterLayer layer];
    _chargeLayer.name = @"emitterLayer";
    _chargeLayer.emitterShape = kCAEmitterLayerCircle;
    _chargeLayer.emitterMode = kCAEmitterLayerOutline;
    _chargeLayer.emitterSize = CGSizeMake(25, 0);
    _chargeLayer.emitterCells = @[chargeCell];
    _chargeLayer.renderMode = kCAEmitterLayerOldestFirst;
    _chargeLayer.masksToBounds = NO;
    [self.layer addSublayer:_chargeLayer];

    self.emitterCells = @[chargeCell, explosionCell];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    self.chargeLayer.emitterPosition    = center;
    self.explosionLayer.emitterPosition = center;
}

- (void)setCustomEmitterImg:(UIImage *)customEmitterImg
{
    _customEmitterImg = customEmitterImg;

    for (CAEmitterCell *cell in self.emitterCells) {
        cell.contents = (id)[customEmitterImg CGImage];
    }
}

- (void)popOutsideWithDuration:(NSTimeInterval)duration
{
    __weak typeof(self) weakSelf = self;
    self.transform = CGAffineTransformIdentity;
    [UIView animateKeyframesWithDuration:duration delay:0 options:0 animations:^{

        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:1/3.0 animations:^{
            typeof(self) strongself = weakSelf;
            strongself.transform = CGAffineTransformMakeScale(1.5, 1.5);
        }];
        [UIView addKeyframeWithRelativeStartTime:1/3.0 relativeDuration:1/3.0 animations:^{

            typeof(self) strongself = weakSelf;
            strongself.transform = CGAffineTransformMakeScale(0.8, 0.8);
        }];

        [UIView addKeyframeWithRelativeStartTime:2/3.0 relativeDuration:1/3.0 animations:^{
            typeof(self) strongself = weakSelf;
            strongself.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }];

    } completion:nil];
}

- (void)popInsideWithDuration:(NSTimeInterval)duration
{
    __weak typeof(self) weakSelf = self;
    self.transform = CGAffineTransformIdentity;
    [UIView animateKeyframesWithDuration:duration delay:0 options:0 animations:^{

        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:1/2.0 animations:^{

            typeof(self) strongself = weakSelf;
            strongself.transform = CGAffineTransformMakeScale(0.8, 0.8);
        }];

        [UIView addKeyframeWithRelativeStartTime:1/2.0 relativeDuration:1/2.0 animations:^{
            typeof(self) strongself = weakSelf;
            strongself.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }];
        
    } completion:nil];
}

//爆炸动画
- (void)animate {
    self.chargeLayer.beginTime = CACurrentMediaTime();
    [self.chargeLayer setValue:@80 forKeyPath:@"emitterCells.charge.birthRate"];
    [self performSelector:@selector(explode) withObject:nil afterDelay:0.2];
}

- (void)explode {
    [self.chargeLayer setValue:@0 forKeyPath:@"emitterCells.charge.birthRate"];
    self.explosionLayer.beginTime = CACurrentMediaTime();
    [self.explosionLayer setValue:@500 forKeyPath:@"emitterCells.explosion.birthRate"];
    [self performSelector:@selector(stop) withObject:nil afterDelay:0.1];
}

- (void)stop {
    [self.chargeLayer setValue:@0 forKeyPath:@"emitterCells.charge.birthRate"];
    [self.explosionLayer setValue:@0 forKeyPath:@"emitterCells.explosion.birthRate"];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
