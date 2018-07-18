//
//  WechatManager.m
//  RedEnvelope
//
//  Created by 袁江 on 2018/7/18.
//  Copyright © 2018年 Envelope. All rights reserved.
//

#import "WechatManager.h"

@interface WechatManager () <WXApiDelegate>

@property (nonatomic, copy) WeChatSignInCompletionHandler signCompletionHandler;

@end

@implementation WechatManager

+ (instancetype)sharedManager
{
    static id manager;
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        manager = [[self alloc] init];
    });
    
    return manager;
}

- (void)signInWithCompletionHandler:(WeChatSignInCompletionHandler)completionHandler
{
    
}

- (BOOL)handleURL:(NSURL *)url;
{
    return [WXApi handleOpenURL:url delegate:self];
}

-(void) onReq:(BaseReq*)reqonReq
{
    
}

-(void) onResp:(BaseResp*)resp
{
    if ([resp isKindOfClass:[SendAuthResp class]])
    {
        SendAuthResp *authResp = (SendAuthResp *)resp;
        
        if (authResp.errCode == -4)
        {
            [SVProgressHUD showErrorWithStatus:@"用户拒绝授权"];
        }
        
        if (authResp.errCode == -2)
        {
            [SVProgressHUD showErrorWithStatus:@"用户取消"];
        }
        
        if (authResp.errCode == 0){
            
        }
    }
}

@end
