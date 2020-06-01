//
//  NSDate+ADSuyiKit.h
//  ADSuyiKit
//
//  Created by 陈坤 on 2020/3/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (ADSuyiKit)

@property (nonatomic, assign, readonly) NSInteger adsy_year;
@property (nonatomic, assign, readonly) NSInteger adsy_month;
@property (nonatomic, assign, readonly) NSInteger adsy_day;
@property (nonatomic, assign, readonly) NSInteger adsy_hour;
@property (nonatomic, assign, readonly) NSInteger adsy_minute;
@property (nonatomic, assign, readonly) NSInteger adsy_seconds;
@property (nonatomic, assign, readonly) NSInteger adsy_nanoseconds;
@property (nonatomic, assign, readonly) NSInteger adsy_weekday;

+ (nullable NSDate *)adsy_dateWithDateString:(NSString *)dateString;

+(nullable NSDate *)adsy_dateWithFormat_yyyy_MM_dd_HH_mm_ss_string:(NSString *)string;
+(nullable NSDate *)adsy_dateWithFormat_yyyy_MM_dd_HH_mm_string:(NSString *)string;
+(nullable NSDate *)adsy_dateWithFormat_yyyy_MM_dd_HH_string:(NSString *)string;
+(nullable NSDate *)adsy_dateWithFormat_yyyy_MM_dd_string:(NSString *)string;
+(nullable NSDate *)adsy_dateWithFormat_yyyy_MM_string:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
