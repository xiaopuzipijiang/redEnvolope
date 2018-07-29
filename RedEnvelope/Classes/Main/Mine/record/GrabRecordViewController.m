//
//  GrabRecordViewController.m
//  RedEnvelope
//
//  Created by 袁江 on 2018/7/17.
//  Copyright © 2018年 Envelope. All rights reserved.
//

#import "GrabRecordViewController.h"
#import "GrabRecordCell.h"
#import "ServiceManager.h"
#import "GrabRecord.h"

@interface GrabRecordViewController ()

@property (nonatomic, strong) DMResultSet *resultSet;

@end

@implementation GrabRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    self.resultSet = [[DMResultSet alloc] init];
    
    self.title = @"收到的红包";
    
    [self setUpRefreshControls];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.firstAppearance)
    {
        [self.tableView.mj_header beginRefreshing];
    }
}

- (NSArray<Class> *)classesForRegiste
{
    return @[[GrabRecordCell class]];
}

- (void)setUpRefreshControls
{
    DMWEAKSELFDEFIND
    
    self.tableView.mj_header = [RERefreshHeader headerWithRefreshingBlock:^{
        [wSelf.resultSet removeAllItems];
        wSelf.resultSet.currentPage = 1;
        [[ServiceManager sharedManager] grabRecordListWithResult:self.resultSet CompletionHandler:^(BOOL success, NSString *errorMessage) {
            [wSelf.tableView.mj_header endRefreshing];
            wSelf.tableView.mj_footer.hidden = !self.resultSet.hasMore;
            
            [wSelf reloadDataSource];
        }];
    }];
    
    self.tableView.mj_footer = [RERefreshFooter footerWithRefreshingBlock:^{
        wSelf.resultSet.currentPage += 1;
        [[ServiceManager sharedManager] grabRecordListWithResult:self.resultSet CompletionHandler:^(BOOL success, NSString *errorMessage) {
            [wSelf.tableView.mj_footer endRefreshing];
            wSelf.tableView.mj_footer.hidden = !self.resultSet.hasMore;
            
            [wSelf reloadDataSource];
        }];
    }];
}

- (void)reloadDataSource
{
    [self.viewDataSource removeAllSubitems];
    
    DMDataSourceItem *section = [[DMDataSourceItem alloc] init];
    
    for (GrabRecord *record in self.resultSet.items)
    {
        [section addSubitemWithClass:[GrabRecordCell class] object:record configCellBlock:^(GrabRecordCell *cell, GrabRecord *object) {
            
        }];
    }
    
    [self.viewDataSource addSubitem:section];
    
    [self.tableView reloadData];
    
}

@end
