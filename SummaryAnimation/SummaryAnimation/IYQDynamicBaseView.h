//
//  IYQDynamicBaseView.h
//  SummaryAnimation
//
//  Created by chmtech003 on 2016/11/30.
//  Copyright © 2016年 gongyouqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IYQDynamicBaseView : UIView

/**  方块视图  */
@property (nonatomic, weak) UIImageView *boxView;

/**  仿真者  */
@property (nonatomic, strong) UIDynamicAnimator *animator;

@end
