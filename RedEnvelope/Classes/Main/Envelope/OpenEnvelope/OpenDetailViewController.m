//
//  OpenDetailViewController.m
//  RedEnvelope
//
//  Created by 袁江 on 2018/7/15.
//  Copyright © 2018年 Envelope. All rights reserved.
//

#import "OpenDetailViewController.h"
#import "DetailHeaderCell.h"
#import "DetailCountingCell.h"
#import "DetailRecommendCell.h"
#import "RecommendHeaderCell.h"

@interface OpenDetailViewController ()

@property (nonatomic, strong) UINavigationBar *customerBar;

@end

@implementation OpenDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    if (@available(iOS 11.0, *)) {
//        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//    } else {
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    [self.tableView performSelector:@selector(setTableHeaderBackgroundColor:) withObject:HEXCOLOR(0xd65a44) withObject:nil];
#pragma clang diagnostic pop
    
    self.customerBar = [[UINavigationBar alloc] init];
    [self.customerBar setShadowImage:[UIImage imageWithColor:[UIColor clearColor]]];
    self.customerBar.clipsToBounds = YES;
    
    [self.customerBar setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18.0f], NSForegroundColorAttributeName : HEXCOLOR(0xfde6ce)}];
    [self.view addSubview:self.customerBar];

    UINavigationItem *item = [[UINavigationItem alloc] init];
    item.title = @"红包信息";
    self.customerBar.items = @[item];
    
    item.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStyleDone target:self action:@selector(backBarButtonPressed:)];
    self.customerBar.tintColor = [UIColor whiteColor];
    [self.customerBar setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]] forBarMetrics:UIBarMetricsDefault];
    
    [self reloadDataSource];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.customerBar.frame = CGRectMake(0, [UIApplication sharedApplication].statusBarFrame.size.height, self.view.width, 100);
}

- (NSArray<Class> *)classesForRegiste
{
    return @[[DetailHeaderCell class], [DetailCountingCell class], [RecommendHeaderCell class], [DetailRecommendCell class]];
}

- (void)reloadDataSource
{
    [self.viewDataSource removeAllSubitems];
    
    DMDataSourceItem *section = [[DMDataSourceItem alloc] init];
    
    [section addSubitemWithClass:[DetailHeaderCell class] object:nil configCellBlock:^(id cell, id object) {
        
    }];
    
    [section addSubitemWithClass:[DetailCountingCell class] object:nil configCellBlock:^(id cell, id object) {
        
    }];

    [section addSubitemWithClass:[RecommendHeaderCell class] object:nil configCellBlock:^(id cell, id object) {
        
    }];
    
    [section addSubitemWithClass:[DetailRecommendCell class] object:nil configCellBlock:^(id cell, id object) {
        
    } didSelectedBlock:^(id cell, id object) {
        
    }];
    
    [self.viewDataSource addSubitem:section];
    
    [self.tableView reloadData];
}

- (DMNavigationBarStyle)navigationBarStyle
{
    return DMNavigationBarStyleHidden;
}

@end
