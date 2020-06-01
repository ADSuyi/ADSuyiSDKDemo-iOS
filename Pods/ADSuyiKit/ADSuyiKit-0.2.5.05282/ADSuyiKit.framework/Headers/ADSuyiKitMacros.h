//
//  ADSuyiKitMacros.h
//  ADSuyiKit
//
//  Created by 陈坤 on 2020/3/17.
//

#ifndef ADSuyiKitMacros_h
#define ADSuyiKitMacros_h

#import <UIKit/UIKit.h>

#define ADSY_SUPPRESS_PERFORM_SELECTOR_LEAK_WARNING(code) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
code; \
_Pragma("clang diagnostic pop")

// 字符串是否为空
#define kADSYStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || ![str isKindOfClass:[NSString class]] || [str length] < 1 ? YES : NO)
// 数组是否为空
#define kADSYArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || ![array isKindOfClass:[NSArray class]] || array.count == 0)
// 字典是否为空
#define kADSYDictIsEmpty(dict) (dict == nil || [dict isKindOfClass:[NSNull class]] || ![dict isKindOfClass:[NSDictionary class]] || dict.allKeys.count == 0)
// 对象是否为空
#define kADSYObjectIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [_object isKindOfClass:[NSData class]] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [_object isKindOfClass:[NSArray class]] && [(NSArray *)_object count] == 0))


static inline CGSize ADSuyiKitScreenSize(void) {
    static CGSize size;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        size = [UIScreen mainScreen].bounds.size;
        if (size.height < size.width) {
            CGFloat tmp = size.height;
            size.height = size.width;
            size.width = tmp;
        }
    });
    return size;
}

static inline CGFloat ADSuyiKitScreenScale(void) {
    static CGFloat scale;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        scale = [UIScreen mainScreen].scale;
    });
    return scale;
}

// main screen's scale (portrait)
#ifndef kADSYScreenScale
#define kADSYScreenScale ADSuyiKitScreenScale();
#endif

// main screen's size (portrait)
#ifndef kADSYScreenSize
#define kADSYScreenSize ADSuyiKitScreenSize();
#endif

// main screen's width (portrait)
#ifndef kADSYScreenWidth
#define kADSYScreenWidth ADSuyiKitScreenSize().width
#endif

// main screen's height (portrait)
#ifndef kADSYScreenHeight
#define kADSYScreenHeight ADSuyiKitScreenSize().height
#endif

#define kADSYCurveScreen (CGSizeEqualToSize(CGSizeMake(375.f, 812.f), [UIScreen mainScreen].bounds.size) || CGSizeEqualToSize(CGSizeMake(812.f, 375.f), [UIScreen mainScreen].bounds.size)  || CGSizeEqualToSize(CGSizeMake(414.f, 896.f), [UIScreen mainScreen].bounds.size) || CGSizeEqualToSize(CGSizeMake(896.f, 414.f), [UIScreen mainScreen].bounds.size)) // 刘海屏幕

// iphone 4及4s 屏幕尺寸为3：2
#define KADSYSmallScreen (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone && kADSYScreenWidth == 320.0 && kADSYScreenHeight == 480.0)

#define kADSYStatusBarHeight (kADSYCurveScreen ? 44 : 20)
#define kADSYNavBarHeight 44
#define kADSYTopBarHeight (kADSYStatusBarHeight + kADSYNavBarHeight)
#define kADSYTabBarHeight (kADSYCurveScreen ? 83 : 49)


#endif /* ADSuyiKitMacros_h */
