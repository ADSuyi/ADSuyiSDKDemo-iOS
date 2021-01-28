//
//  ADSuyiGroupAdViewController.m
//  ADSuyiSDKDemo-iOS
//
//  Created by 技术 on 2021/1/27.
//  Copyright © 2021 陈坤. All rights reserved.
//

#import "ADSuyiGroupAdViewController.h"
#import <ADSuyiSDK/ADSuyiSDKNativeAd.h>
#import <ADSuyiKit/UIFont+ADSuyiKit.h>
#import <ADSuyiKit/UIColor+ADSuyiKit.h>
#import <ADSuyiKit/ADSuyiKitMacros.h>
#import <ADSuyiSDK/ADSuyiSDKRewardvodAd.h>

@interface ADSuyiGroupAdViewController ()<ADSuyiSDKNativeAdDelegate,ADSuyiSDKRewardvodAdDelegate>

@property (nonatomic, strong) ADSuyiSDKNativeAd *nativeAd;
@property (nonatomic, strong) UIView *alertView;
@property (nonatomic, strong) ADSuyiSDKRewardvodAd *rewardvodAd;
@property (nonatomic, strong) UIButton *closeButton;

@end

@implementation ADSuyiGroupAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    self.alertView = [UIView new];
    self.alertView.frame = self.view.frame;
    self.alertView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    _closeButton = [UIButton new];
    [self.alertView addSubview:_closeButton];
    [_closeButton setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    
    UIButton *button = [UIButton new];
    [button setTitle:@"获取组合广告" forState:UIControlStateNormal];
    button.clipsToBounds = YES;
    button.layer.cornerRadius = 4;
    button.layer.borderWidth = 1.0;
    button.layer.borderColor = UIColor.blackColor.CGColor;
    button.backgroundColor = UIColor.whiteColor;
    [button addTarget:self action:@selector(requestNativeAd) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:button];
    button.frame = CGRectMake(UIScreen.mainScreen.bounds.size.width/2-60, UIScreen.mainScreen.bounds.size.height/2-15,120, 30);
    
}

- (void)requestNativeAd {
    if(!_nativeAd) {
        // 1、信息流广告初始化
        _nativeAd = [[ADSuyiSDKNativeAd alloc] initWithAdSize:CGSizeMake(320, 180)];
        // 2、传入posId，重要
        _nativeAd.posId = _nativePosid;
        _nativeAd.delegate = self;
        _nativeAd.controller = self;
    }
    // 3、加载信息流广告
    [_nativeAd load:1];
}

- (void)requestRewardAd {
    // 1、初始化激励视频广告
    self.rewardvodAd  = [[ADSuyiSDKRewardvodAd alloc]init];
    self.rewardvodAd.delegate = self;
    self.rewardvodAd.tolerateTimeout = 5;
    self.rewardvodAd.controller = self;
    self.rewardvodAd.posId = _rewardPosid;
    
    // 2、加载激励视频广告
    [self.rewardvodAd loadRewardvodAd];
}

#pragma mark -- ADSuyiNativeAdDelegate

- (void)adsy_nativeAdSucessToLoad:(ADSuyiSDKNativeAd *)nativeAd
                      adViewArray:(NSArray<__kindof UIView<ADSuyiAdapterNativeAdViewDelegate> *> *)adViewArray {
    for (UIView<ADSuyiAdapterNativeAdViewDelegate> *adView in adViewArray) {
        // 4、判断信息流广告是否为自渲染类型（必须实现） 可仿照所示样式demo实现 如无所需样式则需自行实现
        if(adView.renderType == ADSuyiAdapterRenderTypeNative) {
            [self setUpUnifiedOnlyImageNativeAdView:adView];
        }
        // 5、注册，自渲染：注册点击事件，模板：render，重要
        [adView adsy_registViews:@[adView]];
        // 广点通视频信息流广告会给mediaView添加事件，点击会出现半屏广告，以下为广点通官方给予的解决方案
        if([adView.adsy_platform isEqualToString:ADSuyiAdapterPlatformGDT]
           && adView.renderType == ADSuyiAdapterRenderTypeNative
           && adView.data.shouldShowMediaView) {
            UIView *mediaView = [adView adsy_mediaViewForWidth:0.0];
            mediaView.userInteractionEnabled = NO;
        }
    }
}

- (void)adsy_nativeAdFailToLoad:(ADSuyiSDKNativeAd *)nativeAd
                     errorModel:(ADSuyiAdapterErrorDefine *)errorModel {
//    加载激励图文失败时 开始加载激励视频
    [self requestRewardAd];
}

- (void)adsy_nativeAdViewRenderOrRegistSuccess:(UIView<ADSuyiAdapterNativeAdViewDelegate> *)adView {
    // 6、注册或渲染成功，此时高度正常，可以展示
    adView.frame = CGRectMake(0, UIScreen.mainScreen.bounds.size.height/2-adView.bounds.size.height/2, adView.bounds.size.width, adView.bounds.size.height);
    [self.closeButton addTarget:adView action:@selector(adsy_close) forControlEvents:UIControlEventTouchUpInside];
    self.closeButton.frame = CGRectMake(adView.frame.size.width - 44, adView.frame.origin.y - 44, 44, 44);
    [self.alertView addSubview:adView];
    [self.view addSubview:self.alertView];
}

- (void)adsy_nativeAdViewRenderOrRegistFail:(UIView<ADSuyiAdapterNativeAdViewDelegate> *)adView {
    
}

- (void)adsy_nativeAdClicked:(ADSuyiSDKNativeAd *)nativeAd
                      adView:(__kindof UIView<ADSuyiAdapterNativeAdViewDelegate> *)adView {
    
}

- (void)adsy_nativeAdClose:(ADSuyiSDKNativeAd *)nativeAd
                    adView:(__kindof UIView<ADSuyiAdapterNativeAdViewDelegate> *)adView {
    [adView adsy_unRegistView];
    [adView removeFromSuperview];
    [self.alertView removeFromSuperview];
    
}

- (void)adsy_nativeAdExposure:(ADSuyiSDKNativeAd *)nativeAd
                       adView:(__kindof UIView<ADSuyiAdapterNativeAdViewDelegate> *)adView {
    
}
// 激励图文广告样式
- (void)setUpUnifiedOnlyImageNativeAdView:(UIView<ADSuyiAdapterNativeAdViewDelegate> *)adView {
    // 设计的adView实际大小，其中宽度和高度可以自己根据自己的需求设置
    CGFloat adWidth = self.view.frame.size.width;
    CGFloat adHeight = adWidth / 16.0 * 9;
    adView.frame = CGRectMake(0, 0, adWidth, adHeight);
    
    // 设置主图/视频（主图可选，但强烈建议带上,如果有视频试图，则必须带上）
    CGRect mainFrame = CGRectMake(0, 0, adWidth, adHeight);
    if(adView.data.shouldShowMediaView) {
        UIView *mediaView = [adView adsy_mediaViewForWidth:mainFrame.size.width];
        mediaView.frame = mainFrame;
        [adView addSubview:mediaView];
    } else {
        UIImageView *imageView = [UIImageView new];
        imageView.backgroundColor = [UIColor adsy_colorWithHexString:@"#CCCCCC"];
        [adView addSubview:imageView];
        imageView.frame = mainFrame;
        NSString *urlStr = adView.data.imageUrl;
        if(urlStr.length > 0) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlStr]]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    imageView.image = image;
                });
            });
        }
    }
    
    // 显示logo图片（必要）
    if(![adView.adsy_platform isEqualToString:ADSuyiAdapterPlatformGDT]) { // 优量汇（广点通）会自带logo，不需要添加
        UIImageView *logoImage = [UIImageView new];
        [adView addSubview:logoImage];
//        [adView bringSubviewToFront:logoImage];
        [adView adsy_platformLogoImageHasText:YES loadImageBlock:^(UIImage * _Nullable image) {
            CGFloat maxWidth = 40;
            CGFloat logoHeight = maxWidth / image.size.width * image.size.height;
            logoImage.frame = CGRectMake(adWidth - maxWidth, adHeight - logoHeight, maxWidth, logoHeight);
            logoImage.image = image;
        }];
    }

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
