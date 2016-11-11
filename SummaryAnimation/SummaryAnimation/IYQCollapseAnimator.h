//
//  IYQCollapseAnimator.h
//  SummaryAnimation
//
//  Created by chmtech003 on 2016/11/11.
//  Copyright © 2016年 gongyouqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface IYQCollapseAnimator : NSObject<UIViewControllerAnimatedTransitioning>

/**
 *  转场持续时间
 */
@property (nonatomic, assign) NSTimeInterval duration;

/**
 *  碎片大小
 */
@property (nonatomic, assign) NSInteger sideLength;

@end
