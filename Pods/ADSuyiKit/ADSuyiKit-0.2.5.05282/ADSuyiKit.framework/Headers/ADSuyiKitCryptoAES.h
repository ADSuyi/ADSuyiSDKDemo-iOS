//
//  ADSuyiKitCryptoAES.h
//  ADSuyiKit
//
//  Created by 陈坤 on 2020/3/19.
//

#import <Foundation/Foundation.h>

#pragma mark - GET string
/**
AES ECB模式加密
*/
NSString * KADSYAESECBEncryptString(NSString *content, NSString *key);
/**
AES ECB模式解密
*/
NSString * KADSYAESECBDecryptString(NSString *content, NSString *key);

#pragma mark - GET data

/**
 AES ECB模式加密
 */
NSData * KADSYAESECBEncryptData(NSData *contentData, NSData *keyData);
/**
 AES ECB模式解密
*/
NSData * KADSYAESECBDecryptData(NSData *contentData, NSData *keyData);

#pragma mark - AES CBC 加解密

NSString * KADSYAESCBCEncryptData(NSString *content, NSString *key, NSString *iv);

NSString * KADSYAESCBCDecryptData(NSString *content, NSString *key, NSString *iv);
