//
//  DMTableView.m
//  Dealmoon
//
//  Created by Kai on 12/21/13.
//  Copyright (c) 2013 Dealmoon. All rights reserved.
//

#import "DMTableView.h"
#import <objc/runtime.h>

@interface UITableView (DMTableView)

- (BOOL)allowsHeaderViewsToFloat;
- (UIColor *)tableHeaderBackgroundColor;
- (void)setTableHeaderBackgroundColor:(UIColor *)tableHeaderBackgroundColor;

@end

@interface DMTableView ()

@property (nonatomic, readwrite, strong) UILabel *resultsTitleLabel;
@property (nonatomic, assign) BOOL shouldManuallyLayoutSectionHeaderViews;

@end

@implementation DMTableView

#pragma mark - Load

+ (void)load
{
    [super load];
}

#pragma mark - Results Title Label

- (UILabel *)resultsTitleLabel
{
    if (_resultsTitleLabel == nil)
    {
        _resultsTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, 88)];
        _resultsTitleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _resultsTitleLabel.backgroundColor = [UIColor clearColor];
//        _resultsTitleLabel.textColor = DMSkinColor(DMSkinColorKeyCommonTextColor1);
        _resultsTitleLabel.textAlignment = NSTextAlignmentCenter;
        _resultsTitleLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:_resultsTitleLabel];
    }
    
    return _resultsTitleLabel;
}

#pragma mark - Layout

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _resultsTitleLabel.top = self.tableHeaderView ? self.tableHeaderView.bottom : 0;
    [self updateEmptyViewLayout];
}

#pragma mark - Empty View

- (void)setEmptyView:(DMEmptyView *)emptyView
{
    [_emptyView removeFromSuperview];
    _emptyView = emptyView;
    [self addSubview:_emptyView];
    [self updateEmptyViewLayout];
}

- (void)setDisplaysEmptyView:(BOOL)displaysEmptyView
{
    _displaysEmptyView = displaysEmptyView;
    [self updateEmptyViewLayout];
}

- (void)updateEmptyViewLayout
{
    self.emptyView.hidden = !self.displaysEmptyView;
    if (self.displaysEmptyView)
    {
        self.emptyView.frame = CGRectMake(0, self.contentSize.height + self.emptyViewOffset.vertical, self.width, [self.emptyView heightWithWidth:self.width]);
    }
}

@end
