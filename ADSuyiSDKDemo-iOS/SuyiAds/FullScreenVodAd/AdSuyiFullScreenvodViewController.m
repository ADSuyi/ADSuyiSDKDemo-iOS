//
//  AdSuyiFullScreenvodViewController.m
//  ADSuyiSDKDemo
//
//  Created by 陈坤 on 2020/4/21.
//  Copyright © 2020 陈坤. All rights reserved.
//

#import "AdSuyiFullScreenvodViewController.h"
#import <ADSuyiSDK/ADSuyiSDKFullScreenVodAd.h>
#import "UIView+Toast.h"
#import "SetConfigManager.h"
@interface AdSuyiFullScreenvodViewController ()<ADSuyiSDKFullScreenVodAdDelegate>

@property (nonatomic, strong) ADSuyiSDKFullScreenVodAd *fullScreenvodAd;
@property(nonatomic ,assign) BOOL isReady;

@end

@implementation AdSuyiFullScreenvodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor colorWithRed:225/255.0 green:233/255.0 blue:239/255.0 alpha:1];
    
    self.title = @"全屏视频";
    self.view.backgroundColor = [UIColor colorWithRed:225/255.0 green:233/255.0 blue:239/255.0 alpha:1];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    UIButton *loadBtn = [UIButton new];
    loadBtn.layer.cornerRadius = 10;
    loadBtn.clipsToBounds = YES;
    loadBtn.backgroundColor = UIColor.whiteColor;
    [loadBtn setTitle:@"加载全屏视频" forState:(UIControlStateNormal)];
    [loadBtn setTitleColor:UIColor.blackColor forState:(UIControlStateNormal)];
    [self.view addSubview:loadBtn];
    loadBtn.frame = CGRectMake(30, UIScreen.mainScreen.bounds.size.height/2-60, UIScreen.mainScreen.bounds.size.width-60, 60);
    [loadBtn addTarget:self action:@selector(loadFullScreenvod) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIButton *showBtn = [UIButton new];
    showBtn.layer.cornerRadius = 10;
    showBtn.clipsToBounds = YES;
    showBtn.backgroundColor = UIColor.whiteColor;
    [showBtn setTitle:@"展示全屏视频" forState:(UIControlStateNormal)];
    [showBtn setTitleColor:UIColor.blackColor forState:(UIControlStateNormal)];
    [self.view addSubview:showBtn];
    [showBtn addTarget:self action:@selector(showFullScreenvodAd) forControlEvents:(UIControlEventTouchUpInside)];
    showBtn.frame = CGRectMake(30, UIScreen.mainScreen.bounds.size.height/2+20, UIScreen.mainScreen.bounds.size.width-60, 60);
    _isReady = NO;
    
}



// 99b38e917aada07c6d 全屏视频广告id
- (void)loadFullScreenvod{
    // 1、初始化全屏视频广告
    self.fullScreenvodAd = [ADSuyiSDKFullScreenVodAd new];
    self.fullScreenvodAd.controller = self;
    self.fullScreenvodAd.posId = @"f3953777bc833957d8";
    self.fullScreenvodAd.delegate = self;
    self.fullScreenvodAd.tolerateTimeout = 5;
    if (![[SetConfigManager sharedManager].fullAdAdScenceId isEqualToString:@""])
        self.fullScreenvodAd.scenesId = [SetConfigManager sharedManager].fullAdAdScenceId;
    // 2、加载全屏视频广告
    [self.fullScreenvodAd loadAdData];
    
}

- (void)showFullScreenvodAd {
    if (_isReady) {
        [self.fullScreenvodAd show];
        return;
    }
    [self.view makeToast:@"广告未准备完成"];
    
}

#pragma mark - ADSuyiSDKFullScreenVodAdDelegate
/**
 ADSuyiSDKFullScreenVodAd请求成功回调
 
 @param fullScreenVodAd 全屏视频广告实例对象
*/
- (void)adsy_fullScreenVodAdSuccedToLoad:(ADSuyiSDKFullScreenVodAd *)fullScreenVodAd{
    ADSuyiSDKExtInfo *extInfo = [fullScreenVodAd adsy_extInfo];
    NSLog(@"ecpm=%@, ecpmType=%ld", extInfo.ecpm, extInfo.ecpmType);
}

/**
 ADSuyiSDKFullScreenVodAd准备好被播放
 
 @param fullScreenVodAd 全屏视频广告实例对象
*/
- (void)adsy_fullScreenVodAdReadyToPlay:(ADSuyiSDKFullScreenVodAd *)fullScreenVodAd{
    // 3、推荐在准备好被播放会调用展示激励视频广告
    _isReady = YES;
    [self.view makeToast:@"广告准备完成"];
}

/**
 ADSuyiSDKFullScreenVodAd视频加载成功回调
 
 @param fullScreenVodAd 全屏视频广告实例对象
*/
- (void)adsy_fullScreenVodAdSuccessToLoadVideo:(ADSuyiSDKFullScreenVodAd *)fullScreenVodAd{
    // 3、也可在视频加载成功回调中展示激励视频广告
    _isReady = YES;
    [self.view makeToast:@"广告准备完成"];
}

/**
 ADSuyiSDKFullScreenVodAd请求失败回调

 @param fullScreenVodAd 全屏视频广告实例对象
 @param error 失败原因
*/
- (void)adsy_fullScreenVodAdFailedToLoad:(ADSuyiSDKFullScreenVodAd *)fullScreenVodAd error:(ADSuyiAdapterErrorDefine *)error{
    // 4、广告内存回收
    [self.view makeToast:error.description];
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

/**
ADSuyiSDKFullScreenVodAd关闭落地页回调

 @param fullScreenVodAd 广告实例
*/
- (void)adsy_fullScreenVodAdCloseLandingPage:(ADSuyiSDKFullScreenVodAd *)fullScreenVodAd {
    
}

@end
