//
//  WalletRuleCell.m
//  RedEnvelope
//
//  Created by 袁江 on 2018/7/15.
//  Copyright © 2018年 Envelope. All rights reserved.
//

#import "WalletRuleCell.h"

@interface WalletRuleCell ()

@property (nonatomic, strong) UILabel *ruleLabel;

@property (nonatomic, strong) UIImageView *ruleImageView;

@end

@implementation WalletRuleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.ruleLabel = [[UILabel alloc] init];
        self.ruleLabel.text = @"票票规则";
        self.ruleLabel.textAlignment = NSTextAlignmentCenter;
        self.ruleLabel.backgroundColor = HEXCOLOR(0xe9e9e9);
        self.ruleLabel.font = [UIFont systemFontOfSize:14.0f];
        self.ruleLabel.textColor = DM153GRAYCOLOR;
        [self.contentView addSubview:self.ruleLabel];
        
        self.separatorMode = DMTableViewCellSeparatorModeNone;
        
        self.ruleImageView = [[UIImageView alloc] init];
        self.ruleImageView.image = [UIImage imageNamed:@"票票规则"];
        self.ruleImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.ruleImageView];
        
        [self.ruleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.left.equalTo(@0);
            make.right.equalTo(@0);
            make.height.mas_equalTo(40);
        }];
        
        [self.ruleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.ruleLabel.mas_bottom);
            make.left.equalTo(@0);
            make.right.equalTo(@0);
            make.height.equalTo(self.ruleImageView.mas_width).with.multipliedBy(828.0 / 750.0);
            make.bottom.equalTo(@0);
        }];
    }
    
    return self;
}


@end
