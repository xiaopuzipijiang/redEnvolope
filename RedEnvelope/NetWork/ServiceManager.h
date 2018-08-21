//
//  ServiceManager.h
//  RedEnvelope
//
//  Created by 袁江 on 2018/7/20.
//  Copyright © 2018年 Envelope. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "REPrenticeResultSet.h"

@class NetWorkClient;
@class HomeInfo;

typedef void(^DMHttpRequestCompletionHandler)(BOOL success, NSString *errorMessage);
typedef void(^DMHttpRequestCompletionObjectHandler)(BOOL success, id object, NSString *errorMessage);

@interface ServiceManager : NSObject

@property (nonatomic, strong, readonly) NetWorkClient *networkClient;

@property (nonatomic, strong, readonly) HomeInfo *homeInfo;

+ (instancetype)sharedManager;

- (void)loginWithToken:(NSString *)token completionHandler:(DMHttpRequestCompletionObjectHandler)completionHandler;
- (void)vistorLoginWithcompletionHandler:(DMHttpRequestCompletionObjectHandler)completionHandler;


//用户信息
- (void)requestUserInfoWithCompletionHandler:(DMHttpRequestCompletionObjectHandler)completionHandler;
- (void)uploadToken:(NSString *)token completionHandler:(DMHttpRequestCompletionHandler)completionHandler;

//首页信息
- (void)requestHomerInfoWithCompletionHandler:(DMHttpRequestCompletionObjectHandler)completionHandler;


//获取徒弟列表
- (void)requestPrenticeListWithResultSet:(REPrenticeResultSet *)resultSet completionHandler:(DMHttpRequestCompletionObjectHandler)completionHandler;

//获取徒孙列表
- (void)requestDiscipleListWithResultSet:(REPrenticeResultSet *)resultSet completionHandler:(DMHttpRequestCompletionObjectHandler)completionHandler;

//收徒奖励
- (void)requestApprenticeRewardListWithResultSet:(DMResultSet *)resultSet completionHandler:(DMHttpRequestCompletionHandler)completionHandler;


//收到的红包接口
- (void)grabRecordListWithResult:(DMResultSet *)resultSet CompletionHandler:(DMHttpRequestCompletionHandler)completionHandler;

//拆红包接口
- (void)openEnvelopeWithId:(NSString *)envelopeId completionHandler:(DMHttpRequestCompletionObjectHandler)completionHandler;

//钱包详情
- (void)requestWalletInfoWithCompletionHandler:(DMHttpRequestCompletionObjectHandler)completionHandler;

//提现
- (void)requestWithdrawWithCount:(NSInteger)amount completionHandler:(DMHttpRequestCompletionHandler)completionHandler;

//提现记录
- (void)requestWithdrawRecordListWithResult:(DMResultSet *)resultSet completionHandler:(DMHttpRequestCompletionHandler)completionHandler;

//阿里相关
- (void)requestAliInfoCompletionHandler:(DMHttpRequestCompletionObjectHandler)completionHandler;
- (void)notifiyAliHasShowCompletionHandler:(DMHttpRequestCompletionHandler)completionHandler;

//log

- (void)requestRecodLogWithPrarms:(NSDictionary *)params;

@end
