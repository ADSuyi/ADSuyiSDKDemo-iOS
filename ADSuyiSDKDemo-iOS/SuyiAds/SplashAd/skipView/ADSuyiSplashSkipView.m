//
//  ADSuyiSplashSkipView.m
//  ADSuyiSDKDemo
//
//  Created by 技术 on 2020/11/3.
//  Copyright © 2020 陈坤. All rights reserved.
//

#import "ADSuyiSplashSkipView.h"
#import "ADSuyiRingProgressView.h"
@interface ADSuyiSplashSkipView ()
{
    UILabel *_titleLabel;
    
}

@end

@implementation ADSuyiSplashSkipView

- (instancetype)initWithFrame:(CGRect)frame
{
    frame = [self frameForContainer];
    self = [super initWithFrame:frame];
    if (self) {
#warning 关闭按钮背景色不能设置为透明 否则会被认为是作弊行为
//        self.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:0.5];
        self.layer.cornerRadius = 3;
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)setLifeTime:(NSInteger)lifeTime {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (!self->_titleLabel) {
            self->_titleLabel = [UILabel new];
            self->_titleLabel.font = [UIFont systemFontOfSize:14];
            self->_titleLabel.textColor = UIColor.redColor;
            self->_titleLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:self->_titleLabel];
        }
        
        if (lifeTime>0) {
            self->_titleLabel.text = [NSString stringWithFormat:@"%ld | 跳过",lifeTime];
        }else{
            self->_titleLabel.text = @"关闭";
        }
        
    });
    
}

- (CGRect)frameForContainer {
#define kSkipViewWidth 60
#define kSkipViewHeight 26
#define kSkipViewRightMargin 12
#define kSkipViewTopMargin 8
// 状态栏高度  此处未作是否刘海屏幕判断
#define kADSYStatusBarHeight 44
    CGFloat y = kADSYStatusBarHeight + kSkipViewTopMargin;
    CGFloat x = UIScreen.mainScreen.bounds.size.width - kSkipViewRightMargin - kSkipViewWidth;
    return CGRectMake(x, y, kSkipViewWidth, kSkipViewHeight);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _titleLabel.frame = self.bounds;
}

@end
