//
//  NSString+SimpleMatching.m
//  Weibo
//
//  Created by Kai on 10/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "NSString+SimpleMatching.h"

@implementation NSString (SimpleMatching)

// Returns YES if the string is nil or equal to @""
+ (BOOL)isEmptyString:(NSString *)string;
{
    // Note that [string length] == 0 can be false when [string isEqualToString:@""] is true, because these are Unicode strings.
    return string == nil || [string isEqualToString:@""];
}

- (BOOL)containsCharacterInSet:(NSCharacterSet *)searchSet;
{
    NSRange characterRange = [self rangeOfCharacterFromSet:searchSet];
    return characterRange.length != 0;
}

- (BOOL)containsString:(NSString *)searchString options:(unsigned int)mask;
{
    return !searchString || [searchString length] == 0 || [self rangeOfString:searchString options:mask].length > 0;
}

- (BOOL)containsString:(NSString *)searchString;
{
    return !searchString || [searchString length] == 0 || [self rangeOfString:searchString].length > 0;
}

- (BOOL)hasLeadingWhitespace;
{
    if ([self length] == 0)
		return NO;
    switch ([self characterAtIndex:0]) {
        case ' ':
        case '\t':
        case '\r':
        case '\n':
            return YES;
        default:
            return NO;
    }
}

@end
