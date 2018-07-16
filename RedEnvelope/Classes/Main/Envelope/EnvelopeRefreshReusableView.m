//
//  EnvelopeRefreshReusableView.m
//  RedEnvelope
//
//  Created by 袁江 on 2018/7/14.
//  Copyright © 2018年 Envelope. All rights reserved.
//

#import "EnvelopeRefreshReusableView.h"

@implementation EnvelopeRefreshReusableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    self.button = [UIButton buttonWithType:UIButtonTypeSystem];
    self.button.tintColor = [UIColor whiteColor];
    self.button.titleLabel.font = [UIFont systemFontOfSize:18.0f];
    
    [self.button setTitle:@"获取更多红包" forState:UIControlStateNormal];
    self.button.backgroundColor = HEXCOLOR(0xd75b45);
    [self addSubview:self.button];
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.button.height = self.height;
    self.button.width = self.width - 200;
    self.button.centerX = self.width / 2;
    self.button.layer.cornerRadius = self.button.height / 2;
    
}

@end
