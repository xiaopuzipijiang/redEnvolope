//
//  WalletCountingCell.h
//  RedEnvelope
//
//  Created by 袁江 on 2018/7/15.
//  Copyright © 2018年 Envelope. All rights reserved.
//

#import "DMTableViewCell.h"
#import "BalanceInfo.h"

@interface WalletCountingCell : DMTableViewCell

@property (nonatomic, strong) BalanceInfo *balanceInfo;

@end
