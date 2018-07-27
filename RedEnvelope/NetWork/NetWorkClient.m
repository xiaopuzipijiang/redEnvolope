//
//  NetWorkClient.m
//  RedEnvelope
//
//  Created by 袁江 on 2018/7/11.
//  Copyright © 2018年 Envelope. All rights reserved.
//

#import "NetWorkClient.h"

#define kSecretKey  @"11111f99fc9c0341e19a5c9d1da17c64"
NSString * const NetworkBaseURLString = @"http://47.94.135.198:8080/";



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

//- (void)postWithPath:(NSString *)path params:(NSDictionary *)params completionHandler:(NetWorkClientCompletionHandler)completionHandler;
//{
//    [self requestWithPath:path method:@"GET" params:params completionHandler:completionHandler];
//}

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
    [fullPatams setObject:@"123" forKey:@"xx"];
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
                completionHandler(NO, nil, [responseObject stringForKey:@"message"]);
                return;
            }
            
            completionHandler(YES, responseObject, nil);
        }];
        
        [dataTask resume];
    }
}

- (NSDictionary *)paramsProcessedWithOriginParams:(NSDictionary *)params WebServiceName:(NSString *)wsn {
    //    reqpath = wsn;
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithDictionary:params];
    //    NSString *appVersion = [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleShortVersionString"];
    //    paramDict[@"v"] = appVersion;
    //    paramDict[@"app_id"] = self.appId;
    //    paramDict[@"req_time"] = kQTimeNow;
    //    paramDict[@"uniqid"] = mydeviceUniqueIdentifier();
    //
    //    NSMutableDictionary *clientParams = [NSMutableDictionary dictionary];
    //    clientParams[@"model"] = kQModel;
    //    clientParams[@"os"] = kQOS;
    //    clientParams[@"screen"] = kQScreen;
    //    clientParams[@"ua"] = kQUA;
    //    clientParams[@"version"] = kQDVersion;
    
    //    NSString *clientSource = @"";
    //    if (self.sourceEnum == SourceKanZhunApp) {
    //        clientSource = @"KANZHUN";
    //    } else if (self.sourceEnum == SourceBossApp) {
    //        clientSource = @"BOSS";
    //    } else if (self.sourceEnum == SourceBoss_B) {
    //        clientSource = @"BOSS_B";
    //    }
    //    clientParams[@"clientSource"] = clientSource;
    //    paramDict[@"client_info"] = [clientParams JSONString];
    //    if ([KQIdentify identifyForLocal]!=nil) {
    //        paramDict[@"t"] = [KQIdentify identifyForLocal].ticket;
    //    }
    
    
    NSArray *keys = [paramDict allKeys];
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2];
    }];
    
    NSMutableString *paramString = [NSMutableString string];
    for (NSString *key in sortedArray) {
        NSString *str = [NSString stringWithFormat:@"%@",[paramDict objectForKey:key]];
        if (((NSNull *)str!=[NSNull null] && str!=nil && [str isKindOfClass:[NSString class]] && str.length>0)) {
            
            if (paramString.length > 0)
            {
                [paramString appendString:@"&"];
            }
            [paramString appendString:[NSString stringWithFormat:@"%@=%@",key,str]];
        }
        paramDict[key] = str;
    }
    
    NSString *k5str = [paramString substringToIndex:MIN([paramString length] , 5000)];
    
    //    __block NSMutableString *keystr = [kQSecKey mutableCopy];
    
    //    if([kWSNeverAuthList containsObject:wsn] == NO)
    //    {
    //        if ([KQIdentify identifyForLocal] != nil) {
    //            [keystr appendString:[KQIdentify identifyForLocal].userSecret];
    //        }
    //    }
    
    NSString *md5str = [NSString stringWithFormat:@"%@%@%@", wsn,k5str,kSecretKey];
    NSString *sig = [[md5str md5String] lowercaseString];
    [params setValue:[sig lowercaseString] forKey:@"sig"];
    
    
    return paramDict;
}

@end
