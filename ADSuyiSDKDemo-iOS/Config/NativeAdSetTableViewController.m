//
//  NativeAdSetTableViewController.m
//  ADSuyiDev
//
//  Created by Erik on 2021/4/25.
//

#import "NativeAdSetTableViewController.h"
#import "SetConfigManager.h"
@interface NativeAdSetTableViewController ()
@property (nonatomic, strong) UISwitch *switchBtn;
@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, strong) UITextField *textField;
@end

@implementation NativeAdSetTableViewController

- (UISwitch *)switchBtn {
    if (!_switchBtn) {
        _switchBtn = [UISwitch new];
        _switchBtn.on = [SetConfigManager sharedManager].nativeAdMuted;
    }
    return _switchBtn;
}

- (UIButton *)selectBtn {
    if (!_selectBtn) {
        _selectBtn = [UIButton new];
        _selectBtn.layer.borderWidth = 1;
        _selectBtn.layer.borderColor = UIColor.lightGrayColor.CGColor;
        [_selectBtn setImage:[UIImage imageNamed:@"info"] forState:(UIControlStateNormal)];
        [_selectBtn setTitle:[NSString stringWithFormat:@"%ld",(long)[SetConfigManager sharedManager].nativeAdCount] forState:UIControlStateNormal];
        [_selectBtn setTitleColor:UIColor.blackColor forState:(UIControlStateNormal)];
        _selectBtn.frame = CGRectMake(0, 0, 60, 30);
        _selectBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 30);
        _selectBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0);
        [_selectBtn addTarget:self action:@selector(showSelectTableView) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _selectBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"信息流设置";
    UIButton *setAdConfigBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [setAdConfigBtn setTitle:@"保存" forState:(UIControlStateNormal)];
    [setAdConfigBtn setTitleColor:UIColor.whiteColor forState:(UIControlStateNormal)];
    setAdConfigBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    setAdConfigBtn.frame = CGRectMake(0, 0, 50, 20);
    [setAdConfigBtn addTarget:self action:@selector(saveSetConfig) forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:setAdConfigBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    self.tableView.backgroundColor = [UIColor colorWithRed:225/255.0 green:233/255.0 blue:239/255.0 alpha:1];
    self.tableView.tableFooterView = [UIView new];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)showSelectTableView {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"" message:@"拉去广告数量" preferredStyle:(UIAlertControllerStyleActionSheet)];
    UIAlertAction *numer1Action = [UIAlertAction actionWithTitle:@"1" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [self.selectBtn setTitle:[NSString stringWithFormat:@"%@",@1] forState:(UIControlStateNormal)];
    }];
    UIAlertAction *numer2Action = [UIAlertAction actionWithTitle:@"2" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [self.selectBtn setTitle:[NSString stringWithFormat:@"%@",@2] forState:(UIControlStateNormal)];
    }];
    UIAlertAction *numer3Action = [UIAlertAction actionWithTitle:@"3" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [self.selectBtn setTitle:[NSString stringWithFormat:@"%@",@3] forState:(UIControlStateNormal)];
    }];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVC addAction:numer1Action];
    [alertVC addAction:numer2Action];
    [alertVC addAction:numer3Action];
    [alertVC addAction:cancle];
    [self presentViewController:alertVC animated:YES completion:nil];
//    [self.view addSubview:self.selectTableView];
//    [self.view bringSubviewToFront:self.selectTableView];
//    [self.selectBtn sizeToFit];
//    self.selectTableView.frame = CGRectMake(self.selectBtn.frame.origin.x, self.selectBtn.frame.origin.y+30, 60, 120);
}

- (void)saveSetConfig {
    [SetConfigManager sharedManager].nativeAdMuted = self.switchBtn.on;
    if (_textField.text != nil)
        [SetConfigManager sharedManager].nativeAdScenceId = _textField.text;
    [SetConfigManager sharedManager].nativeAdCount = [self.selectBtn.currentTitle integerValue];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections

    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows

    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 25;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"cell"];
    switch (indexPath.section) {
        case 0: {
            cell.textLabel.text = @"视频静音播放";
            cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
            cell.detailTextLabel.text = @"部分平台支持";
            cell.accessoryView = self.switchBtn;
            break;
        }
        case 1: {
            cell.textLabel.text = @"一次请求拉取的广告数";
            cell.accessoryView = self.selectBtn;
            break;
        }
        case 2: {
            cell.textLabel.text = @"场景ID";
//            cell.accessoryType = UIAccessibilityCustomSystemRotorTypeTextField;
            _textField = [UITextField new];
            _textField.placeholder = @"场景id";
//            cell.accessoryView = textField;
            _textField.text = [SetConfigManager sharedManager].nativeAdScenceId;
            [cell.contentView addSubview:_textField];
            _textField.frame = CGRectMake(100, 0, UIScreen.mainScreen.bounds.size.width/2, 45);
        }
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
