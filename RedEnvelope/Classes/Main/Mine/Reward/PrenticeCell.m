//
//  PrenticeCell.m
//  RedEnvelope
//
//  Created by 袁江 on 2018/7/17.
//  Copyright © 2018年 Envelope. All rights reserved.
//

#import "PrenticeCell.h"

@interface PrenticeCell ()

@property (nonatomic, strong) UIImageView *avatar;
@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation PrenticeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
     
        self.avatar = [[UIImageView alloc] init];
        self.avatar.clipsToBounds = YES;
        self.avatar.layer.cornerRadius = 20;
        self.avatar.backgroundColor = HEXCOLOR(0xf5f5f5);
        
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.font = [UIFont systemFontOfSize:16.0f];
        self.nameLabel.textColor = HEXCOLOR(0x333333);
        self.nameLabel.text = @"用户昵称";
        
        [self.contentView addSubview:self.avatar];
        [self.contentView addSubview:self.nameLabel];
        
        [self.avatar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@15);
            make.top.equalTo(@15);
            make.bottom.equalTo(@-15);
            make.width.height.mas_equalTo(40);
        }];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.avatar);
            make.left.equalTo(self.avatar.mas_right).offset(15);
        }];
    }
    
    return self;
}

@end
