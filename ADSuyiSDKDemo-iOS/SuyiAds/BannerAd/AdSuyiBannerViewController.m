//
//  AdSuyiBannerViewController.m
//  ADSuyiSDKDemo
//
//  Created by 陈坤 on 2020/4/21.
//  Copyright © 2020 陈坤. All rights reserved.
//

#import "AdSuyiBannerViewController.h"
#import <ADSuyiSDK/ADSuyiSDKBannerAdView.h>
#import <ADSuyiKit/ADSuyiKitMacros.h>
#import "SetConfigManager.h"
@interface AdSuyiBannerItem : NSObject

@property (nonatomic, assign) CGFloat rate;

@property (nonatomic, copy) NSString *posId;

@property (nonatomic, copy) NSString *title;

+ (instancetype)itemWithRate:(CGFloat)rate posId:(NSString *)posId title:(NSString *)title;

@end


@interface AdSuyiBannerViewController ()<ADSuyiSDKBannerAdViewDelegate>

@property (nonatomic, strong) ADSuyiSDKBannerAdView * bannerView;

@property (nonatomic, copy) NSArray<AdSuyiBannerItem *> *array;

@property (nonatomic, strong) NSMutableArray<UIButton *> *btns;

@end

@implementation AdSuyiBannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    for (int i = 0; i < self.array.count; i++) {
        [self createButtonWithItem:self.array[i] index:i];
    }
}


#pragma mark - Private method

- (void)loadBannerWithRate:(CGFloat)rate posId:(NSString *)posId {
    [self.bannerView removeFromSuperview];
    self.bannerView.delegate = nil;
    self.bannerView = nil;
    
    // 1、初始化banner视图，并给定frame值，rate取值根据banner的尺寸
    self.bannerView = [[ADSuyiSDKBannerAdView alloc] initWithFrame:CGRectMake(0, 250, kADSYScreenWidth, kADSYScreenWidth / rate)];
    self.bannerView.delegate = self;
    // 2、设置广告位id，重要
    self.bannerView.posId = posId;
    if (![[SetConfigManager sharedManager].bannerAdScenceId isEqualToString:@""])
        self.bannerView.scenesId = [SetConfigManager sharedManager].bannerAdScenceId;
    // 3、可先展示再请求
    [self.view addSubview:self.bannerView];
    // 4、加载并展示；设置控制器，用来弹出落地页，重要
    [self.bannerView loadAndShow:self];
}

#pragma mark - ADSuyiSDKBannerAdViewDelegate
/**
 广告获取成功
 
 @param bannerView banner实例
 */
- (void)adsy_bannerViewDidReceived:(ADSuyiSDKBannerAdView *)bannerView{
    ADSuyiSDKExtInfo *extInfo = [bannerView adsy_extInfo];
    NSLog(@"ecpm=%@, ecpmType=%ld", extInfo.ecpm, extInfo.ecpmType);
}

/**
 广告拉取失败
 
 @param bannerView banner实例
 @param errorModel 错误描述
 */
- (void)adsy_bannerViewFailToReceived:(ADSuyiSDKBannerAdView *)bannerView errorModel:(ADSuyiAdapterErrorDefine *)errorModel{
    NSLog(@"adsy_bannerViewFailToReceived:%@, %@",errorModel.errorDescription, errorModel.errorDetailDict);
    [_bannerView removeFromSuperview];
    _bannerView = nil;
}

/**
 广告点击
 
 @param bannerView 广告实例
 */
- (void)adsy_bannerViewClicked:(ADSuyiSDKBannerAdView *)bannerView{
    
}

/**
 广告关闭
 
 @param bannerView 广告实例
 */
- (void)adsy_bannerViewClose:(ADSuyiSDKBannerAdView *)bannerView{
    _bannerView = nil;
}

/**
 广告展示
 
 @param bannerView 广告实例
 */
- (void)adsy_bannerViewExposure:(ADSuyiSDKBannerAdView *)bannerView{
    
}

/**
 关闭落地页
 
 @param bannerView 广告实例
 */
- (void)adsy_bannerAdCloseLandingPage:(ADSuyiSDKBannerAdView *)bannerView{
    
}
#pragma mark - Touch event

- (void)clickLoadBannerButton:(UIButton *)btn {
    btn.enabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        btn.enabled = YES;
    });
    for (UIButton *lbtn in self.btns) {
        lbtn.backgroundColor = (lbtn == btn) ? [UIColor colorWithRed:222/255.0 green:236/255.0 blue:251/255.0 alpha:1.0] : [UIColor whiteColor];
    }
    AdSuyiBannerItem *item = self.array[btn.tag];
    [self loadBannerWithRate:item.rate posId:item.posId];
}

#pragma mark - Helper - UI

- (void)createButtonWithItem:(AdSuyiBannerItem *)item index:(NSInteger)index {
    UIButton *btn = [UIButton new];
    [self.view addSubview:btn];

    static NSInteger btn_num_per_line = 4;
    static CGFloat btn_height = 32;
    static CGFloat btn_margin_top = 10;
    static CGFloat btn_margin_left = 10;
    static CGFloat margin_top = 16;
    static CGFloat margin_left = 17;
    
    CGFloat btn_width = ((self.view.frame.size.width - margin_left * 2) - ((btn_num_per_line - 1) * btn_margin_left)) / btn_num_per_line;
    CGFloat x = ((index % btn_num_per_line) * (btn_margin_left + btn_width)) + margin_left;
    CGFloat y = (index / btn_num_per_line) * (btn_margin_top + btn_height) + margin_top + 100;
    
    btn.frame = CGRectMake(x, y, btn_width, btn_height);
    
    btn.tag = index;
    
    [btn addTarget:self action:@selector(clickLoadBannerButton:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:item.title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:0 green:122/255.0 blue:1 alpha:1] forState:UIControlStateNormal];
    btn.layer.borderWidth = 1.0;
    btn.layer.borderColor = [UIColor colorWithRed:199/255.0 green:199/255.0 blue:204/255.0 alpha:1.0].CGColor;
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.btns addObject:btn];
    
    [self.view addSubview:btn];
}

#pragma mark - Lazy load

- (NSArray<AdSuyiBannerItem *> *)array {
    if(!_array) {
        NSMutableArray *array = [NSMutableArray new];
        
        [array addObject:[AdSuyiBannerItem itemWithRate:640/100.0 posId:@"9ca1e179e38ca5a35c" title:@"640*100"]];
        [array addObject:[AdSuyiBannerItem itemWithRate:600/150.0 posId:@"f75ccc39a18436f65c" title:@"600*150"]];
        [array addObject:[AdSuyiBannerItem itemWithRate:600/260.0 posId:@"ddf3dbdbef73a0e0b2" title:@"600*260"]];
        [array addObject:[AdSuyiBannerItem itemWithRate:600/300.0 posId:@"2a74467bee2eb3e31f" title:@"600*300"]];
        [array addObject:[AdSuyiBannerItem itemWithRate:690/388.0 posId:@"cf17c076d6d2b5f86f" title:@"690*388"]];
        [array addObject:[AdSuyiBannerItem itemWithRate:600/400.0 posId:@"1d54d4991ffd9273b7" title:@"600*400"]];
        [array addObject:[AdSuyiBannerItem itemWithRate:600/500.0 posId:@"2e5443fd293252ad30" title:@"600*500"]];
        
        _array = [array copy];
    }
    return _array;
}

- (NSMutableArray<UIButton *> *)btns {
    if(!_btns) {
        _btns = [NSMutableArray new];
    }
    return _btns;;
}

@end

@implementation AdSuyiBannerItem

+ (instancetype)itemWithRate:(CGFloat)rate posId:(NSString *)posId title:(NSString *)title {
    AdSuyiBannerItem *item = [super new];
    if(self) {
        item.rate = rate;
        item.posId = posId;
        item.title = title;
    }
    return item;
}

@end
