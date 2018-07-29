//
//  NSString+Check.m
//  DealmoonMerchant
//
//  Created by 袁江 on 2018/6/20.
//  Copyright © 2018年 Dealmoon. All rights reserved.
//

#import "NSString+Check.h"

@implementation NSString (Check)


//判断是否为整形：

- (BOOL)isPureInt{
    
    NSScanner* scan = [NSScanner scannerWithString:self];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}



//判断是否为浮点形：

- (BOOL)isPureFloat{
    NSScanner* scan = [NSScanner scannerWithString:self];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}


-(BOOL)isNameValid
{
    NSString *userNameRegex = @"^(?![0-9]+$)[0-9A-Za-z]{1,20}$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:self];
    return B;
}

-(BOOL)isPasswordValid
{
    NSString *userNameRegex = @"^[a-zA-Z0-9]{6,20}$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:self];
    return B;
}

-(BOOL)isValidateEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

- (BOOL)isZipCode
{
    NSString * regex = @"^[0-9]{1,6}$";
    NSPredicate * pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

- (BOOL)isTelephone
{
    NSString * regex = @"^[0-9\\s-\(\\)（） ]{1,18}";
    NSPredicate * pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

@end
