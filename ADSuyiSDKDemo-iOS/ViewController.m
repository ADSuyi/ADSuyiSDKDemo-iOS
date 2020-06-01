//
//  ViewController.m
//  ADSuyiSDKDemo-iOS
//
//  Created by 陈坤 on 2020/5/27.
//  Copyright © 2020 陈坤. All rights reserved.
//

#import "ViewController.h"
#import <ADSuyiKit/ADSuyiKitMacros.h>
#import <ADSuyiKit/NSObject+ADSuyiKit.h>
#import <ADSuyiKit/UIColor+ADSuyiKit.h>
#import <ADSuyiKit/UIFont+ADSuyiKit.h>
#import <ADSuyiSDK/ADSuyiSDK.h>

#import "AdSuyiSplashViewController.h"
#import "AdSuyiBannerViewController.h"
#import "AdSuyiNativeViewController.h"
#import "AdSuyiRewardvodViewController.h"
#import "AdSuyiFullScreenvodViewController.h"
#import "AdSuyiInterstitialViewController.h"
#import "AdSuyiDrawvodViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = [NSString stringWithFormat:@"ADSuyiSDK-Demo-v%@",[ADSuyiSDK getSDKVersion]];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.dataArray = @[@"开屏广告 SplashAD",@"横幅广告 BannerAD",@"信息流广告(模板) NativeAD",@"信息流广告列表(自渲染) NativeAD",@"插屏广告 InterstitalAD",@"全屏视频 FullScreenVideoAD",@"沉浸式视频 DrawVideoAD",@"激励视频 RewardVideoAD",];
    
    [self.mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.mainTableView];
}


- (UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.backgroundColor = [UIColor whiteColor];
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _mainTableView;
}

#pragma make - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSString *title = [self.dataArray adsy_objectOrNilAtIndex:indexPath.row];
    
    UIView *view = [cell.contentView viewWithTag:999];
    if (view) {
        [view removeFromSuperview];
    }
    
    UILabel *labTitle = [[UILabel alloc]init];
    labTitle.font = [UIFont adsy_PingFangRegularFont:14];
    labTitle.backgroundColor = [UIColor whiteColor];
    labTitle.textAlignment = NSTextAlignmentCenter;
    labTitle.textColor = [UIColor adsy_colorWithHexString:@"#666666"];
    labTitle.tag = 999;
    labTitle.text = title;
    [cell.contentView addSubview:labTitle];
    labTitle.frame = CGRectMake(16, 8, self.view.bounds.size.width - 32, 32);
    labTitle.layer.cornerRadius = 4;
    labTitle.layer.borderWidth = 1;
    labTitle.layer.borderColor = [UIColor adsy_colorWithHexString:@"#E5E5EA"].CGColor;
    labTitle.layer.shadowColor = [UIColor adsy_colorWithHexString:@"#000000" alphaComponent:0.1].CGColor;
    labTitle.layer.shadowOffset = CGSizeMake(0, 1);
    labTitle.layer.shadowOpacity = 1;
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 48;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    switch (indexPath.row) {
        case 0: {
            [self.navigationController pushViewController:[AdSuyiSplashViewController new] animated:YES];
            break;
        }
        case 1: {
            [self.navigationController pushViewController:[AdSuyiBannerViewController new] animated:YES];
            break;
        }
        case 2: {
            AdSuyiNativeViewController *vc = [AdSuyiNativeViewController new];
            vc.posId = @"01ab5a91baf16067cd";
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 3: {
            AdSuyiNativeViewController *vc = [AdSuyiNativeViewController new];
            vc.posId = @"2292f78269697e0e39";
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 4: {
            [self.navigationController pushViewController:[AdSuyiInterstitialViewController new] animated:YES];
            break;
        }
        case 5: {
            [self.navigationController pushViewController:[AdSuyiFullScreenvodViewController new] animated:YES];
            break;
        }
        case 6: {
            [self.navigationController pushViewController:[AdSuyiDrawvodViewController new] animated:YES];
            break;
        }
        case 7: {
            [self.navigationController pushViewController:[AdSuyiRewardvodViewController new] animated:YES];
            break;
        }
            
        default:
            break;
    }
}


@end
