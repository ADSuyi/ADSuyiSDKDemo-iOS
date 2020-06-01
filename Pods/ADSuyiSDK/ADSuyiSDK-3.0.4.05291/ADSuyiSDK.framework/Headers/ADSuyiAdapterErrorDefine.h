//
//  ADSuyiAdapterErrorDefine.h
//  ADSuyiSDK
//
//  Created by 陈坤 on 2020/3/27.
//

#import <Foundation/Foundation.h>
#import "ADSuyiAdapterCommonDefine.h"

typedef enum : NSInteger {
    ADSY_SDK_SPLASH_LOADTIMEOUT = 10000, //splash广告获取超时
    ADSY_SDK_LANDSCAPE_NOTLOADSPLASH = 10001, //横屏不加载开屏广告
    ADSY_SDK_BANNER_LOADTIMEOUT = 10020, //banner广告获取超时
    ADSY_SDK_BANNER_LOADFAIL = 10021, //banner广告获取失败
    ADSY_SDK_BANNER_RELOAD = 10022, //banner广告重复加载
    ADSY_SDK_BANNER_VIEWNIL = 10023, //banner广告请求获取视图为空
    ADSY_SDK_NATIVE_LOADTIMEOUT = 10040, //native广告获取超时
    ADSY_SDK_NATIVE_LOADFAIL = 10041, //native广告获取失败
    ADSY_SDK_REWARDVOD_LOADTIMEOUT = 10060, //reward video广告获取超时
    ADSY_SDK_REWARDVOD_LOADFAIL = 10061, //reward video广告获取失败
    ADSY_SDK_REWARDVOD_RELOAD = 10062, //reward video广告重复加载
    ADSY_SDK_DRAWVOD_LOADTIMEOUT = 10080, //drawvod广告获取超时
    ADSY_SDK_DRAWVOD_LOADFAIL = 10081, //drawvod广告获取失败
    ADSY_SDK_INTERSTITIAL_LOADTIMEOUT = 10100, //interstitial广告获取超时
    ADSY_SDK_INTERSTITIAL_LOADFAIL = 10101, //interstitial广告获取失败
    ADSY_SDK_INIT_FAIL = 10200, //SDK初始化失败
    ADSY_SDK_APPID_NIL = 10201, //appId为空
    ADSY_SDK_PACKAGE_ERROR = 10202, //包名和appId不对应
    ADSY_SDK_CONFIG_EMPTY = 10203, //请求配置为空
    ADSY_SDK_PRATFORM_EMPTY = 10204, //未获取到加载广告的平台，可能一下原因 1、第一次启动未获取到配置信息；2、运营未配置广告
    ADSY_SDK_POSID_EMPTY = 10205, //posId为空
    ADSY_SDK_CLASS_EMPTY = 10206, //未导入需要加载的广告类型对应的类
    ADSY_SDK_VIDEO_INITFAIL = 10207, //播放器初始化失败
    ADSY_SDK_VIDEO_UNKNOWN = 10208, //视频资源出现未知错误
    ADSY_SDK_VIDEO_ITEMPLAYFAIL = 10209, //视频playitem播放失败
    
    ADSY_ADMOB_SPLASH_ARGUMENTEMPTY = 11000, //admobile spalsh广告参数错误
    ADSY_ADMOB_SPLASH_IMAGEEMPTY = 11001, //admobile spalsh广告图片为空
    ADSY_ADMOB_SPLASH_ORIENTATION = 11002, //admobile splash广告方向不对
    ADSY_ADMOB_BANNER_EMPTYIMAGE = 11020, //admobile banner广告图片为空
    ADSY_ADMOB_BANNER_ARGUMENTEMPTY = 11021, //admobile banner广告参数错误
    ADSY_ADMOB_REWARDVOD_LOAD_FAIL = 11060, //admobile reward video广告加载失败
    ADSY_ADMOB_REWARDVOD_PRESENT = 11061, //admobile rewaedVideo未知原因显示失败
    ADSY_ADMOB_ORIGINAL_ARGUMENTEMPTY = 11080, //admobile original广告参数错误
    ADSY_ADMOB_UNIFIEDNATIVE_ARGUMENTEMPTY = 11100, //admobile unified native广告参数错误
    ADSY_ADMOB_INTERSTITIAL_LANDSCAPE = 11140, //admobile interstitial不支持横屏
    ADSY_ADMOB_MIX_RENDER_ERROR = 11180, //admobile mix广告渲染失败
    ADSY_ADMOB_MIX_ARGUMENTEMPTY = 11181, //admobile mix广告参数错误
    ADSY_ADMOB_VIDEO_LOAD_ERROR = 11200, //admobile 视频加载失败
    ADSY_ADMOB_NATIVE_EMPTY = 11201, //admobile native广告为空
    ADSY_ADMOB_NATIVE_TYPE_ERROR = 11202, //admobile native类型错误
    ADSY_ADMOB_NATIVE_ARGUMENTEMPTY = 11203, //admobile native广告参数错误
    ADSY_ADMOB_NATIVE_IMAGEEMPTY = 11204, //admobile native广告图片为空
    ADSY_ADMOB_VIDEO_CLEAN_ERROR = 11205, //admobile video缓存清理失败
    ADSY_ADMOB_VIDEO_WRITE_ERROR = 11206, //admobile video写入失败
    ADSY_ADMOB_VIDEO_READ_ERROR = 11207, //admobile video读取失败
    
    ADSY_GDT_SPLASH_TIMEOUT = 30000, //gdt splash广告超时
    ADSY_GDT_REWARDVOD_PRESENT = 30060, //gdt rewaedVideo未知原因显示失败
    
    ADSY_BU_FULLSCREENVOD_PRESENT = 40200,//bu fullScreenVideo未知原因展示失败
    ADSY_BU_INTERSTITIAL_PRESENT = 40140,//bu interstitial未知原因展示失败
    ADSY_BU_SPLASH_TIMEOUT = 40000, //bu splash广告超时
    ADSY_BU_BANNER_OUTSCREEN = 40020, //bu banner广告初始化时在屏幕外
    ADSY_BU_DRAWVOD_EMPTY = 40120, //bu drawvod广告位空
    ADSY_BU_REWARDVOD_PRESENT = 40060, //bu reward未知原因展示失败
    
    ADSY_INMOBI_BANNER_OUTSCREEN = 50020, //inmobi banner广告初始化时在屏幕外
    ADSY_INMOBI_BANNER_FAILED = 50021, //inmobi banner广告获取失败
    ADSY_INMOBI_NATIVEEXPRESS_UNSUPPORTTYPE = 50040, //inmobi native express广告类型不支持
    ADSY_INMOBI_NATIVEEXPRESS_EMPTY = 50041, //inmobi native express广告为空
    ADSY_INMOBI_NATIVE_EMPTY = 50200, //inmobi native广告为空
    ADSY_INMOBI_SPLASH_PRESENT = 50060, //inmobi splash未知原因展示失败
    
    ADSY_MTG_SPLASH_TIMEOUT = 60000, //MTG 开屏超时
    ADSY_MTG_SPLASH_RENDER_ERROR = 60000, //MTG splash广告渲染失败
    ADSY_MTG_BANNER_REDER_ERROR = 60020, //MTG banner广告渲染失败
    ADSY_MTG_NATIVE_EMPTY = 60200, //MTG native广告为空
    
    ADSY_GOOGLE_NATIVEEXPRESS_UNSUPPORTTYPE = 70040, //google native express广告类型不支持
    ADSY_GOOGLE_NATIVEEXPRESS_EMPTY = 70041, //google native express广告为空
    ADSY_GOOGLE_NATIVE_EMPTY = 70200, //google native广告为空
    
    ADSY_MGTV_SPLASH_LOAD_FAIL = 80000, //MGTV splash广告获取失败
    ADSY_MGTV_BANNER_RENDER_ERROR = 80020, //MGTV banner广告渲染失败
    ADSY_MGTV_BANNER_LOAD_FAIL = 80021, //MGTV banner广告获取失败
    
    ADSY_BAIDU_SPLASH_NOAD = 90000, // 百度 开屏广告获取失败
    ADSY_BAIDU_SPLASH_TIMEOUT = 90001, //百度 开屏广告超时
    ADSY_BAIDU_INTERSTITIAL_ERROR = 90140, //百度 interstitial未知错误
    ADSY_BAIDU_AD_NOAD = 90990, // 百度广告没有推广返回
    ADSY_BAIDU_AD_EXCEPTION = 90991, // 百度广告网络或其它异常
    ADSY_BAIDU_AD_FRAME = 90992, // 百度广告尺寸或元素异常，不显示广告
    
    ADSY_MOPUB_NATIVEEXPRESS_NOAD = 91040, //mopub native express广告为空
    ADSY_KS_FULLSCREENVOD_PRESENT = 91200, //ks fullScreenVideo未知原因展示失败
    ADSY_KS_REWARD_PRESENT = 91060, //ks reward未知原因展示失败
    ADSY_MOPUB_REWARD_PRESENT = 91061, //mopub reward未知原因展示失败
    
} ADSuyiAdapterErrorCode;

#define ADSuyiAdapterErrorDomain @"com.adsyad.error"

NSError *ADSuyiAdapterError(NSErrorDomain domain, NSInteger code, NSString *localizedDescription);


@interface ADSuyiAdapterErrorDefine : NSObject

@property (nonatomic, copy, readonly) NSString *posId;

@property (nonatomic, copy, readonly) ADSuyiAdapterAdType adType;

@property (nonatomic, assign, readonly) ADSuyiAdapterErrorCode code;

@property (nonatomic, copy, readonly) NSString *errorDescription;

@property (nonatomic, strong, readonly) NSDictionary<ADSuyiAdapterPlatform,NSError *> *errorDetailDict;

@end
