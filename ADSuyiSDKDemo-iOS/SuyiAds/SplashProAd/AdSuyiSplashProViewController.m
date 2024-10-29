//
//  AdSuyiSplashProViewController.m
//  ADSuyiSDKDemo-iOS
//
//  Created by apple on 2024/6/25.
//  Copyright © 2024 陈坤. All rights reserved.
//

#import "AdSuyiSplashProViewController.h"
#import <ADSuyiSDK/ADSuyiSDKSplashProAd.h>
#import <ADSuyiKit/UIColor+ADSuyiKit.h>
#import <ADSuyiKit/ADSuyiKitMacros.h>
#import "SetConfigManager.h"
#import "ADSuyiSplashSkipView.h"
#import "ADSuyiRingProgressView.h"
#import "AdMacros.h"
@interface AdSuyiSplashProViewController ()<ADSuyiSDKSplashProAdDelegate>

@property (nonatomic, strong) ADSuyiSDKSplashProAd *splashAd;

@property (nonatomic, strong) ADSuyiSplashSkipView *skipNormalView;

@property (nonatomic, strong) ADSuyiRingProgressView *skipRingView;

@property (nonatomic, assign) BOOL isReady;

@end

@implementation AdSuyiSplashProViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:225/255.0 green:233/255.0 blue:239/255.0 alpha:1];
    self.title = @"开屏广告2.0";
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    UIButton *loadBtn = [UIButton new];
    loadBtn.layer.cornerRadius = 3;
    loadBtn.clipsToBounds = YES;
    loadBtn.backgroundColor = UIColor.whiteColor;
    [loadBtn setTitle:@"加载开屏" forState:(UIControlStateNormal)];
    [loadBtn setTitleColor:UIColor.blackColor forState:(UIControlStateNormal)];
    [self.view addSubview:loadBtn];
    loadBtn.frame = CGRectMake(30, UIScreen.mainScreen.bounds.size.height/2-80, UIScreen.mainScreen.bounds.size.width-60, 40);
    [loadBtn addTarget:self action:@selector(loadSplashAd) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIButton *showBtn = [UIButton new];
    showBtn.layer.cornerRadius = 3;
    showBtn.clipsToBounds = YES;
    showBtn.backgroundColor = UIColor.whiteColor;
    [showBtn setTitle:@"展示开屏" forState:(UIControlStateNormal)];
    [showBtn setTitleColor:UIColor.blackColor forState:(UIControlStateNormal)];
    [self.view addSubview:showBtn];
    [showBtn addTarget:self action:@selector(showSplashAd) forControlEvents:(UIControlEventTouchUpInside)];
    showBtn.frame = CGRectMake(30, UIScreen.mainScreen.bounds.size.height/2 - 20, UIScreen.mainScreen.bounds.size.width-60, 40);
    
    UIButton *loadAndShowBtn = [UIButton new];
    loadAndShowBtn.layer.cornerRadius = 3;
    loadAndShowBtn.clipsToBounds = YES;
    loadAndShowBtn.backgroundColor = UIColor.whiteColor;
    [loadAndShowBtn setTitle:@"加载和展示开屏" forState:(UIControlStateNormal)];
    [loadAndShowBtn setTitleColor:UIColor.blackColor forState:(UIControlStateNormal)];
    [self.view addSubview:loadAndShowBtn];
    loadAndShowBtn.frame = CGRectMake(30, UIScreen.mainScreen.bounds.size.height/2+60, UIScreen.mainScreen.bounds.size.width-60, 40);
    [loadAndShowBtn addTarget:self action:@selector(loadAndShowSplashAd) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)loadAndShowSplashAd{
    [self requestSplashAd];
    [self.splashAd loadAndShowInWindow:[UIApplication sharedApplication].keyWindow withBottomView:[self getBottonView]];
}
- (void)loadSplashAd{
    [self requestSplashAd];
    [self.splashAd loadAdInWindow:[UIApplication sharedApplication].keyWindow withBottomView:[self getBottonView]];
}
- (void)showSplashAd{
    if (_isReady) {
        [self.splashAd showAdInWindow:[UIApplication sharedApplication].keyWindow];
    }else{
        
    }
}
// 开屏测试id 518f5daa123ec3e866
- (void)requestSplashAd{
    self.splashAd = [[ADSuyiSDKSplashProAd alloc]init];
    self.splashAd.delegate = self;
    self.splashAd.controller = self;
    self.splashAd.posId = Suyi_Demo_splashAd_PosId;
    self.splashAd.tolerateTimeout = 4;
    self.splashAd.backgroundColor = [UIColor adsy_getColorWithImage:[UIImage imageNamed:@"750x1334.png"] withNewSize:[UIScreen mainScreen].bounds.size];
}
- (UIView *)getBottonView{
    CGFloat bottomViewHeight;
//    if (kADSYCurveScreen) {
        bottomViewHeight = [UIScreen mainScreen].bounds.size.height * 0.15;
//    } else {
//        bottomViewHeight = [UIScreen mainScreen].bounds.size.height - [UIScreen mainScreen].bounds.size.width * (960 / 640.0);
//    }
//
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    bottomView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, bottomViewHeight);
    UIImageView *logoImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ADMob_Logo.png"]];
    logoImageView.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-135)/2, (bottomViewHeight-46)/2, 135, 46);
    [bottomView addSubview:logoImageView];
    return bottomView;
}

#pragma mark - ADSuyiSDKSplashProAdDelegate
/**
 开屏加载成功
 
 @param splashAd 广告实例
 */
- (void)adsy_splashAdSuccessToLoadAd:(ADSuyiSDKSplashProAd *)splashAd{
    _isReady = YES;
    ADSuyiSDKExtInfo *extInfo = [splashAd adsy_extInfo];
    NSLog(@"ecpm=%@, ecpmType=%ld", extInfo.ecpm, extInfo.ecpmType);
}

/**
 开屏展现成功
 
 @param splashAd 广告实例
 */
- (void)adsy_splashAdSuccessToPresentScreen:(ADSuyiSDKSplashProAd *)splashAd{
    
}

/**
 开屏展现失败
 
 @param splashAd 广告实例
 @param error 具体错误信息
 */
- (void)adsy_splashAdFailToPresentScreen:(ADSuyiSDKSplashProAd *)splashAd failToPresentScreen:(ADSuyiAdapterErrorDefine *)error{
    _splashAd = nil;
}

/**
 开屏广告点击
 
 @param splashAd 广告实例
 */
- (void)adsy_splashAdClicked:(ADSuyiSDKSplashProAd *)splashAd{
    
}

/**
 开屏被跳过
 
 @param splashAd 广告实例
 */
- (void)adsy_splashAdSkip:(ADSuyiSDKSplashProAd *)splashAd{
    
}

/**
 开屏被关闭
 
 @param splashAd 广告实例
 */
- (void)adsy_splashAdClosed:(ADSuyiSDKSplashProAd *)splashAd{
    _splashAd = nil;
}

/**
 开屏展示
 
 @param splashAd 广告实例
 */
- (void)adsy_splashAdEffective:(ADSuyiSDKSplashProAd *)splashAd{
}

@end
