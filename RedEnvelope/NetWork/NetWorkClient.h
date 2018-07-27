//
//  NetWorkClient.h
//  RedEnvelope
//
//  Created by 袁江 on 2018/7/11.
//  Copyright © 2018年 Envelope. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^NetWorkClientCompletionHandler)(BOOL success, id responseObject, NSString *errorMessage);

@interface NetWorkClient : NSObject

+ (NetWorkClient *)sharedClient;

//- (void)requestWithPath:(NSString *_Nullable)path params:(NSDictionary *_Nullable)params completionHandler:(nullable void (^)(NSURLResponse * _Nullable response, id _Nullable responseObject,  NSError * _Nullable error))completionHandler;

- (void)postWithPath:(NSString *)path params:(NSDictionary *)params completionHandler:(NetWorkClientCompletionHandler)completionHandler;

@end
