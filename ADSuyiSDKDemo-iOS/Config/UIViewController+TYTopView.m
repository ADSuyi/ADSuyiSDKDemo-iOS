//
//  UIViewController+TYTopView.m
//  TommyTemplate
//
//  Created by Tommy on 2017/5/3.
//  Copyright © 2017年 Tommy. All rights reserved.
//

#import "UIViewController+TYTopView.h"

@implementation UIViewController (TYTopView)

+ (UIViewController *)topViewController {
    UIViewController *vc = [self rootTopViewController];
    return [self topViewController:vc];
}

+ (UIViewController *)rootTopViewController {
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    if (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}

+ (UIViewController *)topViewController:(UIViewController *)rootViewController {
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabVC = (UITabBarController *)rootViewController;
        UIViewController *ctl = tabVC.selectedViewController;
        if ([ctl isKindOfClass:[UINavigationController class]]) {
            return ((UINavigationController *)ctl).visibleViewController;
        } else {
            return rootViewController.presentedViewController ? rootViewController.presentedViewController : rootViewController;
        }
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        return ((UINavigationController *)rootViewController).visibleViewController;
    } else {
        return rootViewController.presentedViewController ? rootViewController.presentedViewController : rootViewController;
    }
}
#pragma mark -- 获取根控制器 --
+ (UIViewController *)jsd_getRootViewController{

    UIWindow* window = [[[UIApplication sharedApplication] delegate] window];
    NSAssert(window, @"The window is empty");
    return window.rootViewController;
}
#pragma mark -- 获取当前控制器 --
+ (UIViewController *)jsd_findVisibleViewController {
    
    UIViewController* currentViewController = [UIViewController jsd_getRootViewController];

    BOOL runLoopFind = YES;
    while (runLoopFind) {
        if (currentViewController.presentedViewController) {
            currentViewController = currentViewController.presentedViewController;
        } else {
            if ([currentViewController isKindOfClass:[UINavigationController class]]) {
                currentViewController = ((UINavigationController *)currentViewController).visibleViewController;
            } else if ([currentViewController isKindOfClass:[UITabBarController class]]) {
                currentViewController = ((UITabBarController* )currentViewController).selectedViewController;
            } else {
                break;
            }
        }
    }
    
    return currentViewController;
}
@end
