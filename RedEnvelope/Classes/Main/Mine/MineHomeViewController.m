//
//  MineHomeViewController.m
//  RedEnvelope
//
//  Created by 袁江 on 2018/7/14.
//  Copyright © 2018年 Envelope. All rights reserved.
//

#import "MineHomeViewController.h"
#import "MineHomeGeneralCell.h"
#import "MineHomeProfileCell.h"
#import "GrabRecordViewController.h"
#import "RewardViewController.h"
#import "ServiceManager.h"
#import "UserInfo.h"

@interface MineHomeViewController ()

@property (nonatomic, strong) UIImageView *bottomImageView;

@property (nonatomic, strong) UserInfo *userInfo;

@end

@implementation MineHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.clearsSelectionOnViewWillAppear = YES;
    self.tableView.backgroundColor = HEXCOLOR(0xf2f2f2);
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    [self.tableView performSelector:@selector(setTableHeaderBackgroundColor:) withObject:HEXCOLOR(0xfc5b5b) withObject:nil];
#pragma clang diagnostic pop

//    if (@available(iOS 11.0, *)) {
//        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//    } else {
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
    
    self.bottomImageView = [[UIImageView alloc] init];
    self.bottomImageView.image = [UIImage imageNamed:@"底部彩条"];
    [self.view addSubview:self.bottomImageView];
    
    [self reloadDataSource];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self loadUserInfo];
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

- (void)loadUserInfo
{
    [[ServiceManager sharedManager] requestUserInfoWithCompletionHandler:^(BOOL success, UserInfo *object, NSString *errorMessage) {
        if (success)
        {
            self.userInfo = object;
            
            [self reloadDataSource];
        }
    }];
}

- (NSArray<Class> *)classesForRegiste
{
    return @[[MineHomeGeneralCell class], [MineHomeProfileCell class]];
}

- (void)reloadDataSource
{
    [self.viewDataSource removeAllSubitems];
    
    DMWEAKSELFDEFIND
    
    DMDataSourceItem *section1 = [[DMDataSourceItem alloc] init];
    
    [section1 addSubitemWithClass:[MineHomeProfileCell class] object:nil configCellBlock:^(MineHomeProfileCell *cell, id object) {
        cell.backgroundColor = HEXCOLOR(0xfc5c5c);
        [cell.avatar sd_setImageWithURL:[NSURL URLWithString:wSelf.userInfo.headimgurl]];
        cell.nameLabel.text = wSelf.userInfo.nickname;
    } didSelectedBlock:^(MineHomeProfileCell *cell, id object) {
        
    }];
    
    DMDataSourceItem *section2 = [[DMDataSourceItem alloc] init];

    [section2 addSubitemWithClass:[MineHomeGeneralCell class] object:nil configCellBlock:^(MineHomeGeneralCell *cell, id object) {
        cell.textLabel.text = @"收到的红包";
        cell.imageView.image = [UIImage imageNamed:@"我的-收到的红包"];
    } didSelectedBlock:^(MineHomeGeneralCell *cell, id object) {
        GrabRecordViewController *vc = [[GrabRecordViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [wSelf.navigationController pushViewController:vc animated:YES];
    }];
    
    [section2 addSubitemWithClass:[MineHomeGeneralCell class] object:nil configCellBlock:^(MineHomeGeneralCell *cell, id object) {
        cell.textLabel.text = @"收徒奖励";
        cell.imageView.image = [UIImage imageNamed:@"收徒奖励"];
    } didSelectedBlock:^(MineHomeGeneralCell *cell, id object) {
        RewardViewController *vc = [[RewardViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [wSelf.navigationController pushViewController:vc animated:YES];
    }];

    DMDataSourceItem *section3 = [[DMDataSourceItem alloc] init];
    
    [section3 addSubitemWithClass:[MineHomeGeneralCell class] object:nil configCellBlock:^(MineHomeGeneralCell *cell, id object) {
        cell.textLabel.text = @"联系客服";
        cell.imageView.image = [UIImage imageNamed:@"联系客服"];
    } didSelectedBlock:^(MineHomeGeneralCell *cell, id object) {
        
    }];
    
    [section3 addSubitemWithClass:[MineHomeGeneralCell class] object:nil configCellBlock:^(MineHomeGeneralCell *cell, id object) {
        cell.textLabel.text = @"问题反馈";
        cell.imageView.image = [UIImage imageNamed:@"问题反馈"];
    } didSelectedBlock:^(MineHomeGeneralCell *cell, id object) {
        
    }];

    [section3 addSubitemWithClass:[MineHomeGeneralCell class] object:nil configCellBlock:^(MineHomeGeneralCell *cell, id object) {
        cell.textLabel.text = @"关于天天刷红包";
        cell.imageView.image = [UIImage imageNamed:@"关于"];
    } didSelectedBlock:^(MineHomeGeneralCell *cell, id object) {
        
    }];
    
    [self.viewDataSource addSubitem:section1];
    [self.viewDataSource addSubitem:section2];
    [self.viewDataSource addSubitem:section3];

    [self.tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 2)
    {
        return 10;
    }
    
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc] init];
}

- (DMNavigationBarStyle)navigationBarStyle
{
    return DMNavigationBarStyleHidden;
}

@end
