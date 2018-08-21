//
//  RedEnvelopeListInfo.m
//  RedEnvelope
//
//  Created by 袁江 on 2018/7/31.
//  Copyright © 2018年 Envelope. All rights reserved.
//

#import "RedEnvelopeListInfo.h"

@implementation RedEnvelopeListInfo

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"redEnvelopList" : @"bonus"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"redEnvelopList" : [RedEnvelope class]};
}

@end
