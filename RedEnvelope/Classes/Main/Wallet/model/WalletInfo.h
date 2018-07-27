//
//  WalletInfo.h
//  RedEnvelope
//
//  Created by 袁江 on 2018/7/26.
//  Copyright © 2018年 Envelope. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BalanceInfo.h"

@class TrendInfo;

@interface WalletInfo : NSObject

@property (nonatomic, strong) BalanceInfo *balance;

@property (nonatomic, strong) TrendInfo *trendInfo;

@end
