//
//  GuideContainerViewController.m
//  RedEnvelope
//
//  Created by 袁江 on 2018/7/13.
//  Copyright © 2018年 Envelope. All rights reserved.
//

#import "GuideContainerViewController.h"
#import "GuideItemViewController.h"

@interface GuideContainerViewController () <UIPageViewControllerDelegate, UIPageViewControllerDataSource>

@property (nonatomic, strong) UIPageViewController *pageViewController;

@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation GuideContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageViewController.delegate = self;
    self.pageViewController.dataSource = self;
    [self.pageViewController setViewControllers:@[[[GuideItemViewController alloc] init]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self.view addSubview:self.pageViewController.view];
    
    self.pageControl = [[UIPageControl alloc] init];
    self.pageControl.numberOfPages = 3;
    self.pageControl.pageIndicatorTintColor = UICOLOR_RANDOM;
    self.pageControl.currentPageIndicatorTintColor = UICOLOR_RANDOM;
    
    [self.view addSubview:self.pageControl];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.pageControl.centerX = self.view.width / 2;
    self.pageControl.bottom = self.view.height - 100;
    self.pageControl.currentPage = 1;
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    GuideItemViewController *vc = [[GuideItemViewController alloc] init];
    
    return vc;
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    GuideItemViewController *vc = [[GuideItemViewController alloc] init];
    
    return vc;
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed
{
    
}


@end
