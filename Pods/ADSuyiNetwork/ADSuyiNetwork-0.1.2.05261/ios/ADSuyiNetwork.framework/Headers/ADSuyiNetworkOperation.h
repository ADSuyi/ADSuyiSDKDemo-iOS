//
//  ADSuyiNetworkOperation.h
//  ADSuyiNetwork
//
//  Created by 陈坤 on 2020/3/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class ADSuyiNetworkOperation;
typedef void(^ADSuyiNetworkOperationCompletionBlock)(ADSuyiNetworkOperation *operation, NSURLSessionDataTask *dataTask, NSData *data, NSError *error);

@interface ADSuyiNetworkOperation : NSOperation

/// 当前请求
@property (nonatomic, readonly) NSURLRequest *URLRequest;
/// 网络请求任务
@property (nonatomic, readonly) NSURLSessionDataTask *dataTask;
/// 请求响应
@property (nonatomic, readonly) NSHTTPURLResponse *response;
/// 请求响应数据
@property (nonatomic, readonly) NSData *data;
/// 请求错误
@property (nonatomic, readonly) NSError *error;

/**
 根据NSURLRequest初始化任务

 @param URLRequest URLRequest对象
 @return 请求任务
 */
+ (instancetype)operationWithRequest:(NSURLRequest *)URLRequest;
- (instancetype)initWithRequest:(NSURLRequest *)URLRequest;

/**
 设置请求任务的结束回调

 @param completionBlock 结束回调
 */
- (void)setCompletion:(ADSuyiNetworkOperationCompletionBlock)completionBlock;

@end

NS_ASSUME_NONNULL_END
