//
//  UserAccount.h
//  RedEnvelope
//
//  Created by 袁江 on 2018/7/21.
//  Copyright © 2018年 Envelope. All rights reserved.
//

#import "DMModelObject.h"

@interface UserAccount : DMModelObject

+ (instancetype)currentUserAccount;

@property (nonatomic, strong) NSString *secretKey;
@property (nonatomic, strong) NSString *t;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *wt;

- (void)saveAccount;

- (void)logout;

@end
