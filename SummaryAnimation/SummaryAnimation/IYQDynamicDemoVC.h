//
//  IYQDynamicDemoVC.h
//  SummaryAnimation
//
//  Created by chmtech003 on 2016/11/30.
//  Copyright © 2016年 gongyouqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {

    kDemoFunctionSnap = 0,
    kDemoFunctionPush,
    kDemoFunctionAttachment,
    kDemoFunctionSpring,
    kDemoFunctionCollision,
    kDemoFunctionmultiObject

} kDemoFunction;

@interface IYQDynamicDemoVC : UIViewController

/** 功能类型 */
@property (nonatomic, assign) kDemoFunction function;

@end
