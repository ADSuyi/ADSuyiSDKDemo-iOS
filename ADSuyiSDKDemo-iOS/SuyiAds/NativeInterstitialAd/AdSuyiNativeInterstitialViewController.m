//
//  AdSuyiNativeInterstitialViewController.m
//  ADSuyiSDKDemo-iOS
//
//  Created by 技术2 on 2022/2/11.
//  Copyright © 2022 陈坤. All rights reserved.
//

#import "AdSuyiNativeInterstitialViewController.h"
#import <ADSuyiSDK/ADSuyiSDKNativeAd.h>
#import <ADSuyiKit/ADSuyiKit.h>
#import "UIView+Toast.h"
#import "AdMacros.h"

@interface AdSuyiNativeInterstitialViewController ()<ADSuyiSDKNativeAdDelegate>
@property (nonatomic, strong) UIViewController *presendVc;

@property (nonatomic, strong) ADSuyiSDKNativeAd *nativeAd;

@property (nonatomic, strong) UIButton *closeBtn;

@property (nonatomic, strong) UIView *backgroundView;

@property (nonatomic, strong) UIView *adBgView;

@end

@implementation AdSuyiNativeInterstitialViewController

#pragma mark - lazy load

- (ADSuyiSDKNativeAd *)nativeAd {
    if(!_nativeAd) {
        // 1、信息流广告初始化
        _nativeAd = [[ADSuyiSDKNativeAd alloc] initWithAdSize:CGSizeMake(self.view.frame.size.width, 10)];
        // 2、传入posId，重要
        _nativeAd.delegate = self;
//        _nativeAd.controller = self;
        _nativeAd.controller = self.presendVc;
        _nativeAd.posId = Suyi_Demo_flowAd_Native_PosId;
    }
    return _nativeAd;
}
- (UIButton *)closeBtn{
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(closeAdAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _closeBtn;
}
- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [UIView new];
        _backgroundView.frame = UIScreen.mainScreen.bounds;
        _backgroundView.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.5];
        _backgroundView.userInteractionEnabled = YES;
    }
    return _backgroundView;
}
- (UIView *)adBgView
{
    if (!_adBgView) {
        _adBgView = [UIView new];
        _adBgView.userInteractionEnabled = YES;
        _adBgView.layer.cornerRadius = 5;
        _adBgView.backgroundColor = UIColor.clearColor;
        _adBgView.clipsToBounds = YES;
    }
    return _adBgView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"信息流插屏";
    [UIView appearance].exclusiveTouch = YES;
    self.view.backgroundColor = [UIColor colorWithRed:225/255.0 green:233/255.0 blue:239/255.0 alpha:1];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    UIButton *loadBtn = [UIButton new];
    loadBtn.layer.cornerRadius = 10;
    loadBtn.clipsToBounds = YES;
    loadBtn.backgroundColor = UIColor.whiteColor;
    [loadBtn setTitle:@"加载信息流插屏" forState:(UIControlStateNormal)];
    [loadBtn setTitleColor:UIColor.blackColor forState:(UIControlStateNormal)];
    loadBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:loadBtn];
    loadBtn.frame = CGRectMake(30, UIScreen.mainScreen.bounds.size.height/2-60, UIScreen.mainScreen.bounds.size.width-60, 60);
    [loadBtn addTarget:self action:@selector(loadNativeAd) forControlEvents:(UIControlEventTouchUpInside)];
    
}
- (void)loadNativeAd {
    _nativeAd = nil;
    [self.nativeAd load:1];
}

- (void)closeAdAction {
    [_presendVc dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)removeAllSubviewsWithView:(UIView *)view{
    NSArray *viewsToRemove = [view subviews];
    for (UIView *removeView in viewsToRemove) {
        [removeView removeFromSuperview];
    }
}
#pragma mark - ADSuyiNativeAdDelegate

- (void)adsy_nativeAdSucessToLoad:(ADSuyiSDKNativeAd *)nativeAd
                      adViewArray:(NSArray<__kindof UIView<ADSuyiAdapterNativeAdViewDelegate> *> *)adViewArray {
    for (UIView<ADSuyiAdapterNativeAdViewDelegate> *adView in adViewArray) {
        // 4、判断信息流广告是否为自渲染类型（可选实现） 可仿照所示样式demo实现 如无所需样式则需自行实现
        // 如果单纯只配置了模版信息流，那么不需要实现，如果配置了自渲染信息流，那么需要实现
        if(adView.renderType == ADSuyiAdapterRenderTypeNative) {
            // 4.1、信息流绘制开屏广告样式
            [self setUpUnifiedInterstitialAdView:adView];
        }
        // 5、注册，自渲染：注册点击事件，模板：render，重要
        [adView adsy_registViews:@[adView]];
    }
}

- (void)adsy_nativeAdFailToLoad:(ADSuyiSDKNativeAd *)nativeAd
                     errorModel:(ADSuyiAdapterErrorDefine *)errorModel {
    [self.view makeToast:@"广告加载失败"];

}

- (void)adsy_nativeAdViewRenderOrRegistSuccess:(UIView<ADSuyiAdapterNativeAdViewDelegate> *)adView {
    if(adView.renderType == ADSuyiAdapterRenderTypeNative) {
        
    }else{
        self.adBgView.frame = CGRectMake((CGRectGetWidth(self.backgroundView.frame) - adView.frame.size.width)/2, (CGRectGetHeight(self.backgroundView.frame) - adView.frame.size.height)/2, adView.frame.size.width, adView.frame.size.height);
    }
    [self.adBgView addSubview:adView];
    [self.backgroundView addSubview:self.adBgView];
    
    [_presendVc.view addSubview:self.backgroundView];
//    [self presentViewController:_presendVc animated:YES completion:nil];
    [self presentViewController:_presendVc animated:YES completion:^{
    }];
}

- (void)adsy_nativeAdViewRenderOrRegistFail:(UIView<ADSuyiAdapterNativeAdViewDelegate> *)adView {
    
}

- (void)adsy_nativeAdClicked:(ADSuyiSDKNativeAd *)nativeAd
                      adView:(__kindof UIView<ADSuyiAdapterNativeAdViewDelegate> *)adView {
    NSLog(@"点击");
    
}

- (void)adsy_nativeAdClose:(ADSuyiSDKNativeAd *)nativeAd
                    adView:(__kindof UIView<ADSuyiAdapterNativeAdViewDelegate> *)adView {
    dispatch_async(dispatch_get_main_queue(), ^{
        [adView adsy_unRegistView];
    });
    [self removeAllSubviewsWithView:self.adBgView];
    [self removeAllSubviewsWithView:self.backgroundView];
    [self closeAdAction];
}

- (void)adsy_nativeAdExposure:(ADSuyiSDKNativeAd *)nativeAd
                       adView:(__kindof UIView<ADSuyiAdapterNativeAdViewDelegate> *)adView {
    
}
- (void)setUpUnifiedInterstitialAdView:(UIView<ADSuyiAdapterNativeAdViewDelegate> *)adView {
    // 设计的adView实际大小，其中宽度和高度可以自己根据自己的需求设置
    CGFloat adWidth = self.backgroundView.frame.size.width - 17 * 2;
    CGFloat adHeight = adWidth / 16.0 * 9;
    CGFloat adBgViewHeight = adHeight + 130;
    
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
        [adView adsy_platformLogoImageDarkMode:NO loadImageBlock:^(UIImage * _Nullable image) {
            CGFloat maxWidth = 30;
            CGFloat logoHeight = maxWidth / image.size.width * image.size.height;
            logoImage.frame = CGRectMake(adWidth - maxWidth, adHeight - logoHeight - 5, maxWidth, logoHeight);
            logoImage.image = image;
        }];
    }
    
    // 设置广告描述(可选)
    UILabel *descLabel = [UILabel new];
    descLabel.textColor = [UIColor adsy_colorWithHexString:@"#333333"];
    descLabel.font = [UIFont adsy_PingFangRegularFont:18];
    descLabel.textAlignment = NSTextAlignmentCenter;
    descLabel.numberOfLines = 2;
//    descLabel.text = adView.data.title;
    descLabel.text = @"这里是信息流自渲染适配插屏，需要开发者自行设计样式";
    [self.adBgView addSubview:descLabel];
    descLabel.frame = CGRectMake(0, adHeight + 15, adWidth, 60);
    
   
    self.adBgView.frame = CGRectMake(17, (self.backgroundView.frame.size.height - adBgViewHeight)/2, adWidth, adBgViewHeight);
    
    
    //设置关闭按钮
    CGFloat closeBtnWidth = 40;
    CGFloat closeBtnHeight = closeBtnWidth;
    self.closeBtn.frame = CGRectMake((adWidth - closeBtnWidth)/2, CGRectGetHeight(self.adBgView.frame) - closeBtnHeight, closeBtnWidth, closeBtnHeight);
    [self.adBgView addSubview:self.closeBtn];

}


-(UIViewController *)presendVc
{
    if (!_presendVc) {
        _presendVc = [UIViewController new];
        _presendVc.modalPresentationStyle = UIModalPresentationOverFullScreen;
        _presendVc.view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.1];
    }
    return _presendVc;
}

@end
