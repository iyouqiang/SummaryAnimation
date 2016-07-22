//
//  IYQPraiseBtn.h
//  SummaryAnimation
//
//  Created by chmtech003 on 16/7/22.
//  Copyright © 2016年 gongyouqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IYQPraiseBtn : UIButton

@property (strong, nonatomic) UIImage  *customEmitterImg;

- (void)animate;
- (void)popOutsideWithDuration:(NSTimeInterval)duration;
- (void)popInsideWithDuration:(NSTimeInterval)duration;

@end
