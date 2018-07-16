//
//  DMTableViewHeaderFooterView.m
//  Dealmoon
//
//  Created by Kai Cao on 1/27/16.
//  Copyright © 2016 Dealmoon. All rights reserved.
//

#import "DMTableViewHeaderFooterView.h"

@implementation DMTableViewHeaderFooterView

#pragma mark - Cell Height

+ (CGFloat)viewHeightWithDataObject:(id)object width:(CGFloat)width
{
    return 0;
}

#pragma mark - Cell Identifier

+ (NSString *)defaultCellIdentifier
{
    return NSStringFromClass([self class]);
}

@end
