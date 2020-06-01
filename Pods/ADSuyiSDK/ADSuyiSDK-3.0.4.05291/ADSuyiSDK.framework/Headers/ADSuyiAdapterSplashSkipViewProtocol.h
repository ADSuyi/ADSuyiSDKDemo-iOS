//
//  ADSuyiAdapterSplashSkipViewProtocol.h
//  ADSuyiSDK
//
//  Created by 陶冶明 on 2020/4/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ADSuyiAdapterSplashSkipViewProtocol

@required
/**
当前按钮时间回调用，建议单纯用来展示（不建议用此数值做任何逻辑判断）
*/
- (void)setLifeTime:(NSInteger)lifeTime;

@end

NS_ASSUME_NONNULL_END
