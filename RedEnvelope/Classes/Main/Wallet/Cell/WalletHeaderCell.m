//
//  WalletHeaderCell.m
//  RedEnvelope
//
//  Created by 袁江 on 2018/7/15.
//  Copyright © 2018年 Envelope. All rights reserved.
//

#import "WalletHeaderCell.h"

@interface WalletHeaderCell ()

@property (nonatomic, strong) UILabel *balanceTitleLabel;
@property (nonatomic, strong) UILabel *balanceLabel;

@property (nonatomic, strong) UIButton *withdrawCashButton;
@property (nonatomic, strong) UILabel *exchangeRuleLabel;

@end

@implementation WalletHeaderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.balanceTitleLabel = [[UILabel alloc] init];
        self.balanceTitleLabel.font = [UIFont systemFontOfSize:16.0f];
        self.balanceTitleLabel.textColor = DM153GRAYCOLOR;
        self.balanceTitleLabel.text = @"我的票票价值";
        
        self.balanceLabel = [[UILabel alloc] init];
        self.balanceLabel.text = @"$122121";
        
        self.withdrawCashButton = [UIButton buttonWithType:UIButtonTypeSystem];
        self.withdrawCashButton.contentEdgeInsets = UIEdgeInsetsMake(5, 20, 5, 20);
        [self.withdrawCashButton setTitle:@"提现" forState:UIControlStateNormal];
        self.withdrawCashButton.backgroundColor = HEXCOLOR(0xe06f54);
        [self.withdrawCashButton setTitleColor:HEXCOLOR(0xffffff) forState:UIControlStateNormal];
        
        self.exchangeRuleLabel = [[UILabel alloc] init];
        self.exchangeRuleLabel.font = [UIFont systemFontOfSize:15.0f];
        self.exchangeRuleLabel.textColor = DM153GRAYCOLOR;
        self.exchangeRuleLabel.text = @"我的票票价值 = 今日提现价格 x 我的票票数";
        
        [self.contentView addSubview:self.balanceTitleLabel];
        [self.contentView addSubview:self.balanceLabel];
        [self.contentView addSubview:self.withdrawCashButton];
        [self.contentView addSubview:self.exchangeRuleLabel];
        
        [self.balanceTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@40);
            make.centerX.equalTo(self.contentView);
        }];

        [self.balanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.balanceTitleLabel.mas_bottom).with.offset(10);
            make.centerX.equalTo(self.contentView);
        }];

        [self.withdrawCashButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.balanceLabel.mas_bottom).with.offset(20);
            make.centerX.equalTo(self.contentView);
        }];

        [self.exchangeRuleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.withdrawCashButton.mas_bottom).with.offset(15);
            make.centerX.equalTo(self.contentView);
            make.bottom.equalTo(@-20);
        }];

    }
    
    return self;
}


@end
