//
//  ADSuyiAdapterDrawvodAdView.h
//  ADSuyiSDK
//
//  Created by 陈坤 on 2020/4/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ADSuyiAdapterDrawvodAdView : UIView

- (void)render;

- (void)registView;

- (void)unRegist;

// 记录当前渲染是否完成，如果已经完成渲染，则不要重复回掉
// 因为穿山甲有重复回掉渲染成功的问题
@property (nonatomic, assign) BOOL renderSucced;

@end

NS_ASSUME_NONNULL_END
