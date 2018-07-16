//
//  DMScrollTabBar.h
//  Dealmoon
//
//  Created by Kai on 9/6/12.
//  Copyright (c) 2012 Dealmoon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMScrollTabButton.h"

@class DMScrollTabBar;

@protocol DMScrollTabBarDelegate <NSObject>

@optional
- (BOOL)scrollTabBar:(DMScrollTabBar *)scrollTabBar shouldSelectTabAtIndex:(NSUInteger)selectedIndex;
- (void)scrollTabBar:(DMScrollTabBar *)scrollTabBar didSelectTabAtIndex:(NSUInteger)selectedIndex;

@end

@protocol DMScrollTabBarDataSource <NSObject>

@required
- (NSInteger)numberOfItemsInScrollTabBar:(DMScrollTabBar *)scrollTabBar;
- (DMScrollTabButton *)scrollTabBar:(DMScrollTabBar *)scrollTabBar tabButtonForItemAtIndex:(NSInteger)index;

@end

@interface DMScrollTabBar : UIView

@property (nonatomic, copy) NSArray *tabButtons;
@property (nonatomic, assign) NSUInteger selectedIndex;
@property (nonatomic, readonly, assign) NSUInteger previousSelectedIndex;
@property (nonatomic, weak) id <DMScrollTabBarDelegate> delegate;
@property (nonatomic, weak) id <DMScrollTabBarDataSource> dataSource;

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, readonly, strong) UIImageView *backgroundImageView;
@property (nonatomic, readonly, strong) UIImageView *fadeLeftImageView;
@property (nonatomic, readonly, strong) UIImageView *fadeRightImageView;
@property (nonatomic, readonly, strong) UIImageView *sliderImageView;

@property (nonatomic, assign) UIEdgeInsets contentInsets;
@property (nonatomic, assign) UIEdgeInsets edgeInsets;
@property (nonatomic, assign) CGFloat paddingBetweenButtons;
@property (nonatomic, assign) UIEdgeInsets touchInsets;
@property (nonatomic, assign) CGPoint sliderOffset;
@property (nonatomic, assign) UIEdgeInsets sliderInsets;
@property (nonatomic, assign) BOOL adjustsSliderWidth;     // width same as button text width
@property (nonatomic, assign) CGFloat fixedButtonWidth;
@property (nonatomic, assign) BOOL fillsWidth;
@property (nonatomic, assign) BOOL dividesEqually;     // only works when fillsWidth = YES
@property (nonatomic, assign) BOOL enablesFadeMask;
@property (nonatomic, assign) UIEdgeInsets fadeViewGradientLayerBoundsInsets;

@property (nonatomic, strong) UIImage *separatorImage;
@property (nonatomic, assign) UIEdgeInsets separatorInsets;
@property (nonatomic, assign) UIOffset separatorOffset;
@property (nonatomic, strong) UIColor *bottomSeparatorColor;

@property (nonatomic, readonly, strong) UIView *fadeView;
@property (nonatomic, readonly, strong) UIScrollView *scrollView;

- (void)layoutTabButtons;
- (void)setSelectedIndex:(NSUInteger)newIndex animated:(BOOL)animated;
- (void)floatSliderWithPercentage:(CGFloat)percentage animated:(BOOL)animated;

- (void)reloadData;

@end
