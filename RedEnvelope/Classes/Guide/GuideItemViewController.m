//
//  GuideItemViewController.m
//  RedEnvelope
//
//  Created by 袁江 on 2018/7/13.
//  Copyright © 2018年 Envelope. All rights reserved.
//

#import "GuideItemViewController.h"

@interface GuideItemViewController ()

@property (nonatomic, strong) UIImageView *bgView;

@end

@implementation GuideItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.bgView = [[UIImageView alloc] init];
    self.bgView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:self.bgView];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.bgView.frame = self.view.bounds;
}

@end
