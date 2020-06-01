//
//  ADSuyiKitMachineManager.h
//  ADSuyiKit
//
//  Created by 陈坤 on 2020/4/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ADSuyiKitMachineManager : NSObject

+ (instancetype)sharedInstance;

- (NSString *)readAdMachine;

@end

NS_ASSUME_NONNULL_END
