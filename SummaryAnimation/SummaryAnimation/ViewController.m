//
//  ViewController.m
//  SummaryAnimation
//
//  Created by chmtech003 on 16/7/7.
//  Copyright © 2016年 gongyouqiang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *AnimationScrollerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidLayoutSubviews {
    
    self.AnimationScrollerView.contentSize = CGSizeMake(320, 568);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
