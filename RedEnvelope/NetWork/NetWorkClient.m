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

@end
