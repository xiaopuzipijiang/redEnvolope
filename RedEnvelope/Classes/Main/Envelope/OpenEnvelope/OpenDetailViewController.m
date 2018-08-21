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
#import "WebViewController.h"

@interface OpenDetailViewController () <DetailRecommendCellDelegate>

@property (nonatomic, strong) UINavigationBar *customerBar;

@property (nonatomic, assign) CGFloat heightForWebView;

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger countDown;

@end

@implementation OpenDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.heightForWebView = 0;
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    [self.tableView performSelector:@selector(setTableHeaderBackgroundColor:) withObject:HEXCOLOR(0xd65a44) withObject:nil];
#pragma clang diagnostic pop
//    CGFloat offset;
//    if (@available(iOS 11.0, *)) {
//        offset = self.view.safeAreaInsets.top;
//    } else {
//        offset =
//    }
    
    self.customerBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, [UIApplication sharedApplication].statusBarFrame.size.height, self.view.width, 44)];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, -[UIApplication sharedApplication].statusBarFrame.size.height, self.view.width, 20)];
    view.backgroundColor = HEXCOLOR(0xd65a44);
    [self.customerBar addSubview:view];
    
    [self.customerBar setShadowImage:[UIImage imageWithColor:[UIColor clearColor]]];
    self.customerBar.backgroundColor = HEXCOLOR(0xd65a44);
    self.customerBar.translucent = YES;

    [self.customerBar setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18.0f], NSForegroundColorAttributeName : HEXCOLOR(0xfde6ce)}];

    self.customerBar.tintColor = [UIColor whiteColor];
    [self.customerBar setBackgroundImage:[UIImage imageWithColor:HEXCOLOR(0xd65a44) size:CGSizeMake(self.view.width, 64)] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    
    UINavigationItem *item = [[UINavigationItem alloc] init];
    item.title = @"红包信息";
    
    self.customerBar.items = @[item];
    [self.view addSubview:self.customerBar];

    self.countDown = 5;
    [self updateBackButton:self.countDown canBack:NO];
    DMWEAKSELFDEFIND
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 block:^(NSTimer * _Nonnull timer) {
        wSelf.countDown -= 1;
        BOOL is = NO;
        if (wSelf.countDown <= 0)
        {
            is = YES;
            [wSelf.timer invalidate];
            self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        }
        [wSelf updateBackButton:wSelf.countDown canBack:is];
        
    } repeats:YES];
    
    [self reloadDataSource];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.firstAppearance)
    {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)updateBackButton:(NSInteger)countdown canBack:(BOOL)canBack
{
    if (canBack)
    {
    self.customerBar.topItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStyleDone target:self action:@selector(backBarButtonPressed:)];
    }
    else
    {
        self.customerBar.topItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:[NSString stringWithFormat:@"%zi", countdown] style:(UIBarButtonItemStyle)UIBarButtonItemStylePlain target:nil action:nil];
    }
}

- (NSArray<Class> *)classesForRegiste
{
    return @[[DetailHeaderCell class], [DetailCountingCell class], [RecommendHeaderCell class], [DetailRecommendCell class]];
}

- (void)reloadDataSource
{
    [self.viewDataSource removeAllSubitems];
    
    DMWEAKSELFDEFIND
    
    DMDataSourceItem *section = [[DMDataSourceItem alloc] init];
    
    [section addSubitemWithClass:[DetailHeaderCell class] object:nil configCellBlock:^(DetailHeaderCell *cell, id object) {
        cell.nameLabel.text = [wSelf.info stringForKey:@"nickname"];
        cell.amountLabel.text = [NSString stringWithFormat:@"%@元", [wSelf.info stringForKey:@"value"]];
        [cell.ticketButton setTitle:[NSString stringWithFormat:@"+%@票票", [wSelf.info stringForKey:@"amount"]] forState:UIControlStateNormal];
    }];
    
    [section addSubitemWithClass:[DetailCountingCell class] object:nil configCellBlock:^(id cell, id object) {
        
    }];

    [section addSubitemWithClass:[RecommendHeaderCell class] object:nil configCellBlock:^(id cell, id object) {
        
    }];
    
    [section addSubitemWithClass:[DetailRecommendCell class] object:nil configCellBlock:^(DetailRecommendCell *cell, id object) {
        cell.delegate = wSelf;
    }];
    
    [self.viewDataSource addSubitem:section];
    
    [self.tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 3)
    {
        return self.heightForWebView;
    }
    
    return UITableViewAutomaticDimension;
}

- (DMNavigationBarStyle)navigationBarStyle
{
    return DMNavigationBarStyleHidden;
}

- (void)updateCellHeight:(DetailRecommendCell *)cell height:(CGFloat)height
{
    self.heightForWebView = MAX(100, height);
    
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
}

- (void)detailRecommendCell:(DetailRecommendCell *)cell navigate:(NSString *)url
{
    WebViewController *vc = [[WebViewController alloc] initWithUrl:url];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
