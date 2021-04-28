//
//  DrawAdSetTableViewController.m
//  ADSuyiSDKDemo-iOS
//
//  Created by 陶冶明 on 2021/4/26.
//  Copyright © 2021 陈坤. All rights reserved.
//

#import "DrawAdSetTableViewController.h"
#import "SetConfigManager.h"
@interface DrawAdSetTableViewController ()

@property (nonatomic, assign) NSInteger adCount;

@end

@implementation DrawAdSetTableViewController

#pragma mark - Life crycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _adCount = [SetConfigManager sharedManager].drawAdCount;
    
    self.title = @"Draw视频";
    UIBarButtonItem *saveButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(clickSaveButton)];
    saveButtonItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = saveButtonItem;
    self.tableView.backgroundColor = [UIColor colorWithRed:225/255.0 green:233/255.0 blue:239/255.0 alpha:1];
    self.tableView.tableFooterView = [UIView new];
}

- (void)clickSaveButton {
    [SetConfigManager sharedManager].drawAdCount = _adCount;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [UILabel new];
    label.backgroundColor = [UIColor colorWithRed:225/255.0 green:233/255.0 blue:239/255.0 alpha:1];
    label.font = [UIFont systemFontOfSize:16];
    label.text = @"";
    label.textColor = UIColor.grayColor;
    return label;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 25;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"cell"];
    cell.textLabel.text = @"一次请求拉取广告数";
    cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"xxx"]];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%li", _adCount];
    cell.backgroundColor = [UIColor whiteColor];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.detailTextLabel.textColor = [UIColor blackColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    __weak typeof(self) weakSelf = self;
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:nil message:@"一次请求拉取广告数" preferredStyle:UIAlertControllerStyleActionSheet];
    [ac addAction:[UIAlertAction actionWithTitle:@"1" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf updateInfoWithNum:1];
    }]];
    [ac addAction:[UIAlertAction actionWithTitle:@"2" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf updateInfoWithNum:2];
    }]];
    [ac addAction:[UIAlertAction actionWithTitle:@"3" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf updateInfoWithNum:3];
    }]];
    [ac addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    UIPopoverPresentationController *popover = ac.popoverPresentationController;

    if (popover) {
        popover.sourceView = cell;
        popover.sourceRect = cell.bounds;
        popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
    }
    [self presentViewController:ac animated:YES completion:nil];
}

#pragma mark - Private method

- (void)updateInfoWithNum:(NSInteger)num {
    _adCount = num;
    [self.tableView reloadData];
}

@end
