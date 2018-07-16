//
//  DMDataSourceItem.m
//  Dealmoon
//
//  Created by Kai on 10/2/15.
//  Copyright © 2015 Dealmoon. All rights reserved.
//

#import "DMDataSourceItem.h"

@interface DMDataSourceItem ()

@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation DMDataSourceItem

#pragma mark - Initialization

- (instancetype)initWithID:(NSInteger)identifier
{
    if (self = [super init])
    {
        self.identifier = identifier;
        self.items = [[NSMutableArray alloc] init];
    }
    
    return self;
}

+ (instancetype)item
{
    return [[DMDataSourceItem alloc] initWithID:NSNotFound];
}

+ (instancetype)itemWithID:(NSInteger)identifier
{
    return [[DMDataSourceItem alloc] initWithID:identifier];
}

- (instancetype)initWithClass:(Class)cellClass
{
    if (self = [super init])
    {
        self.cellClass = cellClass;
        self.items = [[NSMutableArray alloc] init];
    }
    
    return self;
}

+ (instancetype)itemWithClass:(Class)cellClass
{
    return [[DMDataSourceItem alloc] initWithClass:cellClass];
}

#pragma mark - Add & Remove Subitems

- (void)addSubitem:(DMDataSourceItem *)item
{
    [self.items addObject:item];
    item.parentItem = self;
}

- (void)insertItem:(DMDataSourceItem *)item atIndex:(NSInteger)index
{
    [self.items insertObject:item atIndex:index];
    item.parentItem = self;
}

- (DMDataSourceItem *)addSubitemWithID:(NSInteger)identifier
{
    return [self addSubitemWithID:identifier object:nil];
}

- (DMDataSourceItem *)addSubitemWithID:(NSInteger)identifier object:(id)object
{
    DMDataSourceItem *item = [DMDataSourceItem itemWithID:identifier];
    item.object = object;
    [self addSubitem:item];
    return item;
}

- (DMDataSourceItem *)addSubitemWithClass:(Class)cellClass
{
    return [self addSubitemWithClass:cellClass object:nil];
}

- (DMDataSourceItem *)addSubitemWithClass:(Class)cellClass object:(id)object
{
    DMDataSourceItem *item = [DMDataSourceItem itemWithClass:cellClass];
    item.object = object;
    [self addSubitem:item];
    return item;
}


- (DMDataSourceItem *)addSubitemWithClass:(Class)cellClass
                                   object:(id)object
                          configCellBlock:(ConfigCellBlock)configBlock
{
    DMDataSourceItem *item = [self addSubitemWithClass:cellClass object:object];
    item.configCellBlock = configBlock;
    
    return item;
}

- (DMDataSourceItem *)addSubitemWithClass:(Class)cellClass
                                   object:(id)object
                          configCellBlock:(ConfigCellBlock)configBlock
                         didSelectedBlock:(DidSelectedCellBlock)selectedBlock
{
    DMDataSourceItem *item = [self addSubitemWithClass:cellClass object:object];
    item.configCellBlock = configBlock;
    item.didSelectedCellBlock = selectedBlock;
    
    return item;
}

- (DMDataSourceItem *)insertSubitemWithID:(NSInteger)identifier atIndex:(NSInteger)index
{
    return [self insertSubitemWithID:identifier atIndex:index object:nil];
}

- (DMDataSourceItem *)insertSubitemWithID:(NSInteger)identifier atIndex:(NSInteger)index object:(id)object
{
    DMDataSourceItem *item = [DMDataSourceItem itemWithID:identifier];
    item.object = object;
    [self insertItem:item atIndex:index];
    return item;
}

- (void)removeSubitem:(DMDataSourceItem *)item
{
    item.parentItem = nil;
    [self.items removeObject:item];
}

- (void)removeAllSubitems
{
    [self.items removeAllObjects];
}

- (NSArray *)subitems
{
    return self.items;
}

- (void)setSubitems:(NSArray *)subitems
{
    self.items = [subitems mutableCopy];
    
    for (DMDataSourceItem *item in self.items)
    {
        item.parentItem = self;
    }
}

- (NSMutableArray *)items
{
    if (_items == nil)
    {
        _items = [[NSMutableArray alloc] init];
    }
    
    return _items;
}

- (NSUInteger)subitemCount
{
    return [self.items count];
}

- (NSUInteger)indexByIdentifier:(NSInteger)identifier
{
    NSUInteger count = [self subitemCount];
    for (int i = 0; i < count; i++)
    {
        if ([(DMDataSourceItem *)self.subitems[i] identifier] == identifier)
        {
            return i;
        }
    }
    
    return NSNotFound;
}

- (DMDataSourceItem *)subitemByIdentifier:(NSInteger)identifier
{
    for (DMDataSourceItem *item in self.subitems)
    {
        if (item.identifier == identifier)
        {
            return item;
        }
    }
    
    return nil;
}

#pragma mark - Subscripting

- (DMDataSourceItem *)objectAtIndexedSubscript:(NSUInteger)index
{
    return self.items[index];
}

- (void)setObject:(DMDataSourceItem *)object atIndexedSubscript:(NSUInteger)index
{
    self.items[index] = object;
}

@end
