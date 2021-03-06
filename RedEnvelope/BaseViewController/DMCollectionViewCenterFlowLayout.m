//
//  DMCollectionViewCenterFlowLayout.m
//  Dealmoon HD
//
//  Created by Kai on 11/19/14.
//  Copyright (c) 2014 Dealmoon. All rights reserved.
//

#import "DMCollectionViewCenterFlowLayout.h"

// https://github.com/keighl/KTCenterFlowLayout

@implementation DMCollectionViewCenterFlowLayout

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *superAttributes = [[NSMutableArray alloc] initWithArray:[super layoutAttributesForElementsInRect:rect] copyItems:YES];
    
    NSMutableDictionary *rowCollections = [NSMutableDictionary new];
    
    // Collect attributes by their midY coordinate.. i.e. rows!
    for (UICollectionViewLayoutAttributes *itemAttributes in superAttributes)
    {
        NSNumber *yCenter = @(CGRectGetMidY(itemAttributes.frame));
        
        if (!rowCollections[yCenter])
        {
            rowCollections[yCenter] = [NSMutableArray new];
        }
        
        [rowCollections[yCenter] addObject:itemAttributes];
    }
    
    // Adjust the items in each row
    [rowCollections enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        
        NSArray *itemAttributesCollection = obj;
        NSInteger itemsInRow = [itemAttributesCollection count];
        
        // x-x-x-x ... sum up the interim space
        CGFloat aggregateInteritemSpacing = self.minimumInteritemSpacing * (itemsInRow -1);
        
        // Sum the width of all elements in the row
        CGFloat aggregateItemWidths = 0.f;
        for (UICollectionViewLayoutAttributes *itemAttributes in itemAttributesCollection)
            aggregateItemWidths += CGRectGetWidth(itemAttributes.frame);
        
        // Build an alignment rect
        // |==|--------|==|
        CGFloat alignmentWidth = aggregateItemWidths + aggregateInteritemSpacing;
        CGFloat alignmentXOffset = (CGRectGetWidth(self.collectionView.bounds) - alignmentWidth) / 2.f;
        
        // Adjust each item's position to be centered
        CGRect previousFrame = CGRectZero;
        for (UICollectionViewLayoutAttributes *itemAttributes in itemAttributesCollection)
        {
            CGRect itemFrame = itemAttributes.frame;
            
            if (CGRectEqualToRect(previousFrame, CGRectZero))
                itemFrame.origin.x = alignmentXOffset;
            else
                itemFrame.origin.x = CGRectGetMaxX(previousFrame) + self.minimumInteritemSpacing;
            
            itemAttributes.frame = itemFrame;
            previousFrame = itemFrame;
        }
    }];
    
    return superAttributes;
}

@end
