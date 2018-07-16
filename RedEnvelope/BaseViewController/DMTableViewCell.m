//
//  DMTableViewCell.m
//  Dealmoon
//
//  Created by Kai on 9/26/14.
//  Copyright (c) 2014 Dealmoon. All rights reserved.
//

#import "DMTableViewCell.h"

NSString * const DMTableViewCellIdentifier = @"DMTableViewCellIdentifier";

@interface DMTableViewCell ()

@property (nonatomic, readwrite, strong) UIView *topSeparator;
@property (nonatomic, readwrite, strong) UIView *bottomSeparator;

@end

@implementation DMTableViewCell

#pragma mark - Initialization

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
    
        self.separatorMode = DMTableViewCellSeparatorModeBottom;
        
        self.topSeparatorInsets = UIEdgeInsetsZero;
        self.bottomSeparatorInsets = UIEdgeInsetsMake(0, 15, 0, 15);
        
        self.topSeparatorColor = RGBCOLOR(230, 230, 230);
        self.bottomSeparatorColor = RGBCOLOR(230, 230, 230);
    }
    
    return self;
}

#pragma mark - Separator

- (void)setSeparatorMode:(DMTableViewCellSeparatorMode)separatorMode
{
    _separatorMode = separatorMode;
    
    self.topSeparator.hidden = YES;
    self.bottomSeparator.hidden = YES;
    
    if (separatorMode & DMTableViewCellSeparatorModeTop)
    {
        if (self.topSeparator == nil)
        {
            self.topSeparator = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, DMAppLineHeight)];
            self.topSeparator.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
            self.topSeparator.backgroundColor = self.topSeparatorColor;
        }
        
        if (![self.topSeparator isDescendantOfView:self])
        {
            [self addSubview:self.topSeparator];
        }
        
        self.topSeparator.hidden = NO;
    }
    
    if (separatorMode & DMTableViewCellSeparatorModeBottom)
    {
        if (self.bottomSeparator == nil)
        {
            self.bottomSeparator = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - DMAppLineHeight, self.width, DMAppLineHeight)];
            self.bottomSeparator.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
            self.bottomSeparator.backgroundColor = self.bottomSeparatorColor;
        }
        
        if (![self.bottomSeparator isDescendantOfView:self])
        {
            [self addSubview:self.bottomSeparator];
        }
        
        self.bottomSeparator.hidden = NO;
    }
}

- (void)setTopSeparatorColor:(UIColor *)topSeparatorColor
{
    _topSeparatorColor = topSeparatorColor;;
    self.topSeparator.backgroundColor = topSeparatorColor;
}

- (void)setBottomSeparatorColor:(UIColor *)bottomSeparatorColor
{
    _bottomSeparatorColor = bottomSeparatorColor;
    self.bottomSeparator.backgroundColor = bottomSeparatorColor;
}

- (void)setTopSeparator:(UIView *)topSeparator
{
    _topSeparator = topSeparator;
    [self layoutSeparators];
}

- (void)setBottomSeparator:(UIView *)bottomSeparator
{
    _bottomSeparator = bottomSeparator;
    [self layoutSeparators];
}

- (void)setTopSeparatorOffset:(UIOffset)topSeparatorOffset
{
    _topSeparatorOffset = topSeparatorOffset;
    [self layoutSeparators];
}

- (void)setBottomSeparatorOffset:(UIOffset)bottomSeparatorOffset
{
    _bottomSeparatorOffset = bottomSeparatorOffset;
    [self layoutSeparators];
}

- (void)setTopSeparatorInsets:(UIEdgeInsets)topSeparatorInsets
{
    _topSeparatorInsets = topSeparatorInsets;
    [self layoutSeparators];
}

- (void)setBottomSeparatorInsets:(UIEdgeInsets)bottomSeparatorInsets
{
    _bottomSeparatorInsets = bottomSeparatorInsets;
    [self layoutSeparators];
}

#pragma mark - Layout

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self layoutSeparators];
    
    DMTableViewCellPosition cellPosition = self.cellPosition;
    if (cellPosition == DMTableViewCellPositionTop || cellPosition == DMTableViewCellPositionMiddle)
    {
        self.bottomSeparatorColor = DM230GRAYCOLOR;
    }
    else
    {
        self.bottomSeparatorColor = [UIColor clearColor];
    }
}

- (void)layoutSeparators
{
    self.topSeparator.frame = CGRectOffset(UIEdgeInsetsInsetRect(CGRectMake(0, 0, self.width, DMAppLineHeight), self.topSeparatorInsets), self.topSeparatorOffset.horizontal, self.topSeparatorOffset.vertical);
    
    UIEdgeInsets bottomInsets = self.bottomSeparatorInsets;
    if ((self.separatorMode & DMTableViewCellSeparatorFullWidthAtBottomCell) &&
        (self.cellPosition == DMTableViewCellPositionBottom || self.cellPosition == DMTableViewCellPositionSingle))
    {
        bottomInsets = UIEdgeInsetsZero;
    }
    
    self.bottomSeparator.frame = CGRectOffset(UIEdgeInsetsInsetRect(CGRectMake(0, self.height - DMAppLineHeight, self.width, DMAppLineHeight), bottomInsets), self.bottomSeparatorOffset.horizontal, self.bottomSeparatorOffset.vertical);
    
    if ((self.separatorMode & DMTableViewCellSeparatorHideBottomAtBottomCell) &&
        (self.cellPosition == DMTableViewCellPositionBottom || self.cellPosition == DMTableViewCellPositionSingle))
    {
        self.bottomSeparator.frame = CGRectZero;
    }
}

#pragma mark - Highlighted & Selected

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
    
    if (!highlighted)
    {
        self.topSeparator.backgroundColor = self.topSeparatorColor;
        self.bottomSeparator.backgroundColor = self.bottomSeparatorColor;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    if (!selected)
    {
        self.topSeparator.backgroundColor = self.topSeparatorColor;
        self.bottomSeparator.backgroundColor = self.bottomSeparatorColor;
    }
}

#pragma mark - Cell Position

- (UITableView *)tableView
{
    SEL selector = NSSelectorFromString(@"_tableView");
    if ([self respondsToSelector:selector])
    {
        UITableView *tableView = [self valueForKey:@"_tableView"];
        if (tableView && [tableView isKindOfClass:[UITableView class]])
        {
            return tableView;
        }
    }
    
    return nil;
}

- (DMTableViewCellPosition)cellPosition
{
    UITableView *tableView = [self tableView];
    NSIndexPath *indexPath = [tableView indexPathForRowAtPoint:self.center];
    
    if (tableView && indexPath)
    {
        return [tableView cellPositionForIndexPath:indexPath];
    }
    
    return DMTableViewCellPositionUnknown;
}

#pragma mark - Cell Height

+ (CGFloat)cellHeightWithDataObject:(id)object width:(CGFloat)width
{
    return 0;
}

#pragma mark - Cell Identifier

+ (NSString *)defaultCellIdentifier
{
    return NSStringFromClass([self class]);
}

@end

@implementation UITableView (DMTableViewCellPosition)

- (DMTableViewCellPosition)cellPositionForIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger rowsInSection = [self numberOfRowsInSection:indexPath.section];
    NSUInteger row = indexPath.row;
    
    if (row == 0 && rowsInSection == 1)
    {
        return DMTableViewCellPositionSingle;
    }
    else if (row == 0 && rowsInSection > 1)
    {
        return DMTableViewCellPositionTop;
    }
    else if (row > 0 && row == rowsInSection - 1)
    {
        return DMTableViewCellPositionBottom;
    }
    else
    {
        return DMTableViewCellPositionMiddle;
    }
}

@end
