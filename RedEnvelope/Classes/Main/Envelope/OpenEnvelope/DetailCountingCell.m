//
//  DetailCountingCell.m
//  RedEnvelope
//
//  Created by 袁江 on 2018/7/16.
//  Copyright © 2018年 Envelope. All rights reserved.
//

#import "DetailCountingCell.h"

@interface DetailCountingCell ()

@property (nonatomic, strong) UILabel *countingLabel;

@end

@implementation DetailCountingCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.bottomSeparatorInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        
        self.countingLabel = [[UILabel alloc] init];
        self.countingLabel.font = [UIFont systemFontOfSize:14.0f];
        self.countingLabel.textColor = DM153GRAYCOLOR;
        [self.contentView addSubview:self.countingLabel];
        self.countingLabel.text = @"已领取100000+份";
        
        [self.countingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(15, 15, 15, 15));
            make.height.mas_equalTo(15);
        }];
    }
    
    return self;
}


@end
