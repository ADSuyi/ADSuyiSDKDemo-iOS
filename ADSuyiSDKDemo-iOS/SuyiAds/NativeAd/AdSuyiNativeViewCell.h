//
//  AdSuyiNativeViewCell.h
//  ADSuyiSDKDemo
//
//  Created by 陶冶明 on 2020/4/21.
//  Copyright © 2020 陈坤. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AdSuyiNativeViewCell : UITableViewCell

@property (nonatomic, strong, nullable) UIView *adView;

@property (nonatomic, strong) UIView *closeBtnView;//只有自渲染广告类型才使用到的关闭按钮

@end

NS_ASSUME_NONNULL_END
