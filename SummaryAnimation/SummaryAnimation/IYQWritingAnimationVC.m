//
//  IYQWritingAnimationVC.m
//  SummaryAnimation
//
//  Created by chmtech003 on 16/8/6.
//  Copyright © 2016年 gongyouqiang. All rights reserved.
//

#import "IYQWritingAnimationVC.h"
#import "UIBezierPath+YQWriteBezier.h"

@interface IYQWritingAnimationVC ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *wrightTextField;
@property (nonatomic, strong) CAShapeLayer        *shapeLayer;
@property (nonatomic, strong) NSMutableDictionary *attrs;

- (IBAction)drawAction:(id)sender;

@end

@implementation IYQWritingAnimationVC

- (void)viewDidAppear:(BOOL)animated
{
    [self drawAction:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.wrightTextField.text = @"Welcome to the world of animation";
    self.wrightTextField.delegate = self;
    [self.view.layer addSublayer:self.shapeLayer];
}

- (CAShapeLayer *)shapeLayer
{
    if (!_shapeLayer) {

        _shapeLayer = [[CAShapeLayer alloc] init];
        _shapeLayer.frame = CGRectMake((self.view.frame.size.width - 200.f)/2.0f, 130.0f, 200.f, 200.f);
        _shapeLayer.geometryFlipped = YES;
        _shapeLayer.strokeColor = [UIColor redColor].CGColor;
        _shapeLayer.fillColor   = [UIColor clearColor].CGColor;
        _shapeLayer.lineJoin    = kCALineJoinRound;
    }

    return _shapeLayer;
}

- (NSMutableDictionary *)attrs
{
    if (!_attrs) {

        _attrs = [NSMutableDictionary dictionary];
        [_attrs setObject:[UIFont systemFontOfSize:20.f] forKey:NSFontAttributeName];
    }

    return _attrs;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)drawAction:(id)sender {

    [_wrightTextField resignFirstResponder];

    if (_wrightTextField.text.length > 0) {

        UIBezierPath *path = [UIBezierPath iyqBezierPathWithText:_wrightTextField.text attributes:self.attrs];
        self.shapeLayer.bounds = CGPathGetBoundingBox(path.CGPath);
        self.shapeLayer.path   = path.CGPath;
        [self.shapeLayer removeAllAnimations];

        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        pathAnimation.duration = 0.5f * _wrightTextField.text.length;
        pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
        pathAnimation.toValue   = [NSNumber numberWithFloat:1.0f];
        [self.shapeLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
    }
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];

    return YES;
}
@end
