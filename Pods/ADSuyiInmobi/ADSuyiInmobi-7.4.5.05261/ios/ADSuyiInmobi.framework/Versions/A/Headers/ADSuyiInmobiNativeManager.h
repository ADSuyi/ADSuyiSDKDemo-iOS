//
//  ADSuyiInmobiNativeManager.h
//  ADSuyiInmobi
//
//  Created by 陶冶明 on 2020/4/26.
//

#import <Foundation/Foundation.h>
#import <InMobiSDK/InMobiSDK.h>

NS_ASSUME_NONNULL_BEGIN

@class ADSuyiInmobiNativeManager;

@protocol ADSuyiInmobiNativeManagerDelegate <IMNativeDelegate>

- (void)nativeFailToLoad:(ADSuyiInmobiNativeManager *)manager error:(NSError *)error;

- (void)nativeSuccedToLoad:(ADSuyiInmobiNativeManager *)manager nativeArr:(NSArray<IMNative *> *)nativeArr;

@end

@interface ADSuyiInmobiNativeManager : NSObject

@property (nonatomic, copy) NSString *posId;

- (void)loadWithCount:(NSInteger)count;

@property (nonatomic, weak) id<ADSuyiInmobiNativeManagerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
