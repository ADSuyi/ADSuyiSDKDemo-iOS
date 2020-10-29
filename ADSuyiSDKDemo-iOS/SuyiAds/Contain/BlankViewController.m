//
//  BlankViewController.m
//  ADSuyiSDKDemo
//
//  Created by 技术 on 2020/8/10.
//  Copyright © 2020 陈坤. All rights reserved.
//

#import "BlankViewController.h"

@interface BlankViewController ()

@end

@implementation BlankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"空白页";
    self.view.backgroundColor = UIColor.whiteColor;
    
    UIButton *backBtn = [[UIButton alloc]init];
//    [backBtn setTitle:@"返回" forState:(UIControlStateNormal)];
    [backBtn setTitle:@"返回" forState:(UIControlStateNormal)];
    [backBtn setTitleColor:UIColor.grayColor forState:(UIControlStateNormal)];
    backBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    backBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    backBtn.layer.borderColor = UIColor.grayColor.CGColor;
    backBtn.layer.borderWidth = 1;
    backBtn.layer.cornerRadius = 3;
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:backBtn];
    backBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2-30, [UIScreen mainScreen].bounds.size.height/2-10, 60, 30);
    
    // Do any additional setup after loading the view.
}

- (void)backBtnClick{
    
    if (self.tabBarController.presentedViewController == nil) {
        [self.tabBarController.navigationController popViewControllerAnimated:YES];
    }
    [self.tabBarController dismissViewControllerAnimated:YES completion:nil];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
