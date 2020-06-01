//
//  ADSuyiSDK.h
//  ADSuyiSDK
//
//  Created by 陈坤 on 2020/3/24.
//

#import <UIKit/UIKit.h>
#import <ADSuyiSDK/ADSuyiAdapterCommonDefine.h>
#import <ADSuyiSDK/ADSuyiAdapterErrorDefine.h>
#import <ADSuyiSDK/ADSuyiAdapterNativeAdData.h>
#import <ADSuyiSDK/ADSuyiAdapterSplashSkipViewProtocol.h>
#import <ADSuyiSDK/ADSuyiSDKBannerAdView.h>
#import <ADSuyiSDK/ADSuyiSDKDrawvodAd.h>
#import <ADSuyiSDK/ADSuyiSDKFullScreenVodAd.h>
#import <ADSuyiSDK/ADSuyiSDKIntertitialAd.h>
#import <ADSuyiSDK/ADSuyiSDKNativeAd.h>
#import <ADSuyiSDK/ADSuyiSDKRewardvodAd.h>
#import <ADSuyiSDK/ADSuyiSDKSplashAd.h>
#import <ADSuyiSDK/ADSuyiAdapterDrawvodAdView.h>
// ADSuyiKitLogLevel的定义在<ADSuyiKit/ADSuyiKitLogging.h>
typedef enum ADSuyiKitLogLevel:NSUInteger ADSuyiKitLogLevel;

NS_ASSUME_NONNULL_BEGIN

@interface ADSuyiSDK : NSObject

/**
初始化SDK

@param appId 给定的唯一appid
@param completion 启动完成回调
*/
+ (void)initWithAppId:(NSString *)appId completionBlock:(void(^)(NSError *error))completion;

/**
 SDK Version
 */
+ (NSString *)getSDKVersion;

/**
 设置日志输出等级
 
 @param logLevel 日志输出等级
 */
+ (void)setLogLevel:(ADSuyiKitLogLevel)logLevel;

@end

NS_ASSUME_NONNULL_END
