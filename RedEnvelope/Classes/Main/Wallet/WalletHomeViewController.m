//
//  WalletHomeViewController.m
//  RedEnvelope
//
//  Created by 袁江 on 2018/7/14.
//  Copyright © 2018年 Envelope. All rights reserved.
//

#import "WalletHomeViewController.h"
#import "WalletHeaderCell.h"
#import "WalletCountingCell.h"
#import "WalletIncomingChartCell.h"
#import "WalletRuleCell.h"
#import "WithdrawCashViewController.h"
#import "ServiceManager.h"
#import "WalletInfo.h"

@interface WalletHomeViewController ()

@property (nonatomic, strong) UIImageView *bottomImageView;

@property (nonatomic, strong) WalletInfo *walletInfo;

@end

@implementation WalletHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.extendedLayoutIncludesOpaqueBars = YES;
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    [self.tableView performSelector:@selector(setTableHeaderBackgroundColor:) withObject:HEXCOLOR(0xfafafa) withObject:nil];
#pragma clang diagnostic pop

    self.tableView.backgroundColor = [UIColor whiteColor];
    
    self.bottomImageView = [[UIImageView alloc] init];
    self.bottomImageView.image = [UIImage imageNamed:@"底部彩条"];
    [self.view addSubview:self.bottomImageView];

    if (@available(iOS 11.0, *)){
        self.tableView.estimatedRowHeight = 0;
//        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedSectionHeaderHeight = 0;
        self.tableView.estimatedSectionFooterHeight = 0;
    }
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 20, 0);
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self loadData];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    if (@available(iOS 11.0, *)) {
        self.bottomImageView.frame = CGRectMake(0, self.view.height - self.view.safeAreaInsets.bottom - 20, self.view.width, 20);
    } else {
        self.bottomImageView.frame = CGRectMake(0, self.view.height - 44 - 20, self.view.width, 20);
    }
}

- (NSArray<Class> *)classesForRegiste
{
    return @[[WalletHeaderCell class], [WalletCountingCell class], [WalletIncomingChartCell class], [WalletRuleCell class]];
}

- (void)loadData
{
    DMWEAKSELFDEFIND
    [[ServiceManager sharedManager] requestWalletInfoWithCompletionHandler:^(BOOL success, id object, NSString *errorMessage) {
        if (success)
        {
            wSelf.walletInfo = object;
            [wSelf reloadDataSource];
        }
    }];
}

- (void)reloadDataSource
{
    [self.viewDataSource removeAllSubitems];
    
    DMDataSourceItem *section = [[DMDataSourceItem alloc] init];
    
    DMWEAKSELFDEFIND
    
    [section addSubitemWithClass:[WalletHeaderCell class] object:nil configCellBlock:^(WalletHeaderCell *cell, id object) {
        [cell setBalance:self.walletInfo.balance.balance];
        [cell.withdrawCashButton removeAllTargets];
        [cell.withdrawCashButton addTarget:wSelf action:@selector(withdrawCashButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }];
    
    [section addSubitemWithClass:[WalletCountingCell class] object:nil configCellBlock:^(WalletCountingCell *cell, id object) {
        cell.balanceInfo = wSelf.walletInfo.balance;
    }];

    [section addSubitemWithClass:[WalletIncomingChartCell class] object:nil configCellBlock:^(WalletIncomingChartCell *cell, id object) {

        cell.trendInfo = self.walletInfo.trendInfo;

    }];

    [section addSubitemWithClass:[WalletRuleCell class] object:nil configCellBlock:^(id cell, id object) {

    }];

    
    [self.viewDataSource addSubitem:section];
    
    [self.tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
    {
        case 0:
            return 190;
        case 1:
            return 80;
        case 2:
            return 300;
        case 3:
            return self.tableView.width * 828.0 / 750.0 + 40;
        default:
            break;
    }
    return 0;
}

- (void)withdrawCashButtonPressed:(id)sender
{
    WithdrawCashViewController *vc = [[WithdrawCashViewController alloc] initWithNibName:@"WithdrawCashViewController" bundle:nil];
    vc.balanceInfo = self.walletInfo.balance;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (DMNavigationBarStyle)navigationBarStyle
{
    return DMNavigationBarStyleHidden;
}

@end
