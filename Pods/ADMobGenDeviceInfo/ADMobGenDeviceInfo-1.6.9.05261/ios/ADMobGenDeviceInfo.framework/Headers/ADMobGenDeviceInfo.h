//
//  ADMobGenDeviceInfo.h
//  ADMobGenDeviceInfo
//
//  Created by 陈坤 on 2019/1/14.
//

#import <Foundation/Foundation.h>
#import "ADMobGenTKEventModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ADMobGenDeviceInfo : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, readonly, copy) NSString *admg_imsi; ///< 运营商
@property (nonatomic, readonly, assign) int64_t admg_machineId; ///< machineId, iOS
@property (nonatomic, readonly, assign) int admg_machineType; ///< 机器类型, iOS
@property (nonatomic, readonly, copy) NSString *admg_ua; ///< 浏览器的user-agent
@property (nonatomic, readonly, copy) NSString *admg_networkType; ///< 网络类型
@property (nonatomic, readonly, assign) NSInteger admg_sdScreendpi; ///< 屏幕密度
@property (nonatomic, readonly, copy) NSString *admg_osVersion; ///< 操作系统版本
@property (nonatomic, readonly, copy) NSString *admg_vendor; ///< 手机生产厂商
@property (nonatomic, readonly, copy) NSString *admg_modelNo; ///< 手机型号(转化过后)
@property (nonatomic, readonly, copy) NSString *admg_rawModelNo; ///< 手机型号
@property (nonatomic, readonly, copy) NSString *admg_idfa; ///< 广告标识符
@property (nonatomic, readonly, copy) NSString *admg_openUdid; ///<
@property (nonatomic, readonly, copy) NSString *admg_lat; ///< 纬度1
@property (nonatomic, readonly, copy) NSString *admg_lng; ///< 经度1
@property (nonatomic, readonly, copy) NSString *admg_ip; ///< ip地址1
@property (nonatomic, readonly, assign) NSInteger admg_deviceType; ///< 设备类型, ipad,手机等1
@property (nonatomic, readonly, copy) NSString *admg_idfv;
@property (nonatomic, readonly, copy) NSString *admg_language; ///< 设备语言设置
@property (nonatomic, readonly, copy) NSString *admg_orientation; ///< 横屏竖屏
@property (nonatomic, readonly, assign) int admg_battery; ///< 电池电量
@property (nonatomic, readonly, assign) int admg_isroot; ///< 是否越狱
@property (nonatomic, readonly, copy) NSString *admg_country; ///< 所处国家
@property (nonatomic, readonly, assign) int admg_coordinateType; ///< 坐标类型
@property (nonatomic, readonly, assign) double admg_locaAccuracy; ///< 坐标精度
@property (nonatomic, readonly, assign) double admg_coordTime; ///< 坐标经纬度时间戳
@property (nonatomic, readonly, copy) NSString *admg_bssId; ///< wifi地址
@property (nonatomic, readonly, copy) NSString *admg_mcc; ///< 运营商国家代码1
@property (nonatomic, readonly, copy) NSString *admg_ssid; ///< wifi名称
@property (nonatomic, readonly, assign) int admg_cpuType; ///< cpu类型
@property (nonatomic, readonly, assign) int admg_cpuSubtype; ///< cpu子类型
@property (nonatomic, readonly, copy) NSString *admg_bt;//蓝牙信息加密字符串 （与mac加密方式相同）(iOS 只能获取到设备名称，设备名称为本机的设备名称)
@property (nonatomic, readonly, copy) NSString *admg_wordSize;//字号
@property (nonatomic, readonly, copy) NSString *admg_lastPowerOnTime;//设备开机时间

- (void)sendCustomEventsWithEventModel:(ADMobGenTKEventModel *)eventModel withUpLoadURL:(NSString *)upLoadURL;
/**
 上传用户信息，以提高广告的填充和精准度
 手机号key:pho
 */
- (void)setUserInfo:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
