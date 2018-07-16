//
//  DMDataSourceItem.h
//  Dealmoon
//
//  Created by Kai on 10/2/15.
//  Copyright © 2015 Dealmoon. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DMTableViewCell;

typedef void (^ConfigCellBlock) (id cell, id object);
typedef void (^DidSelectedCellBlock) (id cell, id object);

@interface DMDataSourceItem : NSObject

@property (nonatomic, assign) NSInteger identifier;
@property (nonatomic, strong) id object;
@property (nonatomic, strong) NSDictionary *userInfo;
@property (nonatomic, strong) Class cellClass;

@property (nonatomic, copy) NSArray *subitems;
@property (nonatomic, weak) DMDataSourceItem *parentItem;

- (instancetype)initWithID:(NSInteger)identifier;
+ (instancetype)item;
+ (instancetype)itemWithID:(NSInteger)identifier;

- (void)addSubitem:(DMDataSourceItem *)item;
- (DMDataSourceItem *)addSubitemWithID:(NSInteger)identifier;
- (DMDataSourceItem *)addSubitemWithID:(NSInteger)identifier object:(id)object;

- (void)insertItem:(DMDataSourceItem *)item atIndex:(NSInteger)index;
- (DMDataSourceItem *)insertSubitemWithID:(NSInteger)identifier atIndex:(NSInteger)index;
- (DMDataSourceItem *)insertSubitemWithID:(NSInteger)identifier atIndex:(NSInteger)index object:(id)object;

- (void)removeSubitem:(DMDataSourceItem *)item;
- (void)removeAllSubitems;

- (NSUInteger)subitemCount;

- (NSUInteger)indexByIdentifier:(NSInteger)identifier;
- (DMDataSourceItem *)subitemByIdentifier:(NSInteger)identifier;

- (DMDataSourceItem *)objectAtIndexedSubscript:(NSUInteger)index;
- (void)setObject:(DMDataSourceItem *)object atIndexedSubscript:(NSUInteger)index;


//重构
- (instancetype)initWithClass:(Class)cellClass;
+ (instancetype)itemWithClass:(Class)cellClass;

@property (nonatomic, copy) ConfigCellBlock configCellBlock;
@property (nonatomic, copy) DidSelectedCellBlock didSelectedCellBlock;

- (DMDataSourceItem *)addSubitemWithClass:(Class)cellClass;
- (DMDataSourceItem *)addSubitemWithClass:(Class)cellClass object:(id)object;

- (DMDataSourceItem *)addSubitemWithClass:(Class)cellClass
                                   object:(id)object
                          configCellBlock:(ConfigCellBlock)configBlock;

- (DMDataSourceItem *)addSubitemWithClass:(Class)cellClass
                                   object:(id)object
                          configCellBlock:(ConfigCellBlock)configBlock
                         didSelectedBlock:(DidSelectedCellBlock)selectedBlock;

@end
