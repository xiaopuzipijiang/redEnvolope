//
//  RecommendHeaderCell.m
//  RedEnvelope
//
//  Created by 袁江 on 2018/7/16.
//  Copyright © 2018年 Envelope. All rights reserved.
//

#import "RecommendHeaderCell.h"

@interface RecommendHeaderCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIView *line;

@end

@implementation RecommendHeaderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.bottomSeparatorInsets = UIEdgeInsetsMake(0, 0, 0, 0);

        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.bottomSeparatorInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        self.titleLabel.textColor = DMMainTextColor;
        [self.contentView addSubview:self.titleLabel];
        self.titleLabel.text = @"猜你喜欢";
        
        self.line = [[UIView alloc] init];
        self.line.backgroundColor = HEXCOLOR(0x61adfa);
        [self.contentView addSubview:self.line];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@15);
            make.top.equalTo(@18);
            make.bottom.equalTo(@-18);
            make.height.mas_equalTo(15);
        }];

        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self.titleLabel.mas_width);
            make.centerX.equalTo(self.titleLabel);
            make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-2);
            make.height.mas_equalTo(2);
        }];
        
    }
    
    return self;
}


@end
