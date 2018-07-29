//
//  WithdrawRecordViewController.m
//  RedEnvelope
//
//  Created by 袁江 on 2018/7/17.
//  Copyright © 2018年 Envelope. All rights reserved.
//

#import "WithdrawRecordViewController.h"
#import "WithdDrawRecordCell.h"
#import "GrabRecord.h"

@interface WithdrawRecordViewController ()

@property (nonatomic, strong) DMResultSet *resultSet;

@end

@implementation WithdrawRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    self.title = @"提现记录";
    
    self.resultSet = [[DMResultSet alloc] init];
    [self setUpRefreshControl];
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
    return @[[WithdDrawRecordCell class]];
}

- (void)setUpRefreshControl
{
    DMWEAKSELFDEFIND
    self.tableView.mj_header = [RERefreshHeader headerWithRefreshingBlock:^{
        [wSelf.resultSet removeAllItems];
        wSelf.resultSet.currentPage = 1;
        [[ServiceManager sharedManager] requestWithdrawRecordListWithResult:wSelf.resultSet completionHandler:^(BOOL success, NSString *errorMessage) {
            [wSelf.tableView.mj_header endRefreshing];
            wSelf.tableView.mj_footer.hidden = !wSelf.resultSet.hasMore;
            
            [wSelf reloadDataSource];
        }];
    }];
    
    self.tableView.mj_footer = [RERefreshFooter footerWithRefreshingBlock:^{
        wSelf.resultSet.currentPage += 1;
        [[ServiceManager sharedManager] requestWithdrawRecordListWithResult:wSelf.resultSet completionHandler:^(BOOL success, NSString *errorMessage) {
            [wSelf.tableView.mj_footer endRefreshing];
            wSelf.tableView.mj_footer.hidden = !wSelf.resultSet.hasMore;
            
            [wSelf reloadDataSource];
        }];

    }];
    
    self.tableView.mj_footer.hidden = YES;
}

- (void)reloadDataSource
{
    [self.viewDataSource removeAllSubitems];
    
    DMDataSourceItem *section = [[DMDataSourceItem alloc] init];
    
    for (GrabRecord *record in self.resultSet.items)
    {
        [section addSubitemWithClass:[WithdDrawRecordCell class] object:record configCellBlock:^(WithdDrawRecordCell *cell, GrabRecord *object) {
            cell.record = record;
        }];
    }
    
    [self.viewDataSource addSubitem:section];
    
    [self.tableView reloadData];
    
}


@end
