//
//  AdSuyiInterstitialViewController.m
//  ADSuyiSDKDemo
//
//  Created by 陈坤 on 2020/4/21.
//  Copyright © 2020 陈坤. All rights reserved.
//

#import "AdSuyiInterstitialViewController.h"
#import <ADSuyiSDK/ADSuyiSDKIntertitialAd.h>
#import "UIView+Toast.h"
#import "SetConfigManager.h"
#import "AdMacros.h"
@interface AdSuyiInterstitialViewController ()<ADSuyiSDKIntertitialAdDelegate>

@property (nonatomic, strong) ADSuyiSDKIntertitialAd *intertitialAd;
@property(nonatomic ,assign) BOOL isReady;

@end

@implementation AdSuyiInterstitialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"插屏";
    self.view.backgroundColor = [UIColor colorWithRed:225/255.0 green:233/255.0 blue:239/255.0 alpha:1];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    UIButton *loadBtn = [UIButton new];
    loadBtn.layer.cornerRadius = 10;
    loadBtn.clipsToBounds = YES;
    loadBtn.backgroundColor = UIColor.whiteColor;
    [loadBtn setTitle:@"加载插屏" forState:(UIControlStateNormal)];
    [loadBtn setTitleColor:UIColor.blackColor forState:(UIControlStateNormal)];
    loadBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:loadBtn];
    loadBtn.frame = CGRectMake(30, UIScreen.mainScreen.bounds.size.height/2-60, UIScreen.mainScreen.bounds.size.width-60, 60);
    [loadBtn addTarget:self action:@selector(loadInterstitialAd) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIButton *showBtn = [UIButton new];
    showBtn.layer.cornerRadius = 10;
    showBtn.clipsToBounds = YES;
    showBtn.backgroundColor = UIColor.whiteColor;
    [showBtn setTitle:@"展示插屏" forState:(UIControlStateNormal)];
    [showBtn setTitleColor:UIColor.blackColor forState:(UIControlStateNormal)];
    showBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:showBtn];
    [showBtn addTarget:self action:@selector(showInterstitialAd) forControlEvents:(UIControlEventTouchUpInside)];
    showBtn.frame = CGRectMake(30, UIScreen.mainScreen.bounds.size.height/2+20, UIScreen.mainScreen.bounds.size.width-60, 60);
    _isReady = NO;
}

// 217d589e286f472159 插屏测试id
- (void)loadInterstitialAd{
    // 1、初始化插屏广告
    self.intertitialAd = [ADSuyiSDKIntertitialAd new];
    self.intertitialAd.controller = self;
    self.intertitialAd.posId = Suyi_Demo_intertitialAd_PosId;
    self.intertitialAd.delegate = self;
    self.intertitialAd.tolerateTimeout = 4;
    if (![[SetConfigManager sharedManager].fullAdAdScenceId isEqualToString:@""])
        self.intertitialAd.scenesId = [SetConfigManager sharedManager].fullAdAdScenceId;
    // 2、加载插屏广告
    [self.intertitialAd loadAdData];
}

- (void)showInterstitialAd {
    if (_isReady) {
        [self.intertitialAd show];
        return;
    }
    [self.view makeToast:@"广告未准备好"];
    
}

#pragma mark - ADSuyiSDKIntertitialAdDelegate
/**
 ADSuyiSDKIntertitialAd请求成功回调
 
 @param interstitialAd 插屏广告实例对象
*/
- (void)adsy_interstitialAdSuccedToLoad:(ADSuyiSDKIntertitialAd *)interstitialAd{
    ADSuyiSDKExtInfo *extInfo = [interstitialAd adsy_extInfo];
    NSLog(@"ecpm=%@, ecpmType=%ld", extInfo.ecpm, extInfo.ecpmType);
    // 3、展示插屏广告
    _isReady = YES;
    [self.view makeToast:@"广告准备好"];
}

/**
 ADSuyiSDKIntertitialAd请求失败回调

 @param interstitialAd 插屏广告实例对象
 @param error 失败原因
*/
- (void)adsy_interstitialAdFailedToLoad:(ADSuyiSDKIntertitialAd *)interstitialAd error:(ADSuyiAdapterErrorDefine *)error{
    // 4、内存回收
    [self.view makeToast:error.description];
    _intertitialAd = nil;
}

/**
 ADSuyiSDKIntertitialAd展示在屏幕内回调

 @param interstitialAd 插屏广告实例对象
*/
- (void)adsy_interstitialAdDidPresent:(ADSuyiSDKIntertitialAd *)interstitialAd{
    
}

/**
 ADSuyiSDKIntertitialAd展示在屏幕内失败回调

 @param interstitialAd 插屏广告实例对象
*/
- (void)adsy_interstitialAdFailedToPresent:(ADSuyiSDKIntertitialAd *)interstitialAd error:(NSError *)error{
    [self.view makeToast:error.description];
}

/**
 ADSuyiSDKIntertitialAd点击回调

 @param interstitialAd 插屏广告实例对象
*/
- (void)adsy_interstitialAdDidClick:(ADSuyiSDKIntertitialAd *)interstitialAd{
    
}

/**
 ADSuyiSDKIntertitialAd关闭回调

 @param interstitialAd 插屏广告实例对象
*/
- (void)adsy_interstitialAdDidClose:(ADSuyiSDKIntertitialAd *)interstitialAd{
    // 4、内存回收
    _intertitialAd = nil;
}

/**
 ADSuyiSDKIntertitialAd展示回调
 
 @param interstitialAd 广告实例
 */
- (void)adsy_interstitialAdExposure:(ADSuyiSDKIntertitialAd *)interstitialAd{
    
}

/**
 ADSuyiSDKIntertitialAd关闭落地页回调
 
 @param interstitialAd 广告实例
 */
-(void)adsy_interstitialAdCloseLandingPage:(ADSuyiSDKIntertitialAd *)interstitialAd{
    
}
@end
