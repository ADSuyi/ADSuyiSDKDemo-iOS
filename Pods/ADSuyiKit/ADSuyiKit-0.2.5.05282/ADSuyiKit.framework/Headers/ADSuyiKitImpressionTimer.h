//
//  ADSuyiKitImpressionTimer.h
//  ADSuyiKit
//
//  Created by 陈坤 on 2020/4/10.
//

#import <Foundation/Foundation.h>

static inline BOOL ADSuyiKitViewIsVisible(UIView *view);
static inline BOOL ADSuyiKitViewHasHiddenAncestor(UIView *view);
static inline BOOL ADSuyiKitViewIntersectsParentWindow(UIView *view);
static inline BOOL ADSuyiKitViewIntersectsParentWindowWithPercent(UIView *view, CGFloat percentVisible);
static inline UIWindow * ADSuyiKitViewGetParentWindow(UIView *view);

@protocol ADSuyiKitImpressionTimerDelegate <NSObject>

- (void)viewWillLogImpression:(UIView *)view;

@end

@interface ADSuyiKitImpressionTimer : NSObject

@property (nonatomic, weak) id<ADSuyiKitImpressionTimerDelegate> delegate;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

/**
初始化一个视图的监听对象, 然后回调给外部该视图是否达到展示要求

@param requiredSecondsForImpression 展示时间 [0, infinite]
@param requiredViewVisibilityPixels 展示像素 [0, infinite]
*/
- (instancetype)initWithRequiredSecondsForImpression:(NSTimeInterval)requiredSecondsForImpression requiresViewVisibilityPixels:(CGFloat)requiredViewVisibilityPixels NS_DESIGNATED_INITIALIZER;

/**
初始化一个视图的监听对象, 然后回调给外部该视图是否达到展示要求

@param requiredSecondsForImpression 展示时间 [0, infinite]
@param visibilityPercentage 视图展示比例 [0, 1], 1代表100%
*/
- (instancetype)initWithRequiredSecondsForImpression:(NSTimeInterval)requiredSecondsForImpression requiredViewVisibilityPercentage:(CGFloat)visibilityPercentage NS_DESIGNATED_INITIALIZER;

- (void)startTrackingView:(UIView *)adView;

@end

