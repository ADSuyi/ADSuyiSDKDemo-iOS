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
    for (UIView *view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    _adView = adView;
    _adView.frame = self.contentView.bounds;
    [self.contentView addSubview:_adView];
}

- (void)setCloseBtnView:(UIView *)closeBtnView{
    _closeBtnView = closeBtnView;
    //frame根据需求进行自行调整
    _closeBtnView.frame = CGRectMake(UIScreen.mainScreen.bounds.size.width-60, 10, 60, 30);
    [self.contentView addSubview:_closeBtnView];
}

@end
