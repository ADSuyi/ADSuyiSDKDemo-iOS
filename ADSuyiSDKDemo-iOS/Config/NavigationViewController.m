//
//  NavigationBarViewController.m
//  ADSuyiDev
//
//  Created by Erik on 2021/4/19.
//

#import "NavigationViewController.h"

@interface NavigationViewController ()

@end

@implementation NavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.barTintColor
    = [UIColor colorWithRed:36/255.0 green:132/255.0 blue:207/255.0 alpha:1];
    // Do any additional setup after loading the view.
    [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    if (@available(iOS 13.0, *)) {
            [self.navigationBar.standardAppearance configureWithOpaqueBackground];
            self.navigationBar.standardAppearance.backgroundColor = [UIColor colorWithRed:36/255.0 green:132/255.0 blue:207/255.0 alpha:1];
            [self.navigationBar.standardAppearance setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:[UIColor whiteColor]}];
            self.navigationBar.scrollEdgeAppearance= self.navigationBar.standardAppearance;
            
        } else {
            // Fallback on earlier versions
            self.navigationBar.barTintColor = [UIColor colorWithRed:36/255.0 green:132/255.0 blue:207/255.0 alpha:1];
            [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:[UIColor whiteColor]}];
        }
}

- (void)backBtnclick {
    [self popViewControllerAnimated:YES];
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
