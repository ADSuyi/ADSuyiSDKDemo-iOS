//
//  AppDelegate.m
//  ADSuyiSDKDemo-iOS
//
//  Created by 陈坤 on 2020/5/27.
//  Copyright © 2020 陈坤. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import <ADSuyiSDK/ADSuyiSDK.h>
#import <ADSuyiSDK/ADSuyiSDKSplashAd.h>
#import <ADSuyiKit/UIColor+ADSuyiKit.h>
#import <ADSuyiKit/ADSuyiKitMacros.h>
#import <ADSuyiKit/ADSuyiKitLogging.h>

#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <AdSupport/AdSupport.h>
#import "NavigationViewController.h"
// 支持广点通开屏广告v+
#define SUPPORT_SPLASH_ZOOMOUT 1

@interface AppDelegate ()
<
#ifdef SUPPORT_SPLASH_ZOOMOUT
ADSuyiSDKSplashAdZoomOutViewDelegate,
#endif
ADSuyiSDKSplashAdDelegate
>{
    UIWindow *_window;
}

@property (nonatomic, strong)ADSuyiSDKSplashAd *splashAd;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
//    获取idfa权限 建议启动就获取权限 不获取权限会影响收益
    if (@available(iOS 14.0, *)) {
        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
                    
        }];
    }
    
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _window.rootViewController = [[NavigationViewController alloc] initWithRootViewController:[ViewController new]];
    [_window makeKeyAndVisible];
    [self setThirtyPartySdk];
    /*
     * 推荐在AppDelegate中的最后加载开屏广告
     * 其他的接入方式会有需要特殊注意的方式，遇到过的相关问题在SDK相关问题的文档中有提到
     */
    [self loadSplashAd];
    
    return YES;
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // 热启动加载开屏广告 进入前台加载
    [self loadSplashAd];
//    进入前台 小说控制事件结束
    [application endReceivingRemoteControlEvents];
}
#pragma mark - 小说SDK后台播放控制
- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [application beginReceivingRemoteControlEvents];
}
// 小说后台播放控制
- (void)remoteControlReceivedWithEvent:(UIEvent *)event {
    switch (event.subtype) {
        case UIEventSubtypeRemoteControlPlay: {//恢复播放
            [ADSuyiSDKContainAd replay];
        }
            break;
        case UIEventSubtypeRemoteControlPause: {//暂停
            [ADSuyiSDKContainAd pause];
            break;
        }
        case UIEventSubtypeRemoteControlPreviousTrack: {//上一曲
            [ADSuyiSDKContainAd last];
            break;
        }
        case UIEventSubtypeRemoteControlNextTrack: {//下一曲
            [ADSuyiSDKContainAd next];
            break;
        }
        case UIEventSubtypeRemoteControlTogglePlayPause: {//小窗口暂停
            [ADSuyiSDKContainAd smallWindowPause];
            break;
        }
        default:
            break;
    }
}


- (void)loadSplashAd{
    if (self.splashAd) {
        return;
    }
    // 1、初始化开屏广告实例对象
    self.splashAd = [[ADSuyiSDKSplashAd alloc]init];
    self.splashAd.delegate = self;
#ifdef SUPPORT_SPLASH_ZOOMOUT
    self.splashAd.zoomOutViewDelegate = self;
#endif
    self.splashAd.controller = _window.rootViewController;
    // 2、设置开屏的广告位id
    self.splashAd.posId = @"73128265daffdd6a1d";
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

#pragma mark - ADSuyiSDKSplashAdDelegate
/**
 开屏展现成功
 
 @param splashAd 广告实例
 */
- (void)adsy_splashAdSuccessToPresentScreen:(ADSuyiSDKSplashAd *)splashAd{
#ifdef SUPPORT_SPLASH_ZOOMOUT
    if(splashAd.splashZoomOutView) {
        UIViewController *rootVc = [UIApplication sharedApplication].keyWindow.rootViewController;
        [rootVc.view addSubview:splashAd.splashZoomOutView];
    }
#endif
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
#ifdef SUPPORT_SPLASH_ZOOMOUT
    if(_splashAd.splashZoomOutView == nil)
        _splashAd = nil;
#else
    _splashAd = nil;
#endif
}

/**
 开屏展示
 
 @param splashAd 广告实例
 */
- (void)adsy_splashAdEffective:(ADSuyiSDKSplashAd *)splashAd{
    
}

#ifdef SUPPORT_SPLASH_ZOOMOUT

#pragma mark - ADSuyiSDKSplashAdZoomOutViewDelegate

/**
 ZoomOutView被点击
 
 @param splashAd 广告实例
 @param splashZoomOutView zoomOutView
 */
- (void)adsy_splashZoomOutViewDidClick:(ADSuyiSDKSplashAd *)splashAd
                     splashZoomOutView:(__kindof UIView <ADSuyiSDKSplashAdZoomOutViewProtocol>*)splashZoomOutView {
    
}

/**
 ZoomOutView 被关闭
 
 @param splashAd 广告实例
 @param splashZoomOutView zoomOutView
 */
- (void)adsy_splashZoomOutViewAdDidClose:(ADSuyiSDKSplashAd *)splashAd
                       splashZoomOutView:(__kindof UIView <ADSuyiSDKSplashAdZoomOutViewProtocol>*)splashZoomOutView {
    
}

/**
 ZoomOutView 播放完成
 
 @param splashAd 广告实例
 @param splashZoomOutView zoomOutView
 */
- (void)adsy_splashZoomOutViewAdVideoFinished:(ADSuyiSDKSplashAd *)splashAd
                            splashZoomOutView:(__kindof UIView <ADSuyiSDKSplashAdZoomOutViewProtocol>*)splashZoomOutView {
    
}

/**
 ZoomOutView 进入视频详情页
 
 @param splashAd 广告实例
 @param splashZoomOutView zoomOutView
 */
- (void)adsy_splashZoomOutViewAdDidPresentFullScreenModal:(ADSuyiSDKSplashAd *)splashAd
                                        splashZoomOutView:(__kindof UIView <ADSuyiSDKSplashAdZoomOutViewProtocol>*)splashZoomOutView {
    
}

/**
 ZoomOutView 退出视频详情页
 
 @param splashAd 广告实例
 @param splashZoomOutView zoomOutView
 */
- (void)adsy_splashZoomOutViewAdDidDismissFullScreenModal:(ADSuyiSDKSplashAd *)splashAd
                                        splashZoomOutView:(__kindof UIView <ADSuyiSDKSplashAdZoomOutViewProtocol>*)splashZoomOutView {
    _splashAd = nil;
}

#endif

#pragma mark -- private

- (void)showAgreePrivacy {
    // 隐私合规化示例
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"亲爱的用户，欢迎您信任并使用【】，我们依据相关法律制定了《用户协议》和《隐私协议》帮你你了解我们手机，使用，存储和共享个人信息情况，请你在点击之前仔细阅读并理解相关条款。\n1、在使用我们的产品和服务时，将会提供与具体功能有关的个法人信息（可能包括身份验证，位置信息，设备信息和操作日志等）\n2、我们会采用业界领先的安全技术来保护你的个人隐私，未经授权许可我们不会讲上述信息共享给任何第三方或用于未授权的其他用途。\n如你同意请点击同意按钮并继续。" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"不同意" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"点击同意才能使用该App服务" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
            [self->_window.rootViewController presentViewController:alertVc animated:YES completion:nil];
            }];
        [alert addAction:sure];
        [self->_window.rootViewController presentViewController:alert animated:YES completion:nil];
    }];
    UIAlertAction *agree = [UIAlertAction actionWithTitle:@"同意并继续" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        // 记录是否第一次启动
        [self writeAppLoad];
        // 用户同意隐私后 初始化
        [self initADSuyiSDK];
        
    }];
    [alertVc addAction:cancle];
    [alertVc addAction:agree];
    [_window.rootViewController presentViewController:alertVc animated:YES completion:nil];
}
- (void)setThirtyPartySdk {
    if ([self isFirstAppLoad]) {
        [self showAgreePrivacy];
    }else {
        [self initADSuyiSDK];
    }
}
- (void)initADSuyiSDK {
    // 设置日志输出等级
    [ADSuyiSDK setLogLevel:ADSuyiKitLogLevelDebug];
    // ADSuyiSDK初始化
    [ADSuyiSDK initWithAppId:@"3437764" completionBlock:^(NSError * _Nonnull error) {
        if (error) {
            NSLog(@"SDK 初始化失败：%@", error.localizedDescription);
        }
    }];
    
}

#pragma mark -- helper

- (void)writeAppLoad {
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:@"yes" forKey:@"isFirstLoad"];
    [userDefault synchronize];
    
}

- (BOOL)isFirstAppLoad {

    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    if ([[userDefault objectForKey:@"isFirstLoad"] isEqualToString:@"yes"]) {
        return NO;
    }
    return YES;
    
}

#pragma mark - Window

- (void)setWindow:(UIWindow *)window {
    _window = window;
}

- (UIWindow *)window {
    return _window;
}


@end
