//
//  WithdDrawRecordCell.m
//  RedEnvelope
//
//  Created by 袁江 on 2018/7/17.
//  Copyright © 2018年 Envelope. All rights reserved.
//

#import "WithdDrawRecordCell.h"

@interface WithdDrawRecordCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *amountLabel;

@end

@implementation WithdDrawRecordCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        self.titleLabel.textColor = HEXCOLOR(0x333333);
        self.titleLabel.text = @"提现状态";
        
        self.timeLabel = [[UILabel alloc] init];
        self.timeLabel.font = [UIFont systemFontOfSize:12.0f];
        self.timeLabel.textColor = HEXCOLOR(0x999999);
        self.timeLabel.text = @"2018-04-17 11:32";
        
        self.amountLabel = [[UILabel alloc] init];
        self.amountLabel.font = [UIFont systemFontOfSize:14.0f];
        self.amountLabel.textColor = DM153GRAYCOLOR;
        self.amountLabel.text = @"+ 0.1223";
        
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.amountLabel];
        
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@20);
            make.left.equalTo(@15);
            
        }];
        
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).with.offset(10);
            make.left.equalTo(@15);
        }];
        
        [self.amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@27);
            make.right.equalTo(@-20);
            make.height.mas_equalTo(16);
            make.bottom.equalTo(@-27);
        }];
        
    }
    
    return self;
}



@end

