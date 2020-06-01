//
//  ADSuyiAdapterNativeAdView.h
//  ADSuyiSDK
//
//  Created by 陶冶明 on 2020/4/16.
//

#import <UIKit/UIKit.h>
#import "ADSuyiAdapterCommonDefine.h"

NS_ASSUME_NONNULL_BEGIN

@class ADSuyiAdapterNativeAdData;

@protocol ADSuyiAdapterNativeAdViewDelegate
/**
 注册广告视图
 */
- (void)adsy_registViews:(NSArray<UIView *> *)clickViews;

/**
 取消注册
    如果renderType为ExpressView，可以不调用
    如果renderType为UnifiedNative，必须调用，否则会有内存泄漏
 */
- (void)adsy_unRegistView;

/**
 渲染类型
 */
- (ADSuyiAdapterRenderType)renderType;

/**
 自渲染广告数据，模版类型为空
 */
@property (nonatomic, strong, nullable, readonly) ADSuyiAdapterNativeAdData *data;

/**
 获取视频视图，如果是模版广告则为nil
 */
- (nullable UIView *)adsy_mediaViewForWidth:(CGFloat)width;

/**
 平台logo
 */
- (void)adsy_platformLogoImageHasText:(BOOL)hasText loadImageBlock:(void(^)(UIImage * _Nullable))block;

@end


@interface ADSuyiAdapterNativeAdData : NSObject

/**
 标题
 */
@property (nonatomic, copy, nullable, readonly) NSString *title;

/**
 描述
 */
@property (nonatomic, copy, nullable, readonly) NSString *desc;

/**
 封面大图
 */
@property (nonatomic, copy, nullable, readonly) NSString *imageUrl;

/**
 图片列表
 */
@property (nonatomic, copy, nullable, readonly) NSArray<NSString *> *imageUrlAry;

/**
 icon图片
 */
@property (nonatomic, strong, nullable, readonly) NSString *iconImageUrl;

/**
 获取icon图片
 */
- (void)loadIconImage:(void(^)(UIImage * _Nullable))block;

/**
 是否需要显示多媒体View（当素材为视频素材时，或者没有图片素材，需要调用获取广告视图方法）
 */
@property (nonatomic, assign, readonly) BOOL shouldShowMediaView;

@end

NS_ASSUME_NONNULL_END
