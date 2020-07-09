//
//  AdSuyiFullScreenvodViewController.m
//  ADSuyiSDKDemo
//
//  Created by 陈坤 on 2020/4/21.
//  Copyright © 2020 陈坤. All rights reserved.
//

#import "AdSuyiFullScreenvodViewController.h"
#import <ADSuyiSDK/ADSuyiSDKFullScreenVodAd.h>

@interface AdSuyiFullScreenvodViewController ()<ADSuyiSDKFullScreenVodAdDelegate>

@property (nonatomic, strong) ADSuyiSDKFullScreenVodAd *fullScreenvodAd;

@end

@implementation AdSuyiFullScreenvodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self loadFullScreenvod];
}

// 99b38e917aada07c6d 全屏视频广告id
- (void)loadFullScreenvod{
    // 1、初始化全屏视频广告
    self.fullScreenvodAd = [ADSuyiSDKFullScreenVodAd new];
    self.fullScreenvodAd.controller = self;
    self.fullScreenvodAd.posId = @"f3953777bc833957d8";
    self.fullScreenvodAd.delegate = self;
    self.fullScreenvodAd.tolerateTimeout = 5;
    // 2、加载全屏视频广告
    [self.fullScreenvodAd loadAdData];
    
}

#pragma mark - ADSuyiSDKFullScreenVodAdDelegate
/**
 ADSuyiSDKFullScreenVodAd请求成功回调
 
 @param fullScreenVodAd 全屏视频广告实例对象
*/
- (void)adsy_fullScreenVodAdSuccedToLoad:(ADSuyiSDKFullScreenVodAd *)fullScreenVodAd{
    
}

/**
 ADSuyiSDKFullScreenVodAd准备好被播放
 
 @param fullScreenVodAd 全屏视频广告实例对象
*/
- (void)adsy_fullScreenVodAdReadyToPlay:(ADSuyiSDKFullScreenVodAd *)fullScreenVodAd{
    // 3、推荐在准备好被播放会调用展示激励视频广告
    [self.fullScreenvodAd show];
}

/**
 ADSuyiSDKFullScreenVodAd视频加载成功回调
 
 @param fullScreenVodAd 全屏视频广告实例对象
*/
- (void)adsy_fullScreenVodAdSuccessToLoadVideo:(ADSuyiSDKFullScreenVodAd *)fullScreenVodAd{
    // 3、也可在视频加载成功回调中展示激励视频广告
    [self.fullScreenvodAd show];
}

/**
 ADSuyiSDKFullScreenVodAd请求失败回调

 @param fullScreenVodAd 全屏视频广告实例对象
 @param error 失败原因
*/
- (void)adsy_fullScreenVodAdFailedToLoad:(ADSuyiSDKFullScreenVodAd *)fullScreenVodAd error:(ADSuyiAdapterErrorDefine *)error{
    // 4、广告内存回收
    _fullScreenvodAd = nil;
}

/**
 ADSuyiSDKFullScreenVodAd展示在屏幕内回调

 @param fullScreenVodAd 全屏视频广告实例对象
*/
- (void)adsy_fullScreenVodAdDidPresent:(ADSuyiSDKFullScreenVodAd *)fullScreenVodAd{
    
}

/**
 ADSuyiSDKFullScreenVodAd展示失败回调

 @param fullScreenVodAd 全屏视频广告实例对象
 @param error 失败原因
*/
- (void)adsy_fullScreenVodAdFailToPresent:(ADSuyiSDKFullScreenVodAd *)fullScreenVodAd error:(NSError *)error{
    
}

/**
 ADSuyiSDKFullScreenVodAd点击回调

 @param fullScreenVodAd 全屏视频广告实例对象
*/
- (void)adsy_fullScreenVodAdDidClick:(ADSuyiSDKFullScreenVodAd *)fullScreenVodAd{
    
}

/**
 ADSuyiSDKFullScreenVodAd关闭回调

 @param fullScreenVodAd 全屏视频广告实例对象
*/
- (void)adsy_fullScreenVodAdDidClose:(ADSuyiSDKFullScreenVodAd *)fullScreenVodAd{
    // 4、广告内存回收
    _fullScreenvodAd = nil;
}

/**
 ADSuyiSDKFullScreenVodAd展示回调
 
 @param fullScreenVodAd 广告实例
 */
- (void)adsy_fullScreenVodAdExposure:(ADSuyiSDKFullScreenVodAd *)fullScreenVodAd{
    
}

/**
ADSuyiSDKFullScreenVodAd播放完成回调

 @param fullScreenVodAd 广告实例
 @param error 失败原因（如果为nil，则是单纯的播放完成）
*/
- (void)adsy_fullScreenVodAdPlayComplete:(ADSuyiSDKFullScreenVodAd *)fullScreenVodAd didFailed:(NSError *_Nullable)error{
    
}
@end
