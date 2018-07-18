//
//  WithdrawRecordViewController.m
//  RedEnvelope
//
//  Created by 袁江 on 2018/7/17.
//  Copyright © 2018年 Envelope. All rights reserved.
//

#import "WithdrawRecordViewController.h"
#import "WithdDrawRecordCell.h"

@interface WithdrawRecordViewController ()

@end

@implementation WithdrawRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    self.title = @"提现记录";
    
    [self reloadDataSource];
}

- (NSArray<Class> *)classesForRegiste
{
    return @[[WithdDrawRecordCell class]];
}

- (void)reloadDataSource
{
    [self.viewDataSource removeAllSubitems];
    
    DMDataSourceItem *section = [[DMDataSourceItem alloc] init];
    
    for (int i = 0; i < 10; i++)
    {
        [section addSubitemWithClass:[WithdDrawRecordCell class] object:nil configCellBlock:^(id cell, id object) {
            
        }];
    }
    
    [self.viewDataSource addSubitem:section];
    
    [self.tableView reloadData];
    
}


@end
