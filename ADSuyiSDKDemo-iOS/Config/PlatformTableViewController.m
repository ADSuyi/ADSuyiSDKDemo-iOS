//
//  PlatformTableViewController.m
//  ADSuyiDev
//
//  Created by Erik on 2021/4/25.
//

#import "PlatformTableViewController.h"
#import "SetConfigManager.h"
#import <ADSuyiSDK/ADSuyiSDK.h>
@interface PlatformTableViewController ()
@property (nonatomic, strong) NSArray *platformArray;
@property(nonatomic ,assign) NSInteger selectIndex;
@property (nonatomic, strong) NSDictionary *platformDic;
@end

@implementation PlatformTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"广告平台选择";
    self.tableView.backgroundColor = [UIColor colorWithRed:225/255.0 green:233/255.0 blue:239/255.0 alpha:1];
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.platformArray = @[@"默认所有",@"天目",@"优量汇",@"穿山甲",@"百度",@"快手",@"gromore",@"爱奇艺"];
    self.platformDic = @{
        @"天目":@"tianmu",
        @"优量汇":@"gdt",
        @"穿山甲":@"toutiao",
        @"百度":@"baidu",
        @"快手":@"ksad",
        @"gromore":@"gromore",
        @"爱奇艺":@"iqy",
    };
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.platformArray.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [UILabel new];
    label.backgroundColor = [UIColor colorWithRed:225/255.0 green:233/255.0 blue:239/255.0 alpha:1];
    label.font = [UIFont systemFontOfSize:16];
    label.text = @"   请选择需要调试的广告平台（ADN）";
    label.textColor = UIColor.grayColor;
    return label;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
    
    cell.detailTextLabel.textAlignment = NSTextAlignmentCenter;
    cell.detailTextLabel.text = self.platformArray[indexPath.row];
    UILabel *label = [UILabel new];
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = UIColor.blackColor;
    label.text = self.platformArray[indexPath.row];;
    [cell.contentView addSubview:label];
    [label sizeToFit];
    label.frame = CGRectMake(UIScreen.mainScreen.bounds.size.width/2-label.bounds.size.width/2, 45/2-label.bounds.size.height/2, label.bounds.size.width, label.bounds.size.height);
    if (indexPath.row == 0) {
        cell.accessoryView.hidden = NO;
        cell.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"selected"]];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectIndex = indexPath.row;
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    for (UITableViewCell *noneCell in tableView.visibleCells) {
        noneCell.accessoryView.hidden = YES;
    }
    cell.accessoryView.hidden = NO;
    cell.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"selected"]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (_selectIndex == 0) {
        return;
    }
    if (self.selectedBlock) {
        self.selectedBlock(self.platformArray[_selectIndex]);
    }
    [SetConfigManager sharedManager].platform = self.platformArray[_selectIndex];
    [ADSuyiSDK setOnlyPlatform:self.platformDic[self.platformArray[_selectIndex]]];
    
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
