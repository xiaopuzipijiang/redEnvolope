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

@property (nonatomic, strong) NSTimer *timer;

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
    
    self.deadLineLabel = [[UILabel alloc] init];
    self.deadLineLabel.backgroundColor = [UIColor whiteColor];
    self.deadLineLabel.layer.cornerRadius = 5;
    self.deadLineLabel.clipsToBounds = YES;
    self.deadLineLabel.hidden = YES;
    self.deadLineLabel.textColor = DM153GRAYCOLOR;
    self.deadLineLabel.font = [UIFont systemFontOfSize:12.0f];
    self.deadLineLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.deadLineLabel];

    return self;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    [self.timer invalidate];
    self.deadLineLabel.hidden = YES;
    self.coverImageView.image = [UIImage imageNamed:@"首页-未拆红包"];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.coverImageView.frame = self.bounds;

    self.deadLineLabel.height = 16;
    self.deadLineLabel.width = self.width - 30;
    self.deadLineLabel.integralCenterX = self.width / 2;
    self.deadLineLabel.bottom = self.height - 10;
}

- (void)setComingTime:(NSInteger)comingTime
{
    self.coverImageView.image = [UIImage imageNamed:@"红包倒计时状态"];
    
    DMWEAKSELFDEFIND
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 block:^(NSTimer * _Nonnull timer) {
        NSInteger offset = comingTime - [NSDate date].timeIntervalSince1970;
        if (offset >= 0)
        {
            wSelf.deadLineLabel.hidden = NO;
            NSString *offsetString = [NSString stringWithFormat:@"%zi:%zi", offset / 60, offset % 60];
            wSelf.deadLineLabel.text = offsetString;
            [wSelf setNeedsLayout];
        }
    }
                                                 repeats:YES];

}

@end
