//
//  NSString+SimpleMatching.h
//  Weibo
//
//  Created by Kai on 10/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SimpleMatching)

// Returns YES if the string is nil or equal to @""
+ (BOOL)isEmptyString:(NSString *)string;

- (BOOL)containsCharacterInSet:(NSCharacterSet *)searchSet;
- (BOOL)containsString:(NSString *)searchString options:(unsigned int)mask;
- (BOOL)containsString:(NSString *)searchString;
- (BOOL)hasLeadingWhitespace;

@end
