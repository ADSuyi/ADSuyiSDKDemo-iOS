//
//  NotificationAdSetViewController.m
//  ADSuyiSDKDemo-iOS
//
//  Created by 陶冶明 on 2021/4/26.
//  Copyright © 2021 陈坤. All rights reserved.
//

#import "NotificationAdSetViewController.h"
#import "SetConfigManager.h"
#import <ADSuyiSDK/ADSuyiSDK.h>
#import <ADSuyiSDK/ADSuyiSDKNotificationAd.h>
@interface NotificationAdSetViewController ()

@property (nonatomic, strong) UISwitch *switchBtn;

@end

@implementation NotificationAdSetViewController

#pragma mark - Life crycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"浮窗设置";
    UIBarButtonItem *saveButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(clickSaveButton)];
    saveButtonItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = saveButtonItem;
    self.tableView.backgroundColor = [UIColor colorWithRed:225/255.0 green:233/255.0 blue:239/255.0 alpha:1];
    self.tableView.tableFooterView = [UIView new];
}

- (void)clickSaveButton {
    [SetConfigManager sharedManager].showNotificationAd = self.switchBtn.on;
    if (self.switchBtn.on) {
        [ADSuyiSDKStatusManager notificationAdContinue];
    } else {
        [ADSuyiSDKStatusManager notificationAdPause];
    }
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 25;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"cell"];
    cell.textLabel.text = @"浮窗广告开关";
    cell.accessoryView = self.switchBtn;
    cell.backgroundColor = [UIColor whiteColor];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - Lazy load

- (UISwitch *)switchBtn {
    if (!_switchBtn) {
        _switchBtn = [UISwitch new];
        _switchBtn.on = [SetConfigManager sharedManager].showNotificationAd;
    }
    return _switchBtn;
}

@end
