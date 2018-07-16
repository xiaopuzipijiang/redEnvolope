//
//  DetailHeaderCell.m
//  RedEnvelope
//
//  Created by 袁江 on 2018/7/16.
//  Copyright © 2018年 Envelope. All rights reserved.
//

#import "DetailHeaderCell.h"

@interface DetailHeaderCell ()

@property (nonatomic, strong) UIImageView *headerBg;

@property (nonatomic, strong) UIImageView *redEnvelopeView;

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *amountLabel;
@property (nonatomic, strong) UILabel *descLabel;

@property (nonatomic, strong) UIButton *ticketButton;

@end

@implementation DetailHeaderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.separatorMode = DMTableViewCellSeparatorModeNone;
        self.contentView.backgroundColor = HEXCOLOR(0xe8e8ea);
        
        self.headerBg = [[UIImageView alloc] init];
        self.headerBg.image = [UIImage imageNamed:@"首页-打开红包上部分"];
        [self.contentView addSubview:self.headerBg];
        
        self.redEnvelopeView = [[UIImageView alloc] init];
        self.redEnvelopeView.image = [UIImage imageNamed:@"关于天天刷红包"];
        [self.contentView addSubview:self.redEnvelopeView];
        
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.font = [UIFont systemFontOfSize:16.0f];
        self.nameLabel.textColor = DMMainTextColor;
        self.nameLabel.text = @"时时红包";
        [self.contentView addSubview:self.nameLabel];

        self.amountLabel = [[UILabel alloc] init];
        self.amountLabel.font = [UIFont systemFontOfSize:16.0f];
        self.amountLabel.textColor = DMMainTextColor;
        self.amountLabel.text = @"1.2222元";
        [self.contentView addSubview:self.amountLabel];

        self.descLabel = [[UILabel alloc] init];
        self.descLabel.font = [UIFont systemFontOfSize:16.0f];
        self.descLabel.textColor = DM153GRAYCOLOR;
        self.descLabel.text = @"已存入红包，可提现";
        [self.contentView addSubview:self.descLabel];
        
        self.ticketButton = [[UIButton alloc] init];
        [self.ticketButton setTitle:@"+0.61233票票" forState:UIControlStateNormal];
        self.ticketButton.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        self.ticketButton.backgroundColor = [UIColor orangeColor];
        self.ticketButton.contentEdgeInsets = UIEdgeInsetsMake(3, 20, 3, 5);
        [self.contentView addSubview:self.ticketButton];
        
        [self.headerBg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@0);
            make.right.equalTo(@0);
            make.top.equalTo(@0);
            make.height.mas_equalTo(self.width * 220 / 750);
        }];
        
        [self.redEnvelopeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.mas_equalTo(70);
            make.centerX.equalTo(self.contentView);
            make.top.equalTo(self.headerBg.mas_bottom).with.offset(-35);
        }];

        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView);
            make.top.equalTo(self.redEnvelopeView.mas_bottom).with.offset(10);
        }];

        [self.amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView);
            make.top.equalTo(self.nameLabel.mas_bottom).with.offset(10);
        }];
        
        [self.ticketButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.amountLabel.mas_top).with.offset(5);
            make.left.equalTo(self.amountLabel.mas_right).with.offset(-5);
        }];

        [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView);
            make.top.equalTo(self.amountLabel.mas_bottom).with.offset(10);
            make.bottom.equalTo(@-30);
        }];

    }
    
    return self;
}


@end