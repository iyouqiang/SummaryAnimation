//
//  IYQMainView.m
//  SummaryAnimation
//
//  Created by chmtech003 on 2016/11/10.
//  Copyright © 2016年 gongyouqiang. All rights reserved.
//

#import "IYQMainView.h"
@implementation IYQMainView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    if (self) {

        _suspendimgView = [[UIImageView alloc] initWithFrame:self.bounds];
        _suspendimgView.backgroundColor = [UIColor whiteColor];
        _suspendimgView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:_suspendimgView];

        _suspendLabel   = [[UILabel alloc] initWithFrame:self.bounds];
        _suspendLabel.backgroundColor = [UIColor clearColor];
        _suspendLabel.textAlignment = NSTextAlignmentCenter;
        _suspendLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _suspendLabel.textColor = [UIColor colorWithHexString:@"#40e0b0"];
        [self addSubview:_suspendLabel];
    }

    return self;
}

@end
