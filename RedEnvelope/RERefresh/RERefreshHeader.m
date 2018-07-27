//
//  RERefreshHeader.m
//  RedEnvelope
//
//  Created by 袁江 on 2018/7/22.
//  Copyright © 2018年 Envelope. All rights reserved.
//

#import "RERefreshHeader.h"

@implementation RERefreshHeader


- (void)prepare
{
    [super prepare];
    
    self.stateLabel.hidden = YES;
    self.lastUpdatedTimeLabel.hidden = YES;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
