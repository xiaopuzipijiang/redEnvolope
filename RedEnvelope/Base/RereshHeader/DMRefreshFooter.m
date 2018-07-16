//
//  DMRefreshFooter.m
//  DealmoonMerchant
//
//  Created by 袁江 on 2018/6/23.
//  Copyright © 2018年 Dealmoon. All rights reserved.
//

#import "DMRefreshFooter.h"

@implementation DMRefreshFooter

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
