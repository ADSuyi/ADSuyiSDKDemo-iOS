//
//  ADSuyiSDKDrawvodAd.h
//  ADSuyiSDK
//
//  Created by 陈坤 on 2020/4/22.
//

#import <Foundation/Foundation.h>
#import "ADSuyiAdapterErrorDefine.h"

NS_ASSUME_NONNULL_BEGIN

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

NS_ASSUME_NONNULL_END
