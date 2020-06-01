//
//  ADSuyiMTGUnifiedNativeAdView.h
//  ADSuyiMTG
//
//  Created by 陶冶明 on 2020/4/26.
//

#import <UIKit/UIKit.h>

#import <MTGSDK/MTGSDK.h>

#import <ADSuyiSDK/ADSuyiAdapterNativeAdData.h>
#import <ADSuyiSDK/ADSuyiAdapterCommonReportMark.h>

NS_ASSUME_NONNULL_BEGIN

@class ADSuyiMTGUnifiedNativeAdView;

@protocol ADSuyiMTGUnifiedNativeAdViewDelegate <NSObject>

- (void)adsuyiMTGUnifiedNativeAdViewRender:(ADSuyiMTGUnifiedNativeAdView *)adView;

@end

@interface ADSuyiMTGUnifiedNativeAdView : UIView <ADSuyiAdapterNativeAdViewDelegate>

@property (nonatomic, weak) MTGNativeAdManager *mtgNativeADManager;

@property (nonatomic, strong) MTGCampaign *mtgNativeAdData;

@property (nonatomic, copy) NSString *mtgUUID;

@property (nonatomic, strong) ADSuyiAdapterCommonReportMark *mark;

@property (nonatomic, weak) id<ADSuyiMTGUnifiedNativeAdViewDelegate> delegate;

- (nullable MTGMediaView *)adsy_mediaViewForWidth:(CGFloat)width;

@end

NS_ASSUME_NONNULL_END
