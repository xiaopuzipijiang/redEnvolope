//
//  DMTabBarViewController.m
//  DealmoonMerchant
//
//  Created by 袁江 on 2018/5/21.
//  Copyright © 2018年 Dealmoon. All rights reserved.
//

#import "DMTabBarViewController.h"
#import "EnvelopeHomeViewController.h"
#import "MineHomeViewController.h"
#import "WalletHomeViewController.h"
#import "ApprenticeHomeViewController.h"

@interface DMTabBarViewController () <UITabBarControllerDelegate>

@end

@implementation DMTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    EnvelopeHomeViewController *homeVC = [[EnvelopeHomeViewController alloc] init];
    DMNavigationViewController *homeNavVC = [[DMNavigationViewController alloc] initWithRootViewController:homeVC];
    homeNavVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"红包", nil) image:DMSkinOriginalImage(@"红包-黑") selectedImage:DMSkinOriginalImage(@"红包-红")];
    
    ApprenticeHomeViewController *apprenticeVc = [[ApprenticeHomeViewController alloc] init];
    DMNavigationViewController *apprenticeNaVc = [[DMNavigationViewController alloc] initWithRootViewController:apprenticeVc];
    apprenticeNaVc.tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"师徒", nil) image:DMSkinOriginalImage(@"收徒-黑") selectedImage:DMSkinOriginalImage(@"收徒-红")];

    WalletHomeViewController *walletVc = [[WalletHomeViewController alloc] init];
    DMNavigationViewController *walletNaVc = [[DMNavigationViewController alloc] initWithRootViewController:walletVc];
    walletNaVc.tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"钱包", nil) image:DMSkinOriginalImage(@"钱包-黑") selectedImage:DMSkinOriginalImage(@"钱包-红")];
    
    MineHomeViewController *mineVC = [[MineHomeViewController alloc] init];
    DMNavigationViewController *mineNavVC = [[DMNavigationViewController alloc] initWithRootViewController:mineVC];
    mineNavVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"我的", nil) image:DMSkinOriginalImage(@"我-黑") selectedImage:DMSkinOriginalImage(@"我-红")];
    
    [self setViewControllers:@[homeNavVC, apprenticeNaVc, walletNaVc, mineNavVC]];
    self.tabBar.tintColor = DMSkinColorKeyAppTintColor;
    
    self.tabBar.clipsToBounds = YES;
    self.selectedIndex = 0;
    
    self.delegate = self;
}

@end

