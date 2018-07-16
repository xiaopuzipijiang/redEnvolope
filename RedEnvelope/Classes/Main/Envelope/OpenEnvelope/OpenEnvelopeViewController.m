//
//  OpenEnvelopeViewController.m
//  RedEnvelope
//
//  Created by 袁江 on 2018/7/14.
//  Copyright © 2018年 Envelope. All rights reserved.
//

#import "OpenEnvelopeViewController.h"

@interface OpenEnvelopeViewController ()

@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIImageView *bgView;

@end

@implementation OpenEnvelopeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    self.bgView = [[UIImageView alloc] init];
    self.bgView.image = [UIImage imageNamed:@"红包弹出"];
    [self.view addSubview:self.bgView];
    
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.cancelButton setImage:DMSkinOriginalImage(@"关闭") forState:UIControlStateNormal];
    self.cancelButton.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    [self.cancelButton addTarget:self action:@selector(cancelButtonePressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.cancelButton];
    // Do any additional setup after loading the view.
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.bgView.frame = self.view.bounds;
    
    [self.cancelButton sizeToFit];
    self.cancelButton.left = 10;
    self.cancelButton.top = 10;
}

- (void)cancelButtonePressed:(id)sender
{
    [DMModalPresentationViewController dismiss];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
