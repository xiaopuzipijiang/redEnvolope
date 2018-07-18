//
//  GrabRecordViewController.m
//  RedEnvelope
//
//  Created by 袁江 on 2018/7/17.
//  Copyright © 2018年 Envelope. All rights reserved.
//

#import "GrabRecordViewController.h"
#import "GrabRecordCell.h"


@interface GrabRecordViewController ()

@end

@implementation GrabRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    self.title = @"收到的红包";
    
    [self reloadDataSource];
    // Do any additional setup after loading the view.
}

- (NSArray<Class> *)classesForRegiste
{
    return @[[GrabRecordCell class]];
}

- (void)reloadDataSource
{
    [self.viewDataSource removeAllSubitems];
    
    DMDataSourceItem *section = [[DMDataSourceItem alloc] init];
    
    for (int i = 0; i < 10; i++)
    {
        [section addSubitemWithClass:[GrabRecordCell class] object:nil configCellBlock:^(id cell, id object) {
            
        }];
    }
    
    [self.viewDataSource addSubitem:section];
    
    [self.tableView reloadData];
    
}

@end
