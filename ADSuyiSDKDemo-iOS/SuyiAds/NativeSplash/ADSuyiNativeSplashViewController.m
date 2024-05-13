//
//  ADSuyiNativeSplashViewController.m
//  ADSuyiSDKDemo-iOS
//
//  Created by Erik on 2022/1/24.
//  Copyright © 2022 陈坤. All rights reserved.
//

#import "ADSuyiNativeSplashViewController.h"
#import <ADSuyiSDK/ADSuyiSDKNativeAd.h>
#import <ADSuyiKit/ADSuyiKit.h>
#import "UIViewController+TYTopView.h"
#import "AdMacros.h"

@interface ADSuyiNativeSplashViewController ()<ADSuyiSDKNativeAdDelegate>
@property (nonatomic, strong) ADSuyiSDKNativeAd *nativeAd;

@property (nonatomic, strong) UILabel *skipLable;

@property (nonatomic, strong) ADSuyiKitTimer *timer;

@property (nonatomic, assign) NSInteger skipCount;

@property (nonatomic, strong) UIView *backgroundView;

@property (nonatomic, strong) UILabel *customClickLabel;

@property (nonatomic, strong) UIViewController *splashViewController;

@end

@implementation ADSuyiNativeSplashViewController

#pragma mark - lazy load

- (ADSuyiSDKNativeAd *)nativeAd {
    if(!_nativeAd) {
        // 1、信息流广告初始化
        _nativeAd = [[ADSuyiSDKNativeAd alloc] initWithAdSize:CGSizeMake(self.view.frame.size.width, 10)];
        // 2、传入posId，重要
        _nativeAd.delegate = self;
        _nativeAd.controller = self.splashViewController;
        _nativeAd.posId = Suyi_Demo_flowAd_Native_PosId;
    }
    return _nativeAd;
}

- (UILabel *)skipLable {
    if (!_skipLable) {
        _skipLable = [UILabel new];
        _skipLable.frame = CGRectMake(0, 0, 70, 25);
        _skipLable.backgroundColor = UIColor.clearColor;
        _skipLable.layer.borderWidth = 0.5;
        _skipLable.layer.borderColor = UIColor.blackColor.CGColor;
        _skipLable.textColor = UIColor.blackColor;
        _skipLable.font = [UIFont systemFontOfSize:14];
        _skipLable.layer.cornerRadius = 6;
        _skipLable.textAlignment = NSTextAlignmentCenter;
    }
    return _skipLable;
}

- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [UIView new];
        _backgroundView.frame = UIScreen.mainScreen.bounds;
        _backgroundView.backgroundColor = UIColor.whiteColor;
    }
    return _backgroundView;
}

- (UILabel *)customClickLabel {
    if (!_customClickLabel) {
        _customClickLabel = [UILabel new];
        _customClickLabel.font = [UIFont systemFontOfSize:15];
        _customClickLabel.textColor = UIColor.blackColor;
        _customClickLabel.layer.borderWidth = 1;
        _customClickLabel.layer.borderColor = UIColor.blackColor.CGColor;
        _customClickLabel.layer.cornerRadius = 10;
        _customClickLabel.text = @"点击跳转详情页   >";
        _customClickLabel.textAlignment = NSTextAlignmentCenter;
        _customClickLabel.userInteractionEnabled = NO;
    }
    return _customClickLabel;
}
- (UIViewController *)splashViewController{
    if (!_splashViewController) {
        _splashViewController = [UIViewController new];
        _splashViewController.modalPresentationStyle = UIModalPresentationOverFullScreen;
    }
    return _splashViewController;
}

- (void)timerAction:(ADSuyiKitTimer *)timer {
    _skipCount--;
    _skipCount = _skipCount < 0 ? 0 : _skipCount;
    self.skipLable.text = [NSString stringWithFormat:@" 跳过 | %ld ",(long)_skipCount];
    if (_skipCount==0 && [[UIViewController topViewController] isEqual:self.splashViewController]) {
        [self closeAd];
    }
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"信息流开屏";
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    self.skipCount = 5;
    [self loadNativeAd];
    
}

- (void)dealloc {
    [_timer invalidate];
    _timer = nil;
}

- (void)loadNativeAd {
    [self.nativeAd load:1];
}

- (void)closeAd {
    [_splashViewController dismissViewControllerAnimated:YES completion:nil];
    [self.backgroundView removeFromSuperview];
}

#pragma mark - ADSuyiNativeAdDelegate

- (void)adsy_nativeAdSucessToLoad:(ADSuyiSDKNativeAd *)nativeAd
                      adViewArray:(NSArray<__kindof UIView<ADSuyiAdapterNativeAdViewDelegate> *> *)adViewArray {
    for (UIView<ADSuyiAdapterNativeAdViewDelegate> *adView in adViewArray) {
        // 4、判断信息流广告是否为自渲染类型（可选实现） 可仿照所示样式demo实现 如无所需样式则需自行实现
        // 如果单纯只配置了模版信息流，那么不需要实现，如果配置了自渲染信息流，那么需要实现
        NSInteger tt = adView.renderType;
        if(adView.renderType == ADSuyiAdapterRenderTypeNative) {
            // 4.1、信息流绘制开屏广告样式
            [self setUpUnifiedSplahAdView:adView];
        } else {
            [self.backgroundView addSubview:adView];
            adView.frame = CGRectMake(self.backgroundView.bounds.size.width/2 - adView.bounds.size.width/2, self.backgroundView.bounds.size.height/2 - adView.bounds.size.height/2, adView.bounds.size.width, adView.bounds.size.height);
            [self.backgroundView addSubview:self.skipLable];
            self.skipLable.userInteractionEnabled = YES;
            self.skipLable.frame = CGRectMake(self.view.bounds.size.width - self.skipLable.bounds.size.width - 30, 44, self.skipLable.bounds.size.width, self.skipLable.bounds.size.height);
            self.skipLable.text = [NSString stringWithFormat:@" 跳过 | %ld ",(long)_skipCount];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:adView action:@selector(adsy_close)];
            [self.skipLable addGestureRecognizer:tap];
            
            
            [self.backgroundView addSubview:self.customClickLabel];
            self.customClickLabel.frame = CGRectMake(self.view.bounds.size.width/2 - 150, self.view.bounds.size.height - 50 - 50, 300, 40);
        }
        // 5、注册，自渲染：注册点击事件，模板：render，重要
        [adView adsy_registViews:@[adView]];
    }

}

- (void)adsy_nativeAdFailToLoad:(ADSuyiSDKNativeAd *)nativeAd
                     errorModel:(ADSuyiAdapterErrorDefine *)errorModel {
    
}

- (void)adsy_nativeAdViewRenderOrRegistSuccess:(UIView<ADSuyiAdapterNativeAdViewDelegate> *)adView {
    // 6、注册或渲染成功，此时高度正常，可以展示
    // 建议采用控制器承载广告视图，部分平台有监测父视图，window承载时无法点击
    
    [self.splashViewController.view addSubview:self.backgroundView];
    [self presentViewController:_splashViewController animated:nil completion:nil];
    _timer = [ADSuyiKitTimer timerWithTimeInterval:1 target:self selector:@selector(timerAction:) repeats:YES];
    [_timer scheduleImmediately:NO];
    
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


- (void)setUpUnifiedSplahAdView:(UIView<ADSuyiAdapterNativeAdViewDelegate> *)adView {
    // 设计的adView实际大小，其中宽度和高度可以自己根据自己的需求设置
    [self.backgroundView addSubview:adView];
    CGFloat adWidth = self.view.frame.size.width;
    CGFloat adHeight = self.view.frame.size.height;
    
    [self.backgroundView addSubview:self.skipLable];
    self.skipLable.userInteractionEnabled = YES;
    self.skipLable.frame = CGRectMake(self.view.bounds.size.width - self.skipLable.bounds.size.width - 30, 44, self.skipLable.bounds.size.width, self.skipLable.bounds.size.height);
    self.skipLable.text = [NSString stringWithFormat:@" 跳过 | %ld ",(long)_skipCount];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:adView action:@selector(adsy_close)];
    [self.skipLable addGestureRecognizer:tap];
    
    adView.frame = CGRectMake(0, 0, adWidth, adHeight);
    
    [self.backgroundView addSubview:self.customClickLabel];
    self.customClickLabel.frame = CGRectMake(self.view.bounds.size.width/2 - 150, self.view.bounds.size.height - 50 - 50, 300, 40);
    
    
    // 显示logo图片（必要）
    if(![adView.adsy_platform isEqualToString:ADSuyiAdapterPlatformGDT]) { // 优量汇（广点通）会自带logo，不需要添加
        UIImageView *logoImage = [UIImageView new];
        [adView addSubview:logoImage];
        [adView adsy_platformLogoImageDarkMode:NO loadImageBlock:^(UIImage * _Nullable image) {
            CGFloat maxWidth = 40;
            CGFloat logoHeight = maxWidth / image.size.width * image.size.height;
            logoImage.frame = CGRectMake(adWidth - maxWidth - 20, adHeight - logoHeight - 20, maxWidth, logoHeight);
            logoImage.image = image;
        }];
    }
    
    CGFloat adViewY = adHeight/2 - (adWidth - 17 * 2) / 16.0 * 9/2 - 8 - 8;
    
    // 设置标题文字（可选，但强烈建议带上）
    UILabel *titlabel = [UILabel new];
    [adView addSubview:titlabel];
    titlabel.font = [UIFont adsy_PingFangMediumFont:14];
    titlabel.textColor = [UIColor adsy_colorWithHexString:@"#333333"];
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
    descLabel.textColor = [UIColor adsy_colorWithHexString:@"#333333"];
    descLabel.font = [UIFont adsy_PingFangLightFont:12];
    descLabel.textAlignment = NSTextAlignmentLeft;
    descLabel.text = adView.data.desc;
    [adView addSubview:descLabel];
    descLabel.frame = CGRectMake(17 + 36 + 4, height, self.view.frame.size.width - 57 - 17 - 20, 18);
}




@end
