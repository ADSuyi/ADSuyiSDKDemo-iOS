//
//  ADSuyiInmobiUnifiedNativeAdView.h
//  ADSuyiInmobi
//
//  Created by 陶冶明 on 2020/4/26.
//

#import <UIKit/UIKit.h>

#import <InMobiSDK/InMobiSDK.h>

#import <ADSuyiSDK/ADSuyiAdapterNativeAdData.h>
#import <ADSuyiSDK/ADSuyiAdapterCommonReportMark.h>


NS_ASSUME_NONNULL_BEGIN

@class ADSuyiInmobiUnifiedNativeAdView;

@protocol ADSuyiInmobiUnifiedNativeAdViewDelegate <NSObject>

- (void)adsuyiInmobiUnifiedNativeAdViewRender:(ADSuyiInmobiUnifiedNativeAdView *)adView;

@end

@interface ADSuyiInmobiUnifiedNativeAdView : UIView <ADSuyiAdapterNativeAdViewDelegate>

@property (nonatomic, strong) IMNative *inmobiNativeAdData;

@property (nonatomic, weak) id<ADSuyiInmobiUnifiedNativeAdViewDelegate> delegate;

@property (nonatomic, strong) ADSuyiAdapterCommonReportMark *mark;

@end

NS_ASSUME_NONNULL_END
