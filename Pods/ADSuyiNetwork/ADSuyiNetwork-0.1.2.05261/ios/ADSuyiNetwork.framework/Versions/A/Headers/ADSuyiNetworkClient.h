//
//  ADSuyiNetworkClient.h
//  ADSuyiNetwork
//
//  Created by 陈坤 on 2020/3/19.
//

#import <Foundation/Foundation.h>
#import "ADSuyiNetworkRequestSerialization.h"
#import "ADSuyiNetworkResponseSerialization.h"

//NS_ASSUME_NONNULL_BEGIN

@interface ADSuyiNetworkClient : NSObject

/// 基础URL, 调用GET,POST方法传入的URL会跟他以"relativeToURL:"拼接
@property (nonatomic, readonly, strong) NSURL *baseURL;
/// 请求任务队列
@property (nonatomic, readonly, strong) NSOperationQueue *operationQueue;

/// 请求转换器, 根据传入参数, 解析出正确的NSURLRequest
@property (nonatomic, strong) ADSuyiNetworkRequestSerialization *requestSerializer;
/// 响应转换器, 根据需求, 把response转成对应的responseObject
@property (nonatomic, strong) ADSuyiNetworkResponseSerialization *responseSerializer;

+ (instancetype)adsy_sharedClient;

/**
 指定初始化方法, 申明为单例或者全局对象,否则会被释放

 @param baseURL 基础URL
 @return 网络请求对象
 */
- (instancetype)initWithBaseURL:(NSURL *)baseURL;

/**
 GET请求

 @param URLString 请求URL
 @param parameters 参数
 @param success 成功回调
 @param failure 失败回调
 */
- (void)GET:(NSString *)URLString
 parameters:(id)parameters
    success:(void (^)(NSURLSessionDataTask *task, NSHTTPURLResponse *response, id responseObject))success
    failure:(void (^)(NSURLSessionDataTask *task, NSHTTPURLResponse *response, NSError *error))failure;

/**
 GET请求(可定制NSURLRequest)

 @param URLString 请求URL
 @param parameters 参数
 @param requestSerializer 请求转换器
 @param success 成功回调
 @param failure 失败回调
 */
- (void)GET:(NSString *)URLString
 parameters:(id)parameters
requestSerializer:(ADSuyiNetworkRequestSerialization *)requestSerializer
    success:(void (^)(NSURLSessionDataTask *task, NSHTTPURLResponse *response, id responseObject))success
    failure:(void (^)(NSURLSessionDataTask *task, NSHTTPURLResponse *response, NSError *error))failure;

/**
 GET请求(可定制NSURLRequest,也可定制response解析)

 @param URLString 请求URL
 @param parameters 参数
 @param requestSerializer 请求转换器
 @param responseSerializer 响应转换器
 @param success 成功回调
 @param failure 失败回调
 */
- (void)GET:(NSString *)URLString
 parameters:(id)parameters
requestSerializer:(ADSuyiNetworkRequestSerialization *)requestSerializer
responseSerializer:(ADSuyiNetworkResponseSerialization *)responseSerializer
    success:(void (^)(NSURLSessionDataTask *task, NSHTTPURLResponse *response, id responseObject))success
    failure:(void (^)(NSURLSessionDataTask *task, NSHTTPURLResponse *response, NSError *error))failure;

/**
 POST请求
 
 @param URLString 请求URL
 @param parameters 参数
 @param success 成功回调
 @param failure 失败回调
 */
- (void)POST:(NSString *)URLString
  parameters:(id)parameters
     success:(void (^)(NSURLSessionDataTask *task, NSHTTPURLResponse *response, id responseObject))success
     failure:(void (^)(NSURLSessionDataTask *task, NSHTTPURLResponse *response, NSError *error))failure;

/**
 POST请求(可定制NSURLRequest)
 
 @param URLString 请求URL
 @param parameters 参数
 @param requestSerializer 请求转换器
 @param success 成功回调
 @param failure 失败回调
 */
- (void)POST:(NSString *)URLString
  parameters:(id)parameters
requestSerializer:(ADSuyiNetworkRequestSerialization *)requestSerializer
     success:(void (^)(NSURLSessionDataTask *task, NSHTTPURLResponse *response, id responseObject))success
     failure:(void (^)(NSURLSessionDataTask *task, NSHTTPURLResponse *response, NSError *error))failure;

/**
 POST请求(可定制NSURLRequest,也可定制response解析)
 
 @param URLString 请求URL
 @param parameters 参数
 @param requestSerializer 请求转换器
 @param responseSerializer 响应转换器
 @param success 成功回调
 @param failure 失败回调
 */
- (void)POST:(NSString *)URLString
  parameters:(id)parameters
requestSerializer:(ADSuyiNetworkRequestSerialization *)requestSerializer
responseSerializer:(ADSuyiNetworkResponseSerialization *)responseSerializer
     success:(void (^)(NSURLSessionDataTask *task, NSHTTPURLResponse *response, id responseObject))success
     failure:(void (^)(NSURLSessionDataTask *task, NSHTTPURLResponse *response, NSError *error))failure;

/**
 对已有的NSURLRequest进行请求
 @param request 已有的NSURLRequest
 @param responseSerializer 响应转换器
 @param success 成功回调
 @param failure 失败回调
 
 */
- (void)SendRequest:(NSURLRequest *)request
responseSerializer:(ADSuyiNetworkResponseSerialization *)responseSerializer
           success:(void (^)(NSURLSessionDataTask *task, NSHTTPURLResponse *response, id responseObject))success
            failure:(void (^)(NSURLSessionDataTask *task, NSHTTPURLResponse *response, NSError *error))failure;

@end

//NS_ASSUME_NONNULL_END
