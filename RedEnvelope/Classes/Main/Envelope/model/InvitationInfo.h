//
//  InvitationInfo.h
//  RedEnvelope
//
//  Created by 袁江 on 2018/7/27.
//  Copyright © 2018年 Envelope. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InvitationInfo : NSObject

@property (nonatomic, strong) NSString *inviteCode;
@property (nonatomic, strong) NSString *url;

@property (nonatomic, assign) NSInteger inviteChildCount;
@property (nonatomic, assign) NSInteger inviteGrandCount;

@end
