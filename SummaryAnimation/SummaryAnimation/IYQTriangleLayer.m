//
//  IYQTriangleLayer.m
//  SummaryAnimation
//
//  Created by chmtech003 on 16/8/12.
//  Copyright © 2016年 gongyouqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IYQTriangleLayer.h"
#import "UIColor+Hex.h"
@interface IYQTriangleLayer ()

@property (strong, nonatomic) UIBezierPath *smallTrianglePath;
@property (strong, nonatomic) UIBezierPath *leftTrianglePath;
@property (strong, nonatomic) UIBezierPath *rightTrianglePath;
@property (strong, nonatomic) UIBezierPath *topTrianglePath;

@end

static const CGFloat paddingSpace = 30.0;

@implementation IYQTriangleLayer

- (instancetype)init
{
    self = [super init];

    if (self) {

        self.fillColor = [UIColor colorWithHexString:@"#da70d6"].CGColor;
        self.strokeColor = [UIColor colorWithHexString:@"#da70d6"].CGColor;
        self.lineCap = kCALineCapRound;
        self.lineJoin = kCALineJoinRound;
        self.path = self.smallTrianglePath.CGPath;
    }

    return self;
}

#pragma mark - lazy init
- (UIBezierPath *)smallTrianglePath
{
    if (!_smallTrianglePath) {

        _smallTrianglePath = [UIBezierPath bezierPath];
       // _smallTrianglePath moveToPoint:CGPointMake(<#CGFloat x#>, <#CGFloat y#>)
    }

    return _smallTrianglePath;
}

- (void)triangleAnimate
{

}

@end
