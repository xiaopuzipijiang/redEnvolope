//
//  RERefreshFooter.m
//  RedEnvelope
//
//  Created by 袁江 on 2018/7/22.
//  Copyright © 2018年 Envelope. All rights reserved.
//

#import "RERefreshFooter.h"

@implementation RERefreshFooter

- (void)prepare
{
    [super prepare];
    
    self.refreshingTitleHidden = YES;
    self.automaticallyRefresh = YES;
    self.onlyRefreshPerDrag = NO;
    self.triggerAutomaticallyRefreshPercent = -10;
    self.refreshingTitleHidden = YES;
    [self setTitle:@"" forState:MJRefreshStateIdle];
    
}

@end
