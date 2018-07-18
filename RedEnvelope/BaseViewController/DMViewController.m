//
//  DMViewController.m
//  Dealmoon
//
//  Created by Kai on 9/2/12.
//  Copyright (c) 2012 Dealmoon. All rights reserved.
//

#import "DMViewController.h"

static NSInteger DMViewControllerCurrentUniqueCode = 0;

@interface DMViewController ()

@property (nonatomic, readwrite, assign) DMViewControllerState viewControllerState;
@property (nonatomic, readwrite, assign) NSUInteger viewControllerUniqueCode;
@property (nonatomic, readwrite, assign, getter = isFirstAppearance) BOOL firstAppearance;

@end

@implementation DMViewController

#pragma mark - Initialization

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
    {
        self.viewControllerState = DMViewControllerStateInitialized;
        self.viewControllerUniqueCode = ++DMViewControllerCurrentUniqueCode;
        self.firstAppearance = YES;
    }
    
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.viewControllerState = DMViewControllerStateInitialized;
    self.viewControllerUniqueCode = ++DMViewControllerCurrentUniqueCode;
    self.firstAppearance = YES;
}

#pragma mark - View Life Cycle

- (void)viewDidLoad
{
	[super viewDidLoad];
    NSLog(@">>>>%@",self.class);
    self.view.backgroundColor = DMMainBackgroundColor;
    
    if ([self.navigationController.viewControllers containsObject:self] &&
        [self.navigationController.viewControllers firstObject] != self)
    {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:DMSkinOriginalImage(@"返回") style:UIBarButtonItemStylePlain target:self action:@selector(backBarButtonPressed:)];
        self.navigationItem.leftBarButtonItem.imageInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        self.navigationItem.leftBarButtonItem.tintColor = DMSkinColorKeyAppTintColor;
        self.navigationController.navigationBar.tintColor = DMSkinColorKeyAppTintColor;
    }
    
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;

    self.viewControllerState = DMViewControllerStateViewDidLoad;
}

#pragma mark - Back Bar Button

- (void)backBarButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.viewControllerState = DMViewControllerStateViewWillAppear;
    

    if (self.navigationBarStyle == DMNavigationBarStyleDefault)
    {
        [self.navigationController setNavigationBarHidden:NO animated:animated];
    }
    else
    {
        [self.navigationController setNavigationBarHidden:YES animated:animated];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.viewControllerState = DMViewControllerStateViewDidAppear;
    
    if (self.navigationController.viewControllers.firstObject == self) {
        self.navigationController.interactivePopGestureRecognizer.enabled = false;
    }else{
        self.navigationController.interactivePopGestureRecognizer.enabled = true;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.viewControllerState = DMViewControllerStateViewWillDisappear;
    self.firstAppearance = NO;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    self.viewControllerState = DMViewControllerStateViewDidDisappear;
    self.firstAppearance = NO;
}

#pragma mark - Background Image View

- (UIImageView *)backgroundImageView
{
    if (_backgroundImageView == nil)
    {
        _backgroundImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        _backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:_backgroundImageView];
        [self.view sendSubviewToBack:_backgroundImageView];
    }
    
    return _backgroundImageView;
}

- (void)dealloc
{
    NSLog(@">>>>>> dealloc <<<<< %@", self.className);
}

#pragma mark - Back Bar Button

@end
