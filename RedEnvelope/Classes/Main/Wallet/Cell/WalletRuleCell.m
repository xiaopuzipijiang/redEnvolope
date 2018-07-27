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

@end

@implementation WalletRuleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.ruleLabel = [[UILabel alloc] init];
        self.ruleLabel.text = @"票票规则";
        self.ruleLabel.textAlignment = NSTextAlignmentCenter;
        self.ruleLabel.backgroundColor = HEXCOLOR(0xe9e9e9);
        self.ruleLabel.font = [UIFont systemFontOfSize:14.0f];
        self.ruleLabel.textColor = DM153GRAYCOLOR;
        [self.contentView addSubview:self.ruleLabel];
        
        [self.ruleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 0, 0, 0));
            make.height.mas_equalTo(40);
        }];
    }
    
    return self;
}


@end
