//
//  OpenEnvelopeViewController.m
//  RedEnvelope
//
//  Created by 袁江 on 2018/7/14.
//  Copyright © 2018年 Envelope. All rights reserved.
//

#import "OpenEnvelopeViewController.h"
#import "RedEnvelope.h"

@interface OpenEnvelopeViewController ()

@property (nonatomic, strong) UIImageView *bgView;

@property (nonatomic, strong) UIButton *cancelButton;

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIButton *openButton;

@property (nonatomic, copy) void (^completionHandler) (BOOL success, id object);

@property (nonatomic, strong) RedEnvelope *redEnvelope;

@end

@implementation OpenEnvelopeViewController

- (instancetype)initWithRedEnvelope:(RedEnvelope *)redEnvelope CompletionHandler:(void (^)(BOOL success, id object))completionHandler
{
    self = [super init];
    
    self.completionHandler = completionHandler;
    self.redEnvelope = redEnvelope;
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    self.bgView = [[UIImageView alloc] init];
    self.bgView.image = [UIImage imageNamed:@"红包弹出"];
    self.bgView.userInteractionEnabled = YES;
    [self.view addSubview:self.bgView];
    
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.cancelButton setImage:DMSkinOriginalImage(@"关闭") forState:UIControlStateNormal];
    self.cancelButton.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    [self.cancelButton addTarget:self action:@selector(cancelButtonePressed:) forControlEvents:UIControlEventTouchUpInside];
    
    self.iconView = [[UIImageView alloc] init];
    self.iconView.image = [UIImage imageNamed:@"关于天天刷红包"];
    [self.view addSubview:self.iconView];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont systemFontOfSize:18];
    self.titleLabel.textColor = HEXCOLOR(0xf6e4bc);
    self.titleLabel.text = @"天天刷红包\n给您发了一个红包，金额随机";
    self.titleLabel.numberOfLines = 2;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.titleLabel];
    
    self.openButton = [[UIButton alloc] init];
    [self.openButton setBackgroundImage:[UIImage imageNamed:@"开"] forState:UIControlStateNormal];
    [self.openButton addTarget:self action:@selector(openButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.bgView addSubview:self.openButton];

    [self.view addSubview:self.cancelButton];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.firstAppearance)
    {
        self.bgView.frame = self.view.bounds;

        self.iconView.size = CGSizeMake(60, 60);
        self.iconView.integralCenterX = self.view.width / 2;
        self.iconView.top = 32;
        
        self.titleLabel.size = CGSizeMake(self.view.width, 100);
        self.titleLabel.top = self.iconView.bottom + 20;
        
        self.openButton.size = CGSizeMake(90, 90);
        self.openButton.integralCenterX = self.view.width / 2;
        self.openButton.bottom = self.view.height - 105;
        
        [self.cancelButton sizeToFit];
        self.cancelButton.left = 10;
        self.cancelButton.top = 10;
    }
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
}

- (void)openButtonPressed:(id)sender
{
    DMWEAKSELFDEFIND
    self.cancelButton.enabled = NO;
    self.openButton.enabled = NO;
    
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: 2 * M_PI];
    rotationAnimation.duration = 1;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = NSIntegerMax;
    self.openButton.layer.anchorPoint = CGPointMake(0.5, 0.5);

    [self.openButton.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];

    
    [[ServiceManager sharedManager] openEnvelopeWithId:self.redEnvelope.redEnvelopeId completionHandler:^(BOOL success, id object, NSString *errorMessage) {

        if (!success)
        {
            wSelf.cancelButton.enabled = YES;
            [wSelf.openButton.layer removeAllAnimations];
            [SVProgressHUD showErrorWithStatus:errorMessage];
        }

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            wSelf.cancelButton.enabled = YES;
            [wSelf.openButton.layer removeAllAnimations];
                if (wSelf.completionHandler)
                {
                    wSelf.completionHandler(success, object);
                }
        });

    }];
}

- (void)cancelButtonePressed:(id)sender
{
    [DMModalPresentationViewController dismiss];
}

@end
