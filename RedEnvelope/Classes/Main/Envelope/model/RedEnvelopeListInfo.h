//
//  RedEnvelopeListInfo.h
//  RedEnvelope
//
//  Created by 袁江 on 2018/7/31.
//  Copyright © 2018年 Envelope. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RedEnvelope.h"

@interface RedEnvelopeListInfo : NSObject

@property (nonatomic, assign) NSInteger slots;
@property (nonatomic, assign) NSInteger nextTime;

@property (nonatomic, strong) NSArray <RedEnvelope *> *redEnvelopList;

@end
