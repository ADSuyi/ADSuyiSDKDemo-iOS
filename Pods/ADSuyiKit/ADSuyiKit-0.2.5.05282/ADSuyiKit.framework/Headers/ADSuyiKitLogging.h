//
//  ADSuyiKitLogging.h
//  ADSuyiKit
//
//  Created by 陈坤 on 2020/3/19.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ADSuyiKitLogLevel) {
    /// No logs
    ADSuyiKitLogLevelOff     = 0,
    /// Error logs only. 0...00001
    ADSuyiKitLogLevelError   = (1 << 0),
    /// Error and warning logs, 0...00010
    ADSuyiKitLogLevelWarning = (1 << 1),
    /// Error, warning and info logs, 0...00100
    ADSuyiKitLogLevelInfo    = (1 << 2),
    /// Error, warning, info and debug logs, 0...01000
    ADSuyiKitLogLevelDebug   = (1 << 3),
    /// Error, warning, info, debug and verbose logs, 0...10000
    ADSuyiKitLogLevelVerbose = (1 << 4),
    /// All logs. 1...11111
    ADSuyiKitLogLevelAll     = NSUIntegerMax
};

ADSuyiKitLogLevel ADSuyiKitLogGetLevel(void);
void ADSuyiKitLogSetLevel(ADSuyiKitLogLevel level);

void _ADSuyiKitLogError(NSString *format, ...);
void _ADSuyiKitLogWarn(NSString *format, ...);
void _ADSuyiKitLogInfo(NSString *format, ...);
void _ADSuyiKitLogDebug(NSString *format, ...);
void _ADSuyiKitLogVerbose(NSString *format, ...);

#ifdef DEBUG
    #define ADSuyiKitLogError(...)   _ADSuyiKitLogError(__VA_ARGS__)
    #define ADSuyiKitLogWarn(...)    _ADSuyiKitLogWarn(__VA_ARGS__)
    #define ADSuyiKitLogInfo(...)    _ADSuyiKitLogInfo(__VA_ARGS__)
    #define ADSuyiKitLogDebug(...)   _ADSuyiKitLogDebug(__VA_ARGS__)
    #define ADSuyiKitLogVerbose(...) _ADSuyiKitLogVerbose(__VA_ARGS__)
#else
    #define ADSuyiKitLogError(...)   _ADSuyiKitLogError(__VA_ARGS__)
    #define ADSuyiKitLogWarn(...)    _ADSuyiKitLogWarn(__VA_ARGS__)
    #define ADSuyiKitLogInfo(...)    _ADSuyiKitLogInfo(__VA_ARGS__)
    #define ADSuyiKitLogDebug(...)   _ADSuyiKitLogDebug(__VA_ARGS__)
    #define ADSuyiKitLogVerbose(...) {}
#endif
