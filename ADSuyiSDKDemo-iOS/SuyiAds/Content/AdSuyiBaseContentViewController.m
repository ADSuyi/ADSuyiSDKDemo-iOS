//
//  AdSuyiBaseContentViewController.m
//  ADSuyiSDKDemo
//  作为内容界面的父控制器 目的实现返回按钮自定义
//  Created by 技术 on 2021/1/6.
//  Copyright © 2021 陈坤. All rights reserved.
//

#import "AdSuyiBaseContentViewController.h"

@interface AdSuyiBaseContentViewController ()

@property (nonatomic, strong) UIViewController *vc;
@property (nonatomic, assign) BOOL firstEnterVC;
@property (nonatomic, assign) BOOL preShowNavBar;

@end

@implementation AdSuyiBaseContentViewController

- (instancetype)initWithViewController:(UIViewController *)vc {
    if (self = [super init]) {
        _vc = vc;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self addChildViewController:self.vc];
    [self.view addSubview:self.vc.view];
    self.vc.view.frame = self.view.frame;
    [self.vc didMoveToParentViewController:self];
    [self configBackButtonInFullScreen];
}

- (void)configBackButtonInFullScreen {
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"close"]
                forState:UIControlStateNormal];
    [self.view addSubview:backButton];
    backButton.frame = CGRectMake(24, 40, 29, 29);
    [backButton addTarget:self
                   action:@selector(backAction:)
         forControlEvents:UIControlEventTouchUpInside];
}

- (void)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    if (!self.firstEnterVC) {
        self.preShowNavBar =  !self.navigationController.navigationBarHidden;
        if (self.preShowNavBar) {
            [self.navigationController setNavigationBarHidden:YES animated:animated];
        }
        self.firstEnterVC = YES;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    if (self.preShowNavBar && self.isMovingFromParentViewController) {
        [self.navigationController setNavigationBarHidden:NO animated:animated];
    }
}

- (BOOL)shouldAutorotate {
    return NO;
}

@end
