//
//  FullScreenAdSetTableViewController.m
//  ADSuyiSDKDemo-iOS
//
//  Created by 陶冶明 on 2021/4/26.
//  Copyright © 2021 陈坤. All rights reserved.
//

#import "FullScreenAdSetTableViewController.h"
#import "SetConfigManager.h"
@interface FullScreenAdSetTableViewController ()

@property (nonatomic, strong) UITextField *textField;

@end

@implementation FullScreenAdSetTableViewController

#pragma mark - Life crycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"插屏/全屏视频广告";
    UIBarButtonItem *saveButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(clickSaveButton)];
    saveButtonItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = saveButtonItem;
    self.tableView.backgroundColor = [UIColor colorWithRed:225/255.0 green:233/255.0 blue:239/255.0 alpha:1];
    self.tableView.tableFooterView = [UIView new];
}

- (void)clickSaveButton {
    if (self.textField.text != nil)
        [SetConfigManager sharedManager].fullAdAdScenceId = self.textField.text;
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
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"cell"];
    cell.backgroundColor = [UIColor whiteColor];
    cell.textLabel.text = @"场景ID";
    cell.textLabel.textColor = [UIColor blackColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell addSubview:self.textField];
    return cell;
}

- (UITextField *)textField {
    if(!_textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(100, 0, self.view.frame.size.width - 100, 44)];
//        _textField.placeholder = @"请输入";
        _textField.textColor = [UIColor blackColor];
        
        NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:@"请输入"];
        [placeholder addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, 3)];
        _textField.attributedPlaceholder = placeholder;
        if (![[SetConfigManager sharedManager].fullAdAdScenceId isEqualToString:@""]) {
            _textField.text = [SetConfigManager sharedManager].fullAdAdScenceId;
        }
    }
    return _textField;
}

@end
