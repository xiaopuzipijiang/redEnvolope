//
//  DMMineProfileLogoutCell.m
//  DealmoonMerchant
//
//  Created by 袁江 on 2018/5/28.
//  Copyright © 2018年 Dealmoon. All rights reserved.
//

#import "DMMineProfileLogoutCell.h"

@interface DMMineProfileLogoutCell()

@property (nonatomic, strong) UILabel *logoutLabel;

@end

@implementation DMMineProfileLogoutCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.logoutLabel = [[UILabel alloc] init];
        self.logoutLabel.text = NSLocalizedString(@"退出登录", nil);
        self.logoutLabel.textColor = HEXCOLOR(0xfc5b5b);
        self.logoutLabel.font = [UIFont boldSystemFontOfSize:18.0f];
        
        [self.contentView addSubview:self.logoutLabel];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    [self.logoutLabel sizeToFit];
    self.logoutLabel.integralCenterX = self.contentView.width / 2;
    self.logoutLabel.integralCenterY = self.contentView.height / 2;
}

+ (CGFloat)cellHeightWithDataObject:(id)object width:(CGFloat)width
{
    return 45;
}

@end
