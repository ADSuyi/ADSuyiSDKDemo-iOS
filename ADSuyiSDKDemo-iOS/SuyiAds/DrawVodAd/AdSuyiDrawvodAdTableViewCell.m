//
//  AdSuyiDrawvodAdTableViewCell.m
//  ADSuyiSDKDemo
//
//  Created by 陶冶明 on 2020/5/8.
//  Copyright © 2020 陈坤. All rights reserved.
//

#import "AdSuyiDrawvodAdTableViewCell.h"

@implementation AdSuyiDrawvodAdTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        self.backgroundColor = [UIColor blackColor];
    }
    return self;
}

- (void)setAdView:(UIView *)adView {
    if(_adView == adView)
        return;
    if(_adView.superview == self)
        [_adView removeFromSuperview];
    _adView = adView;
    [self.contentView addSubview:adView];
    adView.frame = self.contentView.bounds;
}

- (void)layoutSubviews {
    _adView.frame = self.contentView.bounds;
}

@end
