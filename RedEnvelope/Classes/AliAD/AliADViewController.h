//
//  AliADViewController.h
//  RedEnvelope
//
//  Created by 袁江 on 2018/7/31.
//  Copyright © 2018年 Envelope. All rights reserved.
//

#import "DMViewController.h"
#import "AliADInfo.h"

@interface AliADViewController : DMViewController

+ (void)showAliADViewController:(AliADInfo *)aliADInfo didPressedADBlock:(void (^)(void))block;

@end
