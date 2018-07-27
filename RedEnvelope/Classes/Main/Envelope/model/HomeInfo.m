//
//  HomeInfo.m
//  RedEnvelope
//
//  Created by 袁江 on 2018/7/22.
//  Copyright © 2018年 Envelope. All rights reserved.
//

#import "HomeInfo.h"

@implementation HomeInfo

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"redEnvelopList" : @"bonus"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"redEnvelopList" : [RedEnvelope class]};
}

@end
