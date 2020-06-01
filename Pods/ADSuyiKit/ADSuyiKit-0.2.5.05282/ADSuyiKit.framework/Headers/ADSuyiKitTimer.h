//
//  ADSuyiKitTimer.h
//  ADSuyiKit
//
//  Created by 陈坤 on 2020/4/10.
//

#import <Foundation/Foundation.h>

@interface ADSuyiKitTimer : NSObject

@property (nonatomic, copy) NSRunLoopMode runLoopMode;

+ (ADSuyiKitTimer *)timerWithTimeInterval:(NSTimeInterval)interval target:(id)atarget selector:(SEL)aSelector repeats:(BOOL)yesOrNo;

@property (readonly, assign) NSTimeInterval timeInterval;

@property (readonly, getter=isValid) BOOL valid;

@property (readonly, getter=isScheduled) BOOL scheduled;

- (void)invalidate;
- (BOOL)scheduleImmediately:(BOOL)immediately;
- (BOOL)pause;
- (BOOL)resume;

@end
