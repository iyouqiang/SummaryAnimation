//
//  IYQUIDynamicVC.m
//  SummaryAnimation
//
//  Created by chmtech003 on 2016/11/25.
//  Copyright © 2016年 gongyouqiang. All rights reserved.
//

#import "IYQUIDynamicVC.h"
#import "UIColor+Hex.h"
#import "IYQDynamicDemoVC.h"
/*
 什么是UIKit动力？—— 一句话：UIKit动力提供了一个模拟真实世界中力学相关的动画和交互系统。比如重力、碰撞和吸附等。UIKit动力具有可组合、可重用和声明式的特点。

 1.吸附行为（UIAttachmentBehavior）：有一个对象UIAttachmentBehavior，该对象用来指定两个动力项（项或点）之间的连接，当一个项或者点移动时，吸附的项也随之移动。当然，这个连接并不是完全是静态的（static），吸附的项有两个属性damping(阻尼)和oscillation(震荡)，这两个属性决定了吸附项的行为是如何随时间而变化的。

 2.碰撞行为（UICollisionBehavior）：通过对象UICollisionBehavior指定一个边界，并且让各个动力项，在该边界内参与碰撞。UICollisionBehavior对象还可以指定这些动力项适当的回应碰撞。

 3.重力行为（UIGravityBehavior）：通过对象UIGravityBehavior给动力项指定一个重力矢量，具有重力矢量的动力项，会在重力矢量的方向上一直加速，直到与别的动力项产生了冲突或者，遇到了边界。

 4.推动行为（UIPushBehavior）：通过对象UIPushBehavior给动力项指定一个持续的或者瞬时的力（force vector）。

 5.捕捉行为（UISnapBehavior）：通过对象UISnapBehavior给动力项指定一个捕捉点。动力项会根据配置的效果，来抓住这一捕捉点。

 当动力行为被添加到animator（UIDynamicAnimator类的实例对象）时，动力行为就被激活。animator为动力行为的执行提供了上下文。动力项可以有多个行为，只不过所有这些行为都必须添加到相同的animator中。
 */

@interface IYQUIDynamicVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *dynamicArray;

@end

@implementation IYQUIDynamicVC

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self configDynamic];
}

- (void)configDynamic
{
    _dynamicArray = @[@"吸附行为", @"推动行为", @"刚性附着行为", @"弹性附着行为", @"碰撞检测", @"多对象附着行为"];

    UITableView *dynamicTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64.0f, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 64.0)];
    dynamicTableView.backgroundColor = [UIColor clearColor];
    dynamicTableView.delegate = self;
    dynamicTableView.dataSource = self;
    [self.view addSubview:dynamicTableView];

    UIView *footerView = [[UIView alloc] initWithFrame:CGRectZero];
    dynamicTableView.tableFooterView = footerView;

    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 30.0f)];
    textLabel.text = @"演示界面 双击返回";
    textLabel.textColor = [UIColor whiteColor];
    textLabel.textAlignment = NSTextAlignmentCenter;
    dynamicTableView.tableHeaderView = textLabel;
}

// 几组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

// 几行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _dynamicArray.count;
}

// 每行的具体内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    // 1. 设置可重用id
    NSString *identifier = @"cellIdentify";

    // 2. 根据可重用id 去tableView 的缓存区去找
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // cell.backgroundColor = [UIColor colorWithHexString:@"#FFABA7"];

    // 3. 如果找不到，就重新实例化一个
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.backgroundColor = [UIColor clearColor];
    }

    cell.textLabel.text = _dynamicArray[indexPath.row];

    return cell;
}

// 执行代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    // 1. 实例化一个仿真管理器
    IYQDynamicDemoVC *demoVc = [[IYQDynamicDemoVC alloc] init];

    // 2. 设置标题
    demoVc.title = _dynamicArray[indexPath.row];

    // 3. 传递功能类型
    demoVc.function = (int)indexPath.row;

    // 4. 跳转界面
    [self.navigationController pushViewController:demoVc animated:YES];
}

@end
