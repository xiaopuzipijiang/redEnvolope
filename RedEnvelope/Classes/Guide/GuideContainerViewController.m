//
//  GuideContainerViewController.m
//  RedEnvelope
//
//  Created by 袁江 on 2018/7/13.
//  Copyright © 2018年 Envelope. All rights reserved.
//

#import "GuideContainerViewController.h"
#import "GuideItemViewController.h"
#import "ServiceManager.h"
#import "WechatManager.h"

#define kPageCount 3

@interface GuideContainerViewController () <UIPageViewControllerDelegate, UIPageViewControllerDataSource>

@property (nonatomic, strong) UIPageViewController *pageViewController;

@property (nonatomic, strong) UIPageControl *pageControl;


@property (nonatomic, strong) YYLabel *protocolLabel;
@property (nonatomic, strong) UIButton *weixinLoginButton;

@end

@implementation GuideContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageViewController.delegate = self;
    self.pageViewController.dataSource = self;
    GuideItemViewController *first = [self pageViewControllerWithIndex:0];
    [self.pageViewController setViewControllers:@[first] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];

    [self.view addSubview:self.pageViewController.view];
    
    self.pageControl = [[UIPageControl alloc] init];
    self.pageControl.numberOfPages = kPageCount;
    self.pageControl.pageIndicatorTintColor = HEXCOLOR(0xdfdfdf);
    self.pageControl.currentPageIndicatorTintColor = HEXCOLOR(0xff4b2c);
    self.pageControl.currentPage = 0;

    
    [self.view addSubview:self.protocolLabel];
    
    self.weixinLoginButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.weixinLoginButton setImage:DMSkinOriginalImage(@"微信登录") forState:UIControlStateNormal];
    [self.weixinLoginButton addTarget:self action:@selector(loginByWeiXin:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.weixinLoginButton];
    
    [self.view addSubview:self.pageControl];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self.weixinLoginButton sizeToFit];
    self.weixinLoginButton.integralCenterX = self.view.width / 2;
    
    if (@available(iOS 11.0, *)) {
        self.weixinLoginButton.bottom = self.view.height - 40 - self.view.safeAreaInsets.bottom;
    } else {
        self.weixinLoginButton.bottom = self.view.height - 40;
    }
    
    self.protocolLabel.size = CGSizeMake(self.view.width, 15);
    self.protocolLabel.bottom = self.weixinLoginButton.top - 20;
    
    self.pageControl.centerX = self.view.width / 2;
    self.pageControl.bottom = self.protocolLabel.top - 60;

}

- (void)loginByWeiXin:(id)sender
{
    [SVProgressHUD show];
    [[WechatManager sharedManager] signInWithCompletionHandler:^(BOOL success, NSString* codeString, NSError *error) {
        [[ServiceManager sharedManager] loginWithToken:codeString completionHandler:^(BOOL success, id object, NSString *errorMessage) {
            if (success)
            {
                [SVProgressHUD dismiss];
                [kAPPDelegate showMainViewContorller];
            }
            else
            {
                [SVProgressHUD showErrorWithStatus:errorMessage];
            }
        }];
    }];
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    GuideItemViewController *vc = (GuideItemViewController *)viewController;
    
    return [self pageViewControllerWithIndex:[self prePageIndex:vc.pageIndex]];
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    GuideItemViewController *vc = (GuideItemViewController *)viewController;

    return [self pageViewControllerWithIndex:[self nextPageIndex:vc.pageIndex]];
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed
{
    GuideItemViewController *vc = pageViewController.viewControllers.firstObject;
    
    self.pageControl.currentPage = vc.pageIndex;
}


- (GuideItemViewController *)pageViewControllerWithIndex:(NSInteger)index
{
    GuideItemViewController *vc = [[GuideItemViewController alloc] init];
    vc.view.backgroundColor = UICOLOR_RANDOM;
    vc.pageIndex = index;
    switch (index)
    {
        case 0:
            vc.bgView.image = DMSkinOriginalImage(@"引导页1");
            break;
        case 1:
            vc.bgView.image = DMSkinOriginalImage(@"引导页2");
            break;
        case 2:
            vc.bgView.image = DMSkinOriginalImage(@"引导页3");
            break;
        default:
            break;
    }
    
    return vc;
}

- (NSInteger)nextPageIndex:(NSInteger)currentPageIndex
{
    if (currentPageIndex == kPageCount - 1)
    {
        return 0;
    }
    
    return currentPageIndex + 1;
}

- (NSInteger)prePageIndex:(NSInteger)currentPageIndex
{
    if (currentPageIndex == 0)
    {
        return kPageCount - 1;
    }
    
    return currentPageIndex - 1;
}

- (YYLabel *)protocolLabel
{
    if (!_protocolLabel)
    {
        _protocolLabel = [YYLabel new];
        NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:@"登录即表示同意 "];
        one.font = [UIFont systemFontOfSize:12];
        one.color = HEXCOLOR(0x666666);
        NSMutableAttributedString *two = [[NSMutableAttributedString alloc] initWithString:@"天天刷红包用户协议"];
        two.font = [UIFont boldSystemFontOfSize:12];
        two.underlineStyle = NSUnderlineStyleSingle;
        [two setTextHighlightRange:two.rangeOfAll
                             color:[UIColor orangeColor]
                   backgroundColor:[UIColor colorWithWhite:0.000 alpha:0.220]
                         tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
                             
                         }];
        [one appendAttributedString:two];
        
    _protocolLabel.attributedText = one;
        _protocolLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _protocolLabel;
}

@end
