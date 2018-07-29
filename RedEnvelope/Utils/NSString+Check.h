//
//  NSString+Check.h
//  DealmoonMerchant
//
//  Created by 袁江 on 2018/6/20.
//  Copyright © 2018年 Dealmoon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Check)

- (BOOL)isPureFloat;

- (BOOL)isPureInt;

-(BOOL)isNameValid;

-(BOOL)isValidateEmail;

-(BOOL)isPasswordValid;

- (BOOL)isZipCode;

- (BOOL)isTelephone;

@end
