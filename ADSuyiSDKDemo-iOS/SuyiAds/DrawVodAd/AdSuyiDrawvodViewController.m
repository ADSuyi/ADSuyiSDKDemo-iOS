//
//  AdSuyiDrawvodViewController.m
//  ADSuyiSDKDemo
//
//  Created by 陈坤 on 2020/4/21.
//  Copyright © 2020 陈坤. All rights reserved.
//

#import "AdSuyiDrawvodViewController.h"
#import "AdSuyiDrawvodAdTableViewCell.h"
#import <ADSuyiSDK/ADSuyiSDKDrawvodAd.h>
#import <ADSuyiSDK/ADSuyiAdapterDrawvodAdView.h>
#import "SetConfigManager.h"
@interface AdSuyiDrawvodViewController () <ADSuyiSDKDrawvodAdDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray<ADSuyiAdapterDrawvodAdView *> *data;

@property (nonatomic, strong) ADSuyiSDKDrawvodAd *drawvodAd;

@end

@implementation AdSuyiDrawvodViewController

#pragma mark - Life crycle

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self setupUI];
    [self loadDrawvodAd];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

#pragma mark - Private method - UI

static NSString *identifier = @"cell";
- (void)setupUI {
    _tableView = [UITableView new];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.frame = self.view.bounds;
    _tableView.pagingEnabled = YES;
    _tableView.backgroundColor = [UIColor blackColor];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [_tableView registerClass:[AdSuyiDrawvodAdTableViewCell class] forCellReuseIdentifier:identifier];
    [self.view addSubview:_tableView];
    
    UIButton *closeButton = [UIButton new];
    [self.view addSubview:closeButton];
    closeButton.frame = CGRectMake(22, 44, 44, 44);
    [closeButton setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(clickCloseButton) forControlEvents:UIControlEventTouchUpInside];
}

- (void)dealloc
{
    for (ADSuyiAdapterDrawvodAdView *adview in self.data) {
        // 5、广告内存回收
        [adview unRegist];
    }
}

#pragma mark - Touch event

- (void)clickCloseButton {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Private method - AD

- (void)loadDrawvodAd{
    // 2、加载沉浸式视频广告
    [self.drawvodAd load:[SetConfigManager sharedManager].drawAdCount];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    AdSuyiDrawvodAdTableViewCell *adCell = (AdSuyiDrawvodAdTableViewCell *)cell;
    ADSuyiAdapterDrawvodAdView *adView = self.data[indexPath.row];
    adCell.adView = adView;
    [adView registView];
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    AdSuyiDrawvodAdTableViewCell *adCell = (AdSuyiDrawvodAdTableViewCell *)cell;
    ADSuyiAdapterDrawvodAdView *adView = self.data[indexPath.row];
    adCell.adView = nil;
    [adView unRegist];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.tableView.frame.size.height;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AdSuyiDrawvodAdTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    return cell;
}

#pragma mark - ADSuyiSDKDrawvodAdDelegate

- (void)adsy_drawvodAdSuccessToLoad:(ADSuyiSDKDrawvodAd *)drawvodAd drawvodAdArray:(NSArray<ADSuyiAdapterDrawvodAdView *> *)drawvodAdViewArray {
    for (ADSuyiAdapterDrawvodAdView *adView in drawvodAdViewArray) {
        ADSuyiSDKExtInfo *extInfo = [adView adsy_extInfo];
        NSLog(@"ecpm=%@, ecpmType=%ld", extInfo.ecpm, extInfo.ecpmType);
        // 3、渲染沉浸式广告
        [adView render];
    }
}

- (void)adsy_drawvodAdFailToLoad:(ADSuyiSDKDrawvodAd *)drawvodAd errorModel:(ADSuyiAdapterErrorDefine *)errorModel {
    
}

- (void)adsy_drawvodAdSuccessToRender:(ADSuyiSDKDrawvodAd *)drawvodAd view:(ADSuyiAdapterDrawvodAdView *)drawvodAdView {
    // 4、渲染成功，此时高度正常，资源加载中，可展示
    [self.data addObject:drawvodAdView];
    [self.tableView reloadData];
}

- (void)adsy_drawvodAdFailToRender:(ADSuyiSDKDrawvodAd *)drawvodAd view:(ADSuyiAdapterDrawvodAdView *)drawvodAdView error:(nullable NSError *)error {
    
}

- (void)adsy_drawvodAdPlayerDidPlayFinish:(ADSuyiAdapterDrawvodAdView *)drawvodAdView {
    
}

- (void)adsy_drawvodAdDidExposure:(ADSuyiAdapterDrawvodAdView *)drawvodAdView {
    
}

- (void)adsy_drawvodAdDidClick:(ADSuyiAdapterDrawvodAdView *)drawvodAdView {
    
}
- (void)adsy_drawvodAdCloseLandingPage:(ADSuyiAdapterDrawvodAdView *)drawvodAdView {
   
}
#pragma mark - Lazy load

- (ADSuyiSDKDrawvodAd *)drawvodAd {
    if(!_drawvodAd) {
        // 1、初始化沉浸式视频广告，流程和信息流广告类似
        _drawvodAd = [[ADSuyiSDKDrawvodAd alloc] initWithSize:self.tableView.frame.size];
        _drawvodAd.posId = @"e60e6ad498e1be4906";
        _drawvodAd.controller = self;
        _drawvodAd.delegate = self;
    }
    return _drawvodAd;
}

- (NSMutableArray<ADSuyiAdapterDrawvodAdView *> *)data {
    if(!_data) {
        _data = [NSMutableArray new];
    }
    return _data;
}

@end
