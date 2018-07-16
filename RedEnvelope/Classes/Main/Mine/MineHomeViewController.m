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

@interface MineHomeViewController ()

@end

@implementation MineHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = RGBCOLOR(240, 239, 238);
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self reloadDataSource];
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
        cell.backgroundColor = UICOLOR_RANDOM;
    } didSelectedBlock:^(MineHomeProfileCell *cell, id object) {
        
    }];
    
    DMDataSourceItem *section2 = [[DMDataSourceItem alloc] init];

    [section2 addSubitemWithClass:[MineHomeGeneralCell class] object:nil configCellBlock:^(MineHomeGeneralCell *cell, id object) {
        cell.textLabel.text = @"收到的红包";
        cell.imageView.image = [UIImage imageNamed:@"我的-收到的红包"];
    } didSelectedBlock:^(MineHomeGeneralCell *cell, id object) {
        
    }];
    
    [section2 addSubitemWithClass:[MineHomeGeneralCell class] object:nil configCellBlock:^(MineHomeGeneralCell *cell, id object) {
        cell.textLabel.text = @"收徒奖励";
        cell.imageView.image = [UIImage imageNamed:@"收徒奖励"];
    } didSelectedBlock:^(MineHomeGeneralCell *cell, id object) {
        
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
