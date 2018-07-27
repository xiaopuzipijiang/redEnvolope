//
//  WalletHeaderCell.h
//  RedEnvelope
//
//  Created by 袁江 on 2018/7/15.
//  Copyright © 2018年 Envelope. All rights reserved.
//

#import "DMTableViewCell.h"

@interface WalletHeaderCell : DMTableViewCell

@property (nonatomic, strong, readonly) UILabel *balanceTitleLabel;
@property (nonatomic, strong, readonly) UILabel *balanceLabel;

@property (nonatomic, strong, readonly) UIButton *withdrawCashButton;
@property (nonatomic, strong, readonly) UILabel *exchangeRuleLabel;

- (void)setBalance:(NSString *)balacne;

@end
