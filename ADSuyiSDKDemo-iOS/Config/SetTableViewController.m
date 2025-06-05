//
//  SetTableViewController.m
//  ADSuyiDev
//
//  Created by Erik on 2021/4/21.
//

#import "SetTableViewController.h"
#import "PlatformTableViewController.h"
#import "SplashSetTableViewController.h"
#import "NativeAdSetTableViewController.h"
#import "BannerAdSetTableViewController.h"
#import "DrawAdSetTableViewController.h"
#import "FullScreenAdSetTableViewController.h"
#import "NotificationAdSetViewController.h"
@interface SetTableViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray *adTypeArray;
@property (nonatomic, strong) UISwitch *switchDarkMode;
@property (nonatomic, copy) NSString *platform;
@end

@implementation SetTableViewController

- (UISwitch *)switchDarkMode {
    if (!_switchDarkMode) {
        _switchDarkMode = [[UISwitch alloc]init];
    }
    return _switchDarkMode;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.adTypeArray = @[@"开屏广告",@"信息流广告",@"横幅广告",@"Draw广告",@"插屏广告/全屏广告",@"浮窗广告"];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = [UIColor colorWithRed:225/255.0 green:233/255.0 blue:239/255.0 alpha:1];
    _platform = @"默认所有";
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section==0) {
        return 1;
    }
    return _adTypeArray.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [UILabel new];
    label.font = [UIFont systemFontOfSize:16];
    label.text = @"   广告位设置";
    label.textColor = UIColor.grayColor;
    return label;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section==0)
        return 0;
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"cell"];
    if (indexPath.section == 0) {
        cell.textLabel.text = @"广告平台";
        cell.detailTextLabel.text = _platform;
        cell.accessoryType = UIAccessibilityNavigationStyleSeparate;
            
    } else {
        cell.textLabel.text = _adTypeArray[indexPath.row];
        cell.accessoryType = UIAccessibilityNavigationStyleSeparate;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section ==0 ) {
        if (indexPath.row==0) {
            PlatformTableViewController *platformVc = [PlatformTableViewController new];
            platformVc.selectedBlock = ^(NSString * _Nonnull platorm) {
                self->_platform = platorm;
                __weak typeof(self) weakSelf = self;
                [weakSelf.tableView reloadData];
            };
            [self.navigationController pushViewController:platformVc animated:YES];
        }
    } else {
        UIViewController *vc = nil;
        switch (indexPath.row) {
            case 0: {
                vc = [SplashSetTableViewController new];
                break;
            }
            case 1: {
                vc = [NativeAdSetTableViewController new];
                break;
            }
            case 2: {
                vc = [BannerAdSetTableViewController new];
                break;
            }
            case 3: {
                vc = [DrawAdSetTableViewController new];
                break;
            }
            case 4: {
                vc = [FullScreenAdSetTableViewController new];
                break;
            }
            case 5: {
                vc = [NotificationAdSetViewController new];
                break;
            }
            default:
                break;
        }
        [self.navigationController pushViewController:vc animated:YES];
    }
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
