//
//  ShareActionSheetViewController.m
//  RedEnvelope
//
//  Created by 袁江 on 2018/7/26.
//  Copyright © 2018年 Envelope. All rights reserved.
//

#import "ShareActionSheetViewController.h"

#define kHeight 200

@interface ShareActionSheetViewController ()

@property (nonatomic, copy) void (^completionHandler)(NSInteger type);

@property (nonatomic, strong) UIView *bottomBg;

@property (nonatomic, strong) UIButton *weixinSessionButton;
@property (nonatomic, strong) UIButton *weixinTimelineButton;
@property (nonatomic, strong) UIButton *qrCodeButton;

@property (nonatomic, strong) UIButton *cancelButton;

@end

@implementation ShareActionSheetViewController

+ (void)showShareActionSheetWithCompletionHandler:(void(^)(NSInteger type))completionHandler
{
    ShareActionSheetViewController *vc = [[ShareActionSheetViewController alloc] initWithCompletionHandler:completionHandler];
    
    [DMModalPresentationViewController presentModeViewController:vc from:[UIApplication sharedApplication].keyWindow.rootViewController  withContentRect:[UIApplication sharedApplication].keyWindow.rootViewController.view.bounds];
}

- (instancetype)initWithCompletionHandler:(void(^)(NSInteger type))completionHandler
{
    self = [super init];
    self.completionHandler = completionHandler;
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    self.bottomBg = [[UIView alloc] init];
    self.bottomBg.backgroundColor = [UIColor whiteColor];
    [self.bottomBg addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:nil]];
    [self.view addSubview:self.bottomBg];
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelButtonPressed:)]];
    
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.cancelButton setImage:DMSkinOriginalImage(@"关闭-1") forState:UIControlStateNormal];
    [self.cancelButton addTarget:self action:@selector(shareButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    self.weixinSessionButton = [self buttonWithImage:DMSkinOriginalImage(@"微信")];
    self.weixinSessionButton.tag = 0;
    
    self.weixinTimelineButton = [self buttonWithImage:DMSkinOriginalImage(@"朋友圈")];
    self.weixinTimelineButton.tag = 1;
    
    self.qrCodeButton = [self buttonWithImage:DMSkinOriginalImage(@"二维码收徒")];
    self.qrCodeButton.tag = 2;
    
    [self.bottomBg addSubview:self.cancelButton];
    [self.bottomBg addSubview:self.weixinTimelineButton];
    [self.bottomBg addSubview:self.weixinSessionButton];
    [self.bottomBg addSubview:self.qrCodeButton];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.firstAppearance)
    {
        self.bottomBg.frame = CGRectMake(0, 0, self.view.width, kHeight);
        self.bottomBg.top = self.view.height;
        [UIView animateWithDuration:0.35 animations:^{
            self.bottomBg.bottom = self.view.height;
        }];
    }
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    CGFloat widht = ceil(self.view.width / 3);
    self.weixinSessionButton.size = CGSizeMake(widht, widht);
    self.weixinSessionButton.left = 0;
    self.weixinSessionButton.top = 15;
    
    self.weixinTimelineButton.size = CGSizeMake(widht, widht);
    self.weixinTimelineButton.left = self.weixinSessionButton.right;
    self.weixinTimelineButton.top = self.weixinSessionButton.top;

    self.qrCodeButton.size = CGSizeMake(widht, widht);
    self.qrCodeButton.left = self.weixinTimelineButton.right;
    self.qrCodeButton.top = self.weixinTimelineButton.top;
    
    self.cancelButton.size = CGSizeMake(28, 28);
    self.cancelButton.integralCenterX = self.bottomBg.width / 2;
    self.cancelButton.bottom = self.bottomBg.height - 25;
    
}

- (UIButton *)buttonWithImage:(UIImage *)image
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:self action:@selector(shareButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

- (void)cancelButtonPressed:(id)sender
{
    [DMModalPresentationViewController dismiss];
}

- (void)shareButtonPressed:(UIButton *)button
{
    [DMModalPresentationViewController dismiss];

    if (self.completionHandler)
    {
        self.completionHandler(button.tag);
    }
}

@end
