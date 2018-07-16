//
//  NetWorkClient.h
//  RedEnvelope
//
//  Created by 袁江 on 2018/7/11.
//  Copyright © 2018年 Envelope. All rights reserved.
//

#import <Foundation/Foundation.h>

//typedef void(^HttpRequestCompletionHandler)(BOOL success, NSError *error);
//typedef void(^HttpRequestCompletionObjectHandler)(BOOL success, id object, NSError *error);


@interface NetWorkClient : NSObject

- (void)requestWithPath:(NSString *)path params:(NSDictionary *)params completionHandler:(nullable void (^)(NSURLResponse *response, id _Nullable responseObject,  NSError * _Nullable error))completionHandler;

@end
