//
//  DMViewController.h
//  Dealmoon
//
//  Created by Kai on 9/2/12.
//  Copyright (c) 2012 Dealmoon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMBaseViewController.h"

#define DMViewDefaultSafeAreaBottomInset    (DMDeviceIsX ? 34 : 0)

typedef NS_ENUM(NSUInteger, DMViewControllerState)
{
    DMViewControllerStateInitialized        = 0,
    DMViewControllerStateViewDidLoad        = 1,
    DMViewControllerStateViewWillAppear     = 2,
    DMViewControllerStateViewDidAppear      = 3,
    DMViewControllerStateViewWillDisappear  = 4,
    DMViewControllerStateViewDidDisappear   = 5,
};

typedef NS_ENUM(NSInteger, DMNavigationBarStyle)
{
    DMNavigationBarStyleDefault,
    DMNavigationBarStyleHidden,
};

@interface DMViewController : DMBaseViewController

@property (nonatomic, readonly, assign) DMViewControllerState viewControllerState;
@property (nonatomic, readonly, assign) NSUInteger viewControllerUniqueCode;
@property (nonatomic, readonly, assign, getter = isFirstAppearance) BOOL firstAppearance;

//@property (nonatomic, readonly) CGFloat topLayoutLength;
//@property (nonatomic, readonly) CGFloat bottomLayoutLength;
//@property (nonatomic, readonly) CGFloat safeAreaBottomInset;

@property (nonatomic, strong) UIImageView *backgroundImageView;

@property (nonatomic, assign) DMNavigationBarStyle navigationBarStyle;


// For override.
- (void)backBarButtonPressed:(id)sender;

@end
