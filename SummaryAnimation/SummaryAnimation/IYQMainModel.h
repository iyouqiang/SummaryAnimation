//
//  IYQMainModel.h
//  SummaryAnimation
//
//  Created by chmtech003 on 2016/11/10.
//  Copyright © 2016年 gongyouqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IYQMainView.h"
#import <UIKit/UIKit.h>
@interface IYQMainModel : NSObject

@property(nonatomic,retain) IYQMainView *showimgView;
@property(nonatomic,assign) CGPoint pushCenter;
@property(nonatomic,assign) CGPoint popCenter;

+ (instancetype)shareIYQMainModelManager;

@end
