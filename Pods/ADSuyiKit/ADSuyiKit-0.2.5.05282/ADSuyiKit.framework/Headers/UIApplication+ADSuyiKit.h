//
//  UIApplication+ADSuyiKit.h
//  ADSuyiKit
//
//  Created by 陈坤 on 2020/3/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIApplication (ADSuyiKit)

/// app是否是盗版(不是从app store下载的)
@property (nonatomic, readonly) BOOL adsy_isPirated;

/// app是否正在被调试
@property (nonatomic, readonly) BOOL adsy_isBeingDebugged;

/// 应用版本
@property (nonatomic, readonly) NSString *adsy_appVersion;

/// 包名
@property (nonatomic, readonly) NSString *adsy_appBundleId;

//  app名称
@property (nonatomic, readonly) NSString *adsy_appBundleName;

/// "Documents"在沙盒中文件夹路径
@property (nonatomic, readonly) NSURL *adsy_documentsURL;
@property (nonatomic, readonly) NSString *adsy_documentsPath;

/// "Caches"在沙盒中文件夹路径
@property (nonatomic, readonly) NSURL *adsy_cachesURL;
@property (nonatomic, readonly) NSString *adsy_cachesPath;

/// "Library"在沙盒中文件夹路径
@property (nonatomic, readonly) NSURL *adsy_libraryURL;
@property (nonatomic, readonly) NSString *adsy_libraryPath;

/// 应用当前展示的控制器
@property (nonatomic, readonly, nullable) UIViewController *adsy_viewController;

@end

NS_ASSUME_NONNULL_END
