//
//  UIView+ADSuyiKit.h
//  ADSuyiKit
//
//  Created by 陈坤 on 2020/3/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (ADSuyiKit)

/**
 Returns the view's view controller (may be nil).
 */
@property (nullable, nonatomic, readonly) UIViewController *adsy_viewController;

@property (nonatomic, readonly, assign) BOOL adsy_inScreen;

@end

NS_ASSUME_NONNULL_END
