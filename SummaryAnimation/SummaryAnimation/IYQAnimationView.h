//
//  IYQAnimationView.h
//  SummaryAnimation
//
//  Created by chmtech003 on 16/8/12.
//  Copyright © 2016年 gongyouqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AnimatiomViewDelegate <NSObject>

- (void)completeAnimation;

@end

@interface IYQAnimationView : UIView

@property (assign, nonatomic) CGRect parentFrame;
@property (weak, nonatomic) id<AnimatiomViewDelegate>delegate;

@end
