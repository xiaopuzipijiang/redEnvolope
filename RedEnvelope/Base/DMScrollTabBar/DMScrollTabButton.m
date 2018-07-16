//
//  DMScrollTabButton.m
//  Dealmoon
//
//  Created by Kai on 9/6/12.
//  Copyright (c) 2012 Dealmoon. All rights reserved.
//

#import "DMScrollTabButton.h"
//#import "DMBadgeView.h"

NSString * const DMScrollBadgeDotBadgeValue = @" ";

@interface DMScrollTabButton ()

//@property (nonatomic, strong) DMBadgeView *badgeView;
@property (nonatomic, strong) UIImageView *dotView;

@end

@implementation DMScrollTabButton

#pragma mark - Size

- (CGSize)sizeThatFits:(CGSize)size
{
    CGSize superSize = [super sizeThatFits:size];
    superSize.width += self.edgeInsets.left;
    superSize.height += self.edgeInsets.right;
    return superSize;
}

#pragma mark - Touch

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    CGRect modifiedHitBox = UIEdgeInsetsInsetRect([self bounds], self.touchInsets);
    return CGRectContainsPoint(modifiedHitBox, point);
}

#pragma mark - Layout

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _dotView.left = self.titleLabel.right + 3;
    _dotView.top = self.titleLabel.top - 2;
}

#pragma mark - Badge
//
//- (DMBadgeView *)badgeView
//{
//    if (!_badgeView)
//    {
//        UIImage *badgeImage = [UIImage roundedImageWithSize:CGSizeMake(18, 18) color:RGBCOLOR(255, 56, 36) radius:4];
//        _badgeView = [[DMBadgeView alloc] initWithFrame:self.bounds];
//        _badgeView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
//        _badgeView.horizontalAlignment = UIControlContentHorizontalAlignmentRight;
//        _badgeView.verticalAlignment = UIControlContentVerticalAlignmentTop;
//        _badgeView.badgeImageView.image = [badgeImage resizableImageWithCapInsets:UIEdgeInsetsMake(4, 4, 4, 4)];
//        _badgeView.badgeLabelEdgeInsets = UIEdgeInsetsMake(2, 2, 2, 2);
//        _badgeView.offset = UIOffsetMake(8, -3);
//        _badgeView.minimumBadgeSize = CGSizeMake(14, 14);
//        _badgeView.maximumBadgeSize = CGSizeMake(100, 15);
//        _badgeView.badgeLabel.font = [UIFont systemFontOfSize:12];
//        _badgeView.badgeLabel.textColor = [UIColor whiteColor];
//        [self addSubview:_badgeView];
//    }
//
//    return _badgeView;
//}

- (UIImageView *)dotView
{
    if (!_dotView)
    {
        _dotView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 6, 6)];
//        _dotView.image = DMSkinImage(@"category_tabbar_dot");
        [self addSubview:_dotView];
    }
    
    return _dotView;
}

- (void)setBadgeValue:(NSString *)badgeValue
{
    _badgeValue = [badgeValue copy];
//    [self updateBadge];
}

//- (void)updateBadge
//{
//    if (self.badgeValue == nil || [self.badgeValue isEqualToString:@""])
//    {
//        _badgeView.badgeValue = nil;
//        _badgeView.hidden = YES;
//        _dotView.hidden = YES;
//    }
//    else if ([self.badgeValue isEqualToString:DMScrollBadgeDotBadgeValue])
//    {
//        _badgeView.badgeValue = nil;
//        _badgeView.hidden = YES;
//        self.dotView.hidden = NO;
//    }
//    else
//    {
//        self.badgeView.badgeValue = self.badgeValue;
//        self.badgeView.hidden = NO;
//        _dotView.hidden = YES;
//    }
//
//    [self setNeedsLayout];
//}

@end
