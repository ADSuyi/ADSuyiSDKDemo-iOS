//
//  UIDevice+ADSuyiKit.h
//  ADSuyiKit
//
//  Created by 陈坤 on 2020/3/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (ADSuyiKit)

#pragma mark - Device Information

// 系统版本号 (e.g. 8.0)
+ (double)adsy_systemVersion;

// 运营商识别码 (e.g. "46001"), 获取失败返回nil
+ (nullable NSString *)adsy_imsi;

// 网络类型 (e.g. "4G"), 获取失败返回nil
+ (nullable NSString *)adsy_networkType;

// idfa广告标识符,获取失败返回nil
+ (nullable NSString *)adsy_idfa;

// idfv,获取失败返回空字符串
+ (NSString *)adsy_idfv;

// 设备原始型号
+ (NSString *)adsy_rawDeviceModel;

// 设备上次开机时间
+ (nullable NSString *)adsy_lastPowerONTime;

// 获取uuid
+ (NSString *)adsy_uuid;

// 是否模拟器
+ (BOOL)adsy_isSimulator;

@end

#ifndef kSystemVersion
#define kSystemVersion [UIDevice adsy_systemVersion]
#endif

#ifndef kiOS7Later
#define kiOS7Later (kSystemVersion >= 7)
#endif

#ifndef kiOS8Later
#define kiOS8Later (kSystemVersion >= 8)
#endif

#ifndef kiOS9Later
#define kiOS9Later (kSystemVersion >= 9)
#endif

#ifndef kiOS10Later
#define kiOS10Later (kSystemVersion >= 10)
#endif

#ifndef kiOS11Later
#define kiOS11Later (kSystemVersion >= 11)
#endif

#ifndef kiOS12Later
#define kiOS12Later (kSystemVersion >= 12)
#endif

#ifndef kiOS13Later
#define kiOS13Later (kSystemVersion >= 13)
#endif

NS_ASSUME_NONNULL_END
