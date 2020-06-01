//
//  NSData+ADSuyiKit.h
//  ADSuyiKit
//
//  Created by 陈坤 on 2020/3/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (ADSuyiKit)

/**
 AES CBC 128位加密模式
 */
- (nullable NSData *)AESCBC128EncryptWithKey:(NSString *)key gIv:(NSString *)Iv;
/**
AES CBC 128位解密模式
*/
- (nullable NSData *)AESCBC128DecryptWithKey:(NSString *)key gIv:(NSString *)Iv;
/**
AES CBC 256位加密模式
*/
- (nullable NSData *)AESCBC256EncryptWithKey:(NSString *)key gIv:(NSString *)Iv;
/**
AES CBC 256位解密模式
*/
- (nullable NSData *)AESCBC256DecryptWithKey:(NSString *)key gIv:(NSString *)Iv;

/**
AES CBC 256位解密模式
*/
- (nullable NSData *)AESCBC256OpenDecryptWithKey:(NSString *)key gIv:(NSString *)Iv;

@end

NS_ASSUME_NONNULL_END
