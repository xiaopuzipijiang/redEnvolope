//
//  DMTableViewHeaderFooterView.h
//  Dealmoon
//
//  Created by Kai Cao on 1/27/16.
//  Copyright © 2016 Dealmoon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DMTableViewHeaderFooterView : UITableViewHeaderFooterView

+ (CGFloat)viewHeightWithDataObject:(id)object width:(CGFloat)width;

+ (NSString *)defaultCellIdentifier;

@end
