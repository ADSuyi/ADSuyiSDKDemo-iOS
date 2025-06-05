//
//  SetConfigManager.m
//  ADSuyiDev
//
//  Created by Erik on 2021/4/26.
//

#import "SetConfigManager.h"


@interface SetConfigManager()

@end

@implementation SetConfigManager

+ (instancetype)sharedManager {
    static SetConfigManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [SetConfigManager new];
    });
    return manager;
}

- (NSString *)platform {
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"platform"];
}

- (void)setPlatform:(NSString *)platform {
    [[NSUserDefaults standardUserDefaults] setValue:platform forKey:@"platform"];
}

- (BOOL)isCustomSkipView {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"customskipview"];
}

- (void)setIsCustomSkipView:(BOOL)isCustomSkipView {
    [[NSUserDefaults standardUserDefaults] setBool:isCustomSkipView forKey:@"customskipview"];
}

- (BOOL)nativeAdMuted {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"nativeadmuted"];
}

- (void)setNativeAdMuted:(BOOL)nativeAdMuted {
    [[NSUserDefaults standardUserDefaults] setBool:nativeAdMuted forKey:@"nativeadmuted"];
}

- (NSString *)nativeAdScenceId {
    if ([[NSUserDefaults standardUserDefaults] stringForKey:@"nativeadscenceid"]==nil) {
        return @"";
    }
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"nativeadscenceid"];
}

- (void)setNativeAdScenceId:(NSString *)nativeAdScenceId {
    [[NSUserDefaults standardUserDefaults] setValue:nativeAdScenceId forKey:@"nativeadscenceid"];
}

- (NSInteger)nativeAdCount {
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"nativeadcount"] == nil) {
        return 1;
    }
    return [[[NSUserDefaults standardUserDefaults] valueForKey:@"nativeadcount"] integerValue];
}

- (void)setNativeAdCount:(NSInteger)nativeAdCount {
    [[NSUserDefaults standardUserDefaults] setValue:@(nativeAdCount) forKey:@"nativeadcount"];
}

- (NSInteger)bannerAdInterval {
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"banneradinterval"]==nil) {
        return 0;
    }
    return [[[NSUserDefaults standardUserDefaults] valueForKey:@"banneradinterval"] integerValue];
}

- (void)setBannerAdInterval:(NSInteger)bannerAdInterval {
    [[NSUserDefaults standardUserDefaults] setValue:@(bannerAdInterval) forKey:@"banneradinterval"];
}

- (NSString *)bannerAdScenceId {
    if ([[NSUserDefaults standardUserDefaults] stringForKey:@"banneradscenceid"] == nil) {
        return @"";
    }
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"banneradscenceid"];
}

- (void)setBannerAdScenceId:(NSString *)bannerAdScenceId {
    [[NSUserDefaults standardUserDefaults] setValue:bannerAdScenceId forKey:@"banneradscenceid"];
}

- (NSInteger)drawAdCount {
    if (![[NSUserDefaults standardUserDefaults] integerForKey:@"drawadcount"])
        return 1;
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"drawadcount"];
}

- (void)setDrawAdCount:(NSInteger)drawAdCount {
    [[NSUserDefaults standardUserDefaults] setInteger:drawAdCount forKey:@"drawadcount"];
}

- (NSString *)fullAdAdScenceId {
    if ([[NSUserDefaults standardUserDefaults] stringForKey:@"fulladscenceid"] == nil) {
        return @"";
    }
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"fulladscenceid"];
}

- (void)setFullAdAdScenceId:(NSString *)fullAdAdScenceId {
    [[NSUserDefaults standardUserDefaults] setValue:fullAdAdScenceId forKey:@"fulladscenceid"];
}


- (BOOL)showNotificationAd {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"shownotificationad"];
}

- (void)setShowNotificationAd:(BOOL)showNotificationAd {
    [[NSUserDefaults standardUserDefaults] setBool:showNotificationAd forKey:@"shownotificationad"];
}




@end
