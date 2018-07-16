//
//  DMModelObject.m
//  Dealmoon
//
//  Created by Kai on 9/3/12.
//  Copyright (c) 2012 Dealmoon. All rights reserved.
//

#import "DMModelObject.h"
#import <objc/runtime.h>

// Holds metadata for subclasses of DMModelObject.
static NSMutableDictionary *keyNames = nil;
static NSMutableDictionary *nillableKeyNames = nil;

@implementation DMModelObject

#pragma mark - Validation

// 数据解析完之后看model数据是否有效
- (BOOL)isValid
{
    return YES;
}

// 数据解析之前检查dictionary数据是否有效
+ (BOOL)isValidForDictionary:(NSDictionary *)dict
{
	return YES;
}

#pragma mark - Initialization

+ (Class)classWithDictionary:(NSDictionary *)dict
{
    return [self class];
}

+ (NSMutableArray *)objectsWithArray:(NSArray *)array
{
    return [[self class] objectsWithArray:array userInfo:nil block:nil];
}

+ (NSMutableArray *)objectsWithArray:(NSArray *)array userInfo:(NSDictionary *)userInfo
{
    return [[self class] objectsWithArray:array userInfo:userInfo block:nil];
}

+ (NSMutableArray *)objectsWithArray:(NSArray *)array userInfo:(NSDictionary *)userInfo block:(DMModelObjectBlock)block
{
	if (array == nil || ![array isKindOfClass:[NSArray class]])
	{
		return [NSMutableArray array];
	}
	
	NSMutableArray *objects = [[NSMutableArray alloc] initWithCapacity:[array count]];
	
	for (NSDictionary *dict in array)
	{
        if ([dict isKindOfClass:[NSNull class]])
        {
            break;
        }
        
        id object = [[[self classWithDictionary:dict] alloc] initWithDictionary:dict userInfo:userInfo];
        
        if (object && [object isValid])
        {
            if (block == nil || (block && block(object) == YES))
            {
                [objects addObject:object];
            }
        }
	}
	
	return objects;
}

+ (instancetype)objectWithDictionary:(NSDictionary *)dict
{
	return [[self class] objectWithDictionary:dict userInfo:nil];
}

+ (instancetype)objectWithDictionary:(NSDictionary *)dict userInfo:(NSDictionary *)userInfo
{
	return [[[self classWithDictionary:dict] alloc] initWithDictionary:dict userInfo:userInfo];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    return [self initWithDictionary:dict userInfo:nil];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict userInfo:(NSDictionary *)userInfo
{
	if (dict == nil || ![dict isKindOfClass:[NSDictionary class]])
	{
        self = nil;
		return nil;
	}
	
	if (![[self class] isValidForDictionary:dict])
	{
        self = nil;
		return nil;
	}
	
	if ((self = [self init]))
	{
		[self updateWithDictionary:dict userInfo:userInfo];
	}
	
	return self;
}

- (BOOL)updateWithDictionary:(NSDictionary *)dict
{
    return [self updateWithDictionary:dict userInfo:nil];
}

- (BOOL)updateWithDictionary:(NSDictionary *)dict userInfo:(NSDictionary *)userInfo
{
	if (dict == nil || ![dict isKindOfClass:[NSDictionary class]])
	{
		return NO;
	}
    
    return YES;
}

#pragma mark - Dictionary

- (NSDictionary *)dictionaryRepresentation
{
    return @{};
}

+ (NSMutableArray *)dictionaryRepresentationsForObjects:(NSArray *)objects
{
    if (objects == nil || ![objects isKindOfClass:[NSArray class]])
	{
		return [NSMutableArray array];
	}
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:[objects count]];
    
    for (DMModelObject *object in objects)
    {
        [array addObject:[object dictionaryRepresentation]];
    }
    
    return array;
}

#pragma mark - Runtime

+ (NSArray *)keysIgnoredForEncoding
{
    return @[];
}

// Before this class is first accessed, we'll need to build up our associated metadata, basically
// just a list of all our property names so we can quickly enumerate through them for various methods.
// Also we maintain a separate list of property names that can be set to nil (type ID) for fast dealloc.
+ (void)initialize
{
	if (!keyNames)
	{
		keyNames = [[NSMutableDictionary alloc] init];
	}
	
	if (!nillableKeyNames)
	{
		nillableKeyNames = [[NSMutableDictionary alloc] init];
	}
	
	NSMutableArray *names = [[NSMutableArray alloc] init];
	NSMutableArray *nillableNames = [[NSMutableArray alloc] init];
	
	for (Class class = self; class != [DMModelObject class]; class = [class superclass])
	{
		unsigned int varCount;
		Ivar *vars = class_copyIvarList(class, &varCount);
		
		for (int i = 0; i < varCount; i++)
		{
			Ivar var = vars[i];
			NSString *name = [[NSString alloc] initWithUTF8String:ivar_getName(var)];
			[names addObject:name];
			
			if (ivar_getTypeEncoding(var)[0] == _C_ID)		// _C_ID = An object (whether statically typed or typed id)
			{
				[nillableNames addObject:name];
			}
		}
        
        [names removeObjectsInArray:[class keysIgnoredForEncoding]];
        [nillableNames removeObjectsInArray:[class keysIgnoredForEncoding]];
		
		free(vars);
	}
	
	[keyNames setObject:names forKey:(id <NSCopying>)self];
	[nillableKeyNames setObject:nillableNames forKey:(id <NSCopying>)self];
}

- (NSArray *)allKeys
{
	return [keyNames objectForKey:[self class]];
}

- (NSArray *)nillableKeys
{
	return [nillableKeyNames objectForKey:[self class]];
}

#pragma mark - Keyed Archiving

- (id)initWithCoder:(NSCoder *)decoder
{
    if ((self = [super init]))
	{
		for (NSString *name in [self allKeys])
		{
            id value = [decoder decodeObjectForKey:name];
            if (!value) continue;
			[self setValue:value forKey:name];
		}
	}
	
	return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
	for (NSString *name in [self allKeys])
	{
        id value = [self valueForKey:name];
        if (!value) continue;
        @synchronized(self)
        {
            [encoder encodeObject:value forKey:name];
        }
	}
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone
{
	id copied = [[[self class] alloc] init];
	
	for (NSString *name in [self allKeys])
	{
        id value = [self valueForKey:name];
        if (!value) continue;
		[copied setValue:value forKey:name];
	}
	
	return copied;
}

#pragma mark - Equality

// For sub-classes to override.
// primaryKey should not be self, otherwise it would be an infinite loop.
- (id)primaryKey
{
	return nil;
}

- (BOOL)isEqual:(id)other
{
	// Compare pointer.
	if (other == self)
	{
		return YES;
	}
	
	// Compare primary key.
	if ([other isKindOfClass:[self class]])
	{
		if ([[other primaryKey] isEqual:[self primaryKey]])
		{
			return YES;
		}
	}
	
	return NO;
}

#pragma mark - Description

- (void)writeLineBreakToString:(NSMutableString *)string withTabs:(NSUInteger)tabCount
{
	[string appendString:@"\n"];
	
	for (int i = 0; i < tabCount; i++)
	{
		[string appendString:@"\t"];
	}
}

// Prints description in a nicely-formatted and indented manner.
- (void)writeToDescription:(NSMutableString *)description withIndent:(NSUInteger)indent foundedObjects:(NSMutableArray *)foundedObjects
{
    if ([foundedObjects containsObject:self])
    {
        [description appendFormat:@"<%@ %p>", NSStringFromClass([self class]), self];
        return;
    }
    
	[description appendFormat:@"<%@ %p", NSStringFromClass([self class]), self];
	
	for (NSString *name in [self allKeys])
	{
		[self writeLineBreakToString:description withTabs:indent];
        [foundedObjects addObject:self];
		
		id object = [self valueForKey:name];
		
		if ([object isKindOfClass:[DMModelObject class]])
		{
			[description appendFormat:@"%@ = ", name];
			
			[object writeToDescription:description withIndent:indent + 1 foundedObjects:foundedObjects];
		}
		else if ([object isKindOfClass:[NSArray class]])
		{
			[description appendFormat:@"%@ =", name];
			
			for (id child in object)
			{
				[self writeLineBreakToString:description withTabs:indent + 1];
                [foundedObjects addObject:self];
				
				if ([child isKindOfClass:[DMModelObject class]]) {
					[child writeToDescription:description withIndent:indent + 2 foundedObjects:foundedObjects];
				} else {
					[description appendString:[child description]];
				}
			}
		}
		else if ([object isKindOfClass:[NSDictionary class]])
		{
			[description appendFormat:@"%@ =", name];
			
			for (id key in object) {
				[self writeLineBreakToString:description withTabs:indent];
                [foundedObjects addObject:self];
				[description appendFormat:@"\t%@ = ", key];
				
				id child = [object objectForKey:key];
				
				if ([child isKindOfClass:[DMModelObject class]]) {
					[child writeToDescription:description withIndent:indent + 2 foundedObjects:foundedObjects];
				} else {
					[description appendString:[child description]];
				}
			}
		}
		else
		{
			[description appendFormat:@"%@ = %@", name, object];
		}
	}
	
	[description appendString:@">"];
}

// Override description for helpful debugging.
- (NSString *)description
{
	NSMutableString *description = [[NSMutableString alloc] init];
	[self writeToDescription:description withIndent:1 foundedObjects:[NSMutableArray array]];
	return description;
}

@end
