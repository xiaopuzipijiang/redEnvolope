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
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:self.avatar];
        
        [self.avatar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(15));
            make.top.equalTo(@(50));
            make.bottom.equalTo(@(-50));
            make.width.height.mas_equalTo(kAvatarWidth);
        }];
        
        self.avatar.backgroundColor = UICOLOR_RANDOM;
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

@end
