//
//  PlatformTableViewController.h
//  ADSuyiDev
//
//  Created by Erik on 2021/4/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PlatformTableViewController : UITableViewController
@property (nonatomic, copy) void (^selectedBlock)(NSString *platorm);
@end

NS_ASSUME_NONNULL_END
