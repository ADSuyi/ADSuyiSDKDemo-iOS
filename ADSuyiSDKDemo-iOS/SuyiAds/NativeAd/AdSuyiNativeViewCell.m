//
//  AdSuyiNativeViewCell.m
//  ADSuyiSDKDemo
//
//  Created by 陶冶明 on 2020/4/21.
//  Copyright © 2020 陈坤. All rights reserved.
//

#import "AdSuyiNativeViewCell.h"

@implementation AdSuyiNativeViewCell

- (void)setAdView:(UIView *)adView {
    [_adView removeFromSuperview];
    
    _adView = adView;
    [self.contentView addSubview:_adView];
}

@end
