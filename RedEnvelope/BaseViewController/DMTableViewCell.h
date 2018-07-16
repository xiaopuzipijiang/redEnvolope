//
//  DMTableViewCell.h
//  Dealmoon
//
//  Created by Kai on 9/26/14.
//  Copyright (c) 2014 Dealmoon. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const DMTableViewCellIdentifier;

typedef NS_OPTIONS(NSInteger, DMTableViewCellSeparatorMode)
{
    DMTableViewCellSeparatorModeNone    = 0,
    DMTableViewCellSeparatorModeTop     = 1 << 0UL,
    DMTableViewCellSeparatorModeBottom  = 1 << 1UL,
    
    DMTableViewCellSeparatorFullWidthAtBottomCell       = 1 << 5UL,        // will show full width for the bottom cell at a section
    DMTableViewCellSeparatorHideBottomAtBottomCell      = 1 << 6UL,
};

typedef NS_ENUM(NSUInteger, DMTableViewCellPosition)
{
    DMTableViewCellPositionUnknown,
    DMTableViewCellPositionTop,
    DMTableViewCellPositionMiddle,
    DMTableViewCellPositionBottom,
    DMTableViewCellPositionSingle
};

@interface DMTableViewCell : UITableViewCell

@property (nonatomic, assign) DMTableViewCellSeparatorMode separatorMode;

@property (nonatomic, readonly, strong) UIView *topSeparator;
@property (nonatomic, strong) UIColor *topSeparatorColor;
@property (nonatomic, assign) UIEdgeInsets topSeparatorInsets;
@property (nonatomic, assign) UIOffset topSeparatorOffset;

@property (nonatomic, readonly, strong) UIView *bottomSeparator;
@property (nonatomic, strong) UIColor *bottomSeparatorColor;
@property (nonatomic, assign) UIEdgeInsets bottomSeparatorInsets;
@property (nonatomic, assign) UIOffset bottomSeparatorOffset;

- (UITableView *)tableView;
@property (nonatomic, readonly) DMTableViewCellPosition cellPosition;

+ (CGFloat)cellHeightWithDataObject:(id)object width:(CGFloat)width;

+ (NSString *)defaultCellIdentifier;

@end

@interface UITableView (DMTableViewCellPosition)

- (DMTableViewCellPosition)cellPositionForIndexPath:(NSIndexPath *)indexPath;

@end
