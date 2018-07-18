//
//  DMModalPresentationViewController.m
//  Dealmoon
//
//  Created by 袁江 on 17/6/9.
//  Copyright © 2017年 Dealmoon. All rights reserved.
//

#import "DMModalPresentationViewController.h"

DMModalPresentationViewController *instance;

@interface DMModalPresentationViewController ()

@property (nonatomic, strong) UIView   *backgroundView;
@property (nonatomic, strong) UIViewController *dmPresentingViewController;

@property (nonatomic, assign) CGRect contentRect;

@end

@implementation DMModalPresentationViewController

+ (void)presentModeViewController:(UIViewController *)viewController from:(UIViewController *)fromViewController withContentRect:(CGRect)contentRect
{

    instance = [[DMModalPresentationViewController alloc] init];
    instance.dmPresentingViewController = viewController;
    instance.contentRect = contentRect;
    
    instance.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    instance.providesPresentationContextTransitionStyle = YES;
    instance.definesPresentationContext = YES;

    instance.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [fromViewController presentViewController:instance animated:NO completion:^{
        
    }];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.backgroundView = [[UIView alloc] init];
    self.backgroundView.backgroundColor = [UIColor blackColor];
    self.backgroundView.alpha = 0.5;
    
    [self.view addSubview:self.backgroundView];

    [self.view addSubview:self.dmPresentingViewController.view];
    
//    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBlank:)]];
//    [self.dmPresentingViewController.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:nil action:nil]];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.backgroundView.frame = self.view.bounds;
    
    if (CGRectEqualToRect(self.contentRect, CGRectZero))
    {
        self.dmPresentingViewController.view.frame = instance.view.bounds;
    }
    else
    {
        self.dmPresentingViewController.view.frame = self.contentRect;
    }
}

- (void)tapBlank:(UIGestureRecognizer *)gesture
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

+ (void)dismiss
{
    [instance dismissViewControllerAnimated:NO completion:^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            instance = nil;
        });
    }];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return YES;
}

@end
