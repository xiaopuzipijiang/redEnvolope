//
//  ShareView.m
//  RedEnvelope
//
//  Created by 袁江 on 2018/7/28.
//  Copyright © 2018年 Envelope. All rights reserved.
//

#import "ShareView.h"
#import "InvitationInfo.h"

@interface ShareView ()

@property (nonatomic, strong) UIImageView *qrCodeView;

@property (nonatomic, strong) UILabel *invitationCodeLabel;

@end

@implementation ShareView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    self.image = [UIImage imageNamed:@"Group 18"];
    
    self.qrCodeView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 75, 75)];
    self.qrCodeView.integralCenterX = self.width / 2;
    self.qrCodeView.bottom = self.height - 85;
    self.qrCodeView.backgroundColor = [UIColor whiteColor];
    
    self.invitationCodeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, 25)];
    self.invitationCodeLabel.textAlignment = NSTextAlignmentCenter;
    self.invitationCodeLabel.top = self.qrCodeView.bottom + 12.5;
    self.invitationCodeLabel.font = [UIFont systemFontOfSize:10];
    self.invitationCodeLabel.textColor = HEXCOLOR(0xffb991);
    
    [self addSubview:self.qrCodeView];
    [self addSubview:self.invitationCodeLabel];
    
    return self;
}

- (void)setInvitationInfo:(InvitationInfo *)invitationInfo
{
    _invitationInfo = invitationInfo;
}

- (UIImage *)makeImage
{
    UIImage *qrcodeImage = [UIImage imageWithCIImage:[self creatQRcodeWithUrlstring:self.invitationInfo.url]];
    self.qrCodeView.image = qrcodeImage;
    
    self.invitationCodeLabel.text = [NSString stringWithFormat:@"邀请码 %@", self.invitationInfo.inviteCode];
    
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, MIN([UIScreen mainScreen].scale, 2));
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (CIImage *)creatQRcodeWithUrlstring:(NSString *)urlString{
    
    // 1.实例化二维码滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 2.恢复滤镜的默认属性 (因为滤镜有可能保存上一次的属性)
    [filter setDefaults];
    // 3.将字符串转换成NSdata
    NSData *data  = [urlString dataUsingEncoding:NSUTF8StringEncoding];
    // 4.通过KVO设置滤镜, 传入data, 将来滤镜就知道要通过传入的数据生成二维码
    [filter setValue:data forKey:@"inputMessage"];
    // 5.生成二维码
    CIImage *outputImage = [filter outputImage];
    return outputImage;
}

@end
