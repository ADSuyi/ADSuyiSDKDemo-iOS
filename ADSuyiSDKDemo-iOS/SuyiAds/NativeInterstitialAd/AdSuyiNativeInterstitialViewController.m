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
@interface AdSuyiNativeInterstitialViewController ()<ADSuyiSDKNativeAdDelegate>
@property (nonatomic, strong) ADSuyiSDKNativeAd *nativeAd;

@property (nonatomic, strong) UIButton *closeBtn;

@property (nonatomic, strong) UIView *backgroundView;

@end

@implementation AdSuyiNativeInterstitialViewController

#pragma mark - lazy load

- (ADSuyiSDKNativeAd *)nativeAd {
    if(!_nativeAd) {
        // 1、信息流广告初始化
        _nativeAd = [[ADSuyiSDKNativeAd alloc] initWithAdSize:CGSizeMake(self.view.frame.size.width, 10)];
        // 2、传入posId，重要
        _nativeAd.delegate = self;
        _nativeAd.controller = self;
        _nativeAd.posId = @"e9eaffb6b9d97cd813";
    }
    return _nativeAd;
}
- (UIButton *)closeBtn{
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(closeAd) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _closeBtn;
}
- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [UIView new];
        _backgroundView.frame = UIScreen.mainScreen.bounds;
        _backgroundView.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.7];
    }
    return _backgroundView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"信息流插屏";
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    [self loadNativeAd];
    
}

- (void)loadNativeAd {
    [self.nativeAd load:1];
}

- (void)closeAd {
    [self.backgroundView removeFromSuperview];
}

#pragma mark - ADSuyiNativeAdDelegate

- (void)adsy_nativeAdSucessToLoad:(ADSuyiSDKNativeAd *)nativeAd
                      adViewArray:(NSArray<__kindof UIView<ADSuyiAdapterNativeAdViewDelegate> *> *)adViewArray {
    for (UIView<ADSuyiAdapterNativeAdViewDelegate> *adView in adViewArray) {
        // 4、判断信息流广告是否为自渲染类型（可选实现） 可仿照所示样式demo实现 如无所需样式则需自行实现
        // 如果单纯只配置了模版信息流，那么不需要实现，如果配置了自渲染信息流，那么需要实现
        if(adView.renderType == ADSuyiAdapterRenderTypeNative) {
            // 4.1、信息流绘制开屏广告样式
            [self setUpUnifiedSplahAdView:adView];
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
    
}

- (void)adsy_nativeAdViewRenderOrRegistSuccess:(UIView<ADSuyiAdapterNativeAdViewDelegate> *)adView {
    // 6、注册或渲染成功，此时高度正常，可以展示
    [[UIApplication sharedApplication].keyWindow addSubview:self.backgroundView];
}

- (void)adsy_nativeAdViewRenderOrRegistFail:(UIView<ADSuyiAdapterNativeAdViewDelegate> *)adView {
    
}

- (void)adsy_nativeAdClicked:(ADSuyiSDKNativeAd *)nativeAd
                      adView:(__kindof UIView<ADSuyiAdapterNativeAdViewDelegate> *)adView {
    
}

- (void)adsy_nativeAdClose:(ADSuyiSDKNativeAd *)nativeAd
                    adView:(__kindof UIView<ADSuyiAdapterNativeAdViewDelegate> *)adView {
    dispatch_async(dispatch_get_main_queue(), ^{
        [adView adsy_unRegistView];
    });
    [self closeAd];
}

- (void)adsy_nativeAdExposure:(ADSuyiSDKNativeAd *)nativeAd
                       adView:(__kindof UIView<ADSuyiAdapterNativeAdViewDelegate> *)adView {
    
}

- (CGSize)getImageSizeWithURL:(id)URL{
    NSURL * url = nil;
    if ([URL isKindOfClass:[NSURL class]]) {
        url = URL;
    }
    if ([URL isKindOfClass:[NSString class]]) {
        url = [NSURL URLWithString:URL];
    }
    if (!URL) {
        return CGSizeZero;
    }
    CGImageSourceRef imageSourceRef =     CGImageSourceCreateWithURL((CFURLRef)url, NULL);
    CGFloat width = 0, height = 0;
    if (imageSourceRef) {
        CFDictionaryRef imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSourceRef, 0, NULL);
      if (imageProperties != NULL) {
          CFNumberRef widthNumberRef = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelWidth);
          if (widthNumberRef != NULL) {
              CFNumberGetValue(widthNumberRef, kCFNumberFloat64Type, &width);
          }
          CFNumberRef heightNumberRef = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelHeight);
          if (heightNumberRef != NULL) {
            CFNumberGetValue(heightNumberRef, kCFNumberFloat64Type, &height);
        }
        CFRelease(imageProperties);
    }
    CFRelease(imageSourceRef);
    }
    return CGSizeMake(width, height);
}
- (void)setUpUnifiedSplahAdView:(UIView<ADSuyiAdapterNativeAdViewDelegate> *)adView {
    // 设计的adView实际大小，其中宽度和高度可以自己根据自己的需求设置
    CGFloat adWidth = self.backgroundView.frame.size.width;
    CGFloat adHeight = self.backgroundView.frame.size.height;
    CGFloat adViewY = adHeight/2 - (adWidth - 17 * 2) / 16.0 * 9/2 - 8 - 8;

    adView.frame = CGRectMake(0, 0, self.backgroundView.frame.size.width, self.backgroundView.frame.size.height);
    [self.backgroundView addSubview:adView];

    //设置关闭按钮
    CGFloat closeBtnWidth = 30;
    CGFloat closeBtnHeight = closeBtnWidth;
    self.closeBtn.frame = CGRectMake(CGRectGetMaxX(self.backgroundView.frame) - closeBtnWidth - 20, 200, closeBtnWidth, closeBtnHeight);
    [adView addSubview:self.closeBtn];
    
    

    // 设置标题文字（可选，但强烈建议带上）
    UILabel *titlabel = [UILabel new];
    [adView addSubview:titlabel];
    titlabel.font = [UIFont adsy_PingFangMediumFont:14];
    titlabel.textColor = [UIColor adsy_colorWithHexString:@"#FFFFFF"];
    titlabel.numberOfLines = 2;
    titlabel.text = adView.data.title;
    CGSize textSize = [titlabel sizeThatFits:CGSizeMake(adWidth - 17 * 2, 999)];
    titlabel.frame = CGRectMake(17, adViewY, adWidth - 17 * 2, textSize.height);
    
    CGFloat height = textSize.height + adViewY + 15;
    
    // 设置主图/视频（主图可选，但强烈建议带上,如果有视频试图，则必须带上）
    CGRect mainFrame = CGRectMake(17, height, adWidth - 17 * 2, (adWidth - 17 * 2) / 16.0 * 9);
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
            CGFloat maxWidth = 40;
            CGFloat logoHeight = maxWidth / image.size.width * image.size.height;
            logoImage.frame = CGRectMake(adWidth - maxWidth - 20, CGRectGetMaxY(mainFrame) - logoHeight - 5, maxWidth, logoHeight);
            logoImage.image = image;
        }];
    }
    
    // 设置广告标识（可选）
    height += (adWidth - 17 * 2) / 16.0 * 9 + 9;
    UILabel *adLabel = [[UILabel alloc]init];
    adLabel.backgroundColor = [UIColor adsy_colorWithHexString:@"#CCCCCC"];
    adLabel.textColor = [UIColor adsy_colorWithHexString:@"#FFFFFF"];
    adLabel.font = [UIFont adsy_PingFangLightFont:12];
    adLabel.text = @"广告";
    [adView addSubview:adLabel];
    adLabel.frame = CGRectMake(17, height, 36, 18);
    adLabel.textAlignment = NSTextAlignmentCenter;
    
    // 设置广告描述(可选)
    UILabel *descLabel = [UILabel new];
    descLabel.textColor = [UIColor adsy_colorWithHexString:@"#FFFFFF"];
    descLabel.font = [UIFont adsy_PingFangLightFont:12];
    descLabel.textAlignment = NSTextAlignmentLeft;
    descLabel.text = adView.data.desc;
    [adView addSubview:descLabel];
    descLabel.frame = CGRectMake(17 + 36 + 4, height, self.view.frame.size.width - 57 - 17 - 20, 18);
}




@end
