//
//  DMResultSet.h
//  Dealmoon
//
//  Created by Kai on 9/3/12.
//  Copyright (c) 2012 Dealmoon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DMResultSet : NSObject

@property (nonatomic, readonly, strong) NSArray *items;
@property (nonatomic, readonly, strong) NSDictionary *userInfo;
@property (nonatomic, assign) NSUInteger pageSize;
@property (nonatomic, assign) NSUInteger currentPage;
@property (nonatomic, assign) NSUInteger expectedTotalCount;
@property (nonatomic, strong) NSDate *lastUpdatedDate;
@property (nonatomic, assign) BOOL hasMore;

+ (instancetype)resultSet;
- (instancetype)initWithItems:(NSArray *)items;

- (void)reset;
- (void)resetWithItems:(NSArray *)items currentPage:(NSInteger)page;

// Add or remove item.
- (void)addItem:(id)item;
- (BOOL)addItemIfAbsent:(id)item;
- (void)addItems:(NSArray *)array;
- (NSMutableArray *)addItemsIfAbsent:(NSArray *)array;
- (void)setItems:(NSArray *)items currentPage:(NSInteger)page;
- (void)removeItem:(id)item;

// Indexed collection.
- (NSUInteger)countOfItems;
- (void)getItems:(id __unsafe_unretained [])buffer range:(NSRange)inRange;
- (id)firstObject;
- (id)lastObject;
- (id)objectInItemsAtIndex:(NSUInteger)index;
- (void)insertObject:(id)anObject inItemsAtIndex:(NSUInteger)index;
- (BOOL)insertObject:(id)anObject inItemsIfAbsentAtIndex:(NSUInteger)index;
- (void)insertItems:(NSArray *)itemArray atIndexes:(NSIndexSet *)indexes;
- (void)insertItemsIfAbsent:(NSArray *)itemArray atIndex:(NSUInteger)index;
- (void)removeObjectFromItemsAtIndex:(NSUInteger)index;
- (void)removeItemsAtIndexes:(NSIndexSet *)indexes;
- (void)removeAllItems;
- (void)replaceObjectInItemsAtIndex:(NSUInteger)index withObject:(id)anObject;
- (void)replaceItemsAtIndexes:(NSIndexSet *)indexes withItems:(NSArray *)itemArray;

// User info.
- (NSDictionary *)userInfo;
- (id)objectInUserInfoForKey:(NSString *)key;
- (void)setUserInfoObject:(id)object forKey:(NSString *)key;
- (void)removeUserInfoObjectForKey:(NSString *)key;

@end
