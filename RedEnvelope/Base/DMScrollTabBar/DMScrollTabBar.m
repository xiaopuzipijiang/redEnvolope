//
//  DMScrollTabBar.m
//  Dealmoon
//
//  Created by Kai on 9/6/12.
//  Copyright (c) 2012 Dealmoon. All rights reserved.
//

#import "DMScrollTabBar.h"
#import "DMScrollTabButton.h"

@interface DMScrollTabBarScrollView : UIScrollView

@end

@implementation DMScrollTabBarScrollView

// http://stackoverflow.com/questions/3512563/scrollview-not-scrolling-when-dragging-on-buttons/3550157#3550157
- (BOOL)touchesShouldCancelInContentView:(UIView *)view
{
    if ([view isKindOfClass:[UIButton class]])
    {
        return YES;
    }
    
    return [super touchesShouldCancelInContentView:view];
}

@end

@interface DMScrollTabBar () <UIScrollViewDelegate>

@property (nonatomic, readwrite, strong) UIView *fadeView;
@property (nonatomic, readwrite, strong) UIScrollView *scrollView;
@property (nonatomic, readwrite, assign) NSUInteger previousSelectedIndex;

@property (nonatomic, readwrite, strong) UIImageView *backgroundImageView;
@property (nonatomic, readwrite, strong) UIImageView *fadeLeftImageView;
@property (nonatomic, readwrite, strong) UIImageView *fadeRightImageView;
@property (nonatomic, readwrite, strong) UIImageView *sliderImageView;

@property (nonatomic, strong) CAGradientLayer *leftSideFadeGradientLayer;
@property (nonatomic, strong) CAGradientLayer *rightSideFadeGradientLayer;
@property (nonatomic, strong) CAGradientLayer *bothSidesFadeGradientLayer;

@property (nonatomic, strong) NSMutableArray *separators;
@property (nonatomic, strong) UIView *bottomSeparator;

@property (nonatomic, assign) NSInteger numberOfItems;

@end

@implementation DMScrollTabBar

#pragma mark - Initialization

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.enablesFadeMask = YES;
        
        self.backgroundImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        self.backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:self.backgroundImageView];
        
        self.fadeView = [[UIView alloc] initWithFrame:self.bounds];
        [self addSubview:self.fadeView];
        
        self.scrollView = [[DMScrollTabBarScrollView alloc] initWithFrame:self.fadeView.bounds];
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.scrollsToTop = NO;
        self.scrollView.delegate = self;
        self.scrollView.canCancelContentTouches = YES;
        [self.fadeView addSubview:self.scrollView];
        
        CGRect slice, remainder;
        CGRectDivide(self.scrollView.bounds, &slice, &remainder, self.scrollView.bounds.size.width / 2, CGRectMinXEdge);
        
        self.fadeLeftImageView = [[UIImageView alloc] initWithFrame:slice];
        self.fadeLeftImageView.contentMode = UIViewContentModeLeft;
        self.fadeRightImageView.userInteractionEnabled = NO;
        [self addSubview:self.fadeLeftImageView];
        
        self.fadeRightImageView = [[UIImageView alloc] initWithFrame:remainder];
        self.fadeRightImageView.contentMode = UIViewContentModeRight;
        self.fadeRightImageView.userInteractionEnabled = NO;
        [self addSubview:self.fadeRightImageView];
        
        self.sliderOffset = CGPointZero;
        self.sliderImageView = [[UIImageView alloc] init];
        [self.scrollView addSubview:self.sliderImageView];
        
        self.bottomSeparator = [[UIView alloc] init];
        self.bottomSeparator.backgroundColor = [UIColor clearColor];
        [self addSubview:self.bottomSeparator];
        
        _previousSelectedIndex = NSUIntegerMax;
        _selectedIndex = NSUIntegerMax;
    }
    
    return self;
}

#pragma mark - Layout

- (void)setFrame:(CGRect)frame
{
    if (!CGRectEqualToRect(self.frame, frame))
    {
        [self clearFadeGradientLayers];
    }
    
    [super setFrame:frame];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.fadeView.frame = UIEdgeInsetsInsetRect(self.bounds, self.contentInsets);
    self.scrollView.frame = self.fadeView.frame;
    self.bottomSeparator.frame = CGRectMake(0, self.height, self.width, DMAppLineHeight);
    [self layoutTabButtons];
    [self floatSliderWithPercentage:0 animated:NO];
}

- (void)setContentInsets:(UIEdgeInsets)contentInsets
{
    _contentInsets = contentInsets;
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

#pragma mark - Background View

- (void)setBackgroundView:(UIView *)backgroundView
{
    [_backgroundView removeFromSuperview];
    _backgroundView = backgroundView;
    _backgroundView.frame = self.bounds;
    _backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self insertSubview:_backgroundView atIndex:0];
}

#pragma mark - Reload Data

- (void)reloadData
{
    NSMutableArray *buttons = [[NSMutableArray alloc] init];
    
    self.numberOfItems = [self.dataSource numberOfItemsInScrollTabBar:self];
    for (int i = 0; i < self.numberOfItems; i++)
    {
        DMScrollTabButton *button = [self.dataSource scrollTabBar:self tabButtonForItemAtIndex:i];
        [buttons addObject:button];
    }
    
    self.tabButtons = buttons;
}

#pragma mark - Buttons

- (void)setTabButtons:(NSArray *)tabButtons
{
    // Remove previous buttons.
    for (DMScrollTabButton *button in _tabButtons)
    {
        [button removeFromSuperview];
    }
    
    _tabButtons = [tabButtons copy];
    _numberOfItems = [tabButtons count];
    
    // Add new buttons.
    
    for (DMScrollTabButton *button in _tabButtons)
    {
        [self.scrollView addSubview:button];
        [button addTarget:self action:@selector(tabButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self layoutTabButtons];
    [self createAndLayoutSeparators];
}

- (void)layoutTabButtons
{
    CGRect frame = UIEdgeInsetsInsetRect(CGRectMake(0, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height), self.edgeInsets);
    CGFloat x = frame.origin.x;
    CGFloat y = frame.origin.y;
    CGFloat height = frame.size.height;
    
    UIButton *lastButton = [self.tabButtons lastObject];
    NSUInteger count = [self.tabButtons count];
    
    if ((self.fixedButtonWidth > 0) || (self.fillsWidth && self.dividesEqually))
    {
        CGFloat fixedWidth = self.fixedButtonWidth ?: floorf(self.scrollView.bounds.size.width / count);
        for (DMScrollTabButton *button in self.tabButtons)
        {
            button.frame = CGRectMake(x, y, fixedWidth, height);
            x += button.frame.size.width;
            if (button != lastButton)
            {
                x += self.paddingBetweenButtons;
            }
        }
        x += self.edgeInsets.right;
    }
    else
    {
        CGFloat estimatedWidth = x;
        for (DMScrollTabButton *button in self.tabButtons)
        {
            [button sizeToFit];
            estimatedWidth += button.frame.size.width;
        }
        estimatedWidth += (count - 1) * self.paddingBetweenButtons;
        estimatedWidth += self.edgeInsets.right;
        
        CGFloat delta = 0;
        if (self.fillsWidth && estimatedWidth < self.scrollView.bounds.size.width)
        {
            delta = floorf((self.scrollView.bounds.size.width - estimatedWidth) / count);
        }
        
        for (DMScrollTabButton *button in self.tabButtons)
        {
            button.frame = CGRectMake(x, y, button.frame.size.width + delta, height);
            x += button.frame.size.width;
            if (button != lastButton)
            {
                x += self.paddingBetweenButtons;
            }
        }
        x += self.edgeInsets.right;
    }
    
    self.scrollView.contentSize = CGSizeMake(x, self.frame.size.height);
    [self updateFaders];
}

- (void)tabButtonPressed:(DMScrollTabButton *)button
{
    NSUInteger index = [self.tabButtons indexOfObject:button];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(scrollTabBar:shouldSelectTabAtIndex:)])
    {
        if (![self.delegate scrollTabBar:self shouldSelectTabAtIndex:index])
        {
            return;
        }
    }
    
    [self setSelectedIndex:index animated:YES];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(scrollTabBar:didSelectTabAtIndex:)])
    {
        [self.delegate scrollTabBar:self didSelectTabAtIndex:self.selectedIndex];
    }
}

#pragma mark - Update Separators

- (void)setSeparatorImage:(UIImage *)separatorImage
{
    _separatorImage = separatorImage;
    [self createAndLayoutSeparators];
}

- (void)setSeparatorInsets:(UIEdgeInsets)separatorInsets
{
    _separatorInsets = separatorInsets;
    [self layoutSeparators];
}

- (void)setSeparatorOffset:(UIOffset)separatorOffset
{
    _separatorOffset = separatorOffset;
    [self layoutSeparators];
}

- (void)createAndLayoutSeparators
{
    [self createSeparators];
    [self layoutSeparators];
}

- (void)createSeparators
{
    [self.separators makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.separators removeAllObjects];
    
    if (self.separatorImage)
    {
        NSMutableArray *separators = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < [self.tabButtons count]; i++)
        {
            UIImageView *separator = [[UIImageView alloc] initWithImage:self.separatorImage];
            separator.contentMode = UIViewContentModeCenter;
            [self addSubview:separator];
            [separators addObject:separator];
        }
        
        self.separators = separators;
    }
}

- (void)layoutSeparators
{
    if (self.separatorImage)
    {
        for (int i = 0; i < [self.separators count]; i++)
        {
            UIImageView *separator = self.separators[i];
            UIButton *button = self.tabButtons[i];
            
            CGRect rect = CGRectMake(button.left, button.top, self.separatorImage.size.width, button.height);
            rect = UIEdgeInsetsInsetRect(rect, self.separatorInsets);
            separator.frame = CGRectOffset(rect, self.separatorOffset.horizontal, self.separatorOffset.vertical);
        }
    }
}

- (void)setBottomSeparatorColor:(UIColor *)bottomSeparatorColor
{
    _bottomSeparatorColor = bottomSeparatorColor;
    self.bottomSeparator.backgroundColor = bottomSeparatorColor;
}

#pragma mark - Selected Index

- (void)setSelectedIndex:(NSUInteger)newIndex
{
    [self setSelectedIndex:newIndex animated:NO];
}

- (void)setSelectedIndex:(NSUInteger)newIndex animated:(BOOL)animated
{
    NSUInteger oldIndex = _selectedIndex;
    
    UIButton *oldButton = (oldIndex < [self.tabButtons count]) ? self.tabButtons[oldIndex] : nil;
    UIButton *newButton = (newIndex < [self.tabButtons count]) ? self.tabButtons[newIndex] : nil;
    
    oldButton.selected = NO;
    newButton.selected = YES;
    
    _selectedIndex = newIndex;
    self.previousSelectedIndex = oldIndex;
    
    if (animated)
    {
        [UIView animateWithDuration:0.2 animations:^{
            [self floatSliderWithPercentage:0 animated:YES];
        }];
    }
    else
    {
        [self floatSliderWithPercentage:0 animated:NO];
    }
}

#pragma mark - Faders

- (void)updateFaders
{
    BOOL shouldShowLeftFader = self.scrollView.contentOffset.x > 0;
    BOOL shouldShowRightFader = (self.scrollView.contentOffset.x < (self.scrollView.contentSize.width - self.fadeView.bounds.size.width));
    
    if (self.fadeLeftImageView.image || self.fadeRightImageView.image)
    {
        [UIView animateWithDuration:0.2 animations:^{
            self.fadeLeftImageView.alpha = shouldShowLeftFader ? 1 : 0;
            self.fadeRightImageView.alpha = shouldShowRightFader ? 1 : 0;
        }];
    }
    
    if (self.enablesFadeMask && (shouldShowLeftFader || shouldShowRightFader))
    {
        CAGradientLayer *gradientLayer = nil;
        if (shouldShowLeftFader && !shouldShowRightFader)
        {
            gradientLayer = self.leftSideFadeGradientLayer;
        }
        else if (!shouldShowLeftFader && shouldShowRightFader)
        {
            gradientLayer = self.rightSideFadeGradientLayer;
        }
        else
        {
            gradientLayer = self.bothSidesFadeGradientLayer;
        }
        
        if (self.fadeView.layer.mask != gradientLayer)
        {
            self.fadeView.layer.mask = gradientLayer;
        }
    }
    else
    {
        self.fadeView.layer.mask = nil;
    }
}

- (CAGradientLayer *)leftSideFadeGradientLayer
{
    if (_leftSideFadeGradientLayer == nil)
    {
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.bounds = UIEdgeInsetsInsetRect(self.fadeView.layer.bounds, self.fadeViewGradientLayerBoundsInsets);
        gradientLayer.position = CGPointMake(CGRectGetMidX(self.fadeView.bounds), CGRectGetMidY(self.fadeView.bounds));
        gradientLayer.startPoint = CGPointMake(0, CGRectGetMidY(self.fadeView.frame));
        gradientLayer.endPoint = CGPointMake(1, CGRectGetMidY(self.fadeView.frame));
        
        id opaque = (id)[UIColor blackColor].CGColor;
        id transparent = (id)[UIColor clearColor].CGColor;
        gradientLayer.colors = @[transparent, opaque];
        gradientLayer.locations = @[@0, @0.1];
        
        _leftSideFadeGradientLayer = gradientLayer;
    }
    
    return _leftSideFadeGradientLayer;
}

- (CAGradientLayer *)rightSideFadeGradientLayer
{
    if (_rightSideFadeGradientLayer == nil)
    {
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.bounds = UIEdgeInsetsInsetRect(self.fadeView.layer.bounds, self.fadeViewGradientLayerBoundsInsets);
        gradientLayer.position = CGPointMake(CGRectGetMidX(self.fadeView.bounds), CGRectGetMidY(self.fadeView.bounds));
        gradientLayer.startPoint = CGPointMake(0, CGRectGetMidY(self.fadeView.frame));
        gradientLayer.endPoint = CGPointMake(1, CGRectGetMidY(self.fadeView.frame));
        
        id opaque = (id)[UIColor blackColor].CGColor;
        id transparent = (id)[UIColor clearColor].CGColor;
        gradientLayer.colors = @[opaque, transparent];
        gradientLayer.locations = @[@0.9, @1];
        
        _rightSideFadeGradientLayer = gradientLayer;
    }
    
    return _rightSideFadeGradientLayer;
}

- (CAGradientLayer *)bothSidesFadeGradientLayer
{
    if (_bothSidesFadeGradientLayer == nil)
    {
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.bounds = UIEdgeInsetsInsetRect(self.fadeView.layer.bounds, self.fadeViewGradientLayerBoundsInsets);
        gradientLayer.position = CGPointMake(CGRectGetMidX(self.fadeView.bounds), CGRectGetMidY(self.fadeView.bounds));
        gradientLayer.startPoint = CGPointMake(0, CGRectGetMidY(self.fadeView.frame));
        gradientLayer.endPoint = CGPointMake(1, CGRectGetMidY(self.fadeView.frame));
        
        id opaque = (id)[UIColor blackColor].CGColor;
        id transparent = (id)[UIColor clearColor].CGColor;
        gradientLayer.colors = @[transparent, opaque, opaque, transparent];
        gradientLayer.locations = @[@0, @0.1, @0.9, @1];
        
        _bothSidesFadeGradientLayer = gradientLayer;
    }
    
    return _bothSidesFadeGradientLayer;
}

- (void)clearFadeGradientLayers
{
    self.leftSideFadeGradientLayer = nil;
    self.rightSideFadeGradientLayer = nil;
    self.bothSidesFadeGradientLayer = nil;
}

- (CGFloat)leftFadeWidth
{
    CGFloat leftFaderImageWidth = self.fadeLeftImageView.image.size.width;
    CGFloat leftFadeWidth = self.fadeView.layer.mask ? CGRectGetWidth(self.fadeView.bounds) * 0.1 / 2 : 0;
    return floorf(MAX(leftFaderImageWidth, leftFadeWidth));
}

- (CGFloat)rightFadeWidth
{
    CGFloat rightFaderImageWidth = self.fadeRightImageView.image.size.width;
    CGFloat rightFadeWidth = self.fadeView.layer.mask ? CGRectGetWidth(self.fadeView.bounds) * 0.1 / 2 : 0;
    return floorf(MAX(rightFaderImageWidth, rightFadeWidth));
}

#pragma mark - Slider

- (void)floatSliderWithPercentage:(CGFloat)percentage animated:(BOOL)animated
{
    if (self.selectedIndex < [self.tabButtons count])
    {
        // Step 1. 滑动这个条的时候先根据percentage选择即将滑动到的index.
        NSInteger floatingIndex = self.selectedIndex;
        if (percentage > 0)
        {
            floatingIndex++;
        }
        else if (percentage < 0)
        {
            floatingIndex--;
        }
        floatingIndex = MIN(MAX(0, floatingIndex), [self.tabButtons count] - 1);
        
        UIButton *currentButton = [self.tabButtons objectAtIndex:self.selectedIndex];
        UIButton *floatingButton = [self.tabButtons objectAtIndex:floatingIndex];
        
        CGRect rect = currentButton.frame;
        rect.origin.y = 0;
        rect.size.height = self.scrollView.frame.size.height;
        rect = CGRectOffset(rect, self.sliderOffset.x, self.sliderOffset.y);
        
        // Step 2. 如果正在滑动到其他index, 对当前slider进行位移和缩放.
        if (currentButton != floatingButton)
        {
            CGFloat deltaX = floatingButton.frame.origin.x - currentButton.frame.origin.x;
            CGFloat deltaWidth = floatingButton.frame.size.width - currentButton.frame.size.width;
            
            rect.origin.x += floorf(deltaX * fabs(percentage));
            rect.size.width += floorf(deltaWidth * fabs(percentage));
        }
        
        if (self.adjustsSliderWidth)
        {
            if (currentButton.titleLabel.width == 0)
            {
                [currentButton.titleLabel sizeToFit];
            }
            
            CGFloat horizontal = floorf((currentButton.frame.size.width - currentButton.titleLabel.frame.size.width) / 2);
            rect = UIEdgeInsetsInsetRect(rect, UIEdgeInsetsMake(0, horizontal, 0, horizontal));
        }
        
        self.sliderImageView.frame = UIEdgeInsetsInsetRect(rect, self.sliderInsets);
        
        // Step 3. 计算即将滑动到的index的按钮是否已经在屏幕上显示, 如果未显示需要用动画将其完全显示.
        CGFloat floatingButtonLeft = floatingButton.frame.origin.x;
        CGFloat floatingButtonRight = floatingButton.frame.origin.x + floatingButton.frame.size.width;
        
        CGFloat lowerBoundX = self.scrollView.contentOffset.x + self.edgeInsets.left + [self leftFadeWidth];
        CGFloat upperBoundX = self.scrollView.contentOffset.x + self.scrollView.frame.size.width - self.edgeInsets.right - [self rightFadeWidth];
        
        CGFloat offsetX = self.scrollView.contentOffset.x;
        if (floatingButtonLeft < lowerBoundX)
        {
            offsetX = floatingButtonLeft - self.edgeInsets.left - [self leftFadeWidth];
        }
        else if (floatingButtonRight > upperBoundX)
        {
            offsetX = floatingButtonRight + self.edgeInsets.right - self.scrollView.frame.size.width + [self rightFadeWidth];
        }
        
        if (offsetX != self.scrollView.contentOffset.x)
        {
            offsetX = MIN(MAX(0, offsetX), self.scrollView.contentSize.width - self.scrollView.frame.size.width);
            
            CGFloat deltaOffsetX = fabs(self.scrollView.contentOffset.x - offsetX);
            NSTimeInterval duration = MIN(MAX(0.2, deltaOffsetX / 200), 0.4);
            
            if (animated == NO)
            {
                duration = 0;
            }
            
            [UIView animateWithDuration:duration animations:^{
                self.scrollView.contentOffset = CGPointMake(offsetX, self.scrollView.contentOffset.y);
            }];
            [self updateFaders];
        }
    }
}

#pragma mark - UIScrollView Delegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self updateFaders];
}

#pragma mark - Touch

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    CGRect modifiedHitBox = UIEdgeInsetsInsetRect([self bounds], self.touchInsets);
    return CGRectContainsPoint(modifiedHitBox, point);
}

@end
