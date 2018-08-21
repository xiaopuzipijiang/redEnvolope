//
//  UserAccount.m
//  RedEnvelope
//
//  Created by 袁江 on 2018/7/21.
//  Copyright © 2018年 Envelope. All rights reserved.
//

#import "UserAccount.h"


#define kCurrentUserAccountStoreKey @"CurrentUserAccountStoreKey110"

@implementation UserAccount

+ (instancetype)currentUserAccount
{
    NSData *currentAccountData = [[NSUserDefaults standardUserDefaults] objectForKey:kCurrentUserAccountStoreKey];
    UserAccount *account = [NSKeyedUnarchiver unarchiveObjectWithData:currentAccountData];
    
    return account;
}

- (void)saveAccount
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:kCurrentUserAccountStoreKey];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)logout
{
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:kCurrentUserAccountStoreKey];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
