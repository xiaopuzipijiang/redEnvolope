//
//  DMModelObject.h
//  Dealmoon
//
//  Created by Kai on 9/3/12.
//  Copyright (c) 2012 Dealmoon. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DMModelObject;

typedef BOOL(^DMModelObjectBlock)(id object);;

@interface DMModelObject : NSObject <NSCoding, NSCopying>

// If the object is not valid, it won't be added into the objects array.
@property (nonatomic, readonly, getter = isValid) BOOL isValid;
// The primary key is mainly used for equality comparison.
@property (nonatomic, readonly) id primaryKey;

@property (nonatomic, readonly) NSArray *allKeys;
@property (nonatomic, readonly) NSArray *nillableKeys;

+ (NSArray *)keysIgnoredForEncoding;

// Validate the dictionary to be converted.
+ (BOOL)isValidForDictionary:(NSDictionary *)dict;

+ (Class)classWithDictionary:(NSDictionary *)dict;

+ (NSMutableArray *)objectsWithArray:(NSArray *)array;
+ (NSMutableArray *)objectsWithArray:(NSArray *)array userInfo:(NSDictionary *)userInfo;
+ (NSMutableArray *)objectsWithArray:(NSArray *)array userInfo:(NSDictionary *)userInfo block:(DMModelObjectBlock)block;
+ (instancetype)objectWithDictionary:(NSDictionary *)dict;
+ (instancetype)objectWithDictionary:(NSDictionary *)dict userInfo:(NSDictionary *)userInfo;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict userInfo:(NSDictionary *)userInfo;
- (BOOL)updateWithDictionary:(NSDictionary *)dict;
- (BOOL)updateWithDictionary:(NSDictionary *)dict userInfo:(NSDictionary *)userInfo;

- (NSDictionary *)dictionaryRepresentation;
+ (NSMutableArray *)dictionaryRepresentationsForObjects:(NSArray *)objects;

@end
