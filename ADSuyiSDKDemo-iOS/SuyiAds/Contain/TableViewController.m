//
//  TableViewController.m
//  TestStarRD
//
//  Created by 技术 on 2020/8/10.
//  Copyright © 2020 技术. All rights reserved.
//

#import "TableViewController.h"
#import "BlankViewController.h"
#import <ADSuyiSDK/ADSuyiSDK.h>
#import <ADSuyiKit/UIColor+ADSuyiKit.h>
#import <ADSuyiKit/UIFont+ADSuyiKit.h>
@interface TableViewController ()
@property (nonatomic, strong) NSArray *typeArray;
@end

@implementation TableViewController

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"内容SDK接入类型";
    self.tableView.backgroundColor = UIColor.whiteColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"containType"];
    
    self.typeArray = @[@"仅内容控制器",@"带导航栏内容控制器",@"带底部栏内容控制器",@"内容控制器做子控制器"];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#warning 初次初始化SDK 可能因网络权限获取等原因导致SDK初始化失败 init error
#warning SDK初始化失败 接入内容控制器将无法显示数据 建议在接入时对SDK初始化状态做判断并对返回值类型判断
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==1) {
        return 2;
    }
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"containType" forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"containType"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UILabel *labTitle = [[UILabel alloc]init];
    labTitle.font = [UIFont adsy_PingFangRegularFont:14];
    labTitle.backgroundColor = [UIColor whiteColor];
    labTitle.textAlignment = NSTextAlignmentCenter;
    labTitle.textColor = [UIColor adsy_colorWithHexString:@"#666666"];
    labTitle.tag = 999;
    if (indexPath.section==0) {
        switch (indexPath.row) {
            case 0:
                labTitle.text = self.typeArray[0];
                break;
            case 1:
                labTitle.text = self.typeArray[2];
                break;
            default:
                labTitle.text = self.typeArray[3];
                break;
        }
    }else{
        switch (indexPath.row) {
            case 0:
                labTitle.text = self.typeArray[0];
                break;
            case 1:
                labTitle.text = self.typeArray[2];
                break;
            default:
                break;
        }
        
    }
    [cell.contentView addSubview:labTitle];
    labTitle.frame = CGRectMake(16, 8, self.view.bounds.size.width - 32, 32);
    labTitle.layer.cornerRadius = 4;
    labTitle.layer.borderWidth = 1;
    labTitle.layer.borderColor = [UIColor adsy_colorWithHexString :@"#E5E5EA"].CGColor;
    labTitle.layer.shadowColor = [UIColor adsy_colorWithHexString:@"#000000" alphaComponent:0.1].CGColor;
    labTitle.layer.shadowOffset = CGSizeMake(0, 1);
    labTitle.layer.shadowOpacity = 1;
    [cell.contentView addSubview:labTitle];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSError *error = nil;
    if (indexPath.section==0) {
        // 推出方式：push
        switch (indexPath.row) {
            case 0:{
                //仅内容控制器
                // 判断返回控制器是否有效
                if ([ADSuyiSDKContainAd isValidControllerWithType:ADSuyiContainVcTypePush]) {
                    UIViewController *containViewController = [ADSuyiSDKContainAd containViewControllerWithType:(ADSuyiContainVcTypePush) withError:&error];
                    // 如果无错误 跳转
                    if (!error)
                        [self.navigationController pushViewController:containViewController animated:YES];
                    NSLog(@"小说问题:%@",error.description);
                }
                break;
            }
            case 1:{
                //带底部栏的内容控制器 一般使tabBar作为根控制器 此处示例作为push推出
                UITabBarController *tabBarVc = [[UITabBarController alloc]init];
                BlankViewController *blankVc = [[BlankViewController alloc]init];
                blankVc.tabBarItem.title = @"返回页";
                blankVc.tabBarItem.image = [UIImage imageNamed:@"blank"];
                blankVc.tabBarItem.selectedImage = [UIImage imageNamed:@"blank"];
                UINavigationController *blankNavVc = [[UINavigationController alloc]initWithRootViewController:blankVc];
                //将内容SDK控制器作为底部分页 无需为containViewController添加导航栏控制器
                // 判断返回控制器是否有效
                if ([ADSuyiSDKContainAd isValidControllerWithType:ADSuyiContainVcTypePush]) {
                    UIViewController *containViewController = [ADSuyiSDKContainAd containViewControllerWithType:(ADSuyiContainVcTypePush) withError:&error];
                    containViewController.tabBarItem.title = @"内容页";
                    containViewController.title = @"内容页";
                    containViewController.tabBarItem.image = [UIImage imageNamed:@"contain"];
                    containViewController.tabBarItem.selectedImage = [UIImage imageNamed:@"contain"];
                    [tabBarVc addChildViewController:blankNavVc];
                    // 如果无误
                    if (!error) {
                        [tabBarVc addChildViewController:containViewController];
                    }
                }
                
                [self.navigationController.navigationBar setHidden:YES];
                [self.navigationController pushViewController:tabBarVc animated:YES];
                break;
            }
            case 2:{
               //内容控制器作为子控制器
                // 判断返回控制器是否有效
                if ([ADSuyiSDKContainAd isValidControllerWithType:ADSuyiContainVcTypePush]) {
                    UIViewController *containViewController = [ADSuyiSDKContainAd containViewControllerWithType:(ADSuyiContainVcTypePush) withError:&error];
                    // 如果无误
                    if (!error) {
                        [self addChildViewController:containViewController];
                        [self.navigationController pushViewController:self.childViewControllers[0] animated:YES];
                    }
                }
                
                break;
            }
            default:
                break;
        }
    }else{
        // 推出方式：present
        switch (indexPath.row) {
            case 0:{
               //仅内容控制器 不建议使用present方式推出（显示时按钮点击 针对push有效）
                // 判断返回控制器是否有效
                if ([ADSuyiSDKContainAd isValidControllerWithType:ADSuyiContainVcTypePresent]) {
                    UIViewController *containViewController = [ADSuyiSDKContainAd containViewControllerWithType:(ADSuyiContainVcTypePresent) withError:&error];
                    // 如果无误
                    if (!error){
                        containViewController.modalPresentationStyle = UIModalPresentationFullScreen;
                        [self presentViewController:containViewController animated:YES completion:nil];
                    }
                }
                
                break;
            }
            case 1:{
               //带底部栏的内容控制器 一般使tabBar作为根控制器 此处示例作为present推出
                UITabBarController *tabBarVc = [[UITabBarController alloc]init];
                BlankViewController *blankVc = [[BlankViewController alloc]init];
                blankVc.tabBarItem.title = @"返回页";
                blankVc.tabBarItem.image = [UIImage imageNamed:@"blank"];
                blankVc.tabBarItem.selectedImage = [UIImage imageNamed:@"blank"];
                UINavigationController *blankNavVc = [[UINavigationController alloc]initWithRootViewController:blankVc];
                //若将内容SDK作为底部分页 无需为内容控制器添加导航栏
                // 判断返回控制器是否有效
                if ([ADSuyiSDKContainAd isValidControllerWithType:ADSuyiContainVcTypePresent]) {
                    UIViewController *containViewController = [ADSuyiSDKContainAd containViewControllerWithType:(ADSuyiContainVcTypePresent) withError:&error];
                    containViewController.tabBarItem.title = @"内容页";
                    containViewController.title = @"内容页";
                    containViewController.tabBarItem.image = [UIImage imageNamed:@"contain"];
                    containViewController.tabBarItem.selectedImage = [UIImage imageNamed:@"contain"];
                    [tabBarVc addChildViewController:blankNavVc];
                    // 如果无误
                    if (!error) {
                        [tabBarVc addChildViewController:containViewController];
                        tabBarVc.modalPresentationStyle = UIModalPresentationFullScreen;
                        [self presentViewController:tabBarVc animated:YES completion:nil];
                    }
                }
                
                break;
            }
            default:
                break;
        }
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 30;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UILabel *label = [[UILabel alloc]init];
    label.font = [UIFont systemFontOfSize:16];
    label.textColor = [UIColor adsy_colorWithHexString:@"#666666"];
    label.textAlignment = NSTextAlignmentCenter;
    if (section==0) {
        label.text = @"push方式接入";
    }else{
        label.text = @"present方式接入";
    }
    return label;
}

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
