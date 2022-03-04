//
//  UIViewController+TYTopView.h
//  TommyTemplate
//
//  Created by Tommy on 2017/5/3.
//  Copyright © 2017年 Tommy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (TYTopView)

+ (UIViewController * _Nullable)topViewController;
+ (UIViewController * _Nullable)jsd_getRootViewController;
+ (UIViewController * _Nullable)jsd_findVisibleViewController;
@end
