//
//  ADMobGenTKEventModel.h
//  ADMobGenDeviceInfo
//
//  Created by 陈坤 on 2019/5/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ADMobGenTKEventModel : NSObject

/**
 操作逻辑,OPEN,CLOSE,CLICK,SLIDE
 */
@property (nonatomic, copy) NSString *operationType;

/**
 机器类型, iOS为2
 */
@property (nonatomic, assign) int machineType;

/**
 场景(Controller类)
 */
@property (nonatomic, copy) NSString *scheme;

/**
 开始X坐标
 */
@property (nonatomic, assign) CGFloat startCooX;

/**
 结束X坐标
 */
@property (nonatomic, assign) CGFloat endCooX;

/**
 开始Y坐标
 */
@property (nonatomic, assign) CGFloat startCooY;

/**
 结束Y坐标
 */
@property (nonatomic, assign) CGFloat endCooY;

/**
 开始时间 e.g. 2017-12-27 19:35:27
 */
@property (nonatomic, copy) NSString *startTime;

/**
 结束时间 e.g. 2017-12-27 19:35:27
 */
@property (nonatomic, copy) NSString *endTime;

/**
 安装包
 */
@property (nonatomic, readonly, copy) NSString *packageName;

/**
 版本号
 */
@property (nonatomic, readonly, copy) NSString *versionNo;

/**
 机器号, 唯一标识符
 */
@property (nonatomic, assign) int64_t machineId;

@end

NS_ASSUME_NONNULL_END
