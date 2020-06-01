//
//  ADMobileAdRewardVideo.h
//  ADMobileAdSDK
//
//  Created by 陈坤 on 2019/8/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ADMobileAdRewardVideoDelegate;

@interface ADMobileAdRewardVideo : NSObject

@property (nonatomic, weak) id<ADMobileAdRewardVideoDelegate> delegate;
/**
 初始化激励视频广告
*/
- (instancetype)initRewardVodWithIsRrward:(BOOL)isReward canSkip:(BOOL)canSkip;

/**
 请求激励视频广告
*/
- (void)request;

/**
 展示激励视频广告
 */
- (BOOL)showAdFromRootViewController:(UIViewController *)viewController;

/**
 激励视频广告是否有效
 */
- (BOOL)rewardvodAdIsValid;

/**
 激励视频广告是否准备好
 */
- (BOOL)rewardvodAdIsReady;

@end

@protocol ADMobileAdRewardVideoDelegate <NSObject>
@optional

/**
 激励视频广告加载成功
 */
- (void)onRewardAdDidLoad:(ADMobileAdRewardVideo *)rewardvodAd;


/**
 激励视频广告准备好播放
 */
- (void)onRewardVideoReadyToPlay:(ADMobileAdRewardVideo *)rewardvodAd;

/**
 激励视频广告请求失败错误回调
 */
- (void)onRewardAdRequestFail:(ADMobileAdRewardVideo *)rewardvodAd didFailWithError:(NSError *)error;

/**
 激励视频广告播放等各种错误回调
 */
- (void)onRewardVideoPlay:(ADMobileAdRewardVideo *)rewardvodAd didFailWithError:(NSError *)error;

/**
 激励视频广告视频加载完成
 */
- (void)onRewardVideoAdVideoDidLoad:(ADMobileAdRewardVideo *)rewardvodAd;

/**
 激励视频广告展示
 */
- (void)onRewardVideoAdDidExposure:(ADMobileAdRewardVideo *)rewardvodAd;

/**
 激励视频广告被点击
 */
- (void)onRewardVideoAdDidClicked:(ADMobileAdRewardVideo *)rewardvodAd;

/**
 激励视频广告视频播放完成
 */
- (void)onRewardVideoAdDidPlayFinish:(ADMobileAdRewardVideo *)rewardvodAd;

/**
 激励视频广告播放达到奖励条件
 */
- (void)onRewardVideoAdDidRewardEffective:(ADMobileAdRewardVideo *)rewardvodAd;

/**
 将要展示激励视频广告
 */
- (void)onRewardVideoAdWillPresentAdverViewController:(ADMobileAdRewardVideo *)rewardvodAd;

/**
 激励视频广告页已经消失
 */
- (void)onRewardVideoAdDidDismissAdverViewController:(ADMobileAdRewardVideo *)rewardvodAd;

/**
 将要离开APP
 */
- (void)onRewardVideoAdWillLeaveApplication:(ADMobileAdRewardVideo *)rewardvodAd;


@end

NS_ASSUME_NONNULL_END
