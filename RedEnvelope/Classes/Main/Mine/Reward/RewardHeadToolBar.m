//
//  RewardHeadToolBar.m
//  RedEnvelope
//
//  Created by 袁江 on 2018/7/17.
//  Copyright © 2018年 Envelope. All rights reserved.
//

#import "RewardHeadToolBar.h"

@interface RewardHeadToolBar ()

@property (nonatomic, strong) UIButton *buttonI;
@property (nonatomic, strong) UIButton *buttonII;
@property (nonatomic, strong) UIButton *buttonIII;

@end

@implementation RewardHeadToolBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.buttonI = [self button];
    self.buttonII = [self button];
    self.buttonIII = [self button];

    [self addSubview:self.buttonI];
    [self addSubview:self.buttonII];
    [self addSubview:self.buttonIII];

    [self.buttonI mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
    
    [self.buttonII mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
        make.left.equalTo(self.buttonI.mas_right).with.offset(1);
        make.width.equalTo(self.buttonI.mas_width);
    }];

    [self.buttonIII mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
        make.left.equalTo(self.buttonII.mas_right).with.offset(1);
        make.width.equalTo(self.buttonII.mas_width);
        make.right.equalTo(@0);
    }];

    return self;
}

- (UIButton *)button
{
    UIButton *button = [[UIButton alloc] init];
    [button setBackgroundImage:[UIImage imageWithColor:HEXCOLOR(0xf5f5f5)] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithColor:HEXCOLOR(0xe06f54)] forState:UIControlStateSelected];
    [button setTitleColor:HEXCOLOR(0x333333) forState:UIControlStateNormal];
    [button setTitleColor:HEXCOLOR(0xffffff) forState:UIControlStateSelected];
    button.titleLabel.numberOfLines = 2;
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    return button;
}


@end
