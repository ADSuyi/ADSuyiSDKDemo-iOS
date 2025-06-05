### iOS使用说明
- -(void)adsy_rewardvodAdServerDidSucceed:(ADSuyiSDKRewardvodAd *)rewardvodAd;
- -(void)adsy_rewardvodAdServerDidSucceed:(ADSuyiSDKRewardvodAd *)rewardvodAd info:(NSDictionary *)info;
**服务端验证成功之后，上面这两个回调都会走，可根据需求进行选择**

使用代码示例：
```ObjectiveC
**初始化激励视频广告对象时传入参数userId、extraInfo**
- (void)loadRewardvodAd{
    self.rewardvodAd  = [[ADSuyiSDKRewardvodAd alloc]init];
    self.rewardvodAd.delegate = self;
    self.rewardvodAd.tolerateTimeout = 5;
    self.rewardvodAd.controller = self;
    self.rewardvodAd.posId = @"d58c23ffb1aed89aff";
    self.rewardvodAd.isMuted = [SetConfigManager sharedManager].isRewardVodAdMute;
    self.rewardvodAd.userId = @"353453";//激励验证参数
    self.rewardvodAd.extraInfo = @"fregrw";//激励验证参数（根据自己的需求传入自定义参数，然后转为json字符串即可）
    [self.rewardvodAd loadRewardvodAd];
}
**视频广告激励服务验证成功会走的两个回调**
- (void)adsy_rewardvodAdServerDidSucceed:(ADSuyiSDKRewardvodAd *)rewardvodAd{
   //添加自己的逻辑
}
- (void)adsy_rewardvodAdServerDidSucceed:(ADSuyiSDKRewardvodAd *)rewardvodAd info:(NSDictionary *)info{
    if ([rewardvodAd.adsy_platform isEqualToString:ADSuyiAdapterPlatformGDT]) {//优量汇
        NSDictionary *gdtInfo = info[@"info"];
        // gdtInfo示例 @{@"GDT_TRANS_ID":@"930f1fc8ac59983bbdf4548ee40ac353"}, 通过@“GDT_TRANS_ID”可获取此次广告行为的交易id
        
    }else if ([rewardvodAd.adsy_platform isEqualToString:ADSuyiAdapterPlatformMTG]){//汇量
        MTGRewardAdInfo *minterginInfo = info[@"info"];
        备注：需导入汇量头文件#import <MTGSDK/MTGSDK.h>
        
    }else{//穿山甲、百度、快手
        NSString *otherPlatformInfo = info[@"info"];
        //otherPlatformInfo示例 @""
        
    }
    
    //添加自己的逻辑
}
```