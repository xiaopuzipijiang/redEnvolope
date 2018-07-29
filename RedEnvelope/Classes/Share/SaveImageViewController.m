//
//  SaveImageViewController.m
//  RedEnvelope
//
//  Created by 袁江 on 2018/7/28.
//  Copyright © 2018年 Envelope. All rights reserved.
//

#import "SaveImageViewController.h"
#import <Photos/Photos.h>

@interface SaveImageViewController ()

@property (nonatomic ,strong) UIImage *image;
@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UIButton *saveButton;
@property (nonatomic, strong) UIButton *cancelButton;

@property (nonatomic, strong) UIView *seperator;

@end

@implementation SaveImageViewController

+ (void)showSaveImageViewControllerWithImage:(UIImage *)image
{
    SaveImageViewController *vc = [[SaveImageViewController alloc] init];
    vc.image = image;
    CGFloat width = DMScreenWidth - 60;
    CGFloat height = width * 400.0 / 250.0;
    CGRect rect = CGRectMake((DMScreenWidth - width) / 2, (DMScreenHeight - height) / 2, width, height);
    
    [DMModalPresentationViewController presentModeViewController:vc from:[UIApplication sharedApplication].keyWindow.rootViewController  withContentRect:rect];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageView = [[UIImageView alloc] init];
    self.imageView.image = self.image;
    [self.view addSubview:self.imageView];
    
    self.view.layer.cornerRadius = 10;
    self.view.clipsToBounds = YES;
    
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.cancelButton.tintColor = [UIColor blackColor];
    self.cancelButton.titleLabel.font = [UIFont systemFontOfSize:18.0f];
    [self.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelButton addTarget:self action:@selector(cancelButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.cancelButton];
    
    self.saveButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.saveButton.tintColor = [UIColor blackColor];
    self.saveButton.titleLabel.font = [UIFont systemFontOfSize:18.0f];
    [self.saveButton setTitle:@"保存到相册" forState:UIControlStateNormal];
    [self.saveButton addTarget:self action:@selector(saveButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.saveButton];

    self.seperator = [[UIView alloc] init];
    self.seperator.backgroundColor = HEXCOLOR(0xcccccc);
    [self.view addSubview:self.seperator];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.imageView.width = self.view.width;
    self.imageView.height = self.view.height - 50;
    
    self.cancelButton.size = CGSizeMake(self.view.width / 2, 50);
    self.cancelButton.top = self.imageView.bottom;
    
    self.saveButton.size = CGSizeMake(self.view.width / 2, 50);
    self.saveButton.top = self.imageView.bottom;
    self.saveButton.left = self.cancelButton.right;
    
    self.seperator.size = CGSizeMake(0.5, 24);
    self.seperator.integralCenterX = self.view.width / 2;
    self.seperator.integralCenterY = self.saveButton.centerY;
}

- (void)cancelButtonPressed:(UIButton *)button
{
    [DMModalPresentationViewController dismiss];
}

- (void)saveButtonPressed:(UIButton *)button
{
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        [PHAssetChangeRequest creationRequestForAssetFromImage:self.image];
        
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        
        if (success)
        {
            [SVProgressHUD showSuccessWithStatus:@"保存成功"];
            [DMModalPresentationViewController dismiss];
        }
        else
        {
            [SVProgressHUD showSuccessWithStatus:error.localizedDescription];
        }
    }];
}

@end
