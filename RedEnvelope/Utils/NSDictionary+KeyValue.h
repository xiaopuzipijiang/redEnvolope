//
//  NSDictionary+KeyValue.h
//  Weibo
//
//  Created by Kai on 10/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#if !defined(TARGET_OS_IPHONE) || !TARGET_OS_IPHONE
	#import <Foundation/NSGeometry.h> // For NSPoint, NSSize, and NSRect
	#import <AppKit/AppKit.h>
#else
	#import <CoreGraphics/CGGeometry.h>
	#import <UIKit/UIKit.h>
#endif

@interface NSDictionary (KeyValue)

- (NSNumber *)numberForKey:(NSString *)key defaultValue:(NSNumber *)defaultValue;
- (NSNumber *)numberForKey:(NSString *)key;

- (NSString *)stringForKey:(NSString *)key defaultValue:(NSString *)defaultValue;
- (NSString *)stringForKey:(NSString *)key emptyValue:(NSString *)emptyValue;
- (NSString *)stringForKey:(NSString *)key;

- (NSArray *)stringArrayForKey:(NSString *)key defaultValue:(NSArray *)defaultValue;
- (NSArray *)stringArrayForKey:(NSString *)key;

// ObjC methods to nil have undefined results for non-id values (though ints happen to currently work)
- (float)floatForKey:(NSString *)key defaultValue:(float)defaultValue;
- (float)floatForKey:(NSString *)key;
- (double)doubleForKey:(NSString *)key defaultValue:(double)defaultValue;
- (double)doubleForKey:(NSString *)key;

- (CGPoint)pointForKey:(NSString *)key defaultValue:(CGPoint)defaultValue;
- (CGPoint)pointForKey:(NSString *)key;
- (CGSize)sizeForKey:(NSString *)key defaultValue:(CGSize)defaultValue;
- (CGSize)sizeForKey:(NSString *)key;
- (CGRect)rectForKey:(NSString *)key defaultValue:(CGRect)defaultValue;
- (CGRect)rectForKey:(NSString *)key;

// Returns YES iff the value is YES, Y, yes, y, or 1.
- (BOOL)boolForKey:(NSString *)key defaultValue:(BOOL)defaultValue;
- (BOOL)boolForKey:(NSString *)key;

// Just to make life easier
- (int)intForKey:(NSString *)key defaultValue:(int)defaultValue;
- (int)intForKey:(NSString *)key;
- (unsigned int)unsignedIntForKey:(NSString *)key defaultValue:(unsigned int)defaultValue;
- (unsigned int)unsignedIntForKey:(NSString *)key;

- (NSInteger)integerForKey:(NSString *)key defaultValue:(NSInteger)defaultValue;
- (NSInteger)integerForKey:(NSString *)key;

- (NSUInteger)unsignedIntegerForKey:(NSString *)key defaultValue:(NSUInteger)defaultValue;
- (NSUInteger)unsignedIntegerForKey:(NSString *)key;

- (unsigned long long int)unsignedLongLongForKey:(NSString *)key defaultValue:(unsigned long long int)defaultValue;
- (unsigned long long int)unsignedLongLongForKey:(NSString *)key;

- (UIImage *)imageForKey:(NSString *)key defaultValue:(UIImage *)defaultValue;
- (UIImage *)imageForKey:(NSString *)key;

- (NSURL *)urlForKey:(NSString *)key defaultValue:(NSURL *)defaultValue percentEscape:(BOOL)percentEscape;
- (NSURL *)urlForKey:(NSString *)key percentEscape:(BOOL)percentEscape;
- (NSURL *)urlForKey:(NSString *)key;

// Originally colorForKey:defaultValue:, colorForKey:.
// BaiduInput has the same names.
- (UIColor *)UIColorForKey:(NSString *)key defaultValue:(UIColor *)defaultValue;
- (UIColor *)UIColorForKey:(NSString *)key;

- (NSDictionary *)dictForKey:(NSString *)key defaultValue:(NSDictionary *)defaultValue;
- (NSDictionary *)dictForKey:(NSString *)key;

- (NSArray *)arrayForKey:(NSString *)key defaultValue:(NSArray *)defaultValue;
- (NSArray *)arrayForKey:(NSString *)key;

@end

@interface NSMutableDictionary (SafeKeyValue)

- (BOOL)setSafeObject:(NSObject *)object forKey:(NSString *)key;

@end
