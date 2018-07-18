//
//  RewardViewController.m
//  RedEnvelope
//
//  Created by 袁江 on 2018/7/17.
//  Copyright © 2018年 Envelope. All rights reserved.
//

#import "RewardViewController.h"
#import "RewardHeadToolBar.h"
#import "PrenticeCell.h"
#import "GrabRecordCell.h"

typedef NS_ENUM(NSInteger, RewardViewListType)
{
    RewardViewListTypeReward,
    RewardViewListTypePrentice,
    RewardViewListTypePrenticePrentice
};


@interface RewardViewController ()

@property (nonatomic, strong) RewardHeadToolBar *toolBar;

@property (nonatomic, assign) RewardViewListType listType;

@end

@implementation RewardViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"收徒奖励";
    
    self.toolBar = [[RewardHeadToolBar alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 64)];
    
    [self.toolBar.buttonI setTitle:@"收徒奖励\n0.84038票票" forState:UIControlStateNormal];
    self.toolBar.buttonI.selected = YES;
    [self.toolBar.buttonI addTarget:self action:@selector(showReward:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.toolBar.buttonII setTitle:@"我的徒弟\n2人" forState:UIControlStateNormal];
    [self.toolBar.buttonII addTarget:self action:@selector(showPrentice:) forControlEvents:UIControlEventTouchUpInside];

    [self.toolBar.buttonIII setTitle:@"我的徒孙\n3人" forState:UIControlStateNormal];
    [self.toolBar.buttonIII addTarget:self action:@selector(showPrenticePrentice:) forControlEvents:UIControlEventTouchUpInside];


    self.tableView.tableHeaderView = self.toolBar;
}

- (NSArray<Class> *)classesForRegiste
{
    return @[[GrabRecordCell class], [PrenticeCell class]];
}

- (void)showReward:(UIButton *)sender
{
    self.listType = RewardViewListTypeReward;
    self.toolBar.buttonI.selected = YES;
    self.toolBar.buttonII.selected = NO;
    self.toolBar.buttonIII.selected = NO;
    
    [self reloadDataSource];
}

- (void)showPrentice:(UIButton *)sender
{
    self.listType = RewardViewListTypePrentice;
    self.toolBar.buttonI.selected = NO;
    self.toolBar.buttonII.selected = YES;
    self.toolBar.buttonIII.selected = NO;
    [self reloadDataSource];
}

- (void)showPrenticePrentice:(UIButton *)sender
{
    self.listType = RewardViewListTypePrenticePrentice;
    self.toolBar.buttonI.selected = NO;
    self.toolBar.buttonII.selected = NO;
    self.toolBar.buttonIII.selected = YES;
    [self reloadDataSource];
}

- (void)reloadDataSource
{
    [self.viewDataSource removeAllSubitems];
    
    DMWEAKSELFDEFIND
    DMDataSourceItem *section = [[DMDataSourceItem alloc] init];
    
    for (int i = 0; i < 10; i ++)
    {
        if (self.listType == RewardViewListTypeReward)
        {
            [section addSubitemWithClass:[GrabRecordCell class] object:nil configCellBlock:^(id cell, id object) {
                
            }];
        }
        else
        {
            [section addSubitemWithClass:[PrenticeCell class] object:nil configCellBlock:^(id cell, id object) {
                
            }];
        }
    }
    
    [self.viewDataSource addSubitem:section];
    
    [self.tableView reloadData];
}

@end
