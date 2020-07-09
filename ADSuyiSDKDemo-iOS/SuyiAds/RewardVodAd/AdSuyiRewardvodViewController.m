//
//  AdSuyiRewardvodViewController.m
//  ADSuyiSDKDemo
//
//  Created by 陈坤 on 2020/4/21.
//  Copyright © 2020 陈坤. All rights reserved.
//

#import "AdSuyiRewardvodViewController.h"
#import <ADSuyiSDK/ADSuyiSDKRewardvodAd.h>

@interface AdSuyiRewardvodViewController ()<ADSuyiSDKRewardvodAdDelegate>

@property (nonatomic, strong)ADSuyiSDKRewardvodAd *rewardvodAd;

@end

@implementation AdSuyiRewardvodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self loadRewardvodAd];
}
// 702a2efe46a42ae0f7 激励视频测试id
- (void)loadRewardvodAd{
    // 1、初始化激励视频广告
    self.rewardvodAd  = [[ADSuyiSDKRewardvodAd alloc]init];
    self.rewardvodAd.delegate = self;
    self.rewardvodAd.tolerateTimeout = 5;
    self.rewardvodAd.controller = self;
    self.rewardvodAd.posId = @"47d196ffaaa92ae93c";
    
    // 2、加载激励视频广告
    [self.rewardvodAd loadRewardvodAd];
}

#pragma mark - ADSuyiSDKRewardvodAdDelegate
/**
 广告数据加载成功回调
 
 @param rewardvodAd 广告实例
 */
- (void)adsy_rewardvodAdLoadSuccess:(ADSuyiSDKRewardvodAd *)rewardvodAd{
    
}

/**
 激励视频广告准备好被播放
 
 @param rewardvodAd 广告实例
 */
- (void)adsy_rewardvodAdReadyToPlay:(ADSuyiSDKRewardvodAd *)rewardvodAd{
    // 3、推荐在准备好被播放回调中展示激励视频广告
    if ([self.rewardvodAd rewardvodAdIsReady]) {
        [self.rewardvodAd showRewardvodAd];
    }
}

/**
 视频数据下载成功回调，已经下载过的视频会直接回调
 
 @param rewardvodAd 广告实例
 */
- (void)adsy_rewardvodAdVideoLoadSuccess:(ADSuyiSDKRewardvodAd *)rewardvodAd{
//    [self.rewardvodAd showRewardvodAd];
}
/**
 视频播放页即将展示回调
 
 @param rewardvodAd 广告实例
 */
- (void)adsy_rewardvodAdWillVisible:(ADSuyiSDKRewardvodAd *)rewardvodAd{
    
}
/**
 视频广告曝光回调
 
 @param rewardvodAd 广告实例
 */
- (void)adsy_rewardvodAdDidVisible:(ADSuyiSDKRewardvodAd *)rewardvodAd{
    
}
/**
 视频播放页关闭回调
 
 @param rewardvodAd 广告实例
 */
- (void)adsy_rewardvodAdDidClose:(ADSuyiSDKRewardvodAd *)rewardvodAd{
    // 4、广告内存回收
    _rewardvodAd = nil;
}
/**
 视频广告信息点击回调
 
 @param rewardvodAd 广告实例
 */
- (void)adsy_rewardvodAdDidClick:(ADSuyiSDKRewardvodAd *)rewardvodAd{
    
}
/**
 视频广告视频播放完成
 
 @param rewardvodAd 广告实例
 */
- (void)adsy_rewardvodAdDidPlayFinish:(ADSuyiSDKRewardvodAd *)rewardvodAd{
    
}

/**
 视频广告视频达到奖励条件
 
 @param rewardvodAd 广告实例
 */
- (void)adsy_rewardvodAdDidRewardEffective:(ADSuyiSDKRewardvodAd *)rewardvodAd{
    
}

/**
 视频广告请求失败回调
 
 @param rewardvodAd 广告实例
 @param errorModel 具体错误信息
 */
- (void)adsy_rewardvodAdFailToLoad:(ADSuyiSDKRewardvodAd *)rewardvodAd errorModel:(ADSuyiAdapterErrorDefine *)errorModel{
    // 4、广告内存回收
    _rewardvodAd = nil;
}

/**
 视频广告播放时各种错误回调
 
 @param rewardvodAd 广告实例
 @param errorModel 具体错误信息
 */
- (void)adsy_rewardvodAdPlaying:(ADSuyiSDKRewardvodAd *)rewardvodAd errorModel:(ADSuyiAdapterErrorDefine *)errorModel{
    
}

@end
