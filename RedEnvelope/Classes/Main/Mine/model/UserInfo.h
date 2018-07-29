//
//  UserInfo.h
//  RedEnvelope
//
//  Created by 袁江 on 2018/7/22.
//  Copyright © 2018年 Envelope. All rights reserved.
//

#import "DMModelObject.h"

@interface UserInfo : DMModelObject

@property (nonatomic, strong) NSString *headimgurl;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *userId;

@end
