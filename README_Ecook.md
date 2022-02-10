## 菜谱内容接入文档 V1.0.0

## 修订历史

| 文档版本 | 修订日期   | 修订说明 |
| -------- | ---------- | -------- |
| v1.0.0   | 2021-10-12 | 首版发布 |
| v1.0.1   | 2022-01-12 | 部分功能优化 |

### 1、概述

尊敬的开发者您好，欢迎使用菜谱内容SDK，通过本文档您可以在几分钟之内轻松完成菜谱内容SDK的集成。

### 2、SDK的导入

1.推荐使用pod命令 (使用xcframework打包，需cocoapods版本1.9.0及以上版本,菜谱SDK内置广告需依赖ADSuyiSDK)

```rub
pod 'EcookSDK'
pod 'ADSuyiSDK','~>3.5.0.0' #必选
# 如不需广告，以下库为可选
pod 'ADSuyiSDK/ADSuyiSDKPlatforms/admobile'
pod 'ADSuyiSDK/ADSuyiSDKPlatforms/gdt'
pod 'ADSuyiSDK/ADSuyiSDKPlatforms/bu'
```

2.手动导入

ADSuyiSDK手动导入[参考](https://github.com/ADSuyi/ADSuyiSDKDemo-iOS)

EcookSDK[下载地址](http://121.41.108.203/adsuyi_kit/ecooksdk)

下载文件解压后将全部SDK导入项目。

### 3、工程环境配置

1.打开项目的 app target，查看 Build Settings 中的 Linking-Other Linker Flags 选项，确保含有 -ObjC 一值， 若没有则添加。

2.在项目的 app target 中，查看 Build Settings 中的 Build options - Enable Bitcode 选项， 设置为NO。 

3.在info.plist添加支持http访问字段

```objective-c
<key>NSAppTransportSecurity</key>
<dict>
<key>NSAllowsArbitraryLoads</key>
<true/>
</dict>
```

### 4、SDK的初始化

```objective-c
// EcookSDK初始化
[EcookSDKManager initWithConfig:@{
@"appid":@"100602",
@"appkey":@"29e1eb7f0710e44be02694e66f4e9272"}];

// 设置菜谱SDK内广告位id（仅支持插屏，横幅，信息流广告）
EcookSDKManager.intertitialAdPosId = @"9535af29514e548fe0";//插屏广告位
EcookSDKManager.bannerAdPosId = @"9ca1e179e38ca5a35c";//横幅广告位
EcookSDKManager.nativeAdPosId = @"e9eaffb6b9d97cd813";//原生信息流广告位
```

注意：初次初始化SDK 可能因网络权限获取等原因导致SDK初始化失败，SDK初始化失败，接入菜谱内容控制器将无法显示数据。**建议在接入时对SDK初始化状态做判断。**

### 5、菜谱内容SDK

```objective-c
// 返回控制器类型
typedef NS_ENUM(NSUInteger, EcookControllerType) {
    EcookControllerTypePresent,
    EcookControllerTypePush,
    EcookControllerTypeTabBar,
};

@interface EcookSDKManager : NSObject
// e.g. @{@"appid":@"xxxx",@"appkey":@"xxxx"};
+ (void)initWithConfig:(NSDictionary *)configInfo;

// 获取菜谱SDK返回的首页控制器
+ (UIViewController *)getViewControllerWithType:(EcookControllerType)type;

/// banner广告位id（搜索页热门搜索）
@property (nonatomic, copy, class) NSString *bannerAdPosId;

/// 信息流广告位id（首页，分类，结果页）
@property (nonatomic, copy, class) NSString *nativeAdPosId;

/// 插屏广告位id（首页）
@property (nonatomic, copy, class) NSString *intertitialAdPosId;



@end

```



### 6、接入方式

```objective-c
//1、以present方式推出
EcookHomeViewController *vc = [EcookHomeViewController new];
// 首页是否展示返回按钮
vc.showBackButton = YES;
UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
nvc.navigationBarHidden = YES;
nvc.modalPresentationStyle = UIModalPresentationFullScreen;
[self presentViewController:nvc animated:YES completion:nil];

// 2、以push方式推出
EcookHomeViewController *vc = [EcookHomeViewController new];
vc.showBackButton = YES;
[self.navigationController pushViewController:vc animated:YES];

// 3、作为tabbar子控制器
UITabBarController *tc = [UITabBarController new];
tc.modalPresentationStyle = UIModalPresentationFullScreen;
    
UIViewController *fvc = [UIViewController new];
fvc.view.backgroundColor = [UIColor whiteColor];
fvc.tabBarItem.title = @"测试";
    
EcookHomeViewController *evc = [EcookHomeViewController new];
evc.showBackButton = NO;

UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:evc];
nvc.navigationBarHidden = YES;
nvc.tabBarItem.title = @"菜谱";
nvc.hidesBottomBarWhenPushed = YES;
tc.viewControllers = @[fvc, nvc];

        
```







