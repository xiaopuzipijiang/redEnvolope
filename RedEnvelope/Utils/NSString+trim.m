//
//  NSString+trim.m
//  Dealmoon
//
//  Created by 袁江 on 2017/10/30.
//  Copyright © 2017年 Dealmoon. All rights reserved.
//

#import "NSString+trim.h"

@implementation NSString (trim)

- (NSString *)trimWhitespaceAndNewline
{
    return [self stringByTrimmingCharactersInSet:[NSMutableCharacterSet whitespaceAndNewlineCharacterSet]];
}

@end
