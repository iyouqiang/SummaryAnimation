//
//  IYQCircleLayer.h
//  SummaryAnimation
//
//  Created by chmtech003 on 16/8/12.
//  Copyright © 2016年 gongyouqiang. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface IYQCircleLayer : CAShapeLayer

/**
 *  Wobble group animation
 */
- (void)wobbleAnimation;

/**
 *  Expend animation for circle layer
 */
- (void)expand;

/**
 *  Contract animation for circle layer
 */
- (void)contract;


@end
