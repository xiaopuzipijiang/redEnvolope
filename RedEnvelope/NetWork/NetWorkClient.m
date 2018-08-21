//
//  NetWorkClient.m
//  RedEnvelope
//
//  Created by 袁江 on 2018/7/11.
//  Copyright © 2018年 Envelope. All rights reserved.
//

#import "NetWorkClient.h"

#define kSecretKey  @"11111f99fc9c0341e19a5c9d1da17c64"

//NSString * const NetworkBaseURLString = @"https://54fc89ec.ngrok.io";

NSString * const NetworkBaseURLString = @"https://hongbao.kanqibao.com";

@interface NetWorkClient ()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end


@implementation NetWorkClient

+ (instancetype)sharedClient
{
    static dispatch_once_t onceToken;
    static NetWorkClient *sharedClient;
    dispatch_once(&onceToken, ^{
        sharedClient = [[[self class] alloc] init];
    });
    
    return sharedClient;
}

- (instancetype)init
{
    self = [super init];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    self.sessionManager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
    
    return self;
}

- (void)postWithPath:(NSString *)path params:(NSDictionary *)params completionHandler:(NetWorkClientCompletionHandler)completionHandler;
{
    [self requestWithPath:path method:@"POST" params:params completionHandler:completionHandler];
}

- (void)requestWithPath:(NSString *)path method:(NSString *)method params:(NSDictionary *)params completionHandler:(NetWorkClientCompletionHandler)completionHandler
{
    NSError *error;
    
    NSString *fullPath = [NetworkBaseURLString stringByAppendingPathComponent:path];
    NSMutableDictionary *fullPatams = [[NSMutableDictionary alloc] initWithCapacity:10];
    [fullPatams addEntriesFromDictionary:params];
    
    [fullPatams setObject:[[UIDevice currentDevice] identifierForVendor].UUIDString forKey:@"uniqid"];
    [fullPatams setObject:@((NSInteger)[NSDate date].timeIntervalSince1970 * 1000) forKey:@"req_time"];
    [fullPatams setObject:@(1002) forKey:@"app_id"];
    [fullPatams setObject:[[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleShortVersionString"] forKey:@"v"];
    
    if ([UserAccount currentUserAccount])
    {
        [fullPatams setSafeObject:[UserAccount currentUserAccount].t forKey:@"t"];
    }
    
    [self paramsProcessedWithOriginParams:fullPatams WebServiceName:path];
    
    NSURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:method URLString:fullPath parameters:fullPatams error:nil];
    
    if (!error) {
        
        NSURLSessionDataTask *dataTask = [self.sessionManager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            
            if (error)
            {
                completionHandler(NO, nil, error.localizedDescription);
                return;
            }
            
            if ([responseObject integerForKey:@"code"] != 0)
            {
                
                if ([responseObject integerForKey:@"code"] == 7)
                {
                    PSTAlertController *alertController = [PSTAlertController alertWithTitle:NSLocalizedString(@"帐号验证失败", nil) message:NSLocalizedString(@"您的帐号登录信息已失效，请重新登录。", nil)];
                    [alertController addAction:[PSTAlertAction actionWithTitle:NSLocalizedString(@"确定", nil) handler:^(PSTAlertAction * _Nonnull action) {
                        [[UserAccount currentUserAccount] logout];
                        [kAPPDelegate showGuide];
                    }]];
                    [alertController showWithSender:nil controller:nil animated:YES completion:nil];
                }
                else
                {
                    completionHandler(NO, nil, [responseObject stringForKey:@"message"]);
                }
                
                return;
            }
            
            completionHandler(YES, responseObject, nil);
        }];
        
        [dataTask resume];
    }
}

- (NSDictionary *)paramsProcessedWithOriginParams:(NSDictionary *)params WebServiceName:(NSString *)wsn {
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithDictionary:params];
    
    NSArray *keys = [paramDict allKeys];
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2];
    }];
    
    NSMutableString *paramString = [NSMutableString string];
    for (NSString *key in sortedArray) {
        NSString *str = [NSString stringWithFormat:@"%@",[paramDict objectForKey:key]];
        if (((NSNull *)str!=[NSNull null] && str!=nil && [str isKindOfClass:[NSString class]] && str.length>0)) {
            [paramString appendString:[NSString stringWithFormat:@"%@=%@",key,str]];
        }
        paramDict[key] = str;
    }
    
    NSString *k5str = [paramString substringToIndex:MIN([paramString length] , 5000)];
    
    NSString *secretString = [UserAccount currentUserAccount] ? [NSString stringWithFormat:@"%@%@", kSecretKey, [UserAccount currentUserAccount].secretKey]: kSecretKey;
    
    NSString *md5str = [NSString stringWithFormat:@"%@%@%@", wsn,k5str,secretString];
    NSString *sig = [[md5str md5String] lowercaseString];
    [params setValue:[sig lowercaseString] forKey:@"sig"];
    
    
    return paramDict;
}

@end
