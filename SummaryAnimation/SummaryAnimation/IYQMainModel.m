//
//  IYQMainModel.m
//  SummaryAnimation
//
//  Created by chmtech003 on 2016/11/10.
//  Copyright © 2016年 gongyouqiang. All rights reserved.
//

#import "IYQMainModel.h"

@implementation IYQMainModel
IYQMainModel *mainModel = nil;
+ (instancetype)shareIYQMainModelManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mainModel = [[IYQMainModel alloc] init];
    });

    return mainModel;
}

@end
