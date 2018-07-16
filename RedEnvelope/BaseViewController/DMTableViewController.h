//
//  DMTableViewController.h
//  Dealmoon
//
//  Created by Kai on 9/2/12.
//  Copyright (c) 2012 Dealmoon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMViewController.h"
#import "DMTableView.h"
#import "DMDataSourceItem.h"

typedef NS_ENUM(NSInteger, DMCellSectionDefaultType)
{
    DMCellSectionDefaultTypeI,
    DMCellSectionDefaultTypeII,
    DMCellSectionDefaultTypeIII,
    DMCellSectionDefaultTypeIV
};

//typedef NS_ENUM(NSInteger, DMCellCellDefaultType)
//{
//    DMCellCellDefaultTypeI,
//    DMCellCellDefaultTypeII,
//    DMCellCellDefaultTypeIII,
//    DMCellCellDefaultTypeIV,
//    DMCellCellDefaultTypeV,
//    DMCellCellDefaultTypeVI
//};

@class DMTableViewCell;

@protocol DMTableViewControllerProtocol <NSObject>

@property (nonatomic, strong) DMDataSourceItem *viewDataSource;

@optional
- (NSArray <Class> *)classesForRegiste;
- (void)reloadDataSource;
- (void)configCell:(DMTableViewCell *)cell withCellClass:(Class)cellClass object:(id)object;

@end


@interface DMTableViewController : DMViewController <UITableViewDelegate, UITableViewDataSource, DMTableViewControllerProtocol, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (nonatomic, strong) DMTableView *tableView;
@property (nonatomic, assign) BOOL clearsSelectionOnViewWillAppear;


- (instancetype)initWithStyle:(UITableViewStyle)style;

- (void)scrollViewDidScroll:(UIScrollView *)scrollView; // must call super when override

@property (nonatomic, assign) UITableViewStyle tableViewStyle;

@property (nonatomic, strong) DMDataSourceItem *viewDataSource;

@end
