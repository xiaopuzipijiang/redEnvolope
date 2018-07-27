//
//  TrendInfo.m
//  RedEnvelope
//
//  Created by 袁江 on 2018/7/26.
//  Copyright © 2018年 Envelope. All rights reserved.
//

#import "TrendInfo.h"
#import "TrendItem.h"

@implementation TrendInfo

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"trends" : [TrendItem class]};
}

- (NSArray *)dataArray
{
    return [self.trends valueForKey:@"time"];
}

- (NSArray *)trendArray
{
    return [self.trends valueForKey:@"price"];
}

@end
