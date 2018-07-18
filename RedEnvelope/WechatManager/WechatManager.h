//
//  WechatManager.h
//  RedEnvelope
//
//  Created by 袁江 on 2018/7/18.
//  Copyright © 2018年 Envelope. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^WeChatSignInCompletionHandler)(BOOL success, NSError *error);

@interface WechatManager : NSObject

+ (instancetype)sharedManager;

- (BOOL)handleURL:(NSURL *)url;

- (void)signInWithCompletionHandler:(WeChatSignInCompletionHandler)completionHandler;

@end
