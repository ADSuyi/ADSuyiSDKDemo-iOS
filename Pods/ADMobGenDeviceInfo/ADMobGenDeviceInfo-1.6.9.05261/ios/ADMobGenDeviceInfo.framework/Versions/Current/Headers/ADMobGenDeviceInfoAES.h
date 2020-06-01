//
//  ADMobileAES.h
//  ADMobileLib
//
//  Created by 陈坤 on 2019/4/9.
//  Copyright © 2019 陈坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#pragma mark - GET string
/**
 AES CBC模式加密
*/
NSString *KADMGAESEncryptString(NSString *content, NSString *key);
/**
 AES CBC模式解密
*/
NSString *KADMGAESDecryptString(NSString *content, NSString *key);

/**
AES ECB模式加密
*/
NSString * KADMGAESECBEncryptString(NSString *content, NSString *key);
/**
AES ECB模式解密
*/
NSString * KADMGAESECBDecryptString(NSString *content, NSString *key);

#pragma mark - GET data
/**
AES CBC模式加密
*/
NSData *KADMGAESEncryptData(NSData *data, NSData *keyData);
/**
 AES CBC模式解密
*/
NSData *KADMGAESDecryptData(NSData *data, NSData *keyData);
/**
 AES ECB模式加密
 */
NSData * KADMGAESECBEncryptData(NSData *contentData, NSData *keyData);
/**
 AES ECB模式解密
*/
NSData * KADMGAESECBDecryptData(NSData *contentData, NSData *keyData);
