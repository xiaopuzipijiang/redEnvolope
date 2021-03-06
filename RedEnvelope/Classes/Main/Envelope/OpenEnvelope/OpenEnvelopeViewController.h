//
//  OpenEnvelopeViewController.h
//  RedEnvelope
//
//  Created by 袁江 on 2018/7/14.
//  Copyright © 2018年 Envelope. All rights reserved.
//

#import "DMViewController.h"

@class RedEnvelope;

@interface OpenEnvelopeViewController : DMViewController

- (instancetype)initWithRedEnvelope:(RedEnvelope *)redEnvelope CompletionHandler:(void (^)(BOOL success, id object))completionHandler;

@end
