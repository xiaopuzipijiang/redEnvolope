//
//  NetWorkClient.m
//  RedEnvelope
//
//  Created by 袁江 on 2018/7/11.
//  Copyright © 2018年 Envelope. All rights reserved.
//

#import "NetWorkClient.h"

NSString * const DMNetworkBaseURLString = @"http://adm.it4.dealmoon.net:8081/";
NSString * const DMNetworkTestBaseURLString = @"https://api2.it4.dealmoon.net/";

@interface NetWorkClient ()

@property (nonatomic, strong) AFURLSessionManager *sessionManager;

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

    self.sessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    return self;
}

- (void)requestWithPath:(NSString *)path params:(NSDictionary *)params completionHandler:(nullable void (^)(NSURLResponse *response, id _Nullable responseObject,  NSError * _Nullable error))completionHandler
{
    NSError *error;
    NSURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:@"xxx" parameters:nil error:&error];
    
    if (!error) {
        
        NSURLSessionDataTask *dataTask = [self.sessionManager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            completionHandler(response, responseObject, error);
        }];
        
        [dataTask resume];
    }
}

//- (NSDictionary *)paramsProcessedWithOriginParams:(NSDictionary *)params WebServiceName:(NSString *)wsn {
//    reqpath = wsn;
//    NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithDictionary:params];
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
//
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
//
//
//    NSArray *keys = [paramDict allKeys];
//    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
//        return [obj1 compare:obj2];
//    }];
//
//    NSMutableString *paramString = [NSMutableString string];
//    for (NSString *key in sortedArray) {
//        NSString *str = [NSString stringWithFormat:@"%@",[paramDict objectForKey:key]];
//        if (((NSNull *)str!=[NSNull null] && str!=nil && [str isKindOfClass:[NSString class]] && str.length>0)) {
//            [paramString appendString:[NSString stringWithFormat:@"%@=%@",key,str]];
//        }
//        paramDict[key] = str;
//    }
//
//    NSString *k5str = [paramString substringToIndex:MIN([paramString length] , 5000)];
//
//    __block NSMutableString *keystr = [kQSecKey mutableCopy];
//
//    if([kWSNeverAuthList containsObject:wsn] == NO)
//    {
//        if ([KQIdentify identifyForLocal] != nil) {
//            [keystr appendString:[KQIdentify identifyForLocal].userSecret];
//        }
//    }
//
//    NSString *md5str = [NSString stringWithFormat:@"%@%@%@", wsn,k5str,keystr];
//    NSString *sig = [self stringDecodingByMD5:md5str];
//    [paramDict setValue:[sig lowercaseString] forKey:@"sig"];
//
    
//    return paramDict;
//}

@end
