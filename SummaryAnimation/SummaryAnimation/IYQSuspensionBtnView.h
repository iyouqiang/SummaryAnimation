//
//  IYQSuspensionBtnView.h
//  SummaryAnimation
//
//  Created by chmtech003 on 16/7/8.
//  Copyright © 2016年 gongyouqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IYQSuspensionBtnView : UIView

/**
 *  传入按钮数组，显示系列按钮
 *
 *  @param btnArray 按钮数组
 *  @param block    点击后返回第几个
 */
- (void)showBtnArray:(NSMutableArray *)btnArray clickIndex:(void(^)(NSInteger index))block;

@end