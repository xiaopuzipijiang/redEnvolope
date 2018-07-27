//
//  TrendInfo.h
//  RedEnvelope
//
//  Created by 袁江 on 2018/7/26.
//  Copyright © 2018年 Envelope. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TrendItem;

@interface TrendInfo : NSObject

@property (nonatomic, assign) CGFloat max;
@property (nonatomic, assign) CGFloat min;
@property (nonatomic, strong) NSArray <TrendItem *> *trends;

- (NSArray *)dataArray;
- (NSArray *)trendArray;

@end
