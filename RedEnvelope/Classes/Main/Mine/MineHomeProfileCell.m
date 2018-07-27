//
//  MineHomeProfileCell.m
//  RedEnvelope
//
//  Created by 袁江 on 2018/7/14.
//  Copyright © 2018年 Envelope. All rights reserved.
//

#import "MineHomeProfileCell.h"

#define kAvatarWidth 60

@interface MineHomeProfileCell ()

@property (nonatomic, strong) UIImageView *avatar;
@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation MineHomeProfileCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:self.avatar];
        [self.contentView addSubview:self.nameLabel];

        [self.avatar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(15));
            make.top.equalTo(@(50));
            make.bottom.equalTo(@(-50));
            make.width.height.mas_equalTo(kAvatarWidth);
        }];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.avatar.mas_right).with.offset(10);
            make.centerY.equalTo(self.avatar);
        }];
    }
    
    return self;
}

- (UIImageView *)avatar
{
    if (!_avatar)
    {
        _avatar = [[UIImageView alloc] init];
        _avatar.clipsToBounds = YES;
        _avatar.layer.cornerRadius = kAvatarWidth / 2;
    }
    
    return _avatar;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel)
    {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [UIColor whiteColor];
    }
    
    return _nameLabel;
}




@end
