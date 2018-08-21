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
    self.signCompletionHandler = completionHandler;
    
    SendAuthReq* req = [[SendAuthReq alloc]init];
    req.scope = @"snsapi_userinfo";
    req.state = @"123";
    [WXApi sendReq:req];
}

- (void)shareToSessionWithImage:(UIImage *)image
{
    [self shareWithImage:image scene:WXSceneSession];
}

- (void)shareToTimelineWithImage:(UIImage *)image
{
    [self shareWithImage:image scene:WXSceneTimeline];
}

- (void)shareWithImage:(UIImage *)image scene:(int)scene
{
    
    if (![WXApi isWXAppInstalled])
    {
        [SVProgressHUD showErrorWithStatus:@"未安装微信"];
    }
    
    WXMediaMessage *message = [WXMediaMessage message];
    [message setThumbImage:image];
    
    WXImageObject *imageObject = [WXImageObject object];
    imageObject.imageData = [image imageDataRepresentation];
    message.mediaObject = imageObject;
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = scene;
    [WXApi sendReq:req];
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
            if (self.signCompletionHandler)
            {
                self.signCompletionHandler(YES, authResp.code, nil);
            }
        }
    }
}

@end
