//
//  AliADViewController.m
//  RedEnvelope
//
//  Created by 袁江 on 2018/7/31.
//  Copyright © 2018年 Envelope. All rights reserved.
//

#import "AliADViewController.h"
#import "ServiceManager.h"

@interface AliADViewController ()

@property (nonatomic, strong) AliADInfo *info;

@property (nonatomic, copy) void (^completionBlock)(void);


@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIImageView *aliImageView;

@end

@implementation AliADViewController

+ (void)showAliADViewController:(AliADInfo *)aliADInfo didPressedADBlock:(void (^)(void))block
{
    AliADViewController *vc = [[AliADViewController alloc] init];
    vc.info = aliADInfo;
    vc.completionBlock = block;
    
    [DMModalPresentationViewController presentModeViewController:vc from:[UIApplication sharedApplication].keyWindow.rootViewController  withContentRect:[UIApplication sharedApplication].keyWindow.rootViewController.view.bounds];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.aliImageView = [[UIImageView alloc] init];
    [self.aliImageView sd_setImageWithURL:[NSURL URLWithString:self.info.img]];
    self.aliImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.aliImageView.backgroundColor = [UIColor clearColor];
    self.aliImageView.clipsToBounds = YES;
    [self.aliImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEvent:)]];
    self.aliImageView.userInteractionEnabled = YES;

    self.view.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:self.aliImageView];
    
    self.cancelButton = [[UIButton alloc] init];
    self.cancelButton.clipsToBounds = YES;
    [self.cancelButton addTarget:self action:@selector(cancelButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.cancelButton setImage:[UIImage imageNamed:@"关闭-2"] forState:UIControlStateNormal];
    [self.view addSubview:self.cancelButton];
    
    [[ServiceManager sharedManager] notifiyAliHasShowCompletionHandler:^(BOOL success, NSString *errorMessage) {
        
    }];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.firstAppearance)
    {
        self.aliImageView.size = CGSizeMake(self.view.width - 100, (self.view.width - 100) * 711.0 / 540.0);
        self.aliImageView.centerX = self.view.width / 2;
        self.aliImageView.bottom = 200;
        
        self.cancelButton.size = CGSizeMake(40, 40);
        self.cancelButton.top = self.aliImageView.bottom + 30;
        self.cancelButton.centerX = self.view.width / 2;
        self.cancelButton.top = self.view.centerY + self.aliImageView.height / 2 + 10;
        self.cancelButton.alpha = 0.0;
        
        [UIView animateWithDuration:0.7 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.4 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.aliImageView.centerY = self.view.height / 2 - 20;
            self.cancelButton.alpha = 1;
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
}

- (void)cancelButtonPressed:(id)sender
{
    [DMModalPresentationViewController dismiss];
}

- (void)tapEvent:(UIGestureRecognizer *)gest
{
    [[ServiceManager sharedManager] requestRecodLogWithPrarms:@{@"action" : @"aliClick"}];
    
    if (self.completionBlock)
    {
        self.completionBlock();
    }
    
    [DMModalPresentationViewController dismiss];
}

@end
