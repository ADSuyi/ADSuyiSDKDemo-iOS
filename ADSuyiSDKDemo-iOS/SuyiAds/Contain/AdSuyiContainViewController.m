//
//  AdSuyiContainViewController.m
//  ADSuyiSDKDemo-iOS
//
//  Created by Erik on 2021/4/27.
//  Copyright © 2021 陈坤. All rights reserved.
//

#import "AdSuyiContainViewController.h"
#import "BlankViewController.h"
#import <ADSuyiSDK/ADSuyiSDKContainAd.h>
@interface AdSuyiContainViewController ()

@end

@implementation AdSuyiContainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"内容组件";
    self.view.backgroundColor = [UIColor colorWithRed:225/255.0 green:233/255.0 blue:239/255.0 alpha:1];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    // Do any additional setup after loading the view.
    CGFloat topY = 120;
    
    UILabel *ecooklabel = [UILabel new];
    ecooklabel.textColor = UIColor.grayColor;
    ecooklabel.text = @"菜谱";
    [self.view addSubview:ecooklabel];
    ecooklabel.frame = CGRectMake(30, topY, 100, 30);
    
    topY += 20 + 30;
    
    UIButton *ecookBtn = [UIButton new];
    ecookBtn.layer.cornerRadius = 10;
    ecookBtn.clipsToBounds = YES;
    ecookBtn.backgroundColor = UIColor.whiteColor;
    [ecookBtn setTitle:@"菜谱入口" forState:(UIControlStateNormal)];
    [ecookBtn setTitleColor:UIColor.blackColor forState:(UIControlStateNormal)];
    [self.view addSubview:ecookBtn];
    ecookBtn.frame = CGRectMake(30, topY, UIScreen.mainScreen.bounds.size.width-60, 60);
    [ecookBtn addTarget:self action:@selector(ecookBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    topY += 20 + 60;
    
    UIButton *ecookTabBtn = [UIButton new];
    ecookTabBtn.layer.cornerRadius = 10;
    ecookTabBtn.clipsToBounds = YES;
    ecookTabBtn.backgroundColor = UIColor.whiteColor;
    [ecookTabBtn setTitle:@"菜谱Tabbar" forState:(UIControlStateNormal)];
    [ecookTabBtn setTitleColor:UIColor.blackColor forState:(UIControlStateNormal)];
    [self.view addSubview:ecookTabBtn];
    ecookTabBtn.frame = CGRectMake(30, topY, UIScreen.mainScreen.bounds.size.width-60, 60);
    [ecookTabBtn addTarget:self action:@selector(ecookTabbarClick) forControlEvents:(UIControlEventTouchUpInside)];
    topY += 80 + 60;
    
    UILabel *novellabel = [UILabel new];
    novellabel.textColor = UIColor.grayColor;
    novellabel.text = @"小说";
    [self.view addSubview:novellabel];
    novellabel.frame = CGRectMake(30, topY, 100, 30);
    topY += 20 + 30;
    
    UIButton *novelBtn = [UIButton new];
    novelBtn.layer.cornerRadius = 10;
    novelBtn.clipsToBounds = YES;
    novelBtn.backgroundColor = UIColor.whiteColor;
    [novelBtn setTitle:@"小说入口" forState:(UIControlStateNormal)];
    [novelBtn setTitleColor:UIColor.blackColor forState:(UIControlStateNormal)];
    [self.view addSubview:novelBtn];
    novelBtn.frame = CGRectMake(30, topY, UIScreen.mainScreen.bounds.size.width-60, 60);
    [novelBtn addTarget:self action:@selector(novelBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    topY += 20 + 60;
    
    UIButton *novelTabBtn = [UIButton new];
    novelTabBtn.layer.cornerRadius = 10;
    novelTabBtn.clipsToBounds = YES;
    novelTabBtn.backgroundColor = UIColor.whiteColor;
    [novelTabBtn setTitle:@"小说Tabbar" forState:(UIControlStateNormal)];
    [novelTabBtn setTitleColor:UIColor.blackColor forState:(UIControlStateNormal)];
    [self.view addSubview:novelTabBtn];
    novelTabBtn.frame = CGRectMake(30, topY, UIScreen.mainScreen.bounds.size.width-60, 60);
    [novelTabBtn addTarget:self action:@selector(novelTabbarClick) forControlEvents:(UIControlEventTouchUpInside)];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (void)ecookBtnClick {

}

- (void)ecookTabbarClick {
    
}

- (void)novelBtnClick {
    //仅内容控制器
    // 判断返回控制器是否有效
    NSError *error = nil;
    if ([ADSuyiSDKContainAd isValidControllerWithType:ADSuyiContainVcTypePush]) {
        UIViewController *containViewController = [ADSuyiSDKContainAd containViewControllerWithType:(ADSuyiContainVcTypePush) withError:&error];
        // 如果无错误 跳转
        if (!error)
            [self.navigationController pushViewController:containViewController animated:YES];
        NSLog(@"小说问题:%@",error.description);
    }
}

- (void)novelTabbarClick {
    NSError *error = nil;
    //带底部栏的内容控制器 一般使tabBar作为根控制器 此处示例作为push推出
    UITabBarController *tabBarVc = [[UITabBarController alloc]init];
    BlankViewController *blankVc = [[BlankViewController alloc]init];
    blankVc.tabBarItem.title = @"测试";
    blankVc.tabBarItem.image = [UIImage imageNamed:@"blank"];
    blankVc.tabBarItem.selectedImage = [UIImage imageNamed:@"blank"];
    UINavigationController *blankNavVc = [[UINavigationController alloc]initWithRootViewController:blankVc];
    //将内容SDK控制器作为底部分页 无需为containViewController添加导航栏控制器
    // 判断返回控制器是否有效
    if ([ADSuyiSDKContainAd isValidControllerWithType:ADSuyiContainVcTypePush]) {
        UIViewController *containViewController = [ADSuyiSDKContainAd containViewControllerWithType:(ADSuyiContainVcTypeTabBar) withError:&error];
        containViewController.tabBarItem.title = @"小说";
        containViewController.title = @"小说";
        containViewController.tabBarItem.image = [UIImage imageNamed:@"contain"];
        containViewController.tabBarItem.selectedImage = [UIImage imageNamed:@"contain"];
        [tabBarVc addChildViewController:blankNavVc];
        // 如果无误
        if (!error) {
            [tabBarVc addChildViewController:containViewController];
            tabBarVc.selectedIndex = 1;
        }
    }
    tabBarVc.modalPresentationStyle = UIModalPresentationFullScreen;
//    [self.navigationController.navigationBar setHidden:YES];
    [self presentViewController:tabBarVc animated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
