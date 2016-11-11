//
//  IYQMainView.h
//  SummaryAnimation
//
//  Created by chmtech003 on 2016/11/10.
//  Copyright © 2016年 gongyouqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+Hex.h"
@interface IYQMainView : UIView

@property (nonatomic, strong) UIImageView *suspendimgView;
@property (nonatomic, strong) UILabel     *suspendLabel;

- (instancetype)initWithFrame:(CGRect)frame;

@end
