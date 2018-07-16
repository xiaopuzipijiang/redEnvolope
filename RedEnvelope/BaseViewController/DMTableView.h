//
//  DMTableView.h
//  Dealmoon
//
//  Created by Kai on 12/21/13.
//  Copyright (c) 2013 Dealmoon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMEmptyView.h"

@interface DMTableView : UITableView

@property (nonatomic, readonly, strong) UILabel *resultsTitleLabel;

@property (nonatomic, strong) DMEmptyView *emptyView;
@property (nonatomic, assign) UIOffset emptyViewOffset;
@property (nonatomic, assign) BOOL displaysEmptyView;

@end
