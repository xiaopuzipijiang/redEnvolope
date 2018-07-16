//
//  DMResultSet.m
//  Dealmoon
//
//  Created by Kai on 9/3/12.
//  Copyright (c) 2012 Dealmoon. All rights reserved.
//

#import "DMResultSet.h"

#define kDefaultPageSize        20

@interface DMResultSet ()
{
    NSMutableArray *_items;
    NSMutableDictionary *_userInfo;
}

@property (nonatomic, readwrite, strong) NSMutableArray *items;
@property (nonatomic, readwrite, strong) NSMutableDictionary *userInfo;

@end

@implementation DMResultSet

#pragma mark - Intialization

- (instancetype)init
{
    if ((self = [super init]))
    {
        self.pageSize = kDefaultPageSize;
        
        [self reset];
    }
    
    return self;
}

- (instancetype)initWithItems:(NSArray *)items
{
    if (self = [self init])
    {
        [self addItems:items];
    }
    
    return self;
}

+ (id)resultSet
{
    return [[[self class] alloc] init];
}

#pragma mark - Reset

- (void)reset
{
    self.items = [[NSMutableArray alloc] init];
    self.userInfo = [[NSMutableDictionary alloc] init];
    self.lastUpdatedDate = nil;
    self.hasMore = YES;
    self.currentPage = 0;
}

- (void)resetWithItems:(NSArray *)items currentPage:(NSInteger)page
{
    [self reset];
    [self setItems:items currentPage:page];
}

#pragma mark - Indexed Collection

- (void)addItem:(id)item
{
    if (item == nil)
    {
        return;
    }
    
    [_items addObject:item];
}

- (BOOL)addItemIfAbsent:(id)item
{
    if (item == nil || [_items containsObject:item])
    {
        return NO;
    }
    
    [_items addObject:item];
    
    return YES;
}

- (void)addItems:(NSArray *)array
{
    if (array && [array isKindOfClass:[NSArray class]])
    {
        [_items addObjectsFromArray:array];
    }
}

- (NSMutableArray *)addItemsIfAbsent:(NSArray *)array
{
    if (array && [array isKindOfClass:[NSArray class]])
    {
        NSMutableArray *validItems = [NSMutableArray arrayWithCapacity:[array count]];
        
        for (id object in array)
        {
            if ([self addItemIfAbsent:object])
            {
                [validItems addObject:object];
            }
        }
        
        return validItems;
    }
    
    return nil;
}

- (void)setItems:(NSArray *)items currentPage:(NSInteger)page
{
    [self removeAllItems];
    [self addItems:items];
    [self setCurrentPage:page];
}

- (void)removeItem:(id)item
{
    [_items removeObject:item];
}

- (NSUInteger)countOfItems
{
    return [_items count];
}

- (void)getItems:(id __unsafe_unretained [])buffer range:(NSRange)inRange
{
    [_items getObjects:buffer range:inRange];
}

- (id)firstObject
{
    return [self objectInItemsAtIndex:0];
}

- (id)lastObject
{
    return [_items lastObject];
}

- (id)objectInItemsAtIndex:(NSUInteger)index
{
    NSUInteger count = [self countOfItems];
    if (count == 0 || index > (count - 1))
    {
        return nil;
    }
    
    return [_items objectAtIndex:index];
}

- (void)insertObject:(id)anObject inItemsAtIndex:(NSUInteger)index
{
    if (index > [self countOfItems])
    {
        return;
    }
    
    if (anObject)
    {
        [_items insertObject:anObject atIndex:index];
    }
}

- (BOOL)insertObject:(id)anObject inItemsIfAbsentAtIndex:(NSUInteger)index
{
    if (index > [self countOfItems])
    {
        return NO;
    }
    
    if (anObject == nil || [_items containsObject:anObject])
    {
        return NO;
    }
    
    [_items insertObject:anObject atIndex:index];
    
    return YES;
}

- (void)insertItems:(NSArray *)itemArray atIndexes:(NSIndexSet *)indexes
{
    [_items insertObjects:itemArray atIndexes:indexes];
}

- (void)insertItemsIfAbsent:(NSArray *)itemArray atIndex:(NSUInteger)index
{
    if (itemArray && [itemArray isKindOfClass:[NSArray class]])
    {
        for (id object in itemArray)
        {
            if ([self insertObject:object inItemsIfAbsentAtIndex:index])
            {
                index ++;
            }
        }
    }
}

- (void)removeObjectFromItemsAtIndex:(NSUInteger)index
{
    NSUInteger count = [self countOfItems];
    if (count == 0 || index > (count - 1))
    {
        return;
    }
    
    [_items removeObjectAtIndex:index];
}

- (void)removeItemsAtIndexes:(NSIndexSet *)indexes
{
    [_items removeObjectsAtIndexes:indexes];
}

- (void)removeAllItems
{
    [_items removeAllObjects];
}

- (void)replaceObjectInItemsAtIndex:(NSUInteger)index withObject:(id)anObject
{
    NSUInteger count = [self countOfItems];
    if (count == 0 || index > (count - 1))
    {
        return;
    }
    
    [_items replaceObjectAtIndex:index withObject:anObject];
}

- (void)replaceItemsAtIndexes:(NSIndexSet *)indexes withItems:(NSArray *)itemArray
{
    [_items replaceObjectsAtIndexes:indexes withObjects:itemArray];
}

#pragma mark - User Info

- (NSDictionary *)userInfo
{
    return _userInfo;
}

- (id)objectInUserInfoForKey:(NSString *)key
{
    return [_userInfo objectForKey:key];
}

- (void)setUserInfoObject:(id)object forKey:(NSString *)key
{
    if (key != nil && object != nil)
    {
        [_userInfo setObject:object forKey:key];
    }
}

- (void)removeUserInfoObjectForKey:(NSString *)key
{
    [_userInfo removeObjectForKey:key];
}

@end
