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
#import "RedEnvelopeListInfo.h"

@interface HomeInfo : NSObject

@property (nonatomic, strong) RedEnvelopeListInfo *redEnvelopListInfo;

@property (nonatomic, strong) BalanceInfo *balanceInfo;

@property (nonatomic, strong) InvitationInfo *invitationInfo;

@property (nonatomic, strong) NSString *morePack;

@end
