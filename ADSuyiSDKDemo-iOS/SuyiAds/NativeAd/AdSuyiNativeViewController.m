//
//  AdSuyiNativeViewController.m
//  ADSuyiSDKDemo
//
//  Created by 陈坤 on 2020/4/21.
//  Copyright © 2020 陈坤. All rights reserved.
//

#import "AdSuyiNativeViewController.h"
#import <ADSuyiSDK/ADSuyiSDKNativeAd.h>
#import "AdSuyiNativeViewCell.h"
#import <MJRefresh/MJRefresh.h>
#import <ADSuyiKit/UIFont+ADSuyiKit.h>
#import <ADSuyiKit/UIColor+ADSuyiKit.h>
#import <ADSuyiKit/ADSuyiKitMacros.h>
#import "SetConfigManager.h"
#import "AdMacros.h"
@interface AdSuyiNativeViewController () <UITableViewDelegate, UITableViewDataSource, ADSuyiSDKNativeAdDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *items;

@property (nonatomic, strong) ADSuyiSDKNativeAd *nativeAd;

@end

@implementation AdSuyiNativeViewController

#pragma mark - Life crycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIButton *setAdConfigBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    //    [setAdConfigBtn setTitle:@"设置" forState:(UIControlStateNormal)];
    [setAdConfigBtn setImage:[UIImage imageNamed:@"set"] forState:(UIControlStateNormal)];
    [setAdConfigBtn setTitleColor:UIColor.whiteColor forState:(UIControlStateNormal)];
    setAdConfigBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    setAdConfigBtn.frame = CGRectMake(0, 0, 50, 20);
    [setAdConfigBtn addTarget:self action:@selector(showTypeSelect) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:setAdConfigBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    _items = [NSMutableArray new];
    
    _tableView = [UITableView new];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [_tableView registerClass:[AdSuyiNativeViewCell class] forCellReuseIdentifier:@"adcell"];
    [self.view addSubview:_tableView];
    _tableView.frame = self.view.bounds;
    
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf cleanAllAd];
        weakSelf.nativeAd = nil;
        [weakSelf loadNative];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadNative];
    }];
    
    [self.tableView.mj_header beginRefreshing];
}

- (void)dealloc {
    [self cleanAllAd];
}

- (void)showTypeSelect {
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"" message:@"选择信息流类型" preferredStyle:(UIAlertControllerStyleActionSheet)];
    UIAlertAction *expressType = [UIAlertAction actionWithTitle:@"模板" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        self.posId = Suyi_Demo_flowAd_PosId;
        [self cleanAllAd];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self->_nativeAd.delegate = nil;
            self->_nativeAd = nil;
            [self loadNative];
        });
    }];
    UIAlertAction *nativeType = [UIAlertAction actionWithTitle:@"自渲染" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        self.posId = Suyi_Demo_flowAd_Native_PosId;
        [self cleanAllAd];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self->_nativeAd.delegate = nil;
            self->_nativeAd = nil;
            [self loadNative];
        });
        
    }];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
    [alertVc addAction:expressType];
    [alertVc addAction:nativeType];
    [alertVc addAction:cancle];
    [self presentViewController:alertVc animated:YES completion:nil];
}

#pragma mark - Private method

- (void)cleanAllAd {
    for (id item in self.items) {
        if([item conformsToProtocol:@protocol(ADSuyiAdapterNativeAdViewDelegate)]) {
            // 7、取消注册
            [(id<ADSuyiAdapterNativeAdViewDelegate>)item adsy_unRegistView];
        }
    }
    _items = [NSMutableArray new];
    [self.tableView reloadData];
}

/**
 自渲染信息流测试 17b352fee9f09b6552
 模版自渲染混合 4d893cb3869b1e1d9c
 模版自渲染混合-视频 750ccddf366d01b017
 */
- (void)loadNative{
    if (kADSYStringIsEmpty(self.posId)) {
        self.posId = Suyi_Demo_flowAd_PosId;
    }
    
    if(!_nativeAd) {
        // 1、信息流广告初始化 建议高度设置为0，为自适应
        _nativeAd = [[ADSuyiSDKNativeAd alloc] initWithAdSize:CGSizeMake(self.tableView.frame.size.width, 0)];
        // 2、传入posId，重要
        _nativeAd.delegate = self;
        _nativeAd.controller = self;
        _nativeAd.posId = self.posId;
        if (![[SetConfigManager sharedManager].nativeAdScenceId isEqualToString:@""]) {
            _nativeAd.scenesId = [SetConfigManager sharedManager].nativeAdScenceId;
        }
    }
    // 3、加载信息流广告
    [_nativeAd load:(int)[SetConfigManager sharedManager].nativeAdCount];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    id item = [_items objectAtIndex:indexPath.row];
    if([item conformsToProtocol:@protocol(ADSuyiAdapterNativeAdViewDelegate)]) {
        return [(UIView *)item frame].size.height;
    } else {
        return 44;
    }
}
    
#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id item = [_items objectAtIndex:indexPath.row];
    if([item conformsToProtocol:@protocol(ADSuyiAdapterNativeAdViewDelegate)]) {
        AdSuyiNativeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"adcell" forIndexPath:indexPath];
        cell.adView = item;
        //备注：如果是自渲染信息流，建议将关闭按钮添加到和adView同一层级，切勿将关闭按钮添加到adView上 (必要)
        UIView<ADSuyiAdapterNativeAdViewDelegate> *adView = item;
        if(!adView.adsy_closeButtonExist) {
            cell.closeBtnView = [self getCloseButtonWithAdItem:item];
        }
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.text = [NSString stringWithFormat:@"ListViewitem %li", indexPath.row];
        return cell;
    }
}

#pragma mark - ADSuyiSDKNativeAdDelegate

- (void)adsy_nativeAdSucessToLoad:(ADSuyiSDKNativeAd *)nativeAd
                      adViewArray:(NSArray<__kindof UIView<ADSuyiAdapterNativeAdViewDelegate> *> *)adViewArray {
    for (UIView<ADSuyiAdapterNativeAdViewDelegate> *adView in adViewArray) {
        ADSuyiSDKExtInfo *extInfo = [adView adsy_extInfo];
        NSLog(@"ecpm=%@, ecpmType=%ld", extInfo.ecpm, extInfo.ecpmType);
        // 4、判断信息流广告是否为自渲染类型（可选实现）
        if(adView.renderType == ADSuyiAdapterRenderTypeNative) {
            // 自渲染广告位, 需自行进行 UI 搭建, 可参考下面示例 ↓
            // 1、常规样式示例:
            [self setUpUnifiedNativeAdView:adView];
            // 2、纯图样式示例 :[self setUpUnifiedOnlyImageNativeAdView:adView];
            // 3、上图下文示例 :[self setUpUnifiedTopImageNativeAdView:adView];
        }
        
        // 5、重要
        [adView adsy_registViews:@[adView]];
    }
    
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

- (void)adsy_nativeAdFailToLoad:(ADSuyiSDKNativeAd *)nativeAd
                     errorModel:(ADSuyiAdapterErrorDefine *)errorModel {
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

- (void)adsy_nativeAdViewRenderOrRegistSuccess:(UIView<ADSuyiAdapterNativeAdViewDelegate> *)adView {
    // 6、注册或渲染成功，此时高度正常，可以展示
    dispatch_async(dispatch_get_main_queue(), ^{
        for (int i = 0; i < 6; i ++) {
            [self.items addObject:[NSNull null]];
        }
        [self.items addObject:adView];
        [self.tableView reloadData];
    });
}

- (void)adsy_nativeAdViewRenderOrRegistFail:(UIView<ADSuyiAdapterNativeAdViewDelegate> *)adView {
    
}

- (void)adsy_nativeAdClicked:(ADSuyiSDKNativeAd *)nativeAd
                      adView:(__kindof UIView<ADSuyiAdapterNativeAdViewDelegate> *)adView {
    
}

- (void)adsy_nativeAdClose:(ADSuyiSDKNativeAd *)nativeAd
                    adView:(__kindof UIView<ADSuyiAdapterNativeAdViewDelegate> *)adView {
    for (id item in _items) {
        if(item == adView) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [adView adsy_unRegistView];
                [self.items removeObject:adView];
                [self.tableView reloadData];
            });
        }
    }
}

- (void)adsy_nativeAdExposure:(ADSuyiSDKNativeAd *)nativeAd
                       adView:(__kindof UIView<ADSuyiAdapterNativeAdViewDelegate> *)adView {
    
}

-(void)adsy_nativeAdCloseLandingPage:(ADSuyiSDKNativeAd *)nativeAd adView:(__kindof UIView<ADSuyiAdapterNativeAdViewDelegate> *)adView{
    
}
#pragma mark - Helper 自渲染类型信息流处理方法（以下广告样式根据需求选择） 1、setUpUnifiedNativeAdView常规样式 2、setUpUnifiedOnlyImageNativeAdView纯图样式  3、setUpUnifiedTopImageNativeAdView上图下文样式

// 1、常规信息流示例样式
- (void)setUpUnifiedNativeAdView:(UIView<ADSuyiAdapterNativeAdViewDelegate> *)adView {
    // 设计的adView实际大小，其中宽度和高度可以自己根据自己的需求设置
    CGFloat adWidth = self.view.frame.size.width;
    CGFloat adHeight = (adWidth - 17 * 2) / 16.0 * 9 + 67 + 38;
    adView.frame = CGRectMake(0, 0, adWidth, adHeight);
    
    // 显示logo图片（必要）
    if(![adView.adsy_platform isEqualToString:ADSuyiAdapterPlatformGDT]) { // 优量汇（广点通）会自带logo，不需要添加
        UIImageView *logoImage = [UIImageView new];
        [adView addSubview:logoImage];
        [adView adsy_platformLogoImageDarkMode:NO loadImageBlock:^(UIImage * _Nullable image) {
            CGFloat maxWidth = 40;
            CGFloat logoHeight = maxWidth / image.size.width * image.size.height;
            logoImage.frame = CGRectMake(adWidth - maxWidth, adHeight - logoHeight, maxWidth, logoHeight);
            logoImage.image = image;
        }];
    }
    
    // 设置标题文字（可选，但强烈建议带上）
    UILabel *titlabel = [UILabel new];
    [adView addSubview:titlabel];
    titlabel.font = [UIFont adsy_PingFangMediumFont:14];
    titlabel.textColor = [UIColor adsy_colorWithHexString:@"#333333"];
    titlabel.numberOfLines = 2;
    titlabel.text = adView.data.title;
    CGSize textSize = [titlabel sizeThatFits:CGSizeMake(adWidth - 17 * 2, 999)];
    titlabel.frame = CGRectMake(17, 16, adWidth - 17 * 2, textSize.height);
    
    CGFloat height = textSize.height + 16 + 15;
    
    // 设置主图/视频（主图可选，但强烈建议带上,如果有视频试图，则必须带上）
    CGRect mainFrame = CGRectMake(17, height, adWidth - 17 * 2, (adWidth - 17 * 2) / 16.0 * 9);
    if(adView.data.shouldShowMediaView) {
        UIView *mediaView = [adView adsy_mediaViewForWidth:mainFrame.size.width];
        mediaView.frame = mainFrame;
        [adView addSubview:mediaView];
    } else {
        UIImageView *imageView = [UIImageView new];
        imageView.backgroundColor = [UIColor adsy_colorWithHexString:@"#CCCCCC"];
        [adView addSubview:imageView];
        imageView.frame = mainFrame;
        NSString *urlStr = adView.data.imageUrl;
        if(urlStr.length > 0) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlStr]]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    imageView.image = image;
                });
            });
        }
    }
    
    // 设置广告标识（可选）
    height += (adWidth - 17 * 2) / 16.0 * 9 + 9;
    UILabel *adLabel = [[UILabel alloc]init];
    adLabel.backgroundColor = [UIColor adsy_colorWithHexString:@"#CCCCCC"];
    adLabel.textColor = [UIColor adsy_colorWithHexString:@"#FFFFFF"];
    adLabel.font = [UIFont adsy_PingFangLightFont:12];
    adLabel.text = @"广告";
    [adView addSubview:adLabel];
    adLabel.frame = CGRectMake(17, height, 36, 18);
    adLabel.textAlignment = NSTextAlignmentCenter;
    
    // 设置广告描述(可选)
    UILabel *descLabel = [UILabel new];
    descLabel.textColor = [UIColor adsy_colorWithHexString:@"#333333"];
    descLabel.font = [UIFont adsy_PingFangLightFont:12];
    descLabel.textAlignment = NSTextAlignmentLeft;
    descLabel.text = adView.data.desc;
    [adView addSubview:descLabel];
    descLabel.frame = CGRectMake(17 + 36 + 4, height, self.view.frame.size.width - 57 - 17 - 20, 18);
}

// 2、纯图样式
- (void)setUpUnifiedOnlyImageNativeAdView:(UIView<ADSuyiAdapterNativeAdViewDelegate> *)adView {
    // 设计的adView实际大小，其中宽度和高度可以自己根据自己的需求设置
    CGFloat adWidth = self.view.frame.size.width;
    CGFloat adHeight = adWidth / 16.0 * 9;
    adView.frame = CGRectMake(0, 0, adWidth, adHeight);
    
    // 设置主图/视频（主图可选，但强烈建议带上,如果有视频试图，则必须带上）
    CGRect mainFrame = CGRectMake(0, 0, adWidth, adHeight);
    if(adView.data.shouldShowMediaView) {
        UIView *mediaView = [adView adsy_mediaViewForWidth:mainFrame.size.width];
        mediaView.frame = mainFrame;
        [adView addSubview:mediaView];
    } else {
        UIImageView *imageView = [UIImageView new];
        imageView.backgroundColor = [UIColor adsy_colorWithHexString:@"#CCCCCC"];
        [adView addSubview:imageView];
        imageView.frame = mainFrame;
        NSString *urlStr = adView.data.imageUrl;
        if(urlStr.length > 0) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlStr]]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    imageView.image = image;
                });
            });
        }
    }
    
    // 显示logo图片（必要）
    if(![adView.adsy_platform isEqualToString:ADSuyiAdapterPlatformGDT]) { // 优量汇（广点通）会自带logo，不需要添加
        UIImageView *logoImage = [UIImageView new];
        [adView addSubview:logoImage];
        //        [adView bringSubviewToFront:logoImage];
        [adView adsy_platformLogoImageDarkMode:NO loadImageBlock:^(UIImage * _Nullable image) {
            CGFloat maxWidth = 40;
            CGFloat logoHeight = maxWidth / image.size.width * image.size.height;
            logoImage.frame = CGRectMake(adWidth - maxWidth, adHeight - logoHeight, maxWidth, logoHeight);
            logoImage.image = image;
        }];
    }
    
}

// 3、上图下文样式
- (void)setUpUnifiedTopImageNativeAdView:(UIView<ADSuyiAdapterNativeAdViewDelegate> *)adView {
    // 设计的adView实际大小，其中宽度和高度可以自己根据自己的需求设置
    CGFloat adWidth = self.view.frame.size.width;
    CGFloat adHeight = (adWidth - 17 * 2) / 16.0 * 9 + 70;
    adView.frame = CGRectMake(0, 0, adWidth, adHeight);
    
    // 显示logo图片（必要）
    if(![adView.adsy_platform isEqualToString:ADSuyiAdapterPlatformGDT]) { // 优量汇（广点通）会自带logo，不需要添加
        UIImageView *logoImage = [UIImageView new];
        [adView addSubview:logoImage];
        [adView adsy_platformLogoImageDarkMode:NO loadImageBlock:^(UIImage * _Nullable image) {
            CGFloat maxWidth = 40;
            CGFloat logoHeight = maxWidth / image.size.width * image.size.height;
            logoImage.frame = CGRectMake(adWidth - maxWidth, adHeight - logoHeight, maxWidth, logoHeight);
            logoImage.image = image;
        }];
    }
    
    // 设置主图/视频（主图可选，但强烈建议带上,如果有视频试图，则必须带上）
    CGRect mainFrame = CGRectMake(17, 0, adWidth - 17 * 2, (adWidth - 17 * 2) / 16.0 * 9);
    if(adView.data.shouldShowMediaView) {
        UIView *mediaView = [adView adsy_mediaViewForWidth:mainFrame.size.width];
        mediaView.frame = mainFrame;
        [adView addSubview:mediaView];
    } else {
        UIImageView *imageView = [UIImageView new];
        imageView.backgroundColor = [UIColor adsy_colorWithHexString:@"#CCCCCC"];
        [adView addSubview:imageView];
        imageView.frame = mainFrame;
        NSString *urlStr = adView.data.imageUrl;
        if(urlStr.length > 0) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlStr]]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    imageView.image = image;
                });
            });
        }
    }
    
    // 设置广告标识（可选）
    UILabel *adLabel = [[UILabel alloc]init];
    adLabel.backgroundColor = [UIColor adsy_colorWithHexString:@"#CCCCCC"];
    adLabel.textColor = [UIColor adsy_colorWithHexString:@"#FFFFFF"];
    adLabel.font = [UIFont adsy_PingFangLightFont:12];
    adLabel.text = @"广告";
    [adView addSubview:adLabel];
    adLabel.frame = CGRectMake(17, (adWidth - 17 * 2) / 16.0 * 9 + 9, 36, 18);
    adLabel.textAlignment = NSTextAlignmentCenter;
    
    // 设置广告描述(可选)
    UILabel *descLabel = [UILabel new];
    descLabel.textColor = [UIColor adsy_colorWithHexString:@"#333333"];
    descLabel.font = [UIFont adsy_PingFangLightFont:12];
    descLabel.textAlignment = NSTextAlignmentLeft;
    descLabel.text = adView.data.desc;
    [adView addSubview:descLabel];
    descLabel.frame = CGRectMake(17 + 36 + 4, (adWidth - 17 * 2) / 16.0 * 9 + 9, self.view.frame.size.width - 57 - 17 - 20, 18);
    
    // 设置标题文字（可选，但强烈建议带上）
    UILabel *titlabel = [UILabel new];
    [adView addSubview:titlabel];
    titlabel.font = [UIFont adsy_PingFangMediumFont:14];
    titlabel.textColor = [UIColor adsy_colorWithHexString:@"#333333"];
    titlabel.numberOfLines = 2;
    titlabel.text = adView.data.title;
    CGSize textSize = [titlabel sizeThatFits:CGSizeMake(adWidth - 17 * 2, 999)];
    titlabel.frame = CGRectMake(17, (adWidth - 17 * 2) / 16.0 * 9 + 30, adWidth - 17 * 2, textSize.height);
    
}
- (UIButton *)getCloseButtonWithAdItem:(id)item{
    UIButton *closeButton = [UIButton new];
    [closeButton setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [closeButton addTarget:item action:@selector(adsy_close) forControlEvents:UIControlEventTouchUpInside];
    return closeButton;
}
@end
