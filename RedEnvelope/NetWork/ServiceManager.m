//
//  ServiceManager.m
//  RedEnvelope
//
//  Created by 袁江 on 2018/7/20.
//  Copyright © 2018年 Envelope. All rights reserved.
//

#import "ServiceManager.h"
#import "NetWorkClient.h"
#import "UserAccount.h"
#import "UserInfo.h"
#import "HomeInfo.h"
#import "GrabRecord.h"
#import "WalletInfo.h"
#import "TrendInfo.h"

@interface ServiceManager ()

@property (nonatomic, strong) NetWorkClient *networkClient;

@end

@implementation ServiceManager

- (instancetype)init
{
    if (self = [super init])
    {
        self.networkClient = [NetWorkClient sharedClient];
    }
    
    return self;
}

+ (instancetype)sharedManager
{
    static id manager;
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        manager = [[self alloc] init];
    });
    
    return manager;
}

- (void)loginWithToken:(NSString *)token completionHandler:(DMHttpRequestCompletionObjectHandler)completionHandler
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:token, @"code", nil];
    [self.networkClient postWithPath:@"/api/user/thirdLogin" params:params completionHandler:^(BOOL success, id responseObject, NSString *errorMessage) {
        if (success)
        {
            UserAccount *account = [UserAccount modelWithJSON:responseObject];
            [account saveAccount];
            completionHandler(YES, account, nil);
        }
        else
        {
            completionHandler(NO, nil, errorMessage);
        }
    }];
}

- (void)requestUserInfoWithCompletionHandler:(DMHttpRequestCompletionObjectHandler)completionHandler
{
    [self.networkClient postWithPath:@"api/login/home" params:nil completionHandler:^(BOOL success, id responseObject, NSString *errorMessage) {
        if (success)
        {
            UserInfo *userInfo = [UserInfo modelWithJSON:[responseObject dictForKey:@"profileInfo"]];
            completionHandler(YES, userInfo, nil);
        }
        else
        {
            completionHandler(NO, nil, errorMessage);
        }
    }];
}

- (void)requestHomerInfoWithCompletionHandler:(DMHttpRequestCompletionObjectHandler)completionHandler
{
    [self.networkClient postWithPath:@"api/login/home" params:nil completionHandler:^(BOOL success, id responseObject, NSString *errorMessage) {
        
        if (success)
        {
            HomeInfo *homeInfo = [HomeInfo modelWithJSON:[responseObject dictForKey:@"bonusInfo"]];
            BalanceInfo *balanceInfo = [BalanceInfo modelWithJSON:[responseObject dictForKey:@"balanceInfo"]];
            homeInfo.balanceInfo = balanceInfo;
            
            completionHandler(YES, homeInfo, errorMessage);
        }
        else
        {
            completionHandler(NO, nil, errorMessage);
        }
    }];
}

- (void)requestWalletInfoWithCompletionHandler:(DMHttpRequestCompletionObjectHandler)completionHandler
{
    [self.networkClient postWithPath:@"api/login/home" params:nil completionHandler:^(BOOL success, id responseObject, NSString *errorMessage) {
        
        if (success)
        {
            WalletInfo *walletInfo = [[WalletInfo alloc] init];
            
            BalanceInfo *balanceInfo = [BalanceInfo modelWithJSON:[responseObject dictForKey:@"balanceInfo"]];
            walletInfo.balance = balanceInfo;
            
            TrendInfo *trendInfo = [TrendInfo modelWithJSON:[responseObject dictForKey:@"trendInfo"]];
            walletInfo.trendInfo = trendInfo;
            
            completionHandler(YES, walletInfo, errorMessage);
        }
        else
        {
            completionHandler(NO, nil, errorMessage);
        }
    }];
}

- (void)bigRequest:(DMHttpRequestCompletionObjectHandler)completionHandler
{
    [self.networkClient postWithPath:@"api/login/home" params:nil completionHandler:^(BOOL success, id responseObject, NSString *errorMessage) {
        
    }];
}

- (void)requestPrenticeListWithResultSet:(REPrenticeResultSet *)resultSet completionHandler:(DMHttpRequestCompletionObjectHandler)completionHandler
{
    NSDictionary *params;
    if (resultSet.lastId != 0)
    {
       params = [NSDictionary dictionaryWithObjectsAndKeys:@(resultSet.lastId), @"lastId", nil];
    }
    
    [self.networkClient postWithPath:@"api/user/children" params:params completionHandler:^(BOOL success, id responseObject, NSString *errorMessage) {
        if (success)
        {
            NSArray *userList = [NSArray modelArrayWithClass:[UserInfo class] json:[responseObject arrayForKey:@"users"]];
            resultSet.lastId = [responseObject integerForKey:@"lastId"];
            resultSet.hasMore = [responseObject boolForKey:@"hasMore"];
            [resultSet addItems:userList];
            completionHandler(YES, userList, nil);
        }
        else
        {
            completionHandler(NO, nil, errorMessage);
        }
    }];
}

- (void)requestDiscipleListWithResultSet:(REPrenticeResultSet *)resultSet completionHandler:(DMHttpRequestCompletionObjectHandler)completionHandler
{
    NSDictionary *params;
    if (resultSet.lastId != 0)
    {
        params = [NSDictionary dictionaryWithObjectsAndKeys:@(resultSet.lastId), @"lastId", nil];
    }
    [self.networkClient postWithPath:@"api/user/grandchildren" params:params completionHandler:^(BOOL success, id responseObject, NSString *errorMessage) {
        if (success)
        {
            NSArray *userList = [NSArray modelArrayWithClass:[UserInfo class] json:[responseObject arrayForKey:@"users"]];
            resultSet.lastId = [responseObject integerForKey:@"lastId"];
            resultSet.hasMore = [responseObject boolForKey:@"hasMore"];
            [resultSet addItems:userList];
            completionHandler(YES, userList, nil);
        }
        else
        {
            completionHandler(NO, nil, errorMessage);
        }
    }];
}

- (void)requestApprenticeRewardListWithResultSet:(DMResultSet *)resultSet completionHandler:(DMHttpRequestCompletionHandler)completionHandler
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@(resultSet.currentPage), @"page", nil];
    
    [self.networkClient postWithPath:@"/api/bonus/invited" params:params completionHandler:^(BOOL success, id responseObject, NSString *errorMessage) {
        if (success)
        {
            NSArray *array = [NSArray modelArrayWithClass:[GrabRecord class] json:[responseObject arrayForKey:@"records"]];
            resultSet.hasMore = [responseObject boolForKey:@"hasMore"];
            [resultSet addItems:array];
            completionHandler(YES, nil);
        }
        else
        {
            completionHandler(NO, errorMessage);
        }
    }];
}

- (void)grabRecordListWithResult:(DMResultSet *)resultSet CompletionHandler:(DMHttpRequestCompletionHandler)completionHandler
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@(resultSet.currentPage), @"page", nil];
    
    [self.networkClient postWithPath:@"/api/bonus/earned" params:params completionHandler:^(BOOL success, id responseObject, NSString *errorMessage) {
        if (success)
        {
            NSArray *array = [NSArray modelArrayWithClass:[GrabRecord class] json:[responseObject arrayForKey:@"records"]];
            resultSet.hasMore = [responseObject boolForKey:@"hasMore"];
            [resultSet addItems:array];
            completionHandler(YES, nil);
        }
        else
        {
            completionHandler(NO, errorMessage);
        }
    }];
}

- (void)openEnvelopeWithId:(NSString *)envelopeId completionHandler:(DMHttpRequestCompletionObjectHandler)completionHandler;
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:envelopeId, @"id", nil];
    [self.networkClient postWithPath:@"/api/bonus/open" params:params completionHandler:^(BOOL success, id responseObject, NSString *errorMessage) {
        if (success)
        {
            completionHandler(YES, responseObject, nil);
        }
        else
        {
            completionHandler(NO, nil, errorMessage);
        }
    }];
}

@end
