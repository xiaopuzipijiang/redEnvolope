//
//  NSDictionary+KeyValue.m
//  Weibo
//
//  Created by Kai on 10/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "NSDictionary+KeyValue.h"
#import "NSString+SimpleMatching.h"

#if !defined(TARGET_OS_IPHONE) || !TARGET_OS_IPHONE
	#define CGPointValue pointValue
	#define CGRectValue rectValue
	#define CGSizeValue sizeValue
	#define UIImage NSImage
#else
	#import <UIKit/UIGeometry.h>
	#define NSPointFromString CGPointFromString
	#define NSRectFromString CGRectFromString
	#define NSSizeFromString CGSizeFromString
	#define NSZeroPoint CGPointZero
	#define NSZeroSize CGSizeZero
	#define NSZeroRect CGRectZero
#endif

@implementation NSDictionary (KeyValue)

- (NSNumber *)numberForKey:(NSString *)key defaultValue:(NSNumber *)defaultValue
{
	id object = [self objectForKey:key];
    if (![object isKindOfClass:[NSNumber class]])
        return defaultValue;
    return object;
}

- (NSNumber *)numberForKey:(NSString *)key
{
	return [self numberForKey:key defaultValue:nil];
}

- (NSString *)stringForKey:(NSString *)key defaultValue:(NSString *)defaultValue;
{
    id object = [self objectForKey:key];
    if ([object isKindOfClass:[NSNumber class]])
        return [object stringValue];
    if (![object isKindOfClass:[NSString class]])
        return defaultValue;
    return object;
}

- (NSString *)stringForKey:(NSString *)key emptyValue:(NSString *)emptyValue
{
    NSString *string = [self stringForKey:key defaultValue:nil];
    if ([string length] == 0)
    {
        return emptyValue;
    }
    
    return string;
}

- (NSString *)stringForKey:(NSString *)key;
{
    return [self stringForKey:key defaultValue:nil];
}

- (NSArray *)stringArrayForKey:(NSString *)key defaultValue:(NSArray *)defaultValue;
{
    NSArray *array = [self objectForKey:key];
    if (![array isKindOfClass:[NSArray class]])
        return defaultValue;
    for (id value in array) {
        if (![value isKindOfClass:[NSString class]])
            return defaultValue;
    }
    return array;
}

- (NSArray *)stringArrayForKey:(NSString *)key;
{
    return [self stringArrayForKey:key defaultValue:nil];
}

- (float)floatForKey:(NSString *)key defaultValue:(float)defaultValue;
{
    id value = [self objectForKey:key];
    if (value && [value respondsToSelector:@selector(floatValue)])
        return [value floatValue];
    return defaultValue;
}

- (float)floatForKey:(NSString *)key;
{
    return [self floatForKey:key defaultValue:0.0f];
}

- (double)doubleForKey:(NSString *)key defaultValue:(double)defaultValue;
{
    id value = [self objectForKey:key];
    if (value && [value respondsToSelector:@selector(doubleValue)])
        return [value doubleValue];
    return defaultValue;
}

- (double)doubleForKey:(NSString *)key;
{
    return [self doubleForKey:key defaultValue:0.0];
}

- (CGPoint)pointForKey:(NSString *)key defaultValue:(CGPoint)defaultValue;
{
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSString class]] && ![NSString isEmptyString:value])
        return NSPointFromString(value);
    else if ([value isKindOfClass:[NSValue class]])
        return [value CGPointValue];
    else
        return defaultValue;
}

- (CGPoint)pointForKey:(NSString *)key;
{
    return [self pointForKey:key defaultValue:NSZeroPoint];
}

- (CGSize)sizeForKey:(NSString *)key defaultValue:(CGSize)defaultValue;
{
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSString class]] && ![NSString isEmptyString:value])
        return NSSizeFromString(value);
    else if ([value isKindOfClass:[NSValue class]])
        return [value CGSizeValue];
    else
        return defaultValue;
}

- (CGSize)sizeForKey:(NSString *)key;
{
    return [self sizeForKey:key defaultValue:NSZeroSize];
}

- (CGRect)rectForKey:(NSString *)key defaultValue:(CGRect)defaultValue;
{
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSString class]] && ![NSString isEmptyString:value])
        return NSRectFromString(value);
    else if ([value isKindOfClass:[NSValue class]])
        return [value CGRectValue];
    else
        return defaultValue;
}

- (CGRect)rectForKey:(NSString *)key;
{
    return [self rectForKey:key defaultValue:NSZeroRect];
}

- (BOOL)boolForKey:(NSString *)key defaultValue:(BOOL)defaultValue;
{
    id value = [self objectForKey:key];
	
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]])
        return [value boolValue];
	
    return defaultValue;
}

- (BOOL)boolForKey:(NSString *)key;
{
    return [self boolForKey:key defaultValue:NO];
}

- (int)intForKey:(NSString *)key defaultValue:(int)defaultValue;
{
    id value = [self objectForKey:key];
    
    if (value && [value respondsToSelector:@selector(intValue)])
    {
        return [value intValue];
    }
    
    return defaultValue;
}

- (int)intForKey:(NSString *)key;
{
    return [self intForKey:key defaultValue:0];
}

- (unsigned int)unsignedIntForKey:(NSString *)key defaultValue:(unsigned int)defaultValue;
{
    id value = [self objectForKey:key];
    
    if (value && [value respondsToSelector:@selector(unsignedIntValue)])
    {
        return [value unsignedIntValue];
    }
    
    return defaultValue;
}

- (unsigned int)unsignedIntForKey:(NSString *)key;
{
    return [self unsignedIntForKey:key defaultValue:0];
}

- (unsigned long long int)unsignedLongLongForKey:(NSString *)key defaultValue:(unsigned long long int)defaultValue;
{
    id value = [self objectForKey:key];
    
    if (value && [value respondsToSelector:@selector(unsignedLongLongValue)])
    {
        return [value unsignedLongLongValue];
    }
    
    return defaultValue;
}

- (unsigned long long int)unsignedLongLongForKey:(NSString *)key;
{
    return [self unsignedLongLongForKey:key defaultValue:0ULL];
}

- (NSInteger)integerForKey:(NSString *)key defaultValue:(NSInteger)defaultValue;
{
    id value = [self objectForKey:key];
    
    if (value && [value respondsToSelector:@selector(integerValue)])
    {
        return [value integerValue];
    }
    
    return defaultValue;
}

- (NSInteger)integerForKey:(NSString *)key;
{
    return [self integerForKey:key defaultValue:0];
}

- (NSUInteger)unsignedIntegerForKey:(NSString *)key defaultValue:(NSUInteger)defaultValue
{
	id value = [self objectForKey:key];
    
    if (value && [value respondsToSelector:@selector(unsignedIntegerValue)])
    {
        return [value unsignedIntegerValue];
    }
    
    return defaultValue;
}

- (NSUInteger)unsignedIntegerForKey:(NSString *)key
{
	return [self unsignedIntegerForKey:key defaultValue:0];
}

- (UIImage *)imageForKey:(NSString *)key defaultValue:(UIImage *)defaultValue
{
    id object = [self objectForKey:key];
    if (![object isKindOfClass:[UIImage class]])
        return defaultValue;
    return object;
}

- (UIImage *)imageForKey:(NSString *)key
{
	return [self imageForKey:key defaultValue:nil];
}

- (NSURL *)urlForKey:(NSString *)key defaultValue:(NSURL *)defaultValue percentEscape:(BOOL)percentEscape
{
    NSString *string = [self stringForKey:key];
    if (string && ![string isEqualToString:@""])
    {
        if (percentEscape)
        {
            string = [string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
        }
        
        return [NSURL URLWithString:string];
    }
    
    return defaultValue;
}

- (NSURL *)urlForKey:(NSString *)key
{
    return [self urlForKey:key defaultValue:nil percentEscape:NO];
}

- (NSURL *)urlForKey:(NSString *)key percentEscape:(BOOL)percentEscape
{
    return [self urlForKey:key defaultValue:nil percentEscape:percentEscape];
}

- (UIColor *)UIColorForKey:(NSString *)key defaultValue:(UIColor *)defaultValue
{
    id object = [self objectForKey:key];
    if (![object isKindOfClass:[UIColor class]])
        return defaultValue;
    return object;
}

- (UIColor *)UIColorForKey:(NSString *)key
{
	return [self UIColorForKey:key defaultValue:[UIColor whiteColor]];
}

- (NSDictionary *)dictForKey:(NSString *)key defaultValue:(NSDictionary *)defaultValue
{
    id object = [self objectForKey:key];
    if (![object isKindOfClass:[NSDictionary class]])
        return defaultValue;
    return object;
}

- (NSDictionary *)dictForKey:(NSString *)key
{
	return [self dictForKey:key defaultValue:@{}];
}

- (NSArray *)arrayForKey:(NSString *)key defaultValue:(NSArray *)defaultValue
{
    id object = [self objectForKey:key];
    if (![object isKindOfClass:[NSArray class]])
        return defaultValue;
    return object;
}

- (NSArray *)arrayForKey:(NSString *)key
{
	return [self arrayForKey:key defaultValue:@[]];
}

@end

@implementation NSMutableDictionary (SafeKeyValue)

- (BOOL)setSafeObject:(NSObject *)object forKey:(NSString *)key
{
    if (object == nil || key == nil)
    {
        return NO;
    }
    
    [self setObject:object forKey:key];
    
    return YES;
}

@end
