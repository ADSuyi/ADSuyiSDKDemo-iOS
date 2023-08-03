# Admobile ADSuyiSDK iOS接入文档 v3.7.7.07141


## 修订历史

[SDK版本更新日志](https://doc.admobile.top/ssp/4changelog/2-iOSchangelog.html)
<div STYLE="page-break-after: always;"></div>


## 1.1 概述

尊敬的开发者朋友，欢迎您使用ADmobile 苏伊士广告SDK。通过本文档，您可以在几分钟之内轻松完成广告的集成过程。

操作系统： iOS 10.0 及以上版本

运行设备：iPhone （iPad上可能部分广告正常展示，但是存在填充很低或者平台不支持等问题，建议不要在iPad上展示广告，穿山甲等平台开屏广告iPad端展示异常）

- `Github: ADSuyiSDK Objective-C Demo地址`[[ADSuyiSDK Objective-C Demo]](https://github.com/ADSuyi/ADSuyiSDKDemo-iOS)
- `Gitee:ADSuyiSDK Objective-C Demo地址`[[ADSuyiSDK Objective-C Demo]](https://gitee.com/admobile/ADSuyiSDKDemo-iOS)
- `Github: ADSuyiSDK Swift Demo地址`[[ADSuyiSDK Swift Demo]](https://github.com/ADSuyi/ADSuyiSDKDemo-iOS-Swift)
- `Gitee: ADSuyiSDK Swift Demo地址`[[ADSuyiSDK Swift Demo]](https://gitee.com/admobile/ADSuyiSDKDemo-iOS-Swift)



## 1.2 ADSuyiSDK&三方广告平台适配器版本(以日志输出为准)

| Name         | 版本号      |  
|--------------|-------------|           
| ADSuyiSDK | 3.7.7.07141 |    
| tianmu | 2.0.7.1.02202 | 
| baidu | 5.31.05231 |    
| gdt | 4.14.32.05231 |    
| ksad | 3.3.49.1.07141 |    
| mintegral | 7.3.9.07141 |    
| toutiao | 5.4.0.5.05231 | 
| gromore | 4.3.0.1.1.07141 | 
                  

## 2.1 采用cocoapods进行SDK的导入

推荐使用pod命令，使用[集成工具](https://app.admobile.top/#/adsdk/adsdk)获取导入命令

```ruby
// 挑选在苏伊士托管的平台导入项目，请不要导入全部，如果不清楚需要哪些平台可以咨询媒介
pod 'ADSuyiSDK','~> 3.7.7.07141' # 主SDK 必选
pod 'ADSuyiSDK/ADSuyiSDKPlatforms/tianmu' # 天目  #必选
pod 'ADSuyiSDK/ADSuyiSDKPlatforms/bu' # 穿山甲(头条)
pod 'ADSuyiSDK/ADSuyiSDKPlatforms/gdt' # 优量汇(广点通）
pod 'ADSuyiSDK/ADSuyiSDKPlatforms/baidu' # 百度
pod 'ADSuyiSDK/ADSuyiSDKPlatforms/ks' # 快手(非内容版本，内容与非内容版本不可同时导入)
pod 'ADSuyiSDK/ADSuyiSDKPlatforms/ksfull' # 快手(内容版本)
pod 'ADSuyiSDK/ADSuyiSDKPlatforms/mtg'     # Mobvista(汇量)
pod 'ADSuyiSDK/ADSuyiSDKPlatforms/gromore' # gromore
pod 'ADSuyiSDK/ADSuyiSDKPlatforms/inmobi' # Inmobi

```

<div STYLE="page-break-after: always;"></div>


### 2.1.1 注意事项

`pod 'ADSuyiSDK/ADSuyiSDKPlatforms/xxxx'` 默认集成了一个固定版本的三方SDK，如果因为项目中也使用了相同的三方广告SDK而发生冲突，可通过以下方法尝试避免或解决；


- 通过 Pod 我们的 __xxx-without__ 依赖，该方式没有绑定三方广告SDK，开发者可自行集成三方广告SDK，但是需要注意，我们的AdapterSdk是基于三方广告SDK某个版本开发的，如果自行集成三方广告SDK，需要承担三方广告SDK版本不一致可能引起的兼容性和其他不可预知问题；



    ```
    # 例如：
    
    pod 'ADSuyiSDK/ADSuyiSDKPlatforms/gdt-without'        # 优量汇(广点通）
    
    ```



## 2.2 手动导入SDK方式

[点击进入SDK下载地址](https://doc.admobile.top/iOSSDK/ADSuyi_iOS_37707141_9ca01ee1dd437c09b0024eb2fd644c0d.zip)下载各SDK拖入到工程中

手动方式导入,需要添加如下依赖库:

```obj-c
AdSupport.framework
CoreLocation.framework
QuartzCore.framework
SystemConfiguration.framework
CoreTelephony.framework
libz.tbd
libc++.tbd
libresolv.9.tbd
WebKit.framework (Optional)
libxml2.tbd
Security.framework
StoreKit.framework
AVFoundation.framework
CoreMedia.framework
```

头条还需要添加依赖库：

```obj-c
DeviceCheck.framework
Accelerate.framework
AudioToolbox.framework
CoreGraphics.framework
CoreImage.framework
CoreMotion.framework
CoreText.framework
ImageIO.framework
JavaScriptCore.framework
MapKit.framework
MediaPlayer.framework
MobileCoreServices.framework
UIKit.framework
libbz2.tbd
libiconv.tbd
libsqlite3.tbd
libc++abi.tbd
```

<div STYLE="page-break-after: always;"></div>

<div STYLE="page-break-after: always;"></div>




## 3.1 工程环境配置

1. 打开项目的 app target，查看 Build Settings 中的 Linking-Other Linker Flags 选项，确保含有 -ObjC 一值， 若没有则添加。

2. 在项目的 app target 中，查看 Build Settings 中的 Build options - Enable Bitcode 选项， 设置为NO。 
3. 苹果公司在iOS9中升级了应用网络通信安全策略，默认推荐开发者使用HTTPS协议来进行网络通信，并限制HTTP协议的请求。为了避免出现无法拉取到广告的情况，我们推荐开发者在info.plist文件中增加如下配置来实现广告的网络访问：（信任HTTP请求）

```obj-c
<key>NSAppTransportSecurity</key>
<dict>
<key>NSAllowsArbitraryLoads</key>
<true/>
</dict>
```

4. SDK 不会主动获取应用位置权限，当应用本身有获取位置权限逻辑时，需要在应用的 info.plist 添加相应配置信息，避免 App Store 审核被拒：

```obj-c
Privacy - Location When In Use Usage Description
Privacy - Location Always and When In Use Usage Description
Privacy - Location Always Usage Description
```

5. Info.plist 添加获取本地网络权限字段
    ```obj-c
    <key>Privacy - Local Network Usage Description</key>
    <string>广告投放及广告监测归因、反作弊</string>
    <key>Bonjour services</key>
    <array>
        <string>_apple-mobdev2._tcp.local</string>
   </array>
    ```

6. Info.plist推荐设置白名单，可提高广告收益

```obj-c
<key>LSApplicationQueriesSchemes</key>
    <array>
        <!--  电商及生活   -->
        <string>com.suning.SuningEBuy</string> <!--  苏宁  -->
        <string>openapp.jdmobile</string> <!--  京东  -->  
        <string>openjd</string> <!--  京东  --> 
        <string>jdmobile</string> <!--  京东  --> 
        <string>vmall</string>
        <string>vipshop</string>  <!--  维品汇  -->  
        <string>suning</string> <!--  苏宁  --> 
        <string>yohobuy</string> <!--  有货  --> 
        <string>kaola</string> <!--  网易考拉  --> 
        <string>yanxuan</string> <!--  网易严选  --> 
        <string>wbmain</string>  <!--  58同城  --> 
        <string>dianping</string>  <!--  大众点评  --> 
        <string>imeituan</string>  <!--  美团  --> 
        <string>beibeiapp</string> <!--  贝贝  --> 
        <string>taobao</string> <!--  淘宝  --> 
        <string>tmall</string>  <!--  天猫  --> 
        <string>wireless1688</string> <!--  阿里巴巴1688  --> 
        <string>tbopen</string> <!--  淘宝  --> 
        <string>taobaolite</string> <!-- 淘特   --> 
        <string>taobaoliveshare</string> <!--  淘宝直播  --> 
        <string>koubei</string> <!--  口碑  --> 
        <string>eleme</string> <!--  饿了么  --> 
        <string>alipays</string> <!--  支付宝  --> 
        <string>kfcapplinkurl</string> <!--  KFC  --> 
        <string>pddopen</string> <!--  拼多多  --> 
        <string>pinduoduo</string> <!--  拼多多  --> 
        <string>mogujie</string> <!--  蘑菇街  --> 
        <string>lianjiabeike</string> <!--  链家贝壳  --> 
        <string>lianjia</string> <!--  链家  --> 
        <string>openanjuke</string> <!--  安居客  --> 
        <string>zhuanzhuan</string> <!--  转转  --> 
        <string>farfetchCN</string> <!--  发发奇全球时尚购物  --> 
        <!--  社交社区  --> 
        <string>weibo</string> <!--  微博  --> 
        <string>xhsdiscover</string> <!--  小红书  --> 
        <string>uclink</string> <!--  uc浏览器  --> 
        <string>momochat</string> <!--  陌陌  --> 
        <string>blued</string> <!--  Blued  --> 
        <string>zhihu</string> <!--  知乎  --> 
        <string>baiduboxapp</string> <!--  手机百度  --> 
        <string>yidui</string> <!--  伊对  --> 
        <!--  资讯及阅读  -->    
        <string>sinanews</string> <!--  新浪新闻  --> 
        <string>snssdk141</string> <!--  今日头条  --> 
        <string>newsapp</string> <!--  网易新闻  --> 
        <string>igetApp</string> <!--  得到  -->  
        <string>kuaikan</string> <!--  快看漫画  --> 
        <!--  短视频及音乐  -->         
        <string>youku</string> <!--  优酷  --> 
        <string>snssdk1128</string> <!--  抖音  --> 
        <string>gifshow</string> <!--  快手  --> 
        <string>snssdk1112</string> <!--  火山  --> 
        <string>miguvideo</string> <!--  咪咕视频  --> 
        <string>iqiyi</string> <!--  爱奇艺  --> 
        <string>bilibili</string> <!--  B站  -->   
        <string>tenvideo</string> <!--  腾讯视频  --> 
        <string>baiduhaokan</string> <!--  百度好看  --> 
        <string>yykiwi</string> <!--  虎牙直播  --> 
        <string>qqmusic</string> <!--  qq音乐  -->  
        <string>orpheus</string> <!--  网易云音乐  --> 
        <string>kugouURL</string> <!--  酷狗  -->   
        <string>qmkege</string> <!--  全民K歌  -->  
        <string>changba</string> <!--  唱吧  --> 
        <string>iting</string> <!--  喜马拉雅  --> 
        <!--  出行  -->                 
        <string>ctrip</string> <!--  携程  --> 
        <string>QunarAlipay</string> <!--  去哪儿旅行  --> 
        <string>diditaxi</string> <!--  滴滴出行  --> 
        <string>didicommon</string> <!--  滴滴出行  --> 
        <string>taobaotravel</string> <!--  飞猪  --> 
        <string>OneTravel</string> <!--  海南航空  --> 
        <string>kfhxztravel</string> <!--  花小猪  --> 
        <!--  医美  -->             
        <string>gengmei</string> <!--  更美  --> 
        <string>app.soyoung</string> <!--  新氧医美  --> 
    </array>
```



## 3.2 iOS14适配

由于iOS14中对于权限和隐私内容有一定程度的修改，而且和广告业务关系较大，请按照如下步骤适配，如果未适配。不会导致运行异常或者崩溃等情况，但是会一定程度上影响广告收入。敬请知悉。

1. 应用编译环境升级至 Xcode 12.0 及以上版本；
2. 升级ADSuyiSDK 3.1.5及以上版本；
3. 设置SKAdNetwork和IDFA权限；



### 3.2.1 获取App Tracking Transparency授权（弹窗授权获取IDFA）

从 iOS 14 开始，在应用程序调用 App Tracking Transparency 向用户提跟踪授权请求之前，IDFA 将不可用。

1. 更新 Info.plist，添加 NSUserTrackingUsageDescription 字段和自定义文案描述。

   弹窗小字文案建议：

   - `获取标记权限向您提供更优质、安全的个性化服务及内容，未经同意我们不会用于其他目的；开启后，您也可以前往系统“设置-隐私 ”中随时关闭。`
   - `获取IDFA标记权限向您提供更优质、安全的个性化服务及内容；开启后，您也可以前往系统“设置-隐私 ”中随时关闭。`

```objective-c
<key>NSUserTrackingUsageDescription</key>
<string>获取标记权限向您提供更优质、安全的个性化服务及内容，未经同意我们不会用于其他目的；开启后，您也可以前往系统“设置-隐私 ”中随时关闭</string>
```

2. 向用户申请权限。

```objective-c
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <AdSupport/AdSupport.h>
...
- (void)requestIDFA {
  [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
    // 无需对授权状态进行处理
  }];
}
// 建议启动App用户同意协议后就获取权限或者请求广告前获取
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
         // 针对iOS15中不弹窗被拒解决方案，方案1：经测试可能无效
    //dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)),             dispatch_get_main_queue(), ^{
            // 用户同意协议后获取
                      //[self requestIDFA];
        //});
}
// 方案2：根据官方文档调整权限申请时机
// 根据官方开发文档选择在此方法中进行权限申请
- (void)applicationDidBecomeActive:(UIApplication *)application {
    // 用户同意协议后获取
      [self requestIDFA];
}
// 建议方案1与2一起使用，可正常通过审核。
```

<div STYLE="page-break-after: always;"></div>



### 3.2.2 SKAdNetwork

SKAdNetwork 是接收iOS端营销推广活动归因数据的一种方法。

1. 将下列SKAdNetwork ID 添加到 info.plist 中，以保证 SKAdNetwork 的正确运行。根据对接平台添加相应SKAdNetworkID，若无对接平台SKNetworkID则无需添加。

```xml
<key>SKAdNetworkItems</key>
  <array>
    // 穿山甲广告（ADSuyiBU）
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>238da6jt44.skadnetwork</string>
    </dict>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>22mmun2rn5.skadnetwork</string>
    </dict>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>x2jnk7ly8j.skadnetwork</string>
    </dict>
    // 优量汇广告（ADSuyiGDT）
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>f7s53z58qe.skadnetwork</string>
    </dict>
    // 汇量广告（ADSuyiMTG）
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>KBD757YWX3.skadnetwork</string>
    </dict>
    // 汇量广告 合作伙伴（ADSuyiMTG）
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>wg4vff78zm.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>737z793b9f.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>ydx93a7ass.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>prcb7njmu6.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>7UG5ZH24HU.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>44jx6755aq.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>2U9PT9HC89.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>W9Q455WK68.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>YCLNXRL5PM.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>TL55SBB4FM.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>8s468mfl3y.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>GLQZH8VGBY.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>c6k4g5qg8m.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>mlmmfzh3r3.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>4PFYVQ9L8R.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>av6w8kgt66.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>6xzpu9s2p8.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>hs6bdukanm.skadnetwork</string>
    </dict>
  </array>
```

<div STYLE="page-break-after: alway;"></div>

## 4.1 集合SDK的初始化

`申请的appid必须与您的包名一一对应`


```obj-c
// SDK 初始化, 需在主线程初始化
// 目前Xcode会有一个线程提示，由优量汇初始化代码触发，可以忽略，并不会引起任何阻塞（后续会跟进优量汇优化提示）
[ADSuyiSDK initWithAppId:@"3427764" completionBlock:^(NSError * _Nonnull error) {
    if (error) {
        NSLog(@"SDK 初始化失败：%@", error.localizedDescription);
    }
}];
```

用户日志输出等级

```obj-c
添加头文件
#import <ADSuyiKit/ADSuyiKitLogging.h>

// 设置日志输出等级
[ADSuyiSDK setLogLevel:ADSuyiKitLogLevelDebug];
```

获取ADSuyiSDK版本号

```obj-c
//获取SDK版本号
NSString *sdkVersion = [ADSuyiSDK getSDKVersion];
```

<div STYLE="page-break-after: always;"></div>

## 4.2 个性化开关

ADSuyi的个性化开关可统一控制第三方广告SDK的个性化开关接口，目前支持天目、穿山甲、优量汇、百度、快手、汇量、Gromore;

```obj-c
// 是否开启个性化广告；默认YES，建议初始化SDK之前设置
ADSuyiSDK.enablePersonalAd = NO;
```

<div STYLE="page-break-after: always;"></div>



## 4.3 开屏广告 - ADSuyiSDKSplashAd

开屏广告会在您的应用开启时加载展示，拥有固定展示时间，展示完毕后自动关闭并进入您的应用主界面。

开屏广告建议在闪屏页进行展示，开屏广告的宽度和高度取决于容器的宽高，都是会撑满广告容器；**开屏广告的高度必须大于等于屏幕高度（手机屏幕完整高度，包括状态栏之类）的75%**，否则可能会影响收益计费。

推荐在 `AppDelegate`的 `didFinishLaunchingWithOptions`方法的 `return YES`之前调用开屏。

- `Github: OC请求开屏代码示例：`[[开屏代码示例]](https://github.com/ADSuyi/ADSuyiSDKDemo-iOS/blob/master/ADSuyiSDKDemo-iOS/AppDelegate.m)
- `Gitee : OC请求开屏代码示例：`[[开屏代码示例]](https://gitee.com/admobile/ADSuyiSDKDemo-iOS/blob/master/ADSuyiSDKDemo-iOS/AppDelegate.m)

- `Github: Swift请求开屏代码示例：`[[开屏代码示例]](https://github.com/ADSuyi/ADSuyiSDKDemo-iOS-Swift/blob/master/ADSuyiSDKDemo-iOS-Swift/AppDelegate.swift)
- `Gitee : Swift请求开屏代码示例：`[[开屏代码示例]](https://gitee.com/admobile/ADSuyiSDKDemo-iOS-Swift/blob/master/ADSuyiSDKDemo-iOS-Swift/AppDelegate.swift)

 **ADSuyiSDKSplashAd**: 开屏广告的加载类
| <center>属性</center> | <center>类型</center>  | <center>说明</center>|
|:-----------|:--|:--------|
| delegate | id\<ADSuyiSDKSplashAdDelegate> | 委托对象 |
| controller | UIViewController | [必选]开发者需传入用来弹出目标页的ViewController，一般为当前ViewController  |
| posId | NSString | 广告位id  |
| scenesId | NSString | 场景id（可选）  |
| backgroundColor | UIColor | 开屏的默认背景色,或者启动页,为nil则代表透明  |
| userId | NSString | 用户id （用户在App内的userID，用于激励视频服务器验证，如无需服务器验证可不传）  |
| extra | NSString | 其他信息 （服务器端验证回调中包含的可选自定义奖励字符串，可选）  |
| tolerateTimeout | NSInteger | 开屏请求总超时时间 |
| zoomOutViewDelegate | id\<ADSuyiSDKSplashAdZoomOutViewDelegate> | zoomOutView代理回调(如果需要支持广点通v+视频开屏广告，需要实现此协议，其他情况暂时不需要实现) |
| splashZoomOutView | UIView\<ADSuyiSDKSplashAdZoomOutViewProtocol> | 当广告命中开屏视频V+时，会存在 |

| <center>接口</center> | <center>说明</center>|
|:-----------|:--------|
| setBottomSplashWithSuyiPosid: platformListId: platform: appId: appKey: platformPosid: renderType: | 设置保底开屏 <br>支持平台：穿山甲、优量汇、快手、百度、汇量 （可选） |
| loadAndShowInWindow: | 加载并展示开屏广告 |
| loadAndShowInWindow: withBottomView: | 加载并展示开屏广告；底部logo视图, 高度不能超过屏幕的25%，可传nil |
| loadAdInWindow: | 加载开屏广告 |
| loadAdInWindow: withBottomView: | 加载开屏广告；底部logo视图, 高度不能超过屏幕的25%，可传nil |
| showAdInWindow: | 展示开屏广告 |
| rewardAdCanServerVerrify | 开屏广告是否支持服务端验证<br>支持平台：优量汇 |


**ADSuyiSDKSplashAdDelegate**：开屏代理方法
| <center>回调函数</center> | <center>回调说明</center>|
|:-----------|:--------|
| adsy_splashAdSuccessToLoadAd: | 开屏加载成功  |
| adsy_splashAdSuccessToPresentScreen: | 开屏展示成功  |
| adsy_splashAdFailToPresentScreen: | 开屏展示失败  |
| adsy_splashAdEffective: | 开屏曝光  |
| adsy_splashAdClicked: | 开屏点击  |
| adsy_splashAdClosed: | 开屏关闭  |
| adsy_splashAdCloseLandingPage: | 开屏关闭落地页  |
| adsy_splashAdDidRewardEffective: info: | 开屏达到激励条件 （开启服务器验证后请使用服务端验证判断是否达到条件，无需使用本回调做激励达成判断） 备注：仅支持优量汇平台 |

**ADSuyiSDKSplashAdZoomOutViewDelegate**：v+开屏代理方法
| <center>回调函数</center> | <center>回调说明</center>|
|:-----------|:--------|
| adsy_splashZoomOutViewDidClick:splashZoomOutView: | ZoomOutView 点击  |
| adsy_splashZoomOutViewAdDidClose:splashZoomOutView: | ZoomOutView 关闭  |
| adsy_splashZoomOutViewAdVideoFinished:splashZoomOutView: | ZoomOutView 播放完成 |
| adsy_splashZoomOutViewAdDidPresentFullScreenModal:splashZoomOutView: | ZoomOutView 进入视频详情页 |
| adsy_splashZoomOutViewAdDidDismissFullScreenModal:splashZoomOutView:| ZoomOutView 退出视频详情页 |


```obj-c
特殊说明
/** 
 开屏请求总超时时间:所有平台轮询的请求等待总时长（不包括图片渲染时间），单位秒，推荐设置为4s，最小值为3s
 开屏各平台分配逻辑:(目前只有开屏需要分配时间，并且理论上分配给到各平台的超时时间不会完全耗尽)
 1、3<=tolerateTimeout<=4:轮询首位平台的超时时间为(tolerateTimeout-1)s，次位为2s，如果后续还有平台统一为1s;
 2、tolerateTimeout>=5:轮询首位平台的超时时间为(tolerateTimeout-2)s，次位为3s，如果后续还有平台统一为2s;
 */

```

- `Github: Swift请求开屏广告代码示例：`[[开屏代码示例]](https://github.com/ADSuyi/ADSuyiSDKDemo-iOS-Swift/blob/master/ADSuyiSDKDemo-iOS-Swift/AppDelegate.swift)
- `Gitee: Swift请求开屏广告代码示例：`[[开屏代码示例]](https://gitee.com/admobile/ADSuyiSDKDemo-iOS-Swift/blob/master/ADSuyiSDKDemo-iOS-Swift/AppDelegate.swift)

OC请求开屏广告代码示例：

```obj-c
#import <ADSuyiSDK/ADSuyiSDKSplashAd.h>
#import <ADSuyiKit/ADSuyiKit.h>

/*
 * 推荐在AppDelegate中的最后加载开屏广告
 * 其他的接入方式会有需要特殊注意的方式，遇到过的相关问题在SDK相关问题的文档中有提到
 * 不建议在开屏展示过程中做控制器的切换（如：开屏广告关闭回调时切换当前window的根控制器或者present另外一个控制器）
 * SUPPORT_SPLASH_ZOOMOUT，是否需要支持V+视频开屏广告取决于开发者，不选择v+开屏则可以不去适配
 */

- (void)loadSplashAd{
    // 1、初始化开屏广告实例对象
    self.splashAd = [[ADSuyiSDKSplashAd alloc]init];
    self.splashAd.delegate = self;
#ifdef SUPPORT_SPLASH_ZOOMOUT
    self.splashAd.zoomOutViewDelegate = self;
#endif
    self.splashAd.controller = _window.rootViewController;
    // 2、设置开屏的广告位id
    self.splashAd.posId = @"d11c2ef29dcb7e6e62";
    /**
    开屏请求总超时时间:所有平台轮询的请求等待总时长（不包括图片渲染时间），单位秒，推荐设置为4s，最小值为3s
    开屏各平台分配逻辑:(目前只有开屏需要分配时间，并且理论上分配给到各平台的超时时间不会完全耗尽)
    1、3<=tolerateTimeout<=4:轮询首位平台的超时时间为(tolerateTimeout-1)s，次位为2s，如果后续还有平台统一为1s;
    2、tolerateTimeout>=5:轮询首位平台的超时时间为(tolerateTimeout-2)s，次位为3s，如果后续还有平台统一为2s;
    */
    self.splashAd.tolerateTimeout = 4;
    // 3、设置默认启动图(一般设置启动图的平铺颜色为背景颜色，使得视觉效果更加平滑)
    self.splashAd.backgroundColor = [UIColor adsy_getColorWithImage:[UIImage imageNamed:@"750x1334.png"] withNewSize:[UIScreen mainScreen].bounds.size];
    
    // 4、开屏广告机型适配
    CGFloat bottomViewHeight = [UIScreen mainScreen].bounds.size.height * 0.15;
    
    // 5、底部视图设置，非必选项
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    bottomView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, bottomViewHeight);
    UIImageView *logoImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ADMob_Logo.png"]];
    logoImageView.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-135)/2, (bottomViewHeight-46)/2, 135, 46);
    [bottomView addSubview:logoImageView];
  // 6、设置开屏保底逻辑（可选）
    /**
     *功能说明：App在首次启动时，需要先请求获取广告位配置文件后，然后再去请求开屏广告，也就是首次加载开屏广告时需要两次串行网络请求，因此很容易因超时导致开屏广告展示失败。
     *解决方案：为避免开屏超时问题，开放此设置给开发者，开发者可以根据实际需求选择一家广告平台，通过API接口将必需参数传递给Suyi聚合SDK。（该设置只能指定一家广告平台，并且首次启动时只会请求该平台的广告，但App首次开屏广告将不受ADmobile后台控制，包括下载提示，广告位关闭。）
     *该设置仅会在首次加载开屏广告时，SDK会使用开发者传入的参数进行广告请求，同时获取后台配置文件的广告配置信息缓存到本地（首次请求广告平台广告和获取配置信息时并发进行），后续的开屏广告将按照缓存缓存的后台广告位配置顺序进行开屏广告请求。
     *支持穿山甲、优量汇、快手、百度、汇量
     */
    [self.splashAd setBottomSplashWithSuyiPosid:@"73128265daffdd6a1d" platformListId:@"3827" platform:@"ksad" appId:@"90010" appKey:nil platformPosid:@"4000000041" renderType:ADSuyiSplashRenderTypeExpressPro];
    // 7、加载开屏广告
    [self.splashAd loadAndShowInWindow:_window withBottomView:bottomView];
}

// 8、代理回调
#pragma mark - ADSuyiSDKSplashAdDelegate
/**
 开屏展现成功
 
 @param splashAd 广告实例
 */
- (void)adsy_splashAdSuccessToPresentScreen:(ADSuyiSDKSplashAd *)splashAd{
#ifdef SUPPORT_SPLASH_ZOOMOUT
    if(splashAd.splashZoomOutView) {
        UIViewController *rootVc = [UIApplication sharedApplication].keyWindow.rootViewController;
        [rootVc.view addSubview:splashAd.splashZoomOutView];
    }
#endif
}

/**
 开屏展现失败
 
 @param splashAd 广告实例
 @param error 具体错误信息
 */
- (void)adsy_splashAdFailToPresentScreen:(ADSuyiSDKSplashAd *)splashAd failToPresentScreen:(ADSuyiAdapterErrorDefine *)error{
    _splashAd = nil;
}

/**
 开屏广告点击
 
 @param splashAd 广告实例
 */
- (void)adsy_splashAdClicked:(ADSuyiSDKSplashAd *)splashAd{
    
}

/**
 开屏被关闭
 
 @param splashAd 广告实例
 */
- (void)adsy_splashAdClosed:(ADSuyiSDKSplashAd *)splashAd{
#ifdef SUPPORT_SPLASH_ZOOMOUT
    if(_splashAd.splashZoomOutView == nil)
        _splashAd = nil;
#else
    _splashAd = nil;
#endif
}

/**
 开屏展示
 
 @param splashAd 广告实例
 */
- (void)adsy_splashAdEffective:(ADSuyiSDKSplashAd *)splashAd{
    
}

#ifdef SUPPORT_SPLASH_ZOOMOUT

#pragma mark - ADSuyiSDKSplashAdZoomOutViewDelegate

/**
 ZoomOutView被点击
 */
- (void)adsy_splashZoomOutViewDidClick:(ADSuyiSDKSplashAd *)splashAd
                     splashZoomOutView:(__kindof UIView <ADSuyiSDKSplashAdZoomOutViewProtocol>*)splashZoomOutView {
    
}

/**
 ZoomOutView 被关闭
 */
- (void)adsy_splashZoomOutViewAdDidClose:(ADSuyiSDKSplashAd *)splashAd
                       splashZoomOutView:(__kindof UIView <ADSuyiSDKSplashAdZoomOutViewProtocol>*)splashZoomOutView {
    
}

/**
 ZoomOutView 播放完成
 */
- (void)adsy_splashZoomOutViewAdVideoFinished:(ADSuyiSDKSplashAd *)splashAd
                            splashZoomOutView:(__kindof UIView <ADSuyiSDKSplashAdZoomOutViewProtocol>*)splashZoomOutView {
    
}

/**
 ZoomOutView 进入视频详情页
 */
- (void)adsy_splashZoomOutViewAdDidPresentFullScreenModal:(ADSuyiSDKSplashAd *)splashAd
                                        splashZoomOutView:(__kindof UIView <ADSuyiSDKSplashAdZoomOutViewProtocol>*)splashZoomOutView {
    
}

/**
 ZoomOutView 退出视频详情页
 */
- (void)adsy_splashZoomOutViewAdDidDismissFullScreenModal:(ADSuyiSDKSplashAd *)splashAd
                                        splashZoomOutView:(__kindof UIView <ADSuyiSDKSplashAdZoomOutViewProtocol>*)splashZoomOutView {
    _splashAd = nil;
}

#endif
```

<div STYLE="page-break-after: always;"></div>


## 4.4 Banner横幅广告 - ADSuyiSDKBannerAdView

Banner广告(横幅广告)位于app顶部、中部、底部任意一处，横向贯穿整个app页面；当用户与app互动时，Banner广告会停留在屏幕上，并可在一段时间后自动刷新。

- `Github: OC请求横幅代码示例：`[[横幅代码示例]](https://github.com/ADSuyi/ADSuyiSDKDemo-iOS/blob/master/ADSuyiSDKDemo-iOS/SuyiAds/BannerAd/AdSuyiBannerViewController.m)
- `Gitee : OC请求横幅代码示例：`[[横幅代码示例]](https://gitee.com/admobile/ADSuyiSDKDemo-iOS/blob/master/ADSuyiSDKDemo-iOS/SuyiAds/BannerAd/AdSuyiBannerViewController.m)


- `Github: Swift请求横幅代码示例：`[[横幅代码示例]](https://github.com/ADSuyi/ADSuyiSDKDemo-iOS-Swift/blob/master/ADSuyiSDKDemo-iOS-Swift/SuyiAds/BannerAd/ADSuyiBannerViewController.swift)
- `Gitee : Swift请求横幅代码示例：`[[横幅代码示例]](https://gitee.com/admobile/ADSuyiSDKDemo-iOS-Swift/blob/master/ADSuyiSDKDemo-iOS-Swift/SuyiAds/BannerAd/ADSuyiBannerViewController.swift)

**ADSuyiSDKBannerAdView**: 横幅广告的加载类

| <center>属性</center> | <center>类型</center>  | <center>说明</center>|
|:-----------|:--|:--------|
| delegate | id\<ADSuyiSDKBannerAdViewDelegate> | 委托对象  |
| controller | UIViewController | [必选]开发者需传入用来弹出目标页的ViewController，一般为当前ViewController  |
| posId | NSString | 广告位id  |
| scenesId | NSString | 场景id（可选）  |
| refershTime | NSInteger | banner刷新时间间隔，30-120s之间；默认不刷新；<br>支持平台：穿山甲、百度、优量汇、汇量 |
| tolerateTimeout | NSInteger | 请求超时时间,默认为4s,需要设置3s及以上  |

| <center>接口</center> | <center>说明</center>|
|:-----------|:--------|
| loadAndShow | 加载并展示广告 |
| loadAndShowWithError: | 加载并展示广告,已废弃请使用loadAndShow代替 |


**ADSuyiSDKBannerAdViewDelegate**：横幅代理方法

| <center>回调函数</center> | <center>回调说明</center>|
|:-----------|:--------|
| adsy_bannerViewDidReceived: | 横幅广告加载成功 |
| adsy_bannerViewFailToReceived:errorModel: | 横幅广告加载失败 |
| adsy_bannerViewDidPresent: | 横幅广告展示 |
| adsy_bannerViewExposure: | 横幅广告曝光 |
| adsy_bannerViewClicked: | 横幅广告点击 |
| adsy_bannerViewClose: | 横幅广告关闭 |
| adsy_bannerAdCloseLandingPage: | 横幅广告关闭落地页 |


- `Github: Swift请求横幅代码示例：`[[横幅代码示例]](https://github.com/ADSuyi/ADSuyiSDKDemo-iOS-Swift/blob/master/ADSuyiSDKDemo-iOS-Swift/SuyiAds/BannerAd/ADSuyiBannerViewController.swift)
- `Gitee: Swift请求横幅代码示例：`[[横幅代码示例]](https://gitee.com/admobile/ADSuyiSDKDemo-iOS-Swift/blob/master/ADSuyiSDKDemo-iOS-Swift/SuyiAds/BannerAd/ADSuyiBannerViewController.swift)

OC请求横幅广告请求示例：

```obj-c
#import <ADSuyiSDK/ADSuyiSDKBannerAdView.h>

- (void)loadBannerWithRate:(CGFloat)rate posId:(NSString *)posId {
    [self.bannerView removeFromSuperview];
    self.bannerView.delegate = nil;
    self.bannerView = nil;
    
    // 1、初始化banner视图，并给定frame值，rate取值根据banner的尺寸
    self.bannerView = [[ADSuyiSDKBannerAdView alloc] initWithFrame:CGRectMake(0, 250, kADSYScreenWidth, kADSYScreenWidth / rate)];
    self.bannerView.delegate = self;
    // 2、设置控制器，用来弹出落地页，重要
    self.bannerView.controller = self;
    // 3、设置广告位id，重要
    self.bannerView.posId = posId;
    self.bannerView.refershTime = 30;
    // 4、可先展示再请求
    [self.view addSubview:self.bannerView];
    self.bannerView.backgroundColor = [UIColor redColor];
    // 5、加载并展示
    [self.bannerView loadAndShow];
}

// 5、代理回调
#pragma mark - ADSuyiSDKBannerAdViewDelegate
/**
 广告获取成功
 
 @param bannerView banner实例
 */
- (void)adsy_bannerViewDidReceived:(ADSuyiSDKBannerAdView *)bannerView{
    
}

/**
 广告拉取失败
 
 @param bannerView banner实例
 @param errorModel 错误描述
 */
- (void)adsy_bannerViewFailToReceived:(ADSuyiSDKBannerAdView *)bannerView errorModel:(ADSuyiAdapterErrorDefine *)errorModel{
    NSLog(@"adsy_bannerViewFailToReceived:%@, %@",errorModel.errorDescription, errorModel.errorDetailDict);
    [_bannerView removeFromSuperview];
    _bannerView = nil;
}

/**
 广告点击
 
 @param bannerView 广告实例
 */
- (void)adsy_bannerViewClicked:(ADSuyiSDKBannerAdView *)bannerView{
    
}

/**
 广告关闭
 
 @param bannerView 广告实例
 */
- (void)adsy_bannerViewClose:(ADSuyiSDKBannerAdView *)bannerView{
    _bannerView = nil;
}

/**
 广告展示
 
 @param bannerView 广告实例
 */
- (void)adsy_bannerViewExposure:(ADSuyiSDKBannerAdView *)bannerView{
    
}
```

<div STYLE="page-break-after: always;"></div>


## 4.5 信息流广告 - ADSuyiSDKNativeAd

信息流广告，具备自渲染和模板两种广告样式：自渲染是SDK将返回广告标题、描述、Icon、图片、多媒体视图等信息，开发者可通过自行拼装渲染成喜欢的样式；模板样式则是返回拼装好的广告视图，开发者只需将视图添加到相应容器即可，模板样式的容器高度建议是自适应。**请务必确保自渲染类型广告渲染时包含广告创意素材（至少包含一张图片）、平台logo、广告标识、关闭按钮；模板广告不得被遮挡。** **注意，信息流广告点击关闭时，开发者需要在- (void)adsy_nativeAdClose:回调中将广告视图隐藏或移除，避免如穿山甲渠道点击关闭后视图依旧存在问题**

- `Github: OC请求信息流广告代码示例：`[[信息流广告代码示例]](https://github.com/ADSuyi/ADSuyiSDKDemo-iOS/blob/master/ADSuyiSDKDemo-iOS/SuyiAds/NativeAd/AdSuyiNativeViewController.m)
- `Gitee: OC请求信息流广告代码示例：`[[信息流广告代码示例]](https://gitee.com/admobile/ADSuyiSDKDemo-iOS/blob/master/ADSuyiSDKDemo-iOS/SuyiAds/NativeAd/AdSuyiNativeViewController.m)

- `Github: Swift请求信息流广告代码示例：`[[信息流广告代码示例]](https://github.com/ADSuyi/ADSuyiSDKDemo-iOS-Swift/blob/master/ADSuyiSDKDemo-iOS-Swift/SuyiAds/NativeAd/AdSuyiNativeViewController.swift)
- `Gitee: Swift请求信息流广告代码示例：`[[信息流广告代码示例]](https://gitee.com/admobile/ADSuyiSDKDemo-iOS-Swift/blob/master/ADSuyiSDKDemo-iOS-Swift/SuyiAds/NativeAd/AdSuyiNativeViewController.swift)

**ADSuyiSDKNativeAd**: 信息流广告的加载类

| <center>属性</center> | <center>类型</center>  | <center>说明</center>|
|:-----------|:--|:--------|
| delegate | id\<ADSuyiSDKNativeAdDelegate> | 委托对象  |
| controller | UIViewController | [必选]开发者需传入用来弹出目标页的ViewController，一般为当前ViewController  |
| posId | NSString | 广告位id  |
| scenesId | NSString | 场景id  |
| tolerateTimeout | NSTimeInterval | 请求超时时间,默认为4s,需要设置3s及以上  |
| muted | BOOL | 是否静音播放视频 默认YES <br>支持平台：天目、优量汇、百度、快手、汇量、Gromore<br/> 特殊平台：穿山甲（需在穿山甲后台广告位配置处设置） |
| detailPageVideoMuted | BOOL | 是否静音播放详情页视频 默认YES <br>支持平台：优量汇 |
| autoPlay | BOOL | 信息流自动播放，默认WiFi自动播放 开启后WiFi/4G自动播放  |
| status | ADSuyiSDKNativeAdStatus | 开发者可通过状态值来判断当前广告对象是否正在加载广告  |
| insets | UIEdgeInsets | 模板信息流内边距  默认（16，16，12，16）（部分平台支持，其余需后台设置）  |

| <center>接口</center> | <center>说明</center>|
|:-----------|:--------|
| load: | 加载广告,建议区间 1~5, 超过可能无法拉取到 |

**ADSuyiSDKNativeAdDelegate**：信息流代理方法

| <center>回调函数</center> | <center>回调说明</center>|
|:-----------|:--------|
| adsy_nativeAdSucessToLoad:adViewArray: | 信息流广告加载成功 |
| adsy_nativeAdFailToLoad:errorModel | 信息流广告加载失败 |
| adsy_nativeAdViewRenderOrRegistSuccess: | 信息流广告渲染成功 |
| adsy_nativeAdViewRenderOrRegistFail: | 信息流广告渲染失败 |
| adsy_nativeAdExposure:adView: | 信息流广告曝光 |
| adsy_nativeAdClicked:adView: | 信息流广告点击 |
| adsy_nativeAdClose:adView: | 信息流广告关闭 |
| adsy_nativeAdCloseLandingPage:adView: | 信息流广告关闭落地页 |
| adsy_nativeAd:adView:playerStatusChanged: | 视频类型信息流广告player 播放状态更新回调 |


- `Github: Swift请求信息流广告代码示例：`[[信息流广告代码示例]](https://github.com/ADSuyi/ADSuyiSDKDemo-iOS-Swift/blob/master/ADSuyiSDKDemo-iOS-Swift/SuyiAds/NativeAd/AdSuyiNativeViewController.swift)
- `Gitee: Swift请求信息流广告代码示例：`[[信息流广告代码示例]](https://gitee.com/admobile/ADSuyiSDKDemo-iOS-Swift/blob/master/ADSuyiSDKDemo-iOS-Swift/SuyiAds/NativeAd/AdSuyiNativeViewController.swift)

OC请求信息流广告请求示例：

```obj-c
#import <ADSuyiSDK/ADSuyiSDKNativeAd.h>

if(!_nativeAd) {
   // 1、信息流广告初始化 建议将高度设置为0；信息流会根据传入的宽度返回相应比例的高度
   _nativeAd = [[ADSuyiSDKNativeAd alloc] initWithAdSize:CGSizeMake(self.tableView.frame.size.width, 0)];
   // 2、传入posId，重要
   _nativeAd.posId = self.posId;
   _nativeAd.delegate = self;
   _nativeAd.controller = self;
}
// 3、加载信息流广告
[_nativeAd load:1];

// 4、代理回调
#pragma mark - ADSuyiSDKNativeAdDelegate
- (void)adsy_nativeAdSucessToLoad:(ADSuyiSDKNativeAd *)nativeAd
                      adViewArray:(NSArray<__kindof UIView<ADSuyiAdapterNativeAdViewDelegate> *> *)adViewArray {
    for (UIView<ADSuyiAdapterNativeAdViewDelegate> *adView in adViewArray) {
        // 4、判断信息流广告是否为自渲染类型
        if(adView.renderType == ADSuyiAdapterRenderTypeNative) {
            // 4.1、如果是自渲染类型则可样式自定义
            [self setUpUnifiedNativeAdView:adView];
        }
        // 5、注册，自渲染：注册点击事件，模板：render，重要
        [adView adsy_registViews:@[adView]];
    }
    
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

// 渲染成功回调
- (void)adsy_nativeAdViewRenderOrRegistSuccess:(UIView<ADSuyiAdapterNativeAdViewDelegate> *)adView {
    // 6、注册或渲染成功，此时高度正常，可以展示
    dispatch_async(dispatch_get_main_queue(), ^{
        for (int i = 0; i < 6; i ++) {
            [self.items addObject:[NSNull null]];
        }
        [self.items addObject:adView];
        [self.tableView reloadData];
    });
}

- (void)adsy_nativeAdClose:(ADSuyiSDKNativeAd *)nativeAd
                    adView:(__kindof UIView<ADSuyiAdapterNativeAdViewDelegate> *)adView {
    for (id item in _items) {
        if(item == adView) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [adView adsy_unRegistView];
                [self.items removeObject:adView];
                [self.tableView reloadData];
            });
        }
    }
}
```

<div STYLE="page-break-after: always;"></div>


## 4.6 激励视频广告 - ADSuyiSDKRewardvodAd

将短视频融入到APP场景当中，用户观看短视频广告后可以给予一些应用内奖励。常出现在游戏的复活、任务等位置，或者网服类APP的一些增值服务场景。

- `Github: OC请求激励视频代码示例：`[[激励视频广告代码示例]](https://github.com/ADSuyi/ADSuyiSDKDemo-iOS/blob/master/ADSuyiSDKDemo-iOS/SuyiAds/RewardVodAd/AdSuyiRewardvodViewController.m)
- `Gitee: OC请求激励视频代码示例：`[[激励视频广告代码示例]](https://gitee.com/admobile/ADSuyiSDKDemo-iOS/blob/master/ADSuyiSDKDemo-iOS/SuyiAds/RewardVodAd/AdSuyiRewardvodViewController.m)

- `Github: Swift请求激励视频代码示例：`[[激励视频广告代码示例]](https://github.com/ADSuyi/ADSuyiSDKDemo-iOS-Swift/blob/master/ADSuyiSDKDemo-iOS-Swift/SuyiAds/RewardAd/AdSuyiRewardViewController.swift)
- `Gitee: Swift请求激励视频代码示例：`[[激励视频广告代码示例]](https://gitee.com/admobile/ADSuyiSDKDemo-iOS-Swift/blob/master/ADSuyiSDKDemo-iOS-Swift/SuyiAds/RewardAd/AdSuyiRewardViewController.swift)

**ADSuyiSDKRewardvodAd**: 激励视频广告的加载类

| <center>属性</center> | <center>类型</center>  | <center>说明</center>|
|:-----------|:--|:--------|
| delegate | id\<ADSuyiSDKRewardvodAdDelegate> | 委托对象  |
| controller | UIViewController | 开发者需传入用来弹出目标页的ViewController，一般为当前ViewController |
| posId | NSString | 广告位id  |
| scenesId | NSString | 场景id  |
| userId | NSString | 用户id （用户在App内的userID，用于激励视频服务器验证，如无需服务器验证可不传）  |
| rewardName | NSString | 奖励名称 （用于激励视频服务器验证参数，可选）  |
| rewardAmount | NSString | 奖励数量 （用于激励视频服务器验证参数，可选）  |
| extraInfo | NSString | 其他信息 （服务器端验证回调中包含的可选自定义奖励字符串，可选）|
| tolerateTimeout | NSInteger | 请求超时时间,默认为4s,需要设置3s及以上  |
| isMuted | BOOL | 是否静音，默认静音 <br>支持平台：优量汇，汇量，快手，Gromore  |

| <center>接口</center> | <center>说明</center>|
|:-----------|:--------|
| loadRewardvodAd | 加载激励视频广告 |
| showRewardvodAd | 展示激励视频广告 |
| rewardvodAdIsValid | 激励视频广告物料是否有效 |
| rewardvodAdIsReady | 激励视频广告是否准备好 |
| rewardvodAdCanServerVerrify | 激励视频广告是否支持服务端验证 <br>支持平台：穿山甲、优量汇、百度、快手、汇量、Gromore |

**ADSuyiSDKRewardvodAdDelegate**：激励视频代理方法

| <center>回调函数</center> | <center>回调说明</center>|
|:-----------|:--------|
| adsy_rewardvodAdLoadSuccess: | 激励视频广告加载成功 |
| adsy_rewardvodAdFailToLoad:errorModel: | 激励视频广告加载失败 |
| adsy_rewardvodAdReadyToPlay: | 激励视频广告准备好播放 |
| adsy_rewardvodAdPlaying:errorModel: | 激励视频广告播放时错误回调 |
| adsy_rewardvodAdVideoLoadSuccess: | 视频数据下载成功回调，已经下载过的视频会直接回调 |
| adsy_rewardvodAdWillVisible: | 激励视频广告播放页即将展示 |
| adsy_rewardvodAdDidVisible: | 激励视频广告曝光 |
| adsy_rewardvodAdDidRewardEffective: | 激励视频广告达到激励条件 |
| adsy_rewardvodAdServerDidSucceed: | 激励视频服务验证成功（需等待服务器返回结果后判断是否激励生效） |
| adsy_rewardvodAdServerDidSucceed:info: | 激励视频服务验证成功（需等待服务器返回结果后判断是否激励生效）,并携带服务验证三方返回的相关参数 |
| adsy_rewardvodAdServerDidFailed:errorModel: | 激励视频服服务验证失败 |
| adsy_rewardvodAdDidPlayFinish: | 激励视频广告播放完成 |
| adsy_rewardvodAdDidClick: | 激励视频广告点击 |
| adsy_rewardvodAdDidClose: | 激励视频广告关闭 |
| adsy_rewardvodAdCloseLandingPage: | 激励视频广告关闭落地页 |


- `Github: Swift请求激励视频代码示例：`[[激励视频广告代码示例]](https://github.com/ADSuyi/ADSuyiSDKDemo-iOS-Swift/blob/master/ADSuyiSDKDemo-iOS-Swift/SuyiAds/RewardAd/AdSuyiRewardViewController.swift)
- `Gitee: Swift请求激励视频代码示例：`[[激励视频广告代码示例]](https://gitee.com/admobile/ADSuyiSDKDemo-iOS-Swift/blob/master/ADSuyiSDKDemo-iOS-Swift/SuyiAds/RewardAd/AdSuyiRewardViewController.swift)

OC请求激励视频代码示例：

```obj-c
#import <ADSuyiSDK/ADSuyiSDKRewardvodAd.h>

- (void)loadRewardvodAd{
    // 1、初始化激励视频广告
    self.rewardvodAd  = [[ADSuyiSDKRewardvodAd alloc]init];
    self.rewardvodAd.delegate = self;
    self.rewardvodAd.tolerateTimeout = 5;
    self.rewardvodAd.controller = self;
    self.rewardvodAd.posId = @"e9e0f8d1fe21873695";
      // 以下参数如不需服务端验证可不传
      self.rewardvodAd.userId = @"xxx";
    self.rewardvodAd.extraInfo = @"这是一个激励视频生效验证";
    self.rewardvodAd.rewardName = @"看视频得金币";
    self.rewardvodAd.rewardAmount = [NSNumber numberWithInt:2];
    
    // 2、加载激励视频广告
    [self.rewardvodAd loadRewardvodAd];
}

/**
 激励视频广告准备好被播放
 
 @param rewardvodAd 广告实例
 */
- (void)adsy_rewardvodAdReadyToPlay:(ADSuyiSDKRewardvodAd *)rewardvodAd{
    // 3、推荐在准备好被播放回调中展示激励视频广告
    if ([self.rewardvodAd rewardvodAdIsReady]) {
        [self.rewardvodAd showRewardvodAd];
    }
}

/**
 视频播放页关闭回调
 
 @param rewardvodAd 广告实例
 */
- (void)adsy_rewardvodAdDidClose:(ADSuyiSDKRewardvodAd *)rewardvodAd{
    // 4、广告内存回收
    _rewardvodAd = nil;
}

/**
 视频广告请求失败回调
 
 @param rewardvodAd 广告实例
 @param errorModel 具体错误信息
 */
- (void)adsy_rewardvodAdFailToLoad:(ADSuyiSDKRewardvodAd *)rewardvodAd errorModel:(ADSuyiAdapterErrorDefine *)errorModel{
    // 4、广告内存回收
    _rewardvodAd = nil;
}

/**
 视频广告发送服务端验证成功回调
 
 @param rewardvodAd 广告实例
 */
- (void)adsy_rewardvodAdServerDidSucceed:(ADSuyiSDKRewardvodAd *)rewardvodAd {
    
}

/**
 视频广告发送服务端验证请求失败回调
 
 @param rewardvodAd 广告实例
 @param errorModel 具体错误信息
 */
- (void)adsy_rewardvodAdServerDidFailed:(ADSuyiSDKRewardvodAd *)rewardvodAd errorModel:(ADSuyiAdapterErrorDefine *)errorModel {
    
}


```

<div STYLE="page-break-after: always;"></div>


## 4.7 插屏广告 - ADSuyiSDKIntertitialAd

插屏广告是移动广告的一种常见形式，在应用流程中弹出，当应用展示插屏广告时，用户可以选择点击广告，访问其目标网址，也可以将其关闭并返回应用。在应用执行流程的自然停顿点，适合投放这类广告。

<p style="color:red;">**注意：穿山甲插屏广告禁止App启动即请求，建议在首页控制器viewDidLoad方法中2~3s后请求展示，否则会有明显数据影响，将会存在约50%数据异常。** </p>

- `Github: OC请求插屏广告代码示例：`[[插屏广告代码示例]](https://github.com/ADSuyi/ADSuyiSDKDemo-iOS/blob/master/ADSuyiSDKDemo-iOS/SuyiAds/InterstitialAd/AdSuyiInterstitialViewController.m)
- `Gitee: OC请求插屏广告代码示例：`[[插屏广告代码示例]](https://gitee.com/admobile/ADSuyiSDKDemo-iOS/blob/master/ADSuyiSDKDemo-iOS/SuyiAds/InterstitialAd/AdSuyiInterstitialViewController.m)

- `Github: Swift请求插屏广告代码示例：`[[插屏广告代码示例]](https://github.com/ADSuyi/ADSuyiSDKDemo-iOS-Swift/blob/master/ADSuyiSDKDemo-iOS-Swift/SuyiAds/InterstitialAd/AdSuyiInterstitialViewController.swift)
- `Gitee: Swift请求插屏广告代码示例：`[[插屏广告代码示例]](https://gitee.com/admobile/ADSuyiSDKDemo-iOS-Swift/blob/master/ADSuyiSDKDemo-iOS-Swift/SuyiAds/InterstitialAd/AdSuyiInterstitialViewController.swift)

**ADSuyiSDKIntertitialAd**: 插屏广告的加载类

| <center>属性</center> | <center>类型</center>  | <center>说明</center>|
|:-----------|:--|:--------|
| delegate | id\<ADSuyiSDKIntertitialAdDelegate> | 委托对象  |
| controller | UIViewController | 开发者需传入用来弹出目标页的ViewController，一般为当前ViewController |
| posId | NSString | 广告位id  |
| scenesId | NSString | 场景id  |
| tolerateTimeout | NSTimeInterval | 请求超时时间,默认为4s,需要设置3s及以上  |
| isMuted | BOOL | 是否静音，默认静音 <br>支持平台：优量汇，汇量，快手，Gromore <br/> 特殊平台：穿山甲（需在穿山甲后台广告位配置处设置） |
| detailPageVideoMuted | BOOL | 是否静音，默认静音 <br>支持平台：优量汇  |
| adSize | CGSize | 广告尺寸，需与平台所申请广告位比例一致，否则会导致素材压缩（仅支持部分平台）  |

| <center>接口</center> | <center>说明</center>|
|:-----------|:--------|
| loadAdData | 加载插屏广告 |
| show | 展示插屏广告 |

**ADSuyiSDKIntertitialAdDelegate**：插屏代理方法

| <center>回调函数</center> | <center>回调说明</center>|
|:-----------|:--------|
| adsy_interstitialAdSuccedToLoad: | 插屏广告加载成功 |
| adsy_interstitialAdFailedToLoad:error: | 插屏广告加载失败 |
| adsy_interstitialAdDidPresent: | 插屏广告展示成功 |
| adsy_interstitialAdFailedToPresent:error: | 插屏广告展示失败 |
| adsy_interstitialAdExposure: | 插屏广告曝光 |
| adsy_interstitialAdDidClick: | 插屏广告点击 |
| adsy_interstitialAdDidClose: | 插屏广告关闭 |
| adsy_interstitialAdCloseLandingPage: | 插屏广告关闭落地页 |

- `Github: Swift请求插屏代码示例：`[[插屏广告代码示例]](https://github.com/ADSuyi/ADSuyiSDKDemo-iOS-Swift/blob/master/ADSuyiSDKDemo-iOS-Swift/SuyiAds/InterstitialAd/AdSuyiInterstitialViewController.swift)
- `Gitee: Swift请求插屏代码示例：`[[插屏广告代码示例]](https://gitee.com/admobile/ADSuyiSDKDemo-iOS-Swift/blob/master/ADSuyiSDKDemo-iOS-Swift/SuyiAds/InterstitialAd/AdSuyiInterstitialViewController.swift)

OC请求插屏代码示例：

```obj-c
#import <ADSuyiSDK/ADSuyiSDKIntertitialAd.h>

- (void)loadInterstitialAd{
    // 1、初始化插屏广告
    self.intertitialAd = [ADSuyiSDKIntertitialAd new];
    self.intertitialAd.controller = self;
    self.intertitialAd.posId = @"1fbfbb9778d168e5a7";
    self.intertitialAd.delegate = self;
    self.intertitialAd.tolerateTimeout = 4;
    // 2、加载插屏广告
    [self.intertitialAd loadAdData];
}

#pragma mark - ADSuyiSDKIntertitialAdDelegate
/**
 ADSuyiSDKIntertitialAd请求成功回调
 
 @param interstitialAd 插屏广告实例对象
*/
- (void)adsy_interstitialAdSuccedToLoad:(ADSuyiSDKIntertitialAd *)interstitialAd{
    // 3、展示插屏广告
    [self.intertitialAd show];
}
/**
 ADSuyiSDKIntertitialAd请求失败回调

 @param interstitialAd 插屏广告实例对象
 @param error 失败原因
*/
- (void)adsy_interstitialAdFailedToLoad:(ADSuyiSDKIntertitialAd *)interstitialAd error:(ADSuyiAdapterErrorDefine *)error{
    // 4、内存回收
    _intertitialAd = nil;
}
/**
 ADSuyiSDKIntertitialAd关闭回调

 @param interstitialAd 插屏广告实例对象
*/
- (void)adsy_interstitialAdDidClose:(ADSuyiSDKIntertitialAd *)interstitialAd{
    // 4、内存回收
    _intertitialAd = nil;
}

```

<div STYLE="page-break-after: always;"></div>

## 4.8 全屏视频广告 - ADSuyiSDKFullScreenVodAd

类似激励视频，与激励视频不同的是，全屏视频广告在观看一定时长（通常为5s）后即可跳过广告，无需全部观看完成，有视频跳过回调，但是没有激励回调。

- `Github: OC请求全屏视频广告代码示例：`[[全屏视频广告代码示例]](https://github.com/ADSuyi/ADSuyiSDKDemo-iOS/blob/master/ADSuyiSDKDemo-iOS/SuyiAds/FullScreenVodAd/AdSuyiFullScreenvodViewController.m)
- `Gitee: OC请求全屏视频广告代码示例：`[[全屏视频广告代码示例]](https://gitee.com/admobile/ADSuyiSDKDemo-iOS/blob/master/ADSuyiSDKDemo-iOS/SuyiAds/FullScreenVodAd/AdSuyiFullScreenvodViewController.m)

- `Github: Swift请求全屏视频广告代码示例：`[[全屏视频广告代码示例]](https://github.com/ADSuyi/ADSuyiSDKDemo-iOS-Swift/blob/master/ADSuyiSDKDemo-iOS-Swift/SuyiAds/FullScreenVodAd/AdSuyiFullScreenVodViewController.swift)
- `Gitee: Swift请求全屏视频广告代码示例：`[[全屏视频广告代码示例]](https://gitee.com/admobile/ADSuyiSDKDemo-iOS-Swift/blob/master/ADSuyiSDKDemo-iOS-Swift/SuyiAds/FullScreenVodAd/AdSuyiFullScreenVodViewController.swift)

**ADSuyiSDKFullScreenVodAd**: 全屏视频广告的加载类

| <center>属性</center> | <center>类型</center>  | <center>说明</center>|
|:-----------|:--|:--------|
| delegate | id\<ADSuyiSDKFullScreenVodAdDelegate> | 委托对象  |
| controller | UIViewController | 开发者需传入用来弹出目标页的ViewController，一般为当前ViewController |
| posId | NSString | 广告位id  |
| scenesId | NSString | 场景id  |
| tolerateTimeout | NSTimeInterval | 请求超时时间,默认为4s,需要设置3s及以上  |

| <center>接口</center> | <center>说明</center>|
|:-----------|:--------|
| loadAdData | 加载全屏视频广告 |
| show | 展示全屏视频广告 |

**ADSuyiSDKFullScreenVodAdDelegate**：全屏视频代理方法

| <center>回调函数</center> | <center>回调说明</center>|
|:-----------|:--------|
| adsy_fullScreenVodAdSuccedToLoad: | 全屏视频广告加载成功 |
| adsy_fullScreenVodAdFailedToLoad:error: | 全屏视频广告加载失败 |
| adsy_fullScreenVodAdReadyToPlay: | 全屏视频广告准备好播放 |
| adsy_fullScreenVodAdSuccessToLoadVideo: | 全屏视频视频加载成功 |
| adsy_fullScreenVodAdDidPresent: | 全屏视频展示成功 |
| adsy_fullScreenVodAdFailToPresent:error: | 全屏视频展示失败 |
| adsy_fullScreenVodAdExposure: | 全屏视频曝光 |
| adsy_fullScreenVodAdDidClick: | 全屏视频点击 |
| adsy_fullScreenVodAdDidClose: | 全屏视频关闭 |
| adsy_fullScreenVodAdCloseLandingPage: | 全屏视频关闭落地页 |
| adsy_fullScreenVodAdPlayComplete:didFailed: | 全屏视频播放完成 |


- `Github: Swift请求全屏视频广告代码示例：`[[全屏视频广告代码示例]](https://github.com/ADSuyi/ADSuyiSDKDemo-iOS-Swift/blob/master/ADSuyiSDKDemo-iOS-Swift/SuyiAds/FullScreenVodAd/AdSuyiFullScreenVodViewController.swift)
- `Gitee: Swift请求全屏视频广告代码示例：`[[全屏视频广告代码示例]](https://gitee.com/admobile/ADSuyiSDKDemo-iOS-Swift/blob/master/ADSuyiSDKDemo-iOS-Swift/SuyiAds/FullScreenVodAd/AdSuyiFullScreenVodViewController.swift)

OC请求全屏视频广告代码示例：

```objective-c
#import <ADSuyiSDK/ADSuyiSDKFullScreenVodAd.h>

- (void)loadFullScreenvod{
    // 1、初始化全屏视频广告
    self.fullScreenvodAd = [ADSuyiSDKFullScreenVodAd new];
    self.fullScreenvodAd.controller = self;
    self.fullScreenvodAd.posId = @"7206088624654025e7";
    self.fullScreenvodAd.delegate = self;
    self.fullScreenvodAd.tolerateTimeout = 5;
    // 2、加载全屏视频广告
    [self.fullScreenvodAd loadAdData];
    
}

/**
 ADSuyiSDKFullScreenVodAd准备好被播放
 
 @param fullScreenVodAd 全屏视频广告实例对象
*/
- (void)adsy_fullScreenVodAdReadyToPlay:(ADSuyiSDKFullScreenVodAd *)fullScreenVodAd{
    // 3、推荐在准备好被播放会调用展示激励视频广告
    [self.fullScreenvodAd show];
}
/**
 ADSuyiSDKFullScreenVodAd视频加载成功回调
 
 @param fullScreenVodAd 全屏视频广告实例对象
*/
- (void)adsy_fullScreenVodAdSuccessToLoadVideo:(ADSuyiSDKFullScreenVodAd *)fullScreenVodAd{
    // 3、也可在视频加载成功回调中展示激励视频广告
    [self.fullScreenvodAd show];
}
/**
 ADSuyiSDKFullScreenVodAd请求失败回调

 @param fullScreenVodAd 全屏视频广告实例对象
 @param error 失败原因
*/
- (void)adsy_fullScreenVodAdFailedToLoad:(ADSuyiSDKFullScreenVodAd *)fullScreenVodAd error:(ADSuyiAdapterErrorDefine *)error{
    // 4、广告内存回收
    _fullScreenvodAd = nil;
}
/**
 ADSuyiSDKFullScreenVodAd关闭回调

 @param fullScreenVodAd 全屏视频广告实例对象
*/
- (void)adsy_fullScreenVodAdDidClose:(ADSuyiSDKFullScreenVodAd *)fullScreenVodAd{
    // 4、广告内存回收
    _fullScreenvodAd = nil;
}
```

<div STYLE="page-break-after: always;"></div> 


## 4.9 沉浸式视频广告 - ADSuyiSDKDrawvodAd

类似抖音、快手小视频一样的视频广告，目前仅有穿山甲和快手联盟拥有该样式。

- `Github: OC请求沉浸式视频代码示例：`[[沉浸式视频广告代码示例]](https://github.com/ADSuyi/ADSuyiSDKDemo-iOS/blob/master/ADSuyiSDKDemo-iOS/SuyiAds/DrawVodAd/AdSuyiDrawvodViewController.m)
- `Gitee: OC请求沉浸式视频代码示例：`[[沉浸式视频广告代码示例]](https://gitee.com/admobile/ADSuyiSDKDemo-iOS/blob/master/ADSuyiSDKDemo-iOS/SuyiAds/DrawVodAd/AdSuyiDrawvodViewController.m)

- `Github: Swift请求沉浸式视频代码示例：`[[沉浸式视频广告代码示例]](https://github.com/ADSuyi/ADSuyiSDKDemo-iOS-Swift/blob/master/ADSuyiSDKDemo-iOS-Swift/SuyiAds/DrawVodAd/AdSuyiDrawVodViewController.swift)
- `Gitee: Swift请求沉浸式视频代码示例：`[[沉浸式视频广告代码示例]](https://gitee.com/admobile/ADSuyiSDKDemo-iOS-Swift/blob/master/ADSuyiSDKDemo-iOS-Swift/SuyiAds/DrawVodAd/AdSuyiDrawVodViewController.swift)

沉浸式视频广告 - ADSuyiSDKDrawvodAd：
**ADSuyiSDKDrawvodAd**: 沉浸式广告的加载类

| <center>属性</center> | <center>类型</center>  | <center>说明</center>|
|:-----------|:--|:--------|
| delegate | id\<ADSuyiSDKDrawvodAdDelegate> | 委托对象  |
| controller | UIViewController | 开发者需传入用来弹出目标页的ViewController，一般为当前ViewController |
| posId | NSString | 广告位id  |
| scenesId | NSString | 场景id  |
| tolerateTimeout | NSTimeInterval | 请求超时时间,默认为4s,需要设置3s及以上  |
| status | ADSuyiSDKDrawvodAdStatus | 开发者可通过状态值来判断当前广告对象是否正在加载广告，支持KVO  |

| <center>接口</center> | <center>说明</center>|
|:-----------|:--------|
| load: | 加载沉浸式广告；建议区间 1~4, 超过可能无法拉取到 |

**ADSuyiSDKDrawvodAdDelegate**：插屏代理方法

| <center>回调函数</center> | <center>回调说明</center>|
|:-----------|:--------|
| adsy_drawvodAdSuccessToLoad:drawvodAdArray: | 沉浸式广告加载成功 |
| adsy_drawvodAdFailToLoad:errorModel: | 沉浸式广告加载失败 |
| adsy_drawvodAdSuccessToRender:view: | 沉浸式广告渲染成功 |
| adsy_drawvodAdFailToRender:view:error: | 沉浸式广告渲染失败 |
| adsy_drawvodAdPlayerDidPlayFinish: | 沉浸式广告播放完成 |
| adsy_drawvodAdDidExposure: | 沉浸式广告曝光 |
| adsy_drawvodAdDidClick: | 沉浸式广告点击 |
| adsy_drawvodAdCloseLandingPage: | 沉浸式广告关闭落地页 |


- `Github: Swift请求沉浸式视频代码示例：`[[沉浸式视频广告代码示例]](https://github.com/ADSuyi/ADSuyiSDKDemo-iOS-Swift/blob/master/ADSuyiSDKDemo-iOS-Swift/SuyiAds/DrawVodAd/AdSuyiDrawVodViewController.swift)
- `Gitee: Swift请求沉浸式视频代码示例：`[[沉浸式视频广告代码示例]](https://gitee.com/admobile/ADSuyiSDKDemo-iOS-Swift/blob/master/ADSuyiSDKDemo-iOS-Swift/SuyiAds/DrawVodAd/AdSuyiDrawVodViewController.swift)

OC请求沉浸式视频代码示例：

```objective-c
- (ADSuyiSDKDrawvodAd *)drawvodAd {
    if(!_drawvodAd) {
        // 1、初始化沉浸式视频广告，流程和信息流广告类似
        _drawvodAd = [[ADSuyiSDKDrawvodAd alloc] initWithSize:self.tableView.frame.size];
        _drawvodAd.posId = @"16e160a112f019de2b";
        _drawvodAd.controller = self;
        _drawvodAd.delegate = self;
    }
    return _drawvodAd;
}

- (void)loadDrawvodAd{
    // 2、加载沉浸式视频广告
    [self.drawvodAd load:3];
}
#pragma mark - ADSuyiSDKDrawvodAdDelegate

- (void)adsy_drawvodAdSuccessToLoad:(ADSuyiSDKDrawvodAd *)drawvodAd drawvodAdArray:(NSArray<ADSuyiAdapterDrawvodAdView *> *)drawvodAdViewArray {
    for (ADSuyiAdapterDrawvodAdView *adView in drawvodAdViewArray) {
        // 3、渲染沉浸式广告
        [adView render];
    }
}

- (void)adsy_drawvodAdFailToLoad:(ADSuyiSDKDrawvodAd *)drawvodAd errorModel:(ADSuyiAdapterErrorDefine *)errorModel {
    
}

- (void)adsy_drawvodAdSuccessToRender:(ADSuyiSDKDrawvodAd *)drawvodAd view:(ADSuyiAdapterDrawvodAdView *)drawvodAdView {
    // 4、渲染成功，此时高度正常，资源加载中，可展示
    [self.data addObject:drawvodAdView];
    [self.tableView reloadData];
}

- (void)dealloc
{
    for (ADSuyiAdapterDrawvodAdView *adview in self.data) {
        // 5、广告内存回收
        [adview unRegist];
    }
}
```

<div STYLE="page-break-after: always;"></div> 


## 4.10 浮窗广告 - ADSuyiSDKNotificationAd

浮窗广告正常情况下不需要手动调用任何相关代码，如果需要展示请联系媒介处理。

**浮窗广告的暂停和恢复**。

```objective-c
#import <ADSuyiSDK/ADSuyiSDK.h>

// 可通过调用此方法暂停浮窗广告投放
[ADSuyiSDKStatusManager notificationAdPause];

// 可通过调用此方法恢复浮窗广告投放
[ADSuyiSDKStatusManager notificationAdContinue];
```

<div STYLE="page-break-after: always;"></div> 


## 4.11 快手内容 - ADSuyiContentAd

快手小视频一样的视频广告，点击进入快手的内容页面

**ADSuyiContentAd**: 快手内容广告的加载类

| <center>属性</center> | <center>类型</center>  | <center>说明</center>|
|:-----------|:--|:--------|
| delegate | id\<ADSuyiSDKContentAdDelegate> | 委托对象  |
| posId | NSString | 广告位id  |
| scenesId | NSString | 场景id  |
| tolerateTimeout | NSTimeInterval | 请求超时时间,默认为4s,需要设置3s及以上  |
| status | ADSuyiSDKContentAdStatus | 开发者可通过状态值来判断当前广告对象是否正在加载广告  |
| contentAdPadding | UIEdgeInsets | 内容广告padding 默认 padding 左右各 16，上 8 下 0 ，在 调用loadContentAd之前配置  |
| contentAdWidth | CGFloat | 内容广告默认宽度为屏幕宽度 在调用loadContentAd之前配置 |

| <center>接口</center> | <center>说明</center>|
|:-----------|:--------|
| loadContentAd | 加载内容组件视图 |

**ADSuyiSDKContentAdDelegate**：快手内容代理方法

| <center>回调函数</center> | <center>回调说明</center>|
|:-----------|:--------|
| adsy_contentAdSucessToLoad:contentAdView: | 快手内容广告加载成功 |
| adsy_contentAdFailToLoad:errorModel: | 快手内容广告加载失败 |
| adsy_contentAdClicked:contentDetailPage: | 快手内容广告点击 |


- `Github: Swift请求快手内容代码示例：`[[内容页广告代码示例]](https://github.com/ADSuyi/ADSuyiSDKDemo-iOS-Swift/blob/master/ADSuyiSDKDemo-iOS-Swift/SuyiAds/Content/AdSuyiBaseContentViewController.swift)
- `Gitee: Swift请求快手内容代码示例：`[[内容页广告代码示例]](https://gitee.com/admobile/ADSuyiSDKDemo-iOS-Swift/blob/master/ADSuyiSDKDemo-iOS-Swift/SuyiAds/Content/AdSuyiBaseContentViewController.swift)

OC请求快手内容代码示例：

```objective-c
#import <ADSuyiSDK/ADSuyiSDK.h>

- (void)loadContentAd {
    _contentAd = [[ADSuyiSDKContentAd alloc]init];
    _contentAd.delegate = self;
    _contentAd.posId = @"7d4b7081b1cb1467aa";
    [_contentAd loadContentAd];
}

#pragma mark - ADSuyiContentAdDelegate

- (void)adsy_contentAdSucessToLoad:(ADSuyiSDKContentAd *)contentAd contentAdView:(__kindof UIView<ADSuyiSDKContentAdViewProtocol> *)contentAdView {
    _contentAdWidth = contentAdView.contentAdSize.width;
    _contentAdHeight = contentAdView.contentAdSize.height;
      [contentAdView adsy_registView:nil];
    [self.items addObject:contentAdView];
    [self.tableView reloadData];
}

- (void)adsy_contentAdFailToLoad:(ADSuyiSDKContentAd *)contentAd errorModel:(ADSuyiAdapterErrorDefine *)errorModel {
    NSLog(@"内容广告加载失败%@",errorModel);
}

- (void)adsy_contentAdClicked:(ADSuyiSDKContentAd *)contentAd contentDetailPage:(UIViewController *)contentPageVc {
    // 使用控制器作为内容页面父控制器来添加返回按钮（按需求是否采用该方式）
    AdSuyiBaseContentViewController *contentVc = [[AdSuyiBaseContentViewController alloc] initWithViewController:contentPageVc];
    [self.navigationController pushViewController:contentVc animated:YES];
}

```


## 商务合作

邮箱：yangyu@admobile.top
