//
//  IYQSuspensionBtnView.m
//  SummaryAnimation
//
//  Created by chmtech003 on 16/7/8.
//  Copyright © 2016年 gongyouqiang. All rights reserved.
//

#import "IYQSuspensionBtnView.h"

#define MAINCOLOER [UIColor colorWithRed:247/255.0 green:251/255.0 blue:242/255.0 alpha:1]

typedef enum : NSUInteger {
    left_suspension = 1,
    right_suspension,
    top_suspension,
    bottom_suspension,
} suspensionPoint;

typedef void(^IndexBlock)(NSInteger index);

@interface IYQSuspensionBtnView ()<UIDynamicAnimatorDelegate>

@property (nonatomic, strong) UIView            *backgroundView;
@property (nonatomic, strong) UIImageView       *imageView;
@property (nonatomic, strong) NSMutableArray    *btnArray;
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, assign) CGPoint           startPoint;
@property (nonatomic, assign) CGPoint           endPoint;
@property (nonatomic, assign) CGPoint           subBtnstartPoint;
@property (nonatomic, assign) CGPoint           subBtnendPoint;
@property (nonatomic, assign) CGFloat           kNavHeight;
@property (nonatomic, assign) CGFloat           kBgWidth;
@property (nonatomic, assign) CGFloat           kImgWidth;
@property (nonatomic, assign) CGFloat           kOffSet;
@property (nonatomic, copy  ) IndexBlock        indexBlock;
@property (nonatomic, assign) suspensionPoint   btnPoint;
@property (nonatomic, assign) BOOL              is_showOrHideBtn;

@end

@implementation IYQSuspensionBtnView

- (instancetype)initWithFrame:(CGRect)frame
{
    self  = [super initWithFrame:frame];
    
    if (self) {
        
        [self setDefaultData:frame];

        //初始化子视图
        [self initSubView];

        // 呼吸动画
        [self hightBgView];
    }
    
    return self;
}

- (void)setDefaultData:(CGRect)frame
{
    // 初始默认左边
    _btnPoint   = left_suspension;
    _kNavHeight = frame.origin.y;
    _kBgWidth   = frame.size.width;
    _kImgWidth  = frame.size.width - 10.0;
    _kOffSet    = _kBgWidth/2.0;
}

- (void)showBtnArray:(NSMutableArray *)btnArray clickIndex:(void(^)(NSInteger index))block
{
    _indexBlock = [block copy];
    _btnArray   = btnArray;
    for (int i = 0; i < btnArray.count; i ++ ) {
        UIButton *btn = btnArray[i];
        btn.tag = i + 1818;
        [btn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.superview addSubview:btn];
    }
}

- (void)initSubView
{
    // 背景View
    _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    _backgroundView.backgroundColor    =    MAINCOLOER;
    _backgroundView.clipsToBounds      = YES;
    _backgroundView.layer.cornerRadius = _kOffSet;
    [self addSubview:_backgroundView];

    // 图片背景View
    UIView *imgbgView = [[UIView alloc] initWithFrame:CGRectMake(5, 5, CGRectGetWidth(self.frame) - 10, CGRectGetHeight(self.frame) - 10)];
    imgbgView.backgroundColor = MAINCOLOER;
    imgbgView.clipsToBounds   = YES;
    imgbgView.layer.cornerRadius = imgbgView.frame.size.height/2.0f;
    [self addSubview:imgbgView];

    // 显示隐藏手势
    UITapGestureRecognizer *tagGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureActon)];
    [self addGestureRecognizer:tagGesture];
    _is_showOrHideBtn = YES;

    // 显示的图片
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _kImgWidth, _kImgWidth)];
    _imageView.center = CGPointMake(_kBgWidth/2.f, _kBgWidth/2.f);
    _imageView.image = [UIImage imageNamed:@"Suspension.png"];
    _imageView.clipsToBounds = YES;
    _imageView.layer.cornerRadius = _imageView.frame.size.height/2.0f;
    [self addSubview:_imageView];
}

#pragma mark - btnAction
- (void)clickAction:(UIButton *)btn
{
    _indexBlock(btn.tag - 1818);
}

- (void)gestureActon
{
    if (_is_showOrHideBtn) {
        
        [self showBtn];
    }else {
        
        [self hiddenBtn];
    }
    
    _is_showOrHideBtn = !_is_showOrHideBtn;
}

- (void)showBtn
{
    for (int i = 0; i < _btnArray.count; i++) {
    
        // 默认左边
        UIButton *btn = _btnArray[i];

        [self changPoint:i];
        
        [self animationShowBtn:_subBtnstartPoint endPoint:_subBtnendPoint btn:btn index:i];
    }
}

- (void)hiddenBtn
{
    count = 0;
    
    for (int  i = (int)_btnArray.count-1; i>=0; i--) {
        UIButton *btn=_btnArray[i];
        
        [self changPoint:i];
        
        [self animationHideenBtn:_subBtnendPoint endPoint:_subBtnstartPoint btn:btn index:i];
    }
}

- (void)animationShowBtn:(CGPoint)startPoint endPoint:(CGPoint)endPoint btn:(UIButton *)btn index:(NSInteger)i
{
    CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    positionAnimation.duration=0.3;
    positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    positionAnimation.fromValue = [NSValue valueWithCGPoint:startPoint];
    positionAnimation.toValue = [NSValue valueWithCGPoint:endPoint];
    //positionAnimation.beginTime = CACurrentMediaTime() + (0.3/(float)_btnArray.count * (float)i);
    positionAnimation.fillMode = kCAFillModeForwards;
    positionAnimation.removedOnCompletion = NO;
    [btn.layer addAnimation:positionAnimation forKey:@"positionAnimation"];
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.duration=.3;
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    scaleAnimation.fromValue = @(0);
    scaleAnimation.toValue = @(1);
    scaleAnimation.beginTime = CACurrentMediaTime() + (0.3/(float)_btnArray.count * (float)i);
    scaleAnimation.fillMode = kCAFillModeForwards;
    scaleAnimation.removedOnCompletion = NO;
    [btn.layer addAnimation:scaleAnimation forKey:@"transformscale"];

    btn.center = endPoint;
}

static int count = 0;
- (void)animationHideenBtn:(CGPoint)startPoint endPoint:(CGPoint)endPoint btn:(UIButton *)btn index:(NSInteger)i
{
    CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    positionAnimation.duration=0.3;
    positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    positionAnimation.fromValue = [NSValue valueWithCGPoint:startPoint];
    positionAnimation.toValue = [NSValue valueWithCGPoint:endPoint];
    positionAnimation.beginTime = CACurrentMediaTime() + (.3/(float)_btnArray.count * (float)count);
    positionAnimation.fillMode = kCAFillModeForwards;
    positionAnimation.removedOnCompletion = NO;
    [btn.layer addAnimation:positionAnimation forKey:@"positionAnimation"];
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.duration=.3;
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    scaleAnimation.fromValue = @(1);
    scaleAnimation.toValue = @(0);
    scaleAnimation.beginTime = CACurrentMediaTime() + (0.3/(float)_btnArray.count * (float)count);
    scaleAnimation.fillMode = kCAFillModeForwards;
    scaleAnimation.removedOnCompletion = NO;
    [btn.layer addAnimation:scaleAnimation forKey:@"transformscale"];
    btn.transform = CGAffineTransformMakeScale(1.f, 1.f);
    
    count ++;
}

- (void)changPoint:(NSInteger)idnex
{
    switch (_btnPoint) {
        case top_suspension:
        {
            _subBtnstartPoint = self.center;
            _subBtnendPoint   = CGPointMake(self.center.x , self.center.y + self.frame.size.height/2.0f + (_kImgWidth + 10)*idnex + 20);
        }
            break;
        case bottom_suspension:
        {
            _subBtnstartPoint = self.center;
            _subBtnendPoint   = CGPointMake(self.center.x , self.center.y - 20.0f - self.frame.size.height/2.0f - (_kImgWidth + 10) * idnex);
        }
            break;

        case left_suspension:
        {
            _subBtnstartPoint = self.center;
            _subBtnendPoint   = CGPointMake(self.center.x + self.frame.size.width/2.0f + (_kImgWidth + 10)*idnex + 20, self.center.y);
        }
            break;
        case right_suspension:
        {
            _subBtnstartPoint = self.center;
            _subBtnendPoint   = CGPointMake(self.center.x - 20.0f - self.frame.size.height/2.0f - (_kImgWidth + 10) * idnex, self.center.y);
        }
            break;
    }
}

#pragma mark - DynamicAnimator
- (UIDynamicAnimator*)animator
{
    if (!_animator) {
        
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.superview];
        
        _animator.delegate = self;
    }
    return _animator;
}

- (void)dynamicAnimatorDidPause:(UIDynamicAnimator *)animator
{
    
}

#pragma mark - touch_breathe
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *startTouch = [touches anyObject];
    
    self.startPoint = [startTouch locationInView:self.superview];
    
    [self.animator removeAllBehaviors];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *moveTouch = [touches anyObject];
    
    self.center = [moveTouch locationInView:self.superview];
    
    if (!_is_showOrHideBtn) {
        
        [self gestureActon];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *endTouch = [touches anyObject];
    
    self.endPoint = [endTouch locationInView:self.superview];
    
    CGFloat permitRange = 6.0;
    
    CGFloat RangX = fabs(self.endPoint.x - self.startPoint.x);
    CGFloat RangY = fabs(self.endPoint.y - self.startPoint.y);
    
    if (!(RangX < permitRange && RangY < permitRange)) {
        
        self.center = self.endPoint;
        
        CGFloat superViewWidth = CGRectGetWidth(self.superview.frame);
        CGFloat superViewHeight= CGRectGetHeight(self.superview.frame);
        CGFloat endX = self.endPoint.x;
        CGFloat endY = self.endPoint.y;
        
        CGFloat topDistance     = endY;
        CGFloat bottomDistance  = superViewHeight - endY;
        CGFloat leftDistance    = endX;
        CGFloat rightDistance   = superViewWidth - endX;
        
        CGFloat verticalMinDistance    = MIN(topDistance, bottomDistance);
        CGFloat horizontalMinDistance  = MIN(leftDistance, rightDistance);
        CGFloat edgeMinDistance        = MIN(verticalMinDistance, horizontalMinDistance);
        
        CGPoint minPoint;
        
        if (edgeMinDistance == topDistance) {
            
            // 按钮边界超出左边缘时
            endX = MAX(_kOffSet, endX);
            
            // 按钮边界超出右边缘时
            endX = endX + _kOffSet > superViewWidth ? superViewWidth - _kOffSet : endX;
            
            minPoint = CGPointMake(endX , _kNavHeight + _kOffSet);
            
            _btnPoint = top_suspension;
        
        }else if (edgeMinDistance == bottomDistance) {
            
            // 按钮边界超出左边缘时
            endX = MAX(_kOffSet, endX);
            
            // 按钮边界超出右边缘时
            endX = endX + _kOffSet > superViewWidth ? superViewWidth - _kOffSet : endX;
            
            minPoint = CGPointMake(endX , superViewHeight - _kOffSet);
            
            _btnPoint = bottom_suspension;
            
        }else if (edgeMinDistance == leftDistance) {
            
            // 按钮边界超出上边缘时
            endY = MAX(endY, _kOffSet + _kNavHeight);
            
            // 按钮边界超出下边缘时
            endY = endY + _kOffSet > superViewHeight ? superViewHeight - _kOffSet : endY;
            
            minPoint = CGPointMake(_kOffSet , endY);
            
            _btnPoint = left_suspension;
            
        }else if (edgeMinDistance == rightDistance) {
            
            // 按钮边界超出上边缘时
            endY = MAX(endY, _kOffSet + _kNavHeight);
            
            // 按钮边界超出下边缘时
            endY = endY + _kOffSet > superViewHeight ? superViewHeight - _kOffSet : endY;
            
            minPoint = CGPointMake(superViewWidth - _kOffSet, endY);
            
            _btnPoint = right_suspension;
            
        }else {
            
            NSLog(@"有鬼...");
        }
        
        //添加吸附物理行为
        UIAttachmentBehavior *attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:self attachedToAnchor:minPoint];
        
        [attachmentBehavior setLength:0];
        
        [attachmentBehavior setDamping:0.3];
        
        [attachmentBehavior setFrequency:3];
        
        [self.animator addBehavior:attachmentBehavior];
    }
}

#pragma mark - breatheAnimation
- (void)hightBgView
{
    [UIView animateWithDuration:1 animations:^{
        
        self.backgroundView.backgroundColor = [self.backgroundView.backgroundColor colorWithAlphaComponent:0.1f];
        
    } completion:^(BOOL finished) {
        
        [self darkBgView];
    }];
}

- (void)darkBgView
{
    [UIView animateWithDuration:1 animations:^{
        
        self.backgroundView.backgroundColor = [self.backgroundView.backgroundColor colorWithAlphaComponent:0.7f];

    } completion:^(BOOL finished) {
        
        [self hightBgView];
    }];
}

@end
