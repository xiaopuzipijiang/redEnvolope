//
//  HomeInfo.h
//  RedEnvelope
//
//  Created by 袁江 on 2018/7/22.
//  Copyright © 2018年 Envelope. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RedEnvelope.h"
#import "BalanceInfo.h"
#import "InvitationInfo.h"

@interface HomeInfo : NSObject

@property (nonatomic, assign) NSInteger slots;
@property (nonatomic, assign) NSInteger nextTime;

@property (nonatomic, strong) NSArray <RedEnvelope *> *redEnvelopList;

@property (nonatomic, strong) BalanceInfo *balanceInfo;

@property (nonatomic, strong) InvitationInfo *invitationInfo;

@end
