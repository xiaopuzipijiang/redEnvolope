//
//  EnvelopeCollectionViewCell.m
//  RedEnvelope
//
//  Created by 袁江 on 2018/7/14.
//  Copyright © 2018年 Envelope. All rights reserved.
//

#import "EnvelopeCollectionViewCell.h"

@interface EnvelopeCollectionViewCell ()

@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UILabel *deadLineLabel;

@end

@implementation EnvelopeCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];

    self.coverImageView = [[UIImageView alloc] init];
    self.coverImageView.image = [UIImage imageNamed:@"首页-未拆红包"];
    [self.contentView addSubview:self.coverImageView];
    
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.coverImageView.frame = self.bounds;
    
}


@end
