//
//  ADSuyiKitGzipUtils.h
//  ADSuyiKit
//
//  Created by 陈坤 on 2020/3/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ADSuyiKitGzipUtils : NSObject

+ (nullable NSData *)adsy_gzipData:(NSData *)gzipData;

+ (nullable NSData *)adsy_unGzipData:(NSData *)unGzipData;

@end

NS_ASSUME_NONNULL_END
