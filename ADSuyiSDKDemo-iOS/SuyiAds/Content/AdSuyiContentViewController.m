//
//  AdSuyiContentViewController.m
//  ADSuyiSDKDemo
//
//  Created by 技术 on 2021/1/5.
//  Copyright © 2021 陈坤. All rights reserved.
//

#import "AdSuyiContentViewController.h"
#import <ADSuyiSDK/ADSuyiSDKContentAd.h>
#import "AdSuyiBaseContentViewController.h"
#import <MJRefresh/MJRefresh.h>
@interface AdSuyiContentViewController ()<ADSuyiSDKContentAdDelegate,UITableViewDelegate,UITableViewDataSource>
{
    CGFloat _contentAdWidth;
    CGFloat _contentAdHeight;
}
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) NSMutableArray *items;

@property (nonatomic, strong) ADSuyiSDKContentAd *contentAd;

@property (nonatomic, strong) UIView<ADSuyiSDKContentAdViewProtocol> *contentView;

@end

@implementation AdSuyiContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView = [UITableView new];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.frame = self.view.frame;
    _tableView.backgroundColor = UIColor.whiteColor;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.estimatedRowHeight = 44.0;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
    _items = [NSMutableArray new];
    __weak typeof(self) weakSelf = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _items = [NSMutableArray new];
        [_tableView reloadData];
        [weakSelf loadContentAd];
    }];
    
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadContentAd];
    }];
    [self loadContentAd];
    // Do any additional setup after loading the view.
}

- (void)loadContentAd {
    if (!_contentAd) {
        _contentAd = [[ADSuyiSDKContentAd alloc]init];
        _contentAd.delegate = self;
        _contentAd.posId = @"7d4b7081b1cb1467aa";
        // 内容组件宽度（可选） 默认屏幕宽
    //    _contentAd.contentAdWidth = 100;
        // 内容组件padding（可选） 默认 左右各 16，上 8 下 0
    //    _contentAd.contentAdPadding = UIEdgeInsetsMake(20, 0, 20, 0);
    }
    [_contentAd loadContentAd];
}

#pragma mark -- tableview delegate datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.items.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    id item = [self.items objectAtIndex:indexPath.row];
    if ([item conformsToProtocol:NSProtocolFromString(@"ADSuyiSDKContentAdViewProtocol")]) {
        UIView<ADSuyiSDKContentAdViewProtocol> *adView = item;
        return adView.contentAdSize.height;
    }
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    id item = [self.items objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if ([item conformsToProtocol:NSProtocolFromString(@"ADSuyiSDKContentAdViewProtocol")]) {
        UIView<ADSuyiSDKContentAdViewProtocol> *adView = item;
        [cell.contentView addSubview:adView];
        adView.frame = CGRectMake(0, 0, adView.contentAdSize.width, adView.contentAdSize.height);
    }else{
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.text = [NSString stringWithFormat:@"ListViewitem %li", indexPath.row];
    }
    return cell;
}

#pragma mark - ADSuyiContentAdDelegate

- (void)adsy_contentAdSucessToLoad:(ADSuyiSDKContentAd *)contentAd contentAdView:(__kindof UIView<ADSuyiSDKContentAdViewProtocol> *)contentAdView {
    contentAdView.frame = CGRectMake(0, 0, 200, 100);
    contentAdView.backgroundColor = UIColor.redColor;
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickContentView)];
//    _contentView = contentAdView;
//    [contentAdView addGestureRecognizer:tap];
//    UIView *view = [UIView new];
//    view.frame = CGRectMake(0, 0, 200, 100);
//    view.backgroundColor = UIColor.greenColor;
    [contentAdView adsy_registView:nil];
    [self.items addObject:contentAdView];
    [self.tableView reloadData];
    [_tableView.mj_header endRefreshing];
    [_tableView.mj_footer endRefreshing];
}

- (void)adsy_contentAdFailToLoad:(ADSuyiSDKContentAd *)contentAd errorModel:(ADSuyiAdapterErrorDefine *)errorModel {
    NSLog(@"内容广告加载失败%@",errorModel);
    [_tableView.mj_header endRefreshing];
    [_tableView.mj_footer endRefreshing];
}

- (void)adsy_contentAdClicked:(ADSuyiSDKContentAd *)contentAd contentDetailPage:(UIViewController *)contentPageVc {
    // 使用控制器作为内容页面父控制器来添加返回按钮（按需求是否采用该方式）
    AdSuyiBaseContentViewController *contentVc = [[AdSuyiBaseContentViewController alloc] initWithViewController:contentPageVc];
    [self.navigationController pushViewController:contentVc animated:YES];
}
//
//- (void)clickContentView {
//    // 该方法执行会自动调用点击回调
//    [_contentAd clickContentPageWithContentView:_contentView];
//}

@end
