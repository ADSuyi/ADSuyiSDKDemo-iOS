//
//  ADMobGenInfoKeyChainManager.h
//  ADMobGenDeviceInfo
//
//  Created by 陶冶明 on 2019/8/20.
//

#import <Foundation/Foundation.h>
#import <Security/Security.h>

NS_ASSUME_NONNULL_BEGIN

@interface ADMobGenInfoKeyChainManager : NSObject

+ (BOOL)saveValue:(NSString *)value forKey:(NSString *)key NS_UNAVAILABLE;

+ (BOOL)saveValue:(NSString *)value forKey:(NSString *)key withAccount:(NSString *)account;

+ (NSString *)readValueForKey:(NSString *)key NS_UNAVAILABLE;

+ (NSString *)readValueForKey:(NSString *)key withAccount:(NSString *)account;

@end

NS_ASSUME_NONNULL_END
