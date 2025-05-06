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

#import "AdMacros.h"

@interface AppDelegate ()<ADSuyiSDKSplashAdDelegate>{
    UIWindow *_window;
}

@property (nonatomic, strong)ADSuyiSDKSplashAd *splashAd;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _window.rootViewController = [[NavigationViewController alloc] initWithRootViewController:[ViewController new]];
    [_window makeKeyAndVisible];
    [self setThirtyPartySdk];
    
    return YES;
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // 热启动加载开屏广告 进入前台加载
    [self loadSplashAd];
//    进入前台 小说控制事件结束
    [application endReceivingRemoteControlEvents];
}

- (void)loadSplashAd{
    if (self.splashAd) {
        return;
    }
    // 1、初始化开屏广告实例对象
    self.splashAd = [[ADSuyiSDKSplashAd alloc]init];
    self.splashAd.delegate = self;
    self.splashAd.controller = _window.rootViewController;
    // 2、设置开屏的广告位id
    self.splashAd.posId = Suyi_Demo_splashAd_PosId;
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
    CGFloat bottomViewHeight = [UIScreen mainScreen].bounds.size.height * 0.15;
    
    // 5、底部视图设置，非必选项
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    bottomView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, bottomViewHeight);
    UIImageView *logoImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ADMob_Logo.png"]];
    logoImageView.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-135)/2, (bottomViewHeight-46)/2, 135, 46);
    [bottomView addSubview:logoImageView];
    
    // 6、设置开屏保底逻辑（可选）
    /**
     *功能说明：App在首次启动时，需要先请求获取广告位配置文件后，然后再去请求开屏广告，也就是首次加载开屏广告时需要两次串行网络请求，因此很容易因超时导致开屏广告展示失败。
     *解决方案：为避免开屏超时问题，开放此设置给开发者，开发者可以根据实际需求选择一家广告平台，通过API接口将必需参数传递给Suyi聚合SDK。（该设置只能指定一家广告平台，并且首次启动时只会请求该平台的广告，但App首次开屏广告将不受ADmobile后台控制，包括下载提示，广告位关闭。）
     *该设置仅会在首次加载开屏广告时，SDK会使用开发者传入的参数进行广告请求，同时获取后台配置文件的广告配置信息缓存到本地（首次请求广告平台广告和获取配置信息时并发进行），后续的开屏广告将按照缓存缓存的后台广告位配置顺序进行开屏广告请求。
     *支持穿山甲、优量汇、快手、百度
     */
    [self.splashAd setBottomSplashWithSuyiPosid:@"73128265daffdd6a1d" platformListId:@"37985" platform:@"baidu" appId:@"ccb60059" appKey:nil platformPosid:@"2058492" renderType:ADSuyiSplashRenderTypeExpress];
    // 7、加载开屏广告
    [self.splashAd loadAndShowInWindow:_window withBottomView:bottomView];
}

#pragma mark - ADSuyiSDKSplashAdDelegate

/**
 开屏加载成功
 
 @param splashAd 广告实例
 */
- (void)adsy_splashAdSuccessToLoadAd:(ADSuyiSDKSplashAd *)splashAd{
    ADSuyiSDKExtInfo *extInfo = [splashAd adsy_extInfo];
    NSLog(@"ecpm=%@, ecpmType=%ld", extInfo.ecpm, extInfo.ecpmType);
}

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
 开屏被跳过
 
 @param splashAd 广告实例
 */
- (void)adsy_splashAdSkip:(ADSuyiSDKSplashAd *)splashAd{
    
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

#pragma mark -- private

- (void)showAgreePrivacy {
    // 隐私合规化示例
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"亲爱的开发者，非常感谢您选择并选用Suyi聚合广告SDK！\n为了保证您的App顺利通过合规检测，本提示将向你演示Suyi聚合广告SDK初始化合规方案。\n1. APP首次运行时请通过弹窗等明显方式提示用户阅读《用户协议》、《隐私政策》和《第三方SDK使用列表》，用户确认同意《用户协议》、《隐私政策》和《第三方SDK使用列表》后，再启用SDK进行个人信息的收集与处理。\n2. 本提示的内容及《用户协议》、《隐私政策》和《第三方SDK使用列表》需根据你的APP业务需求进行编写，可参考《网络安全标准实践指南—移动互联网应用程序（App）收集使用个人信息自评估指南》或咨询对接人员。\n你可以通过阅读完整版的ADmobile 《用户协议》、《隐私政策》和《第三方SDK使用列表》了解ADmobile详细隐私策略" preferredStyle:(UIAlertControllerStyleAlert)];
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
        //    获取idfa权限 建议启动就获取权限 不获取权限会影响收益
        if (@available(iOS 14.0, *)) {
            [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
                
            }];
        }
        // 用户同意隐私后 初始化
        [self initADSuyiSDK];
        
    }];
    UIAlertAction *userLink = [UIAlertAction actionWithTitle:@"《用户协议》" style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction * _Nonnull action) {
        [self openLinkURL:@"https://doc.admobile.top/ssp/pages/contract/"];
    }];
    UIAlertAction *privacyLink = [UIAlertAction actionWithTitle:@"《隐私政策》" style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction * _Nonnull action) {
        [self openLinkURL:@"https://www.admobile.top/privacyPolicy.html"];
    }];
    UIAlertAction *sdkLink = [UIAlertAction actionWithTitle:@"《第三方SDK使用列表》" style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction * _Nonnull action) {
        [self openLinkURL:@"https://doc.admobile.top/ssp/pages/sfsdkth/"];
    }];
    
    [alertVc addAction:cancle];
    [alertVc addAction:agree];
    [alertVc addAction:userLink];
    [alertVc addAction:privacyLink];
    [alertVc addAction:sdkLink];
    [_window.rootViewController presentViewController:alertVc animated:YES completion:nil];
}

- (void)openLinkURL:(NSString *)linkURL {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:linkURL] options:@{} completionHandler:nil];
    [self showAgreePrivacy];
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
    // ADSuyiSDK初始化, 需在主线程初始化
    [ADSuyiSDK initWithAppId:Suyi_Demo_APPID completionBlock:^(NSError * _Nonnull error) {
        if (error) {
            NSLog(@"SDK 初始化失败：%@", error.localizedDescription);
        }
    }];
    /*
     * 推荐在AppDelegate中的最后加载开屏广告
     * 其他的接入方式会有需要特殊注意的方式，遇到过的相关问题在SDK相关问题的文档中有提到
     */
    [self loadSplashAd];
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
