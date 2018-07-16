//
//  WalletCountingCell.m
//  RedEnvelope
//
//  Created by 袁江 on 2018/7/15.
//  Copyright © 2018年 Envelope. All rights reserved.
//

#import "WalletCountingCell.h"

@interface WalletCountingCell ()

@property (nonatomic, strong) UILabel *exchangePriceLabel;

@property (nonatomic, strong) UIView *seperatorLine;

@property (nonatomic, strong) UILabel *ticketCountLabel;

@end

@implementation WalletCountingCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        self.contentView.backgroundColor = HEXCOLOR(0xf7f1f8);
        
        self.exchangePriceLabel = [[UILabel alloc] init];
        self.exchangePriceLabel.numberOfLines = 2;
        self.exchangePriceLabel.text = @"0.9232\n今日体现价";
        self.exchangePriceLabel.textAlignment = NSTextAlignmentCenter;
        
        self.ticketCountLabel = [[UILabel alloc] init];
        self.ticketCountLabel.numberOfLines = 2;
        self.ticketCountLabel.text = @"9.9232\n我的票票数";
        self.ticketCountLabel.textAlignment = NSTextAlignmentCenter;

        self.seperatorLine = [[UIView alloc] init];
        self.seperatorLine.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.exchangePriceLabel];
        [self.contentView addSubview:self.ticketCountLabel];
        [self.contentView addSubview:self.seperatorLine];

        [self.exchangePriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@0);
            make.top.equalTo(@0);
            make.bottom.equalTo(@0);
            make.height.mas_equalTo(80);
            make.right.equalTo(self.ticketCountLabel.mas_left);
        }];
        
        [self.ticketCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.bottom.equalTo(@0);
            make.right.equalTo(@0);
            make.width.equalTo(self.exchangePriceLabel.mas_width);
        }];
        
        [self.seperatorLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@20);
            make.bottom.equalTo(@-20);
            make.centerX.equalTo(self.contentView);
            make.width.mas_equalTo(1);
        }];

    }
    
    return self;
}



@end
