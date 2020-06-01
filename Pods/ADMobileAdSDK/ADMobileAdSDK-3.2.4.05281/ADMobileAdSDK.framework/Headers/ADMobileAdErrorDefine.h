//
//  ADMobileAdErrorDefine.h
//  ADMobileAdSDK
//
//  Created by 陈坤 on 2020/4/9.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ADMobilePlayerState) {
    ADMobilePlayerStateInitial = 0,//初始化状态
    ADMobilePlayerStateBuffering = 1,//缓冲中
    ADMobilePlayerStatePlaying = 2,//播放中
    ADMobilePlayerStatePaused = 3,//播放暂停
    ADMobilePlayerStateStopped = 4,//播放停止
    ADMobilePlayerStateError = 5,//播放出错
    ADMobilePlayerStateFinish = 6,//播放完成
};

typedef enum : NSInteger {
    ADMOBILE_SPLASH_ARGUMENTEMPTY = 11000, //admobile spalsh广告参数错误
    ADMOBILE_SPLASH_IMAGEEMPTY = 11001, //admobile spalsh广告图片为空
    ADMOBILE_BANNER_EMPTYIMAGE = 11020, //admobile banner广告图片为空
    ADMOBILE_BANNER_ARGUMENTEMPTY = 11021, //admobile banner广告参数错误
    ADMOBILE_REWARDVOD_LOAD_FAIL = 11060, //admobile reward video广告加载失败
    ADMOBILE_ORIGINAL_ARGUMENTEMPTY = 11080, //admobile original广告参数错误
    ADMOBILE_UNIFIEDNATIVE_ARGUMENTEMPTY = 11100, //admobile unified native广告参数错误
    ADMOBILE_INTERSTITIAL_LANDSCAPE = 11140, //admobile interstitial不支持横屏
    ADMOBILE_MIX_RENDER_ERROR = 11180, //admobile mix广告渲染失败
    ADMOBILE_MIX_ARGUMENTEMPTY = 11181, //admobile mix广告参数错误
    ADMOBILE_VIDEO_LOAD_ERROR = 11200, //admobile 视频加载失败
    ADMOBILE_NATIVE_EMPTY = 11201, //admobile native广告为空
    ADMOBILE_NATIVE_TYPE_ERROR = 11202, //admobile native类型错误
    ADMOBILE_NATIVE_ARGUMENTEMPTY = 11203, //admobile native广告参数错误
    ADMOBILE_NATIVE_IMAGEEMPTY = 11204, //admobile native广告图片为空
    ADMOBILE_NATIVE_URLEMPTY = 11205, //admobile native广告落地页为空
    ADMOBILE_VIDEO_CLEAN_ERROR = 11206, //admobile video缓存清理失败
    ADMOBILE_VIDEO_WRITE_ERROR = 11207, //admobile video写入失败
    ADMOBILE_VIDEO_READ_ERROR = 11208, //admobile video读取失败
    ADMOBILE_VIDEO_ITEMPLAYFAIL = 11209,//视频playitem播放失败
    ADMOBILE_VIDEO_INITFAIL = 11210,//播放器初始化失败
    ADMOBILE_VIDEO_UNKNOWN = 11211,//视频资源出现未知错误
} ADMobileAdErrorCode;

#define ADMobileAdErrorDomain @"com.ADMobileAd.error"

NSError *ADMobileAdError(NSInteger code, NSString *localizedDescription);
