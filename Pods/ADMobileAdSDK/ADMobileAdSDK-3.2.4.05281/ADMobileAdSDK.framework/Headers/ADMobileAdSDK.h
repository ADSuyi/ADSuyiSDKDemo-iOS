//
//  ADMobileAdSDK.h
//  Pods-ADMobileAdSDK_Example
//
//  Created by 陈坤 on 2019/3/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ADMobileAdSDK : NSObject

@property (nonatomic, copy, readonly) NSString *appId;
@property (nonatomic, copy, readonly) NSString *token;

/**
 Returns the shared ADMobileAdSDK instance
 
 @return the instance of ADMobileAdSDK
 */
+ (instancetype)sharedInstance;

/**
 Initialize the sdk. This must be called before any other API for the SDK used.
 
 @param appId the appid
 @param token the token
 @param turn request back or not
 */
+ (void)initSdkWithAppId:(nonnull NSString *)appId token:(nonnull NSString *)token withTurn:(BOOL)turn;

/**
 Get the SDK version
 */
+ (NSString *)getSDKVersion;


@end

@interface ADMobileAdSDK (UI)

/// To tint the bar's subItems color
@property (nonatomic, strong) UIColor *barItemTintColor;
/// To tint the bar's background
@property (nonatomic, strong) UIColor *barTintColor;
/// the bar's right or left items font
@property (nonatomic, strong) UIFont *barItemFont;
/// the bar's Title font
@property (nonatomic, strong) UIFont *barTitleFont;

@end

NS_ASSUME_NONNULL_END
