//
//  ViewController.m
//  SummaryAnimation
//
//  Created by chmtech003 on 16/7/7.
//  Copyright © 2016年 gongyouqiang. All rights reserved.
//

#import "IYQMainViewController.h"
#import "UIColor+Hex.h"
#import "IYQMainView.h"
#import "IYQMainCollectionCell.h"
#import "IYQMainModel.h"
@interface IYQMainViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UIGestureRecognizerDelegate>

@property (nonatomic, strong) NSMutableArray   *className;
@property (nonatomic, strong) NSMutableArray   *titleName;
@property (nonatomic, strong) NSMutableArray   *imgArray;
@property (nonatomic, strong) UICollectionView *animationCollectionView;
@property (nonatomic, strong) UILongPressGestureRecognizer *longPress;
@property (nonatomic, strong) UIPanGestureRecognizer       *panPress;

@property (nonatomic, strong) IYQMainView *suspendView;  // 悬浮视图
@property (nonatomic, strong) NSIndexPath *presentIndex;
@property (nonatomic, strong) NSIndexPath *currentIndex;
@property (nonatomic, assign) CGPoint     panTranslation;

@property (nonatomic, assign) int dx;
@property (nonatomic, assign) int dy;

@end

@implementation IYQMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.title = @"动画、特效";
    [self.view addSubview:self.animationCollectionView];

    _className = [@[@"IYQBaseAnimationVC",
                    @"IYQSuspensionVC",
                    @"IYQPraiseViewController",
                    @"IYQLoadAnimationVC",
                    @"IYQTransitionVC",
                    @"IYQWritingAnimationVC",
                    @"IYQRadarViewController",
                    @"IYQFotoMosaikEddaVC",
                    @"IYQFragmentViewController",
                    @"IYQFireworksViewController",
                    @"IYQMaskVC",
                    @"IYQBezierPathVC",
                    @"IYQUIDynamicVC"] mutableCopy];

    _titleName = [@[@"基础动画",
                    @"悬浮按钮",
                    @"点赞",
                    @"加载动画",
                    @"过渡动画",
                    @"绘画动画",
                    @"雷达波纹",
                    @"图片拼接",
                    @"碎片过渡动画",
                    @"烟花",      
                    @"mask小玩法",
                    @"贝塞尔曲线精讲",
                    @"UIDynamic力行为"] mutableCopy];

    // 图片
    _imgArray = [[NSMutableArray alloc]init];
    self.view.backgroundColor = [UIColor whiteColor];
    for (NSInteger i = 1; i <= 20; i++) {
        NSString *photoName = [NSString stringWithFormat:@"%ld.jpg",(long)i];
        UIImage *photo = [UIImage imageNamed:photoName];
        [_imgArray addObject:photo];
    }

    // 创建手势
    _longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handlelongPressAction:)];
    _longPress.delegate = self;
    [self.animationCollectionView addGestureRecognizer:_longPress];

    _panPress  = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlepanPressAction:)];
    _panPress.delegate = self;
    [self.animationCollectionView addGestureRecognizer:_panPress];

    // 悬浮图片
    _suspendView = [[IYQMainView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    _suspendView.backgroundColor = [UIColor colorWithHexString:@"#da70d6"];
}

- (UICollectionView *)animationCollectionView
{
    if (!_animationCollectionView) {

        UICollectionViewFlowLayout *collectionLayout = [[UICollectionViewFlowLayout alloc]init];
        collectionLayout.itemSize = CGSizeMake(100, 100);
        _animationCollectionView  = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:collectionLayout];
        _animationCollectionView.backgroundColor = [UIColor whiteColor];
        _animationCollectionView.delegate   = self;
        _animationCollectionView.dataSource = self;
        _animationCollectionView.scrollsToTop = NO;
        [_animationCollectionView registerNib:[UINib nibWithNibName:@"IYQMainCollectionCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"cell"];
    }

    return _animationCollectionView;
}

#pragma mark GestureRecognizer
- (void)handlelongPressAction:(UILongPressGestureRecognizer*)longPressGesture
{
    switch (longPressGesture.state) {

        case UIGestureRecognizerStateBegan:
        {
            self.animationCollectionView.userInteractionEnabled = NO;
            NSIndexPath *indexPath = [self.animationCollectionView indexPathForItemAtPoint:[longPressGesture locationInView:self.animationCollectionView]];

            _currentIndex = [NSIndexPath indexPathForItem:indexPath.item inSection:indexPath.section];

            _presentIndex = [NSIndexPath indexPathForItem:indexPath.item inSection:indexPath.section];

            IYQMainCollectionCell *cell = (IYQMainCollectionCell *)[self.animationCollectionView cellForItemAtIndexPath:indexPath];

            _suspendView.suspendimgView.image = cell.collectionImgView.image;

            _suspendView.suspendLabel.text = cell.collectionL.text;

            [self.animationCollectionView addSubview:_suspendView];

            //////////
            _dx = cell.center.x-[longPressGesture locationInView:self.animationCollectionView].x;
            _dy = cell.center.y-[longPressGesture locationInView:self.animationCollectionView].y;

            _suspendView.center = cell.center;

            CGRect tempFrame = cell.frame;

            tempFrame.size = CGSizeMake(120,120);

            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{

                _suspendView.frame = tempFrame;
                _suspendView.center = cell.center;
                _suspendView.transform = CGAffineTransformMakeScale(1.1, 1.1);

            } completion:^(BOOL finished) {

                [cell setHidden:YES];
            }];
        }
            break;
        case UIGestureRecognizerStateEnded:
        {

            self.animationCollectionView.userInteractionEnabled = YES;

            IYQMainCollectionCell *cell = (IYQMainCollectionCell *)[self.animationCollectionView cellForItemAtIndexPath:_currentIndex];

            CGRect tempFrame = cell.frame;

            tempFrame.size = CGSizeMake(100,100);

            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{

                _suspendView.frame = tempFrame;
                _suspendView.center = cell.center;
                _suspendView.transform = CGAffineTransformMakeScale(1.1, 1.1);
                
            } completion:^(BOOL finished) {
                
                [cell setHidden:NO];
                [_suspendView removeFromSuperview];
            }];
        }
            break;

        default:
            break;
    }
}

- (void)handlepanPressAction:(UIPanGestureRecognizer *)panPressGesture
{
    switch (panPressGesture.state) {
        case UIGestureRecognizerStateChanged:
        {
            _panTranslation = [panPressGesture locationInView:self.animationCollectionView];
            _suspendView.center = CGPointMake(_panTranslation.x + _dx, _panTranslation.y + _dy);
            NSIndexPath *indexPath = [self.animationCollectionView indexPathForItemAtPoint:_suspendView.center];

            if (indexPath) {

                _currentIndex = [NSIndexPath indexPathForItem:indexPath.item inSection:indexPath.section];

                if (_currentIndex.item == _presentIndex.item) {
                    return;
                }

                [self.animationCollectionView moveItemAtIndexPath:_presentIndex toIndexPath:_currentIndex];
            }

            NSObject *imgObj = _imgArray[_presentIndex.item];
            [_imgArray removeObjectAtIndex:_presentIndex.item];
            [_imgArray insertObject:imgObj atIndex:_currentIndex.item];

            NSObject *classNameObj = _className[_presentIndex.item];
            [_className removeObjectAtIndex:_presentIndex.item];
            [_className insertObject:classNameObj atIndex:_currentIndex.item];

            NSObject *titleNameObj = _titleName[_presentIndex.item];
            [_titleName removeObjectAtIndex:_presentIndex.item];
            [_titleName insertObject:titleNameObj atIndex:_currentIndex.item];

            _presentIndex = [NSIndexPath indexPathForItem:_currentIndex.item inSection:_currentIndex.section];
        }
            break;


        case UIGestureRecognizerStateEnded:

            NSLog(@"结束移动");

            break;

        default:
            break;
    }
}

// 需要先长按，再移动，没有长按手势，平移手势return NO
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if ([self.panPress isEqual:gestureRecognizer]) {

        if (self.longPress.state == 0 || self.longPress.state == 5) {

            return NO;
        }
    }else if ([self.longPress isEqual:gestureRecognizer]) {

        // 长按时禁用平移
        if (self.animationCollectionView.panGestureRecognizer.state != 0 && self.animationCollectionView.panGestureRecognizer.state != 5) {

            return NO;
        }
    }

    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if ([self.panPress isEqual:gestureRecognizer]) {

        if (self.longPress.state != 0 && self.longPress.state != 5) {

            if ([self.longPress isEqual:otherGestureRecognizer]) {

                return YES;
            }
            return NO;
        }

    }else if ([self.longPress isEqual:gestureRecognizer]) {

        if ([self.longPress isEqual:otherGestureRecognizer]) {

            return YES;
        }
    }else if ([self.animationCollectionView.panGestureRecognizer isEqual:gestureRecognizer]) {

        if (self.longPress.state == 0 || self.longPress.state == 5) {

            return NO;
        }
    }

    return YES;
}

#pragma mark - Collection Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _className.count;
}

- (IYQMainCollectionCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    IYQMainCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor  = [UIColor colorWithHexString:@"#da70d6"];
    cell.collectionL.text = _titleName[indexPath.row];
    cell.collectionL.textColor = [UIColor colorWithHexString:@"#40e0b0"];
    cell.collectionImgView.image = _imgArray[indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 获取类名
    NSString *className = _className[indexPath.row];
    UIViewController *subViewController = [[NSClassFromString(className) alloc] init];
    subViewController.navigationController.navigationBarHidden = NO;
    subViewController.title = _titleName[indexPath.row];

    // 动画
    IYQMainCollectionCell *cell = (IYQMainCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    IYQMainView *suspendView = [[IYQMainView alloc] init];
    suspendView.suspendimgView.image = cell.collectionImgView.image;
    suspendView.suspendLabel.text    = cell.collectionL.text;
    suspendView.bounds = cell.bounds;
    suspendView.center = CGPointMake(cell.center.x, cell.center.y - collectionView.contentOffset.y);
    
    UIWindow *showwindow = [[UIApplication sharedApplication].delegate window];
    showwindow.backgroundColor = [UIColor whiteColor];
    [showwindow addSubview:suspendView];

    [IYQMainModel shareIYQMainModelManager].showimgView = suspendView;
    [IYQMainModel shareIYQMainModelManager].pushCenter  = suspendView.center;
    [IYQMainModel shareIYQMainModelManager].popCenter   =  CGPointMake(CGRectGetWidth(self.view.frame)/2.0, 32.0);

    [UIView animateWithDuration:0.2 animations:^{

        self.view.alpha = 0;

    } completion:^(BOOL finished) {

        [UIView animateWithDuration:0.5 animations:^{

            suspendView.bounds = CGRectMake(0, 0, 110, 110);
            suspendView.layer.shadowOffset = CGSizeMake(4, 4);
            suspendView.layer.shadowRadius = 30.0;
            suspendView.layer.shadowColor  = [UIColor colorWithHexString:@"#FFABA7"].CGColor;
            suspendView.layer.shadowOpacity = 0.9;
            suspendView.center = [IYQMainModel shareIYQMainModelManager].popCenter;

        } completion:^(BOOL finished) {

            [UIView animateWithDuration:0.2 animations:^{

                suspendView.bounds = CGRectMake(0,0, CGRectGetWidth(self.view.frame), 64.0f);

            } completion:^(BOOL finished) {

                suspendView.layer.shadowOffset = CGSizeMake(0, 0);
                suspendView.layer.shadowRadius = 0;
                suspendView.layer.shadowColor = [UIColor clearColor].CGColor;

                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{


                    [self.navigationController pushViewController:subViewController animated:NO];
                    self.view.alpha = 1;
                });

            }];

        }];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
