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

        self.contentView.backgroundColor = HEXCOLOR(0xffffff);

        self.exchangePriceLabel = [[UILabel alloc] init];
        self.exchangePriceLabel.numberOfLines = 2;
        self.exchangePriceLabel.textAlignment = NSTextAlignmentCenter;
        
        self.ticketCountLabel = [[UILabel alloc] init];
        self.ticketCountLabel.numberOfLines = 2;
        self.ticketCountLabel.textAlignment = NSTextAlignmentCenter;

        self.seperatorLine = [[UIView alloc] init];
        self.seperatorLine.backgroundColor = HEXCOLOR(0xf5f5f5);
        
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
            make.top.equalTo(@18);
            make.bottom.equalTo(@-18);
            make.centerX.equalTo(self.contentView);
            make.width.mas_equalTo(1);
        }];

    }
    
    return self;
}

- (void)setBalanceInfo:(BalanceInfo *)balanceInfo
{
    NSMutableAttributedString *mAString = [[NSMutableAttributedString alloc] initWithString:balanceInfo.price ? : @"" attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:17.0f], NSForegroundColorAttributeName : HEXCOLOR(0x333333)}];
    
    [mAString appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n今日提现价" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12.0f], NSForegroundColorAttributeName : HEXCOLOR(0x888888)}]];

    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 5;
    style.alignment = NSTextAlignmentCenter;
    
    [mAString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, mAString.length)];
    
    self.exchangePriceLabel.attributedText = mAString;
    
    mAString = [[NSMutableAttributedString alloc] initWithString:balanceInfo.amount ? : @"" attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:17.0f], NSForegroundColorAttributeName : HEXCOLOR(0x333333)}];

    [mAString appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n我的票票数" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12.0f], NSForegroundColorAttributeName : HEXCOLOR(0x888888)}]];

    [mAString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, mAString.length)];

    self.ticketCountLabel.attributedText = mAString;

}

@end
