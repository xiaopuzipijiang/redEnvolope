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
#import "PrenticeRewardCell.h"
#import "ServiceManager.h"
#import "UserInfo.h"
#import "REPrenticeResultSet.h"

typedef NS_ENUM(NSInteger, RewardViewListType)
{
    RewardViewListTypeReward,
    RewardViewListTypePrentice,
    RewardViewListTypePrenticePrentice
};


@interface RewardViewController ()

@property (nonatomic, strong) RewardHeadToolBar *toolBar;
@property (nonatomic, assign) RewardViewListType listType;

@property (nonatomic, strong) DMResultSet *rewardResultSet;
@property (nonatomic, strong) REPrenticeResultSet *prenticeResultSet;
@property (nonatomic, strong) REPrenticeResultSet *discipleResultSet;

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
    
    self.rewardResultSet = [[DMResultSet alloc] init];
    self.prenticeResultSet = [[REPrenticeResultSet alloc] init];
    self.discipleResultSet = [[REPrenticeResultSet alloc] init];
    
    [self setUpRefreshControls];
    
    [self showReward:nil];
}

- (NSArray<Class> *)classesForRegiste
{
    return @[[PrenticeRewardCell class], [PrenticeCell class]];
}

- (void)showReward:(UIButton *)sender
{
    self.listType = RewardViewListTypeReward;
    self.toolBar.buttonI.selected = YES;
    self.toolBar.buttonII.selected = NO;
    self.toolBar.buttonIII.selected = NO;
    
    if (self.rewardResultSet.countOfItems == 0)
    {
        [self.tableView.mj_header beginRefreshing];
    }
    else
    {
        [self reloadDataSource];
    }
}

- (void)showPrentice:(UIButton *)sender
{
    self.listType = RewardViewListTypePrentice;
    self.toolBar.buttonI.selected = NO;
    self.toolBar.buttonII.selected = YES;
    self.toolBar.buttonIII.selected = NO;
    
    if (self.prenticeResultSet.countOfItems == 0)
    {
        [self.tableView.mj_header beginRefreshing];
    }
    else
    {
        [self reloadDataSource];
    }
}

- (void)showPrenticePrentice:(UIButton *)sender
{
    self.listType = RewardViewListTypePrenticePrentice;
    self.toolBar.buttonI.selected = NO;
    self.toolBar.buttonII.selected = NO;
    self.toolBar.buttonIII.selected = YES;
    
    if (self.discipleResultSet.countOfItems == 0)
    {
        [self.tableView.mj_header beginRefreshing];
    }
    else
    {
        [self reloadDataSource];
    }
}

- (void)setUpRefreshControls
{
    DMWEAKSELFDEFIND
    
    self.tableView.mj_header = [RERefreshHeader headerWithRefreshingBlock:^{
        switch (wSelf.listType)
        {
            case RewardViewListTypeReward:
            {
                [wSelf.rewardResultSet removeAllItems];
                wSelf.rewardResultSet.currentPage = 1;
                [[ServiceManager sharedManager] requestApprenticeRewardListWithResultSet:wSelf.rewardResultSet completionHandler:^(BOOL success, NSString *errorMessage) {
                    wSelf.tableView.mj_footer.hidden = !wSelf.rewardResultSet.hasMore;
                    [wSelf.tableView.mj_header endRefreshing];
                    [wSelf reloadDataSource];
                }];
                break;
            }
            case RewardViewListTypePrentice:
            {
                [wSelf.prenticeResultSet removeAllItems];
                [[ServiceManager sharedManager] requestPrenticeListWithResultSet:wSelf.prenticeResultSet completionHandler:^(BOOL success, id object, NSString *errorMessage) {
                    wSelf.tableView.mj_footer.hidden = !wSelf.prenticeResultSet.hasMore;
                    [wSelf.tableView.mj_header endRefreshing];
                    [wSelf reloadDataSource];
                }];
                break;
            }
            case RewardViewListTypePrenticePrentice:
            {
                [wSelf.discipleResultSet removeAllItems];
                [[ServiceManager sharedManager] requestDiscipleListWithResultSet:wSelf.discipleResultSet completionHandler:^(BOOL success, id object, NSString *errorMessage) {
                    wSelf.tableView.mj_footer.hidden = !wSelf.prenticeResultSet.hasMore;
                    [wSelf.tableView.mj_header endRefreshing];
                    [wSelf reloadDataSource];
                }];
                break;
            }
            default:
                break;
        }
    }];
    
    self.tableView.mj_footer = [RERefreshFooter footerWithRefreshingBlock:^{
        switch (self.listType)
        {
            case RewardViewListTypeReward:
            {
                
                break;
            }
            case RewardViewListTypePrentice:
            {
                [[ServiceManager sharedManager] requestPrenticeListWithResultSet:self.prenticeResultSet completionHandler:^(BOOL success, id object, NSString *errorMessage) {
                    wSelf.tableView.mj_footer.hidden = !wSelf.prenticeResultSet.hasMore;
                    [wSelf.tableView.mj_footer endRefreshing];
                    [wSelf reloadDataSource];
                }];
                break;
            }
            case RewardViewListTypePrenticePrentice:
            {
                [self.prenticeResultSet removeAllItems];
                [[ServiceManager sharedManager] requestDiscipleListWithResultSet:self.discipleResultSet completionHandler:^(BOOL success, id object, NSString *errorMessage) {
                    wSelf.tableView.mj_footer.hidden = !wSelf.prenticeResultSet.hasMore;
                    [wSelf.tableView.mj_footer endRefreshing];
                    [wSelf reloadDataSource];
                }];
                break;
            }
            default:
                break;
        }
    }];
}

- (void)reloadDataSource
{
    [self.viewDataSource removeAllSubitems];
    
    DMDataSourceItem *section = [[DMDataSourceItem alloc] init];
    
    if (self.listType == RewardViewListTypeReward)
    {
        for (GrabRecord *recordInfo in self.rewardResultSet.items)
        {
            [section addSubitemWithClass:[PrenticeRewardCell class] object:recordInfo configCellBlock:^(PrenticeRewardCell *cell, GrabRecord *object) {
                cell.record = object;
            }];
        }
    }
    else if (self.listType == RewardViewListTypePrentice)
    {
        for (UserInfo *userInfo in self.prenticeResultSet.items)
        {
            [section addSubitemWithClass:[PrenticeCell class] object:userInfo configCellBlock:^(PrenticeCell *cell, UserInfo *object) {
                [cell.avatar sd_setImageWithURL:[NSURL URLWithString:object.headimgurl]];
                cell.nameLabel.text = object.nickname;
            }];
        }
    }
    else if (self.listType == RewardViewListTypePrenticePrentice)
    {
        for (UserInfo *userInfo in self.discipleResultSet.items)
        {
            [section addSubitemWithClass:[PrenticeCell class] object:userInfo configCellBlock:^(PrenticeCell *cell, UserInfo *object) {
                [cell.avatar sd_setImageWithURL:[NSURL URLWithString:object.headimgurl]];
                cell.nameLabel.text = object.nickname;
            }];
        }
    }
    
    [self.viewDataSource addSubitem:section];
    
    [self.tableView reloadData];
}

@end
