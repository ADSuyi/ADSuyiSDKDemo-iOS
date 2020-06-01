//
//  ADSuyiKitKeyChainManager.h
//  ADSuyiKit
//
//  Created by 陈坤 on 2020/3/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ADSuyiKitKeyChainManager : NSObject

+ (BOOL)saveValue:(NSString *)value forKey:(NSString *)key NS_UNAVAILABLE;

+ (BOOL)saveValue:(NSString *)value forKey:(NSString *)key withAccount:(NSString *)account;

+ (NSString *)readValueForKey:(NSString *)key NS_UNAVAILABLE;

+ (NSString *)readValueForKey:(NSString *)key withAccount:(NSString *)account;

@end

NS_ASSUME_NONNULL_END
