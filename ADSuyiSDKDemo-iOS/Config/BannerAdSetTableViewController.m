//
//  BannerAdSetTableViewController.m
//  ADSuyiDev
//
//  Created by Erik on 2021/4/26.
//

#import "BannerAdSetTableViewController.h"
#import "SetConfigManager.h"
@interface BannerAdSetTableViewController ()

@property (nonatomic, strong) UITextField *timeTextFiled;
@property (nonatomic, strong) UITextField *scenceTextFiled;

@end

@implementation BannerAdSetTableViewController

- (UITextField *)timeTextFiled {
    if (!_timeTextFiled) {
        _timeTextFiled = [UITextField new];
        _timeTextFiled.textAlignment = NSTextAlignmentRight;
        _timeTextFiled.text = [NSString stringWithFormat:@"%ld",[SetConfigManager sharedManager].bannerAdInterval];
        _timeTextFiled.keyboardType = UIKeyboardTypePhonePad;
    }
    return _timeTextFiled;
}

- (UITextField *)scenceTextFiled {
    if (!_scenceTextFiled) {
        _scenceTextFiled = [UITextField new];
        _scenceTextFiled.placeholder = @"请输入";
        if (![[SetConfigManager sharedManager].bannerAdScenceId isEqualToString: @""]) {
            _scenceTextFiled.text = [SetConfigManager sharedManager].bannerAdScenceId;
        }
    }
    return _scenceTextFiled;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"横幅广告设置";
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

- (void)saveSetConfig {
    if (self.timeTextFiled.text != nil)
        [SetConfigManager sharedManager].bannerAdInterval = [self.timeTextFiled.text integerValue];
    if (self.scenceTextFiled.text != nil)
        [SetConfigManager sharedManager].bannerAdScenceId = self.scenceTextFiled.text;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    if (section==1) {
        return 1;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section==1) {
        return 0;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [UILabel new];
    label.backgroundColor = [UIColor colorWithRed:225/255.0 green:233/255.0 blue:239/255.0 alpha:1];
    label.font = [UIFont systemFontOfSize:16];
    label.text = @" 横幅广告自刷新间隔时长[30,120]或0，单位秒，0为关闭";
    label.textColor = UIColor.grayColor;
    label.numberOfLines = 2;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    
    return label;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"cell"];
    switch (indexPath.section) {
        case 0: {
            cell.textLabel.text = @"间隔时长";
            [cell.contentView addSubview:self.timeTextFiled];
            self.timeTextFiled.frame = CGRectMake(100, 0, UIScreen.mainScreen.bounds.size.width/2, 45);
            break;
        }
        case 1: {
            cell.textLabel.text = @"场景ID";
            [cell.contentView addSubview:self.scenceTextFiled];
            self.scenceTextFiled.frame = CGRectMake(100, 0, UIScreen.mainScreen.bounds.size.width/2, 45);
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
