

# ADSuyiSDK iOS接入文档 v3.0.4











[TOC]























## 修订历史

| 文档版本 | 修订日期   | 修订说明                                                     |
| -------- | ---------- | ------------------------------------------------------------ |
| V3.0.4   | 2020-05-28 | 接入广点通、头条、百度、inmobi、汇量、快手、谷歌、Mopub、Unity广告平台，建立开屏、banner、信息流（自渲染和模板）、插屏、激励视频、全屏视频、沉浸式视频广告类型 |

<div STYLE="page-break-after: always;"></div>
## 1.1 概述

尊敬的开发者朋友，欢迎您使用苏伊士广告SDK。通过本文档，您可以在几分钟之内轻松完成广告的集成过程。

操作系统： iOS 9.0 及以上版本

运行设备：iPhone （iPad上可能部分广告正常展示，但是存在填充很低或者平台不支持等问题，建议不要在iPad上展示广告）

- `ADSuyiSDK Objective-C Demo地址`[[ADSuyiSDK Objective-C Demo]](https://github.com/ADSuyi/ADSuyiSDKDemo-iOS)
- `ADSuyiSDK Swift Demo地址`[[ADSuyiSDK Swift Demo]](https://github.com/ADSuyi/ADSuyiSDKDemo-iOS-Swift.git)

<br>



## 2.1 采用cocoapods进行SDK的导入

推荐使用pod命令

```ruby
// 挑选在苏伊士托管的平台导入项目
pod 'ADSuyiSDK'
pod 'ADSuyiBU'
pod 'ADSuyiGDT'
pod 'ADSuyiAdMobile'
pod 'ADSuyiInmobi'
pod 'ADSuyiMTG'
pod 'ADSuyiGoogle'
pod 'ADSuyiUnity'
// 推荐导入，通过系统定位获取定位信息
pod 'ADSuyiLocationManagerGPS'// 含有系统定位代码
```

推荐使用导入命令

```ruby
pod 'ADSuyiSDK', '~> 3.0.4'
pod 'ADSuyiBU'
pod 'ADSuyiGDT'
pod 'ADSuyiAdMobile'
pod 'ADSuyiInmobi'
pod 'ADSuyiMTG'
pod 'ADSuyiGoogle'
pod 'ADSuyiUnity'
```

<div STYLE="page-break-after: always;"></div>
## 2.2 手动导入SDK方式

[点击进入SDK下载地址](http://101.37.118.54/dokuwiki/doku.php?id=admobgensdk)下载各SDK拖入到工程中

手动方式导入,需要添加如下依赖库:

```obj-c
AdSupport.framework 
CoreLocation.framework 
QuartzCore.framework 
SystemConfiguration.framework
CoreTelephony.framework
libz.tbd 
WebKit.framework (Optional)
libxml2.tbd
Security.framework 
StoreKit.framework
AVFoundation.framework
CoreMedia.framework
```

头条还需要添加依赖库：

```
libresolv.9.tbd
MobileCoreServices.framework
MediaPlayer.framework
CoreMotion.framework
Accelerate.framework
libc++.tbd
libsqlite3.tbd
ImageIO.framework
```

<div STYLE="page-break-after: always;"></div>
## 3.1 工程环境配置

1. 打开项目的 app target，查看 Build Settings 中的 Linking-Other Linker Flags 选项，确保含有 -ObjC 一值， 若没有则添加。

2. 在项目的 app target 中，查看 Build Settings 中的 Build options - Enable Bitcode 选项， 设置为NO。 
3. info.plist 添加支持 Http访问字段

```obj-c
<key>NSAppTransportSecurity</key>
<dict>
<key>NSAllowsArbitraryLoads</key>
<true/>
</dict>
```

4. Info.plist 添加定位权限字段（使用ADMobGenLocation可不设置）

```obj-c
NSLocationWhenInUseUsageDescription
NSLocationAlwaysAndWhenInUseUsageDeion
```

5. Info.plist推荐设置白名单，可提高广告收益

```obj-c
<key>LSApplicationQueriesSchemes</key>
    <array>
        <string>dianping</string>
        <string>imeituan</string>
        <string>com.suning.SuningEBuy</string>
        <string>openapp.jdmobile</string>
        <string>vipshop</string>
        <string>snssdk141</string>
        <string>ctrip</string>
        <string>suning</string>
        <string>qunariphone</string>
        <string>QunarAlipay</string>
        <string>qunaraphone</string>
        <string>yohobuy</string>
        <string>kaola</string>
        <string>agoda</string>
        <string>openapp.xzdz</string>
        <string>beibeiapp</string>
        <string>taobao</string>
        <string>tmall</string>
        <string>openjd</string>
        <string>jhs</string>
        <string>yhd</string>
        <string>wireless1688</string>
        <string>GomeEShop</string>
        <string>wbmain</string>
        <string>xhsdiscover</string>
        <string>douyin</string>
        <string>pinduoduo</string>
        <string>jdmobile</string>
        <string>tbopen</string>
        <string>pddopen</string>
        <string>mogujie</string>
        <string>koubei</string>
        <string>eleme</string>
        <string>youku</string>
    </array>
```

<br>

<div STYLE="page-break-after: always;"></div>
## 4.1 集合SDK的初始化

`申请的appid和你的包名相对应`

```obj-c
// ADSuyiSDK初始化
[ADSuyiSDK initWithAppId:@"3993370" completionBlock:^(NSError * _Nonnull error) {
    if (error) {
        NSLog(@"SDK 初始化失败：%@", error.localizedDescription);
    }
}];
```

用户日志输出等级

```obj-c
// 设置日志输出等级
[ADSuyiSDK setLogLevel:ADSuyiKitLogLevelDebug];
```

获取ADMobGenSDK版本号

```obj-c
//获取SDK版本号
NSString *sdkVersion = [ADSuyiSDK getSDKVersion];
```

<br>

<div STYLE="page-break-after: always;"></div>
## 4.2 开屏广告 - ADSuyiSDKSplashAd

开屏广告会在您的应用开启时加载，拥有固定展示时间，展示完毕后自动关闭并进入您的应用主界面。

推荐在 `AppDelegate`的 `didFinishLaunchingWithOptions`方法的 `return YES`之前调用开屏。

`OC请求开屏代码示例：`[[开屏代码示例]](https://github.com/ADSuyi/ADSuyiSDKDemo-iOS/blob/master/ADSuyiSDKDemo-iOS/AppDelegate.m)

`Swift请求开屏代码示例：`[[开屏代码示例]](https://github.com/ADSuyi/ADSuyiSDKDemo-iOS-Swift/blob/master/ADSuyiSDKDemo-iOS-Swift/AppDelegate.swift)

开屏广告 - ADSuyiSDKSplashAd：

```obj-c
@interface ADSuyiSDKSplashAd : NSObject

/**
开屏的默认背景色,或者启动页,为nil则代表透明
*/
@property (nonatomic, copy, nullable) UIColor *backgroundColor;

/*
viewControllerForPresentingModalView
详解：[必选]开发者需传入用来弹出目标页的ViewController，一般为当前ViewController
*/
@property (nonatomic, weak) UIViewController *controller;

/**
 广告位id
*/
@property (nonatomic, copy) NSString *posId;

/**
代理回调
*/
@property (nonatomic, weak) id<ADSuyiSDKSplashAdDelegate> delegate;

/**
 开屏请求总超时时间:所有平台轮询的请求等待总时长（不包括图片渲染时间），单位秒，推荐设置为4s，最小值为3s
 开屏各平台分配逻辑:(目前只有开屏需要分配时间，并且理论上分配给到各平台的超时时间不会完全耗尽)
 1、3<=tolerateTimeout<=4:轮询首位平台的超时时间为(tolerateTimeout-1)s，次位为2s，如果后续还有平台统一为1s;
 2、tolerateTimeout>=5:轮询首位平台的超时时间为(tolerateTimeout-2)s，次位为3s，如果后续还有平台统一为2s;
 */
@property (nonatomic, assign) NSInteger tolerateTimeout;

/**
 跳过按钮的类型，可以通过此接口替换开屏广告的跳过按钮样式
 */
@property (nonatomic, strong, null_resettable) UIView<ADSuyiAdapterSplashSkipViewProtocol> *skipView;

/**
加载开屏广告

@param window 开屏广告展示的window
@param bottomView 底部logo视图, 高度不能超过屏幕的25%, 建议: 开屏的广告图片默认640 / 960比例, 可以用 MIN(screenHeight - screenWidth * (960 / 640.0), screenHeight * 0.25) 得出bottomview的高度
*/
- (void)loadAndShowInWindow:(UIWindow *)window withBottomView:(nullable UIView *)bottomView;

/**
加载开屏广告

@param window 开屏广告展示的window
*/
- (void)loadAndShowInWindow:(UIWindow *)window;

@end
```

<div STYLE="page-break-after: always;"></div>
开屏广告代理回调 - ADSuyiSDKSplashAdDelegate

```obj-c
@protocol ADSuyiSDKSplashAdDelegate <NSObject>

@optional

/**
 开屏展现成功
 
 @param splashAd 广告实例
 */
- (void)adsy_splashAdSuccessToPresentScreen:(ADSuyiSDKSplashAd *)splashAd;

/**
 开屏展现失败
 
 @param splashAd 广告实例
 @param error 具体错误信息
 */
- (void)adsy_splashAdFailToPresentScreen:(ADSuyiSDKSplashAd *)splashAd failToPresentScreen:(ADSuyiAdapterErrorDefine *)error;

/**
 开屏广告点击
 
 @param splashAd 广告实例
 */
- (void)adsy_splashAdClicked:(ADSuyiSDKSplashAd *)splashAd;

/**
 开屏被关闭
 
 @param splashAd 广告实例
 */
- (void)adsy_splashAdClosed:(ADSuyiSDKSplashAd *)splashAd;

/**
 开屏展示
 
 @param splashAd 广告实例
 */
- (void)adsy_splashAdEffective:(ADSuyiSDKSplashAd *)splashAd;

@end

```

<div STYLE="page-break-after: always;"></div>
Swift请求开屏广告代码示例：[[开屏代码示例]](https://github.com/ADSuyi/ADSuyiSDKDemo-iOS-Swift/blob/master/ADSuyiSDKDemo-iOS-Swift/AppDelegate.swift)

OC请求开屏广告代码示例：

```obj-c
#import <ADSuyiSDK/ADSuyiSDKSplashAd.h>
#import <ADSuyiKit/UIColor+ADSuyiKit.h>
#import <ADSuyiKit/ADSuyiKitMacros.h>

/*
 * 推荐在AppDelegate中的最后加载开屏广告
 * 其他的接入方式会有需要特殊注意的方式，遇到过的相关问题在SDK相关问题的文档中有提到
 */

- (void)loadSplashAd{
    // 1、初始化开屏广告实例对象
    self.splashAd = [[ADSuyiSDKSplashAd alloc]init];
    self.splashAd.delegate = self;
    self.splashAd.controller = _window.rootViewController;
    // 2、设置开屏的广告位id
    self.splashAd.posId = @"d11c2ef29dcb7e6e62";
    /**
    开屏请求总超时时间:所有平台轮询的请求等待总时长（不包括图片渲染时间），单位秒，推荐设置为4s，最小值为3s
    开屏各平台分配逻辑:(目前只有开屏需要分配时间，并且理论上分配给到各平台的超时时间不会完全耗尽)
    1、3<=tolerateTimeout<=4:轮询首位平台的超时时间为(tolerateTimeout-1)s，次位为2s，如果后续还有平台统一为1s;
    2、tolerateTimeout>=5:轮询首位平台的超时时间为(tolerateTimeout-2)s，次位为3s，如果后续还有平台统一为2s;
    */
    self.splashAd.tolerateTimeout = 4;
    // 3、设置默认启动图(一般设置启动图的平铺颜色为背景颜色，使得视觉效果更加平滑)
    self.splashAd.backgroundColor = [UIColor adsy_getColorWithImage:[UIImage imageNamed:@"750x1334.png"] withNewSize:[UIScreen mainScreen].bounds.size];
    
    // 4、开屏广告机型适配
    CGFloat bottomViewHeight;
    if (kADSYCurveScreen) { // 刘海屏
        bottomViewHeight = [UIScreen mainScreen].bounds.size.height * 0.25;
    } else {
        bottomViewHeight = [UIScreen mainScreen].bounds.size.height - [UIScreen mainScreen].bounds.size.width * (960 / 640.0);
    }
    
    // 5、底部视图设置，非必选项
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    bottomView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, bottomViewHeight);
    UIImageView *logoImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ADMob_Logo.png"]];
    logoImageView.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-135)/2, (bottomViewHeight-46)/2, 135, 46);
    [bottomView addSubview:logoImageView];
    
    // 6、加载开屏广告
    [self.splashAd loadAndShowInWindow:_window withBottomView:bottomView];
}

// 7、代理回调
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
```

<br>

<div STYLE="page-break-after: always;"></div>
## 4.3 banner广告 - ADSuyiSDKBannerAdView

`OC请求横幅代码示例：`[[横幅代码示例]](https://github.com/ADSuyi/ADSuyiSDKDemo-iOS/blob/master/ADSuyiSDKDemo-iOS/SuyiAds/BannerAd/AdSuyiBannerViewController.m)

`Swift请求横幅代码示例：`[[横幅代码示例]](https://github.com/ADSuyi/ADSuyiSDKDemo-iOS-Swift/blob/master/ADSuyiSDKDemo-iOS-Swift/SuyiAds/BannerAd/ADSuyiBannerViewController.swift)

横幅广告 - ADSuyiSDKBannerAdView：

```obj-c
@interface ADSuyiSDKBannerAdView : UIView

/**
 广告生命周期代理
*/
@property (nonatomic, weak) id<ADSuyiSDKBannerAdViewDelegate> delegate;

/**
 广告位id
*/
@property (nonatomic, copy) NSString *posId;

/**
 banner刷新时间间隔，30-120s之间.
*/
@property (nonatomic, assign) NSInteger refershTime;

/**
 请求超时时间,默认为4s,需要设置3s及以上
*/
@property (nonatomic, assign) NSInteger tolerateTimeout;

/**
 viewControllerForPresentingModalView
 详解：[必选]开发者需传入用来弹出目标页的ViewController，一般为当前ViewController
*/
@property (nonatomic, weak) UIViewController *controller;

- (id)new NS_UNAVAILABLE;
- (id)init NS_UNAVAILABLE;

/*
 初始化bannerView
 @param frame 期望的banner视图尺寸
*/
- (instancetype)initWithFrame:(CGRect)frame;

/**
 拉取并展示广告
*/
- (void)loadAndShowWithError:(NSError **)error;

@end
```

横幅广告 - ADSuyiSDKBannerAdViewDelegate

```obj-c
@protocol ADSuyiSDKBannerAdViewDelegate <NSObject>

/**
 广告获取成功
 
 @param bannerView banner实例
 */
- (void)adsy_bannerViewDidReceived:(ADSuyiSDKBannerAdView *)bannerView;

/**
 广告拉取失败
 
 @param bannerView banner实例
 @param errorModel 错误描述
 */
- (void)adsy_bannerViewFailToReceived:(ADSuyiSDKBannerAdView *)bannerView errorModel:(ADSuyiAdapterErrorDefine *)errorModel;

/**
 广告点击
 
 @param bannerView 广告实例
 */
- (void)adsy_bannerViewClicked:(ADSuyiSDKBannerAdView *)bannerView;

/**
 广告关闭
 
 @param bannerView 广告实例
 */
- (void)adsy_bannerViewClose:(ADSuyiSDKBannerAdView *)bannerView;

/**
 广告展示
 
 @param bannerView 广告实例
 */
- (void)adsy_bannerViewExposure:(ADSuyiSDKBannerAdView *)bannerView;

@end
```

Swift请求横幅代码示例：[[横幅代码示例]](https://github.com/ADSuyi/ADSuyiSDKDemo-iOS-Swift/blob/master/ADSuyiSDKDemo-iOS-Swift/SuyiAds/BannerAd/ADSuyiBannerViewController.swift)

OC请求横幅广告请求示例：

```obj-c
#import <ADSuyiSDK/ADSuyiSDKBannerAdView.h>

- (void)loadBannerWithRate:(CGFloat)rate posId:(NSString *)posId {
    [self.bannerView removeFromSuperview];
    self.bannerView.delegate = nil;
    self.bannerView = nil;
    
    // 1、初始化banner视图，并给定frame值，rate取值根据banner的尺寸
    self.bannerView = [[ADSuyiSDKBannerAdView alloc] initWithFrame:CGRectMake(0, 250, kADSYScreenWidth, kADSYScreenWidth / rate)];
    self.bannerView.delegate = self;
    // 2、设置控制器，用来弹出落地页，重要
    self.bannerView.controller = self;
    // 3、设置广告位id，重要
    self.bannerView.posId = posId;
    self.bannerView.refershTime = 30;
    // 4、可先展示再请求
    [self.view addSubview:self.bannerView];
    self.bannerView.backgroundColor = [UIColor redColor];
    // 5、加载并展示
    [self.bannerView loadAndShowWithError:nil];
}

// 5、代理回调
#pragma mark - ADSuyiSDKBannerAdViewDelegate
/**
 广告获取成功
 
 @param bannerView banner实例
 */
- (void)adsy_bannerViewDidReceived:(ADSuyiSDKBannerAdView *)bannerView{
    
}

/**
 广告拉取失败
 
 @param bannerView banner实例
 @param errorModel 错误描述
 */
- (void)adsy_bannerViewFailToReceived:(ADSuyiSDKBannerAdView *)bannerView errorModel:(ADSuyiAdapterErrorDefine *)errorModel{
    NSLog(@"adsy_bannerViewFailToReceived:%@, %@",errorModel.errorDescription, errorModel.errorDetailDict);
    [_bannerView removeFromSuperview];
    _bannerView = nil;
}

/**
 广告点击
 
 @param bannerView 广告实例
 */
- (void)adsy_bannerViewClicked:(ADSuyiSDKBannerAdView *)bannerView{
    
}

/**
 广告关闭
 
 @param bannerView 广告实例
 */
- (void)adsy_bannerViewClose:(ADSuyiSDKBannerAdView *)bannerView{
    _bannerView = nil;
}

/**
 广告展示
 
 @param bannerView 广告实例
 */
- (void)adsy_bannerViewExposure:(ADSuyiSDKBannerAdView *)bannerView{
    
}
```

<br>

<div STYLE="page-break-after: always;"></div>
## 4.4 信息流广告 - ADSuyiSDKNativeAd

`OC请求信息流广告代码示例：`[[信息流广告代码示例]](https://github.com/ADSuyi/ADSuyiSDKDemo-iOS/blob/master/ADSuyiSDKDemo-iOS/SuyiAds/NativeAd/AdSuyiNativeViewController.m)

`Swift请求信息流广告代码示例：`[[信息流广告代码示例]](https://github.com/ADSuyi/ADSuyiSDKDemo-iOS-Swift/blob/master/ADSuyiSDKDemo-iOS-Swift/SuyiAds/NativeAd/AdSuyiNativeViewController.swift)

信息流广告 - ADSuyiSDKNativeAd：

```obj-c
typedef NS_ENUM(NSUInteger, ADSuyiSDKNativeAdStatus) {
    ADSuyiSDKNativeAdStatusDefault, // 闲置状态
    ADSuyiSDKNativeAdStatusLoading, // 加载广告中
};

@protocol ADSuyiSDKNativeAdDelegate;
@class ADSuyiAdapterNativeAdDataObject;

@interface ADSuyiSDKNativeAd : NSObject

- (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithAdSize:(CGSize)adSize;

/*
 viewControllerForPresentingModalView
 详解：[必选]开发者需传入用来弹出目标页的ViewController，一般为当前ViewController
 */
@property (nonatomic, weak) UIViewController *controller;

/*
 status
 详解：开发者可通过状态值来判断当前广告对象是否正在加载广告，支持KVO
*/
@property (nonatomic, assign, readonly) ADSuyiSDKNativeAdStatus status;

/**
 代理回调
 */
@property (nonatomic, weak) id<ADSuyiSDKNativeAdDelegate> delegate;

/**
 广告位id
*/
@property (nonatomic, copy) NSString *posId;

/**
 请求超时时间,默认为4s,需要设置3s及以上
*/
@property (nonatomic, assign) NSInteger tolerateTimeout;

/**
 加载广告

 @param count 拉取几条广告,建议区间 1~5, 超过可能无法拉取到
 */
- (void)load:(int)count;


@end

```

信息流广告代理回调 - ADSuyiSDKNativeAdDelegate

```obj-c
/**
 信息流广告请求成功

 @param nativeAd 广告实例
 @param adViewArray 广告模板集合
 */
- (void)adsy_nativeAdSucessToLoad:(ADSuyiSDKNativeAd *)nativeAd
                      adViewArray:(NSArray<__kindof UIView<ADSuyiAdapterNativeAdViewDelegate> *> *)adViewArray;

/**
 信息流广告请求失败

 @param nativeAd 广告实例
 @param errorModel 请求错误描述
 */
- (void)adsy_nativeAdFailToLoad:(ADSuyiSDKNativeAd *)nativeAd
                     errorModel:(ADSuyiAdapterErrorDefine *)errorModel;

/**
 信息流广告渲染成功

 @param adView 广告视图
 */
- (void)adsy_nativeAdViewRenderOrRegistSuccess:(UIView<ADSuyiAdapterNativeAdViewDelegate> *)adView;

/**
 信息流广告渲染失败

 @param adView 广告视图
 */
- (void)adsy_nativeAdViewRenderOrRegistFail:(UIView<ADSuyiAdapterNativeAdViewDelegate> *)adView;

/**
 信息流广告被点击

 @param nativeAd 广告模板
 */
- (void)adsy_nativeAdClicked:(ADSuyiSDKNativeAd *)nativeAd
                      adView:(__kindof UIView<ADSuyiAdapterNativeAdViewDelegate> *)adView;

/**
 信息流广告被关闭
 
 @param nativeAd 广告模板
 */
- (void)adsy_nativeAdClose:(ADSuyiSDKNativeAd *)nativeAd
                    adView:(__kindof UIView<ADSuyiAdapterNativeAdViewDelegate> *)adView;

/**
 信息流广告被展示
 
 @param nativeAd 广告实例
 */
- (void)adsy_nativeAdExposure:(ADSuyiSDKNativeAd *)nativeAd
                       adView:(__kindof UIView<ADSuyiAdapterNativeAdViewDelegate> *)adView;

@end

```

Swift请求信息流广告代码示例：[[信息流广告代码示例]](https://github.com/ADSuyi/ADSuyiSDKDemo-iOS-Swift/blob/master/ADSuyiSDKDemo-iOS-Swift/SuyiAds/NativeAd/AdSuyiNativeViewController.swift)

OC请求信息流广告请求示例：

```obj-c
#import <ADSuyiSDK/ADSuyiSDKNativeAd.h>

if(!_nativeAd) {
   // 1、信息流广告初始化
   _nativeAd = [[ADSuyiSDKNativeAd alloc] initWithAdSize:CGSizeMake(self.tableView.frame.size.width, 10)];
   // 2、传入posId，重要
   _nativeAd.posId = self.posId;
   _nativeAd.delegate = self;
   _nativeAd.controller = self;
}
// 3、加载信息流广告
[_nativeAd load:1];

// 4、代理回调
#pragma mark - ADSuyiSDKNativeAdDelegate
- (void)adsy_nativeAdSucessToLoad:(ADSuyiSDKNativeAd *)nativeAd
                      adViewArray:(NSArray<__kindof UIView<ADSuyiAdapterNativeAdViewDelegate> *> *)adViewArray {
    for (UIView<ADSuyiAdapterNativeAdViewDelegate> *adView in adViewArray) {
        // 4、判断信息流广告是否为自渲染类型
        if(adView.renderType == ADSuyiAdapterRenderTypeNative) {
            // 4.1、如果是自渲染类型则可样式自定义
            [self setUpUnifiedNativeAdView:adView];
        }
        // 5、注册，自渲染：注册点击事件，模板：render，重要
        [adView adsy_registViews:@[adView]];
    }
    
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

// 渲染成功回调
- (void)adsy_nativeAdViewRenderOrRegistSuccess:(UIView<ADSuyiAdapterNativeAdViewDelegate> *)adView {
    // 6、注册或渲染成功，此时高度正常，可以展示
    dispatch_async(dispatch_get_main_queue(), ^{
        for (int i = 0; i < 6; i ++) {
            [self.items addObject:[NSNull null]];
        }
        [self.items addObject:adView];
        [self.tableView reloadData];
    });
}

- (void)adsy_nativeAdClose:(ADSuyiSDKNativeAd *)nativeAd
                    adView:(__kindof UIView<ADSuyiAdapterNativeAdViewDelegate> *)adView {
    for (id item in _items) {
        if(item == adView) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [adView adsy_unRegistView];
                [self.items removeObject:adView];
                [self.tableView reloadData];
            });
        }
    }
}
```

<br>

<div STYLE="page-break-after: always;"></div>
## 4.5 激励视频广告 - ADSuyiSDKRewardvodAd

`OC请求激励视频代码示例：`[[激励视频广告代码示例]](https://github.com/ADSuyi/ADSuyiSDKDemo-iOS/blob/master/ADSuyiSDKDemo-iOS/SuyiAds/RewardVodAd/AdSuyiRewardvodViewController.m)

`Swift请求激励视频代码示例：`[[激励视频广告代码示例]](https://github.com/ADSuyi/ADSuyiSDKDemo-iOS-Swift/blob/master/ADSuyiSDKDemo-iOS-Swift/SuyiAds/RewardAd/AdSuyiRewardViewController.swift)

激励视频广告 - ADSuyiSDKRewardvodAd：

```obj-c
@interface ADSuyiSDKRewardvodAd : NSObject

/*
 viewControllerForPresentingModalView
 详解：[必选]开发者需传入用来弹出目标页的ViewController，一般为当前ViewController
 */
@property (nonatomic, weak) UIViewController *controller;

/**
 请求超时时间,默认为4s,需要设置3s及以上
 */
@property (nonatomic, assign) NSInteger tolerateTimeout;

/**
 广告位id
*/
@property (nonatomic, copy) NSString *posId;

/**
 代理回调
 */
@property (nonatomic, weak) id<ADSuyiSDKRewardvodAdDelegate> delegate;

/**
加载激励视频广告
*/
- (void)loadRewardvodAd;

/**
 激励视频广告是否准备好
 */
- (BOOL)rewardvodAdIsReady;

/**
 激励视频广告物料是否有效
 */
- (BOOL)rewardvodAdIsValid;

/**
 展示激励视频广告
 */
- (void)showRewardvodAd;

@end

```

激励视频广告代理回调 - ADSuyiSDKRewardvodAdDelegate

```obj-c
@protocol ADSuyiSDKRewardvodAdDelegate <NSObject>

/**
 广告数据加载成功回调
 
 @param rewardvodAd 广告实例
 */
- (void)adsy_rewardvodAdLoadSuccess:(ADSuyiSDKRewardvodAd *)rewardvodAd;

/**
 激励视频广告准备好被播放
 
 @param rewardvodAd 广告实例
 */
- (void)adsy_rewardvodAdReadyToPlay:(ADSuyiSDKRewardvodAd *)rewardvodAd;

/**
 视频数据下载成功回调，已经下载过的视频会直接回调
 
 @param rewardvodAd 广告实例
 */
- (void)adsy_rewardvodAdVideoLoadSuccess:(ADSuyiSDKRewardvodAd *)rewardvodAd;
/**
 视频播放页即将展示回调
 
 @param rewardvodAd 广告实例
 */
- (void)adsy_rewardvodAdWillVisible:(ADSuyiSDKRewardvodAd *)rewardvodAd;
/**
 视频广告曝光回调
 
 @param rewardvodAd 广告实例
 */
- (void)adsy_rewardvodAdDidVisible:(ADSuyiSDKRewardvodAd *)rewardvodAd;
/**
 视频播放页关闭回调
 
 @param rewardvodAd 广告实例
 */
- (void)adsy_rewardvodAdDidClose:(ADSuyiSDKRewardvodAd *)rewardvodAd;
/**
 视频广告信息点击回调
 
 @param rewardvodAd 广告实例
 */
- (void)adsy_rewardvodAdDidClick:(ADSuyiSDKRewardvodAd *)rewardvodAd;
/**
 视频广告视频播放完成
 
 @param rewardvodAd 广告实例
 */
- (void)adsy_rewardvodAdDidPlayFinish:(ADSuyiSDKRewardvodAd *)rewardvodAd;

/**
 视频广告视频达到奖励条件
 
 @param rewardvodAd 广告实例
 */
- (void)adsy_rewardvodAdDidRewardEffective:(ADSuyiSDKRewardvodAd *)rewardvodAd;

/**
 视频广告请求失败回调
 
 @param rewardvodAd 广告实例
 @param errorModel 具体错误信息
 */
- (void)adsy_rewardvodAdFailToLoad:(ADSuyiSDKRewardvodAd *)rewardvodAd errorModel:(ADSuyiAdapterErrorDefine *)errorModel;

/**
 视频广告播放时各种错误回调
 
 @param rewardvodAd 广告实例
 @param errorModel 具体错误信息
 */
- (void)adsy_rewardvodAdPlaying:(ADSuyiSDKRewardvodAd *)rewardvodAd errorModel:(ADSuyiAdapterErrorDefine *)errorModel;

@end

```

Swift请求激励视频代码示例：[[激励视频广告代码示例]](https://github.com/ADSuyi/ADSuyiSDKDemo-iOS-Swift/blob/master/ADSuyiSDKDemo-iOS-Swift/SuyiAds/RewardAd/AdSuyiRewardViewController.swift)

OC请求激励视频代码示例：

```obj-c
#import <ADSuyiSDK/ADSuyiSDKRewardvodAd.h>

- (void)loadRewardvodAd{
    // 1、初始化激励视频广告
    self.rewardvodAd  = [[ADSuyiSDKRewardvodAd alloc]init];
    self.rewardvodAd.delegate = self;
    self.rewardvodAd.tolerateTimeout = 5;
    self.rewardvodAd.controller = self;
    self.rewardvodAd.posId = @"e9e0f8d1fe21873695";
    
    // 2、加载激励视频广告
    [self.rewardvodAd loadRewardvodAd];
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
 视频播放页关闭回调
 
 @param rewardvodAd 广告实例
 */
- (void)adsy_rewardvodAdDidClose:(ADSuyiSDKRewardvodAd *)rewardvodAd{
    // 4、广告内存回收
    _rewardvodAd = nil;
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

```

<div STYLE="page-break-after: always;"></div>
## 4.6 插屏广告 - ADSuyiSDKIntertitialAd

`OC请求插屏广告代码示例：`[[插屏广告代码示例]](https://github.com/ADSuyi/ADSuyiSDKDemo-iOS/blob/master/ADSuyiSDKDemo-iOS/SuyiAds/InterstitialAd/AdSuyiInterstitialViewController.m)

`Swift请求插屏广告代码示例：`[[插屏广告代码示例]](https://github.com/ADSuyi/ADSuyiSDKDemo-iOS-Swift/blob/master/ADSuyiSDKDemo-iOS-Swift/SuyiAds/InterstitialAd/AdSuyiInterstitialViewController.swift)

插屏广告 - ADSuyiSDKIntertitialAd：

```obj-c
@interface ADSuyiSDKIntertitialAd : NSObject

/**
 代理回调
*/
@property (nonatomic, weak) id<ADSuyiSDKIntertitialAdDelegate> delegate;

/*
 viewControllerForPresentingModalView
 详解：[必选]开发者需传入用来弹出目标页的ViewController，一般为当前ViewController
 */
@property (nonatomic, weak) UIViewController *controller;

/**
 请求超时时间,默认为4s,需要设置3s及以上
 */
@property (nonatomic, assign) NSInteger tolerateTimeout;

/**
 广告位id
*/
@property (nonatomic, copy) NSString *posId;

/**
 加载广告数据
*/
- (void)loadAdData;

/**
 展示广告
*/
- (void)show;

@end

```

插屏广告代理回调 - ADSuyiSDKIntertitialAdDelegate

```obj-c
@protocol ADSuyiSDKIntertitialAdDelegate <NSObject>

/**
 ADSuyiSDKIntertitialAd请求成功回调
 
 @param interstitialAd 插屏广告实例对象
*/
- (void)adsy_interstitialAdSuccedToLoad:(ADSuyiSDKIntertitialAd *)interstitialAd;

/**
 ADSuyiSDKIntertitialAd请求失败回调

 @param interstitialAd 插屏广告实例对象
 @param error 失败原因
*/
- (void)adsy_interstitialAdFailedToLoad:(ADSuyiSDKIntertitialAd *)interstitialAd error:(ADSuyiAdapterErrorDefine *)error;

/**
 ADSuyiSDKIntertitialAd展示在屏幕内回调

 @param interstitialAd 插屏广告实例对象
*/
- (void)adsy_interstitialAdDidPresent:(ADSuyiSDKIntertitialAd *)interstitialAd;

/**
 ADSuyiSDKIntertitialAd展示在屏幕内失败回调

 @param interstitialAd 插屏广告实例对象
*/
- (void)adsy_interstitialAdFailedToPresent:(ADSuyiSDKIntertitialAd *)interstitialAd error:(NSError *)error;

/**
 ADSuyiSDKIntertitialAd点击回调

 @param interstitialAd 插屏广告实例对象
*/
- (void)adsy_interstitialAdDidClick:(ADSuyiSDKIntertitialAd *)interstitialAd;

/**
 ADSuyiSDKIntertitialAd关闭回调

 @param interstitialAd 插屏广告实例对象
*/
- (void)adsy_interstitialAdDidClose:(ADSuyiSDKIntertitialAd *)interstitialAd;

/**
 ADSuyiSDKIntertitialAd展示回调
 
 @param interstitialAd 广告实例
 */
- (void)adsy_interstitialAdExposure:(ADSuyiSDKIntertitialAd *)interstitialAd;

@end

```

Swift请求插屏代码示例：[[插屏广告代码示例]](https://github.com/ADSuyi/ADSuyiSDKDemo-iOS-Swift/blob/master/ADSuyiSDKDemo-iOS-Swift/SuyiAds/InterstitialAd/AdSuyiInterstitialViewController.swift)

OC请求插屏代码示例：

```obj-c
#import <ADSuyiSDK/ADSuyiSDKIntertitialAd.h>

- (void)loadInterstitialAd{
    // 1、初始化插屏广告
    self.intertitialAd = [ADSuyiSDKIntertitialAd new];
    self.intertitialAd.controller = self;
    self.intertitialAd.posId = @"1fbfbb9778d168e5a7";
    self.intertitialAd.delegate = self;
    self.intertitialAd.tolerateTimeout = 4;
    // 2、加载插屏广告
    [self.intertitialAd loadAdData];
}

#pragma mark - ADSuyiSDKIntertitialAdDelegate
/**
 ADSuyiSDKIntertitialAd请求成功回调
 
 @param interstitialAd 插屏广告实例对象
*/
- (void)adsy_interstitialAdSuccedToLoad:(ADSuyiSDKIntertitialAd *)interstitialAd{
    // 3、展示插屏广告
    [self.intertitialAd show];
}
/**
 ADSuyiSDKIntertitialAd请求失败回调

 @param interstitialAd 插屏广告实例对象
 @param error 失败原因
*/
- (void)adsy_interstitialAdFailedToLoad:(ADSuyiSDKIntertitialAd *)interstitialAd error:(ADSuyiAdapterErrorDefine *)error{
    // 4、内存回收
    _intertitialAd = nil;
}
/**
 ADSuyiSDKIntertitialAd关闭回调

 @param interstitialAd 插屏广告实例对象
*/
- (void)adsy_interstitialAdDidClose:(ADSuyiSDKIntertitialAd *)interstitialAd{
    // 4、内存回收
    _intertitialAd = nil;
}

```

<div STYLE="page-break-after: always;"></div>
##4.7 全屏视频广告 - ADSuyiSDKFullScreenVodAd

`OC请求全屏视频广告代码示例：`[[全屏视频广告代码示例]](https://github.com/ADSuyi/ADSuyiSDKDemo-iOS/blob/master/ADSuyiSDKDemo-iOS/SuyiAds/FullScreenVodAd/AdSuyiFullScreenvodViewController.m)

`Swift请求全屏视频广告代码示例：`[[全屏视频广告代码示例]](https://github.com/ADSuyi/ADSuyiSDKDemo-iOS-Swift/blob/master/ADSuyiSDKDemo-iOS-Swift/SuyiAds/FullScreenVodAd/AdSuyiFullScreenVodViewController.swift)

全屏视频广告 - ADSuyiSDKFullScreenVodAd：

```objective-c
@interface ADSuyiSDKFullScreenVodAd : NSObject

@property (nonatomic, weak) id<ADSuyiSDKFullScreenVodAdDelegate> delegate;

/*
 viewControllerForPresentingModalView
 详解：[必选]开发者需传入用来弹出目标页的ViewController，一般为当前ViewController
 */
@property (nonatomic, weak) UIViewController *controller;

/**
 请求超时时间,默认为4s,需要设置3s及以上
 */
@property (nonatomic, assign) NSInteger tolerateTimeout;

/**
 广告位id
*/
@property (nonatomic, copy) NSString *posId;

/**
 加载广告
*/
- (void)loadAdData;

/**
 展示广告
*/
- (void)show;

@end
```

全屏视频广告代理回调 - ADSuyiSDKFullScreenVodAdDelegate

```objective-c
@protocol ADSuyiSDKFullScreenVodAdDelegate <NSObject>

/**
 ADSuyiSDKFullScreenVodAd请求成功回调
 
 @param fullScreenVodAd 全屏视频广告实例对象
*/
- (void)adsy_fullScreenVodAdSuccedToLoad:(ADSuyiSDKFullScreenVodAd *)fullScreenVodAd;

/**
 ADSuyiSDKFullScreenVodAd准备好被播放
 
 @param fullScreenVodAd 全屏视频广告实例对象
*/
- (void)adsy_fullScreenVodAdReadyToPlay:(ADSuyiSDKFullScreenVodAd *)fullScreenVodAd;

/**
 ADSuyiSDKFullScreenVodAd视频加载成功回调
 
 @param fullScreenVodAd 全屏视频广告实例对象
*/
- (void)adsy_fullScreenVodAdSuccessToLoadVideo:(ADSuyiSDKFullScreenVodAd *)fullScreenVodAd;

/**
 ADSuyiSDKFullScreenVodAd请求失败回调

 @param fullScreenVodAd 全屏视频广告实例对象
 @param error 失败原因
*/
- (void)adsy_fullScreenVodAdFailedToLoad:(ADSuyiSDKFullScreenVodAd *)fullScreenVodAd error:(ADSuyiAdapterErrorDefine *)error;

/**
 ADSuyiSDKFullScreenVodAd展示在屏幕内回调

 @param fullScreenVodAd 全屏视频广告实例对象
*/
- (void)adsy_fullScreenVodAdDidPresent:(ADSuyiSDKFullScreenVodAd *)fullScreenVodAd;

/**
 ADSuyiSDKFullScreenVodAd展示失败回调

 @param fullScreenVodAd 全屏视频广告实例对象
 @param error 失败原因
*/
- (void)adsy_fullScreenVodAdFailToPresent:(ADSuyiSDKFullScreenVodAd *)fullScreenVodAd error:(NSError *)error;

/**
 ADSuyiSDKFullScreenVodAd点击回调

 @param fullScreenVodAd 全屏视频广告实例对象
*/
- (void)adsy_fullScreenVodAdDidClick:(ADSuyiSDKFullScreenVodAd *)fullScreenVodAd;

/**
 ADSuyiSDKFullScreenVodAd关闭回调

 @param fullScreenVodAd 全屏视频广告实例对象
*/
- (void)adsy_fullScreenVodAdDidClose:(ADSuyiSDKFullScreenVodAd *)fullScreenVodAd;

/**
 ADSuyiSDKFullScreenVodAd展示回调
 
 @param fullScreenVodAd 广告实例
 */
- (void)adsy_fullScreenVodAdExposure:(ADSuyiSDKFullScreenVodAd *)fullScreenVodAd;

/**
ADSuyiSDKFullScreenVodAd播放完成回调

 @param fullScreenVodAd 广告实例
 @param error 失败原因（如果为nil，则是单纯的播放完成）
*/
- (void)adsy_fullScreenVodAdPlayComplete:(ADSuyiSDKFullScreenVodAd *)fullScreenVodAd didFailed:(NSError *_Nullable)error;

@end
```

Swift请求全屏视频广告代码示例：[[全屏视频广告代码示例]](https://github.com/ADSuyi/ADSuyiSDKDemo-iOS-Swift/blob/master/ADSuyiSDKDemo-iOS-Swift/SuyiAds/FullScreenVodAd/AdSuyiFullScreenVodViewController.swift)

OC请求全屏视频广告代码示例：

```objective-c
#import <ADSuyiSDK/ADSuyiSDKFullScreenVodAd.h>

- (void)loadFullScreenvod{
    // 1、初始化全屏视频广告
    self.fullScreenvodAd = [ADSuyiSDKFullScreenVodAd new];
    self.fullScreenvodAd.controller = self;
    self.fullScreenvodAd.posId = @"7206088624654025e7";
    self.fullScreenvodAd.delegate = self;
    self.fullScreenvodAd.tolerateTimeout = 5;
    // 2、加载全屏视频广告
    [self.fullScreenvodAd loadAdData];
    
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
 ADSuyiSDKFullScreenVodAd关闭回调

 @param fullScreenVodAd 全屏视频广告实例对象
*/
- (void)adsy_fullScreenVodAdDidClose:(ADSuyiSDKFullScreenVodAd *)fullScreenVodAd{
    // 4、广告内存回收
    _fullScreenvodAd = nil;
}
```

<div STYLE="page-break-after: always;"></div> 
## 4.8 沉浸式视频广告 - ADSuyiSDKDrawvodAd

`OC请求沉浸式视频代码示例：`[[沉浸式视频广告代码示例]](https://github.com/ADSuyi/ADSuyiSDKDemo-iOS/blob/master/ADSuyiSDKDemo-iOS/SuyiAds/DrawVodAd/AdSuyiDrawvodViewController.m)

`Swift请求沉浸式视频代码示例：`[[沉浸式视频广告代码示例]](https://github.com/ADSuyi/ADSuyiSDKDemo-iOS-Swift/blob/master/ADSuyiSDKDemo-iOS-Swift/SuyiAds/DrawVodAd/AdSuyiDrawVodViewController.swift)

沉浸式视频广告 - ADSuyiSDKDrawvodAd：

```objective-c
#import <ADSuyiSDK/ADSuyiSDKDrawvodAd.h>

typedef NS_ENUM(NSUInteger, ADSuyiSDKDrawvodAdStatus) {
    ADSuyiSDKDrawvodAdStatusDefault, // 闲置状态
    ADSuyiSDKDrawvodAdStatusLoading, // 加载广告中
};

@class ADSuyiAdapterDrawvodAdView;
@protocol ADSuyiSDKDrawvodAdDelegate;

@interface ADSuyiSDKDrawvodAd : NSObject

- (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithSize:(CGSize)size;

/**
 代理回调
 */
@property (nonatomic, weak) id<ADSuyiSDKDrawvodAdDelegate> delegate;

/*
 viewControllerForPresentingModalView
 详解：[必选]开发者需传入用来弹出目标页的ViewController，一般为当前ViewController
 */
@property (nonatomic, weak) UIViewController *controller;

/*
 status
 详解：开发者可通过状态值来判断当前广告对象是否正在加载广告，支持KVO
*/
@property (nonatomic, assign, readonly) ADSuyiSDKDrawvodAdStatus status;

/**
 广告位id
*/
@property (nonatomic, copy) NSString *posId;

/**
 请求超时时间,默认为4s,需要设置3s及以上
*/
@property (nonatomic, assign) NSInteger tolerateTimeout;

/**
 加载广告
 @param count 拉取几条广告,建议区间 1~4, 超过可能无法拉取到
*/
- (void)load:(NSInteger)count;

@end
```

沉浸式视频广告代理回调 - ADSuyiSDKDrawvodAdDelegate

```objective-c
@protocol ADSuyiSDKDrawvodAdDelegate <NSObject>

/**
 DrawvodAd请求成功
 
 @param drawvodAd 广告实例
 @param drawvodAdViewArray ADMobGenDrawvodAd集合
 */
- (void)adsy_drawvodAdSuccessToLoad:(ADSuyiSDKDrawvodAd *)drawvodAd drawvodAdArray:(NSArray<ADSuyiAdapterDrawvodAdView *> *)drawvodAdViewArray;
/**
 DrawvodAd请求失败
 
 @param drawvodAd 广告实例
 @param errorModel 请求错误描述
 */
- (void)adsy_drawvodAdFailToLoad:(ADSuyiSDKDrawvodAd *)drawvodAd errorModel:(ADSuyiAdapterErrorDefine *)errorModel;
/**
 DrawvodAd请求成功
 
 @param drawvodAd 广告实例
 @param drawvodAdView  ADMobGenDrawvodAd广告
 */
- (void)adsy_drawvodAdSuccessToRender:(ADSuyiSDKDrawvodAd *)drawvodAd view:(ADSuyiAdapterDrawvodAdView *)drawvodAdView;
/**
 DrawvodAd请求成功
 
 @param drawvodAd 广告实例
 @param drawvodAdView  ADMobGenDrawvodAd广告
 */
- (void)adsy_drawvodAdFailToRender:(ADSuyiSDKDrawvodAd *)drawvodAd view:(ADSuyiAdapterDrawvodAdView *)drawvodAdView error:(nullable NSError *)error;

/**
 DrawvodAdView播放完成
 
 @param drawvodAdView 广告视图
 */
- (void)adsy_drawvodAdPlayerDidPlayFinish:(ADSuyiAdapterDrawvodAdView *)drawvodAdView ;

/**
 DrawvodAdView被展示
 
 @param drawvodAdView 广告视图
 */
- (void)adsy_drawvodAdDidExposure:(ADSuyiAdapterDrawvodAdView *)drawvodAdView;

/**
 DrawvodAdView被点击
 
 @param drawvodAdView 广告视图
 */
- (void)adsy_drawvodAdDidClick:(ADSuyiAdapterDrawvodAdView *)drawvodAdView;

@end
```

Swift请求沉浸式视频代码示例：[[沉浸式视频广告代码示例]](https://github.com/ADSuyi/ADSuyiSDKDemo-iOS-Swift/blob/master/ADSuyiSDKDemo-iOS-Swift/SuyiAds/DrawVodAd/AdSuyiDrawVodViewController.swift)

OC请求沉浸式视频代码示例：

```objective-c
- (ADSuyiSDKDrawvodAd *)drawvodAd {
    if(!_drawvodAd) {
        // 1、初始化沉浸式视频广告，流程和信息流广告类似
        _drawvodAd = [[ADSuyiSDKDrawvodAd alloc] initWithSize:self.tableView.frame.size];
        _drawvodAd.posId = @"16e160a112f019de2b";
        _drawvodAd.controller = self;
        _drawvodAd.delegate = self;
    }
    return _drawvodAd;
}

- (void)loadDrawvodAd{
    // 2、加载沉浸式视频广告
    [self.drawvodAd load:3];
}
#pragma mark - ADSuyiSDKDrawvodAdDelegate

- (void)adsy_drawvodAdSuccessToLoad:(ADSuyiSDKDrawvodAd *)drawvodAd drawvodAdArray:(NSArray<ADSuyiAdapterDrawvodAdView *> *)drawvodAdViewArray {
    for (ADSuyiAdapterDrawvodAdView *adView in drawvodAdViewArray) {
        // 3、渲染沉浸式广告
        [adView render];
    }
}

- (void)adsy_drawvodAdFailToLoad:(ADSuyiSDKDrawvodAd *)drawvodAd errorModel:(ADSuyiAdapterErrorDefine *)errorModel {
    
}

- (void)adsy_drawvodAdSuccessToRender:(ADSuyiSDKDrawvodAd *)drawvodAd view:(ADSuyiAdapterDrawvodAdView *)drawvodAdView {
    // 4、渲染成功，此时高度正常，资源加载中，可展示
    [self.data addObject:drawvodAdView];
    [self.tableView reloadData];
}

- (void)dealloc
{
    for (ADSuyiAdapterDrawvodAdView *adview in self.data) {
        // 5、广告内存回收
        [adview unRegist];
    }
}
```

<div STYLE="page-break-after: always;"></div> 
## 作者

sangshen@admobile.top

## 商务合作

tomato@admobile.top
