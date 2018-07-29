//
//  ShareView.h
//  RedEnvelope
//
//  Created by 袁江 on 2018/7/28.
//  Copyright © 2018年 Envelope. All rights reserved.
//

#import <UIKit/UIKit.h>

@class InvitationInfo;

@interface ShareView : UIImageView

@property (nonatomic, strong) InvitationInfo *invitationInfo;

- (UIImage *)makeImage;

@end
