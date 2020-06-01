//
//  ADSuyiAdapterCommonDefine.h
//  ADSuyiSDK
//
//  Created by 陈坤 on 2020/3/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ADSuyiAdapterRenderType) {
    ADSuyiAdapterRenderTypeExpress = 1,//模版视图类
    ADSuyiAdapterRenderTypeNative = 2,//原生广告类
};

typedef NSString * ADSuyiAdapterAdType NS_EXTENSIBLE_STRING_ENUM;

FOUNDATION_EXPORT ADSuyiAdapterAdType _Nonnull const ADSuyiAdapterAdTypeOther;

FOUNDATION_EXPORT ADSuyiAdapterAdType _Nonnull const ADSuyiAdapterAdTypeSplash;

FOUNDATION_EXPORT ADSuyiAdapterAdType _Nonnull const ADSuyiAdapterAdTypeBanner;

FOUNDATION_EXPORT ADSuyiAdapterAdType _Nonnull const ADSuyiAdapterAdTypeNative;

FOUNDATION_EXPORT ADSuyiAdapterAdType _Nonnull const ADSuyiAdapterAdTypeRewardvod;

FOUNDATION_EXPORT ADSuyiAdapterAdType _Nonnull const ADSuyiAdapterAdTypeInterstitial;

FOUNDATION_EXPORT ADSuyiAdapterAdType _Nonnull const ADSuyiAdapterAdTypeFullScreenVod;

FOUNDATION_EXPORT ADSuyiAdapterAdType _Nonnull const ADSuyiAdapterAdTypeDrawvod;



typedef NSString * ADSuyiAdapterPlatform NS_EXTENSIBLE_STRING_ENUM;

FOUNDATION_EXPORT ADSuyiAdapterPlatform _Nonnull const ADSuyiAdapterPlatformOther;

FOUNDATION_EXPORT ADSuyiAdapterPlatform _Nonnull const ADSuyiAdapterPlatformGDT;

FOUNDATION_EXPORT ADSuyiAdapterPlatform _Nonnull const ADSuyiAdapterPlatformBU;

FOUNDATION_EXPORT ADSuyiAdapterPlatform _Nonnull const ADSuyiAdapterPlatformBaidu;

FOUNDATION_EXPORT ADSuyiAdapterPlatform _Nonnull const ADSuyiAdapterPlatformADMobile;

FOUNDATION_EXPORT ADSuyiAdapterPlatform _Nonnull const ADSuyiAdapterPlatformInmobi;

FOUNDATION_EXPORT ADSuyiAdapterPlatform _Nonnull const ADSuyiAdapterPlatformMTG;

FOUNDATION_EXPORT ADSuyiAdapterPlatform _Nonnull const ADSuyiAdapterPlatformGoogle;

FOUNDATION_EXPORT ADSuyiAdapterPlatform _Nonnull const ADSuyiAdapterPlatformMGTV;

FOUNDATION_EXPORT ADSuyiAdapterPlatform _Nonnull const ADSuyiAdapterPlatformMopub;

FOUNDATION_EXPORT ADSuyiAdapterPlatform _Nonnull const ADSuyiAdapterPlatformUnity;

FOUNDATION_EXPORT ADSuyiAdapterPlatform _Nonnull const ADSuyiAdapterPlatformKS;

NS_ASSUME_NONNULL_END
