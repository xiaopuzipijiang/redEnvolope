//
//  DMEmptyView.m
//  Dealmoon
//
//  Created by Kai on 5/6/15.
//  Copyright (c) 2015 Dealmoon. All rights reserved.
//

#import "DMEmptyView.h"

#define kContentInsets             UIEdgeInsetsMake(60, 0, 0, 0)

#define kTextLabelHeight           35
#define kSignInButtonWidth         125
#define kSignInButtonHeight        32
#define kEmptyViewMinWidth         200

@interface DMEmptyView ()

@property (nonatomic, readwrite, strong) UIImageView *imageView;
@property (nonatomic, readwrite, strong) UILabel *textLabel;
@property (nonatomic, readwrite, strong) UIButton *signInButton;

@end

@implementation DMEmptyView

#pragma mark - Initialization

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.imageView = [[UIImageView alloc] init];
        self.imageView.contentMode = UIViewContentModeCenter;
        [self addSubview:self.imageView];
        
        self.textLabel = [[UILabel alloc] init];
//        self.textLabel.textColor = DMSkinColor(DMSkinColorKeyCommonTextColor1);
        self.textLabel.font = [UIFont systemFontOfSize:14];
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.textLabel];
    }
    
    return self;
}

- (instancetype)initWithText:(NSString *)text
{
    if (self = [self initWithFrame:CGRectZero])
    {
        self.textLabel.text = text;
    }
    
    return self;
}


#pragma mark - Layout

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect bounds = UIEdgeInsetsInsetRect(self.bounds, kContentInsets);
    
    if (self.imageView.image)
    {
        self.imageView.frame = CGRectMake(CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetWidth(bounds), self.imageView.image.size.height);
        self.textLabel.frame = CGRectMake(CGRectGetMinX(bounds), self.imageView.bottom, CGRectGetWidth(bounds), kTextLabelHeight);
    }
    else
    {
        self.textLabel.frame = CGRectMake(CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetWidth(bounds), kTextLabelHeight);
    }
    
    if (_signInButton)
    {
        _signInButton.frame = CGRectMake(0, self.textLabel.bottom, kSignInButtonWidth, kSignInButtonHeight);
        _signInButton.left = floorf(CGRectGetMidX(bounds) - kSignInButtonWidth / 2);
    }
}

- (CGFloat)heightWithWidth:(CGFloat)width
{
    CGFloat height = kContentInsets.top + kContentInsets.bottom;
    
    if (self.imageView.image)
    {
        height += self.imageView.image.size.height;
    }
    
    if (self.textLabel.text)
    {
        height += kTextLabelHeight;
    }
    
    if (_signInButton)
    {
        height += kSignInButtonHeight;
    }
    
    return height;
}

@end
