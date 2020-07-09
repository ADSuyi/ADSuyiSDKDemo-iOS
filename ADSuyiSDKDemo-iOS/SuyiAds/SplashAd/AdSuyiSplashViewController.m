//
//  AdSuyiSplashViewController.m
//  ADSuyiSDKDemo
//
//  Created by 陈坤 on 2020/4/21.
//  Copyright © 2020 陈坤. All rights reserved.
//

#import "AdSuyiSplashViewController.h"
#import <ADSuyiSDK/ADSuyiSDKSplashAd.h>
#import <ADSuyiKit/UIColor+ADSuyiKit.h>
#import <ADSuyiKit/ADSuyiKitMacros.h>

@interface AdSuyiSplashViewController ()<ADSuyiSDKSplashAdDelegate>

@property (nonatomic, strong) ADSuyiSDKSplashAd *splashAd;

@end

@implementation AdSuyiSplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self loadSplashAd];
}

// 开屏测试id 518f5daa123ec3e866
- (void)loadSplashAd{
    self.splashAd = [[ADSuyiSDKSplashAd alloc]init];
    self.splashAd.delegate = self;
    self.splashAd.controller = self;
    self.splashAd.posId = @"73128265daffdd6a1d";
    self.splashAd.tolerateTimeout = 4;
    self.splashAd.backgroundColor = [UIColor adsy_getColorWithImage:[UIImage imageNamed:@"750x1334.png"] withNewSize:[UIScreen mainScreen].bounds.size];
    
    CGFloat bottomViewHeight;
    if (kADSYCurveScreen) {
        bottomViewHeight = [UIScreen mainScreen].bounds.size.height * 0.25;
    } else {
        bottomViewHeight = [UIScreen mainScreen].bounds.size.height - [UIScreen mainScreen].bounds.size.width * (960 / 640.0);
    }
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    bottomView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, bottomViewHeight);
    UIImageView *logoImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ADMob_Logo.png"]];
    logoImageView.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-135)/2, (bottomViewHeight-46)/2, 135, 46);
    [bottomView addSubview:logoImageView];
    
    [self.splashAd loadAndShowInWindow:[UIApplication sharedApplication].keyWindow withBottomView:bottomView];
}

#pragma mark - ADSuyiSDKSplashAdDelegate
/**
 开屏展现成功
 
 @param splashAd 广告实例
 */
- (void)adsy_splashAdSuccessToPresentScreen:(ADSuyiSDKSplashAd *)splashAd{
    
}

/**
 开屏展现失败
 
 @param splashAd 广告实例
 @param error 具体错误信息
 */
- (void)adsy_splashAdFailToPresentScreen:(ADSuyiSDKSplashAd *)splashAd failToPresentScreen:(ADSuyiAdapterErrorDefine *)error{
    _splashAd = nil;
}

/**
 开屏广告点击
 
 @param splashAd 广告实例
 */
- (void)adsy_splashAdClicked:(ADSuyiSDKSplashAd *)splashAd{
    
}

/**
 开屏被关闭
 
 @param splashAd 广告实例
 */
- (void)adsy_splashAdClosed:(ADSuyiSDKSplashAd *)splashAd{
    _splashAd = nil;
}

/**
 开屏展示
 
 @param splashAd 广告实例
 */
- (void)adsy_splashAdEffective:(ADSuyiSDKSplashAd *)splashAd{
}

@end
