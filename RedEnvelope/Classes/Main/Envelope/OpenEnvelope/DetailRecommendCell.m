//
//  DetailRecommendCell.m
//  RedEnvelope
//
//  Created by 袁江 on 2018/7/16.
//  Copyright © 2018年 Envelope. All rights reserved.
//

#import "DetailRecommendCell.h"

@interface DetailRecommendCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *typeIcon;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UIImageView *coverImageView;

@end

@implementation DetailRecommendCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        self.titleLabel.textColor = DMMainTextColor;
        [self.contentView addSubview:self.titleLabel];
        self.titleLabel.text = @"点击啊链家分；阿法\nflajf;af短发";
        self.titleLabel.numberOfLines = 2;

        self.typeIcon = [[UIButton alloc] init];
        [self.typeIcon setTitle:@"广告" forState:UIControlStateNormal];
        self.typeIcon.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        
        self.descLabel = [[UILabel alloc] init];
        self.descLabel.font = [UIFont systemFontOfSize:14.0f];
        self.descLabel.textColor = DM153GRAYCOLOR;
        [self.contentView addSubview:self.titleLabel];
        self.descLabel.text = @"小字典";

        self.coverImageView = [[UIImageView alloc] init];
        self.coverImageView.backgroundColor = [UIColor greenColor];
        
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.typeIcon];
        [self.contentView addSubview:self.descLabel];
        [self.contentView addSubview:self.coverImageView];

        [self.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@-15);
            make.top.equalTo(@10);
            make.bottom.equalTo(@-10);
            make.width.mas_equalTo(120);
            make.height.mas_equalTo(70);
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@15);
            make.top.equalTo(@10);
            make.right.equalTo(@-180);
        }];
        
        [self.typeIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@15);
            make.bottom.equalTo(@-10);
        }];
        
        [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.typeIcon.mas_right).with.offset(10);
            make.centerY.equalTo(self.typeIcon);
        }];

    }
    
    return self;
}

@end
