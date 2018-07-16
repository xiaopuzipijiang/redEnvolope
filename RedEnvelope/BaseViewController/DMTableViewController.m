//
//  DMTableViewController.m
//  Dealmoon
//
//  Created by Kai on 9/2/12.
//  Copyright (c) 2012 Dealmoon. All rights reserved.
//

#import "DMTableViewController.h"
#import "DMTableViewCell.h"

@interface DMTableViewController ()

@end

@implementation DMTableViewController

#pragma mark - Initialization

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    if (self = [super initWithNibName:nil bundle:nil])
    {
		self.tableViewStyle = style;
        self.clearsSelectionOnViewWillAppear = YES;
    }
	
    return self;
}

#pragma mark - View Life Cycle

- (void)loadView
{
	[super loadView];
    
	self.tableView = [[DMTableView alloc] initWithFrame:self.view.bounds style:self.tableViewStyle];
    self.tableView.backgroundColor = DMMainBackgroundColor;
	self.tableView.delegate = self;
	self.tableView.dataSource = self;
	self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//    self.tableView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
//    self.tableView.estimatedSectionHeaderHeight = 0;
//    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedRowHeight = 44;

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;

	[self.view addSubview:self.tableView];
    
    [self registeCellClasses];
}

- (NSArray<Class> *)classesForRegiste
{
    return nil;
}

- (void)reloadDataSource
{
    [self.tableView reloadData];
}

- (DMDataSourceItem *)viewDataSource
{
    if (!_viewDataSource)
    {
        _viewDataSource = [[DMDataSourceItem alloc] init];
    }
    
    return _viewDataSource;
}

- (void)registeCellClasses
{
    NSArray *array = [self classesForRegiste];
    
    for (Class cellClass in array)
    {
        [self.tableView registerClass:cellClass forCellReuseIdentifier:[cellClass defaultCellIdentifier]];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.firstAppearance)
    {

    }
    
    if (self.clearsSelectionOnViewWillAppear)
    {
		[self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:animated];
    }
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

#pragma mark - Scroll Insets

- (void)setAutomaticallyAdjustsScrollViewInsets:(BOOL)automaticallyAdjustsScrollViewInsets
{
    [super setAutomaticallyAdjustsScrollViewInsets:automaticallyAdjustsScrollViewInsets];
}

#pragma mark - UITableView Data Source Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.viewDataSource.subitemCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewDataSource[section].subitemCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DMDataSourceItem *item = self.viewDataSource[indexPath.section][indexPath.row];

    if (item.configCellBlock)
    {
        DMTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:[item.cellClass defaultCellIdentifier] forIndexPath:indexPath];
        item.configCellBlock(cell, item.object);
        
        return cell;
    }

    if ([self respondsToSelector:@selector(configCell:withCellClass:object:)])
    {
        DMTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:[item.cellClass defaultCellIdentifier] forIndexPath:indexPath];
        
        [self configCell:cell withCellClass:item.cellClass object:item.object];
        
        return cell;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DMDataSourceItem *item = self.viewDataSource[indexPath.section][indexPath.row];
    if (item.didSelectedCellBlock)
    {
        DMTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        item.didSelectedCellBlock(cell, item.object);
    }
}

#pragma mark - Navigation Bar

- (void)showNavigationBar
{
    self.navigationController.navigationBar.alpha = 1;
}

- (BOOL)isNavigationBarVisible
{
    if (self.navigationController.navigationBar.alpha == 1 && !self.navigationController.navigationBar.isHidden)
    {
        return YES;
    }
    
    return NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{

}


#pragma mark - Memory Management

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
}

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView
{
    return NO;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    return -100;
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = NSLocalizedString(@"暂无数据", nil);
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0f],
                                 NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                 NSParagraphStyleAttributeName: paragraph};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}


@end
