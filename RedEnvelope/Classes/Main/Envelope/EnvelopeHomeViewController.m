//
//  EnvelopeHomeViewController.m
//  RedEnvelope
//
//  Created by 袁江 on 2018/7/14.
//  Copyright © 2018年 Envelope. All rights reserved.
//

#import "EnvelopeHomeViewController.h"
#import "EnvelopeCollectionViewCell.h"
#import "EnvelopeRefreshReusableView.h"
#import "OpenEnvelopeViewController.h"
#import "OpenDetailViewController.h"
#import "ServiceManager.h"
#import "HomeInfo.h"
#import "ShareActionSheetViewController.h"

#define kContentInsets UIEdgeInsetsMake(20, 40, 50, 40)
#define kMaxCount 9

@interface EnvelopeHomeViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UIImageView *bottomImageView;

@property (nonatomic, strong) HomeInfo *homeInfo;

@end

@implementation EnvelopeHomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.collectionView registerClass:[EnvelopeCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.collectionView registerClass:[EnvelopeRefreshReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 20, 0);
    
    [self.view addSubview:self.collectionView];
    
    self.bottomImageView = [[UIImageView alloc] init];
    self.bottomImageView.image = [UIImage imageNamed:@"底部彩条"];
    [self.view addSubview:self.bottomImageView];
    
    [self setUpRefreshControls];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self loadData];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.collectionView.frame = self.view.bounds;
    if (@available(iOS 11.0, *)) {
        self.bottomImageView.frame = CGRectMake(0, self.view.height - self.view.safeAreaInsets.bottom - 20, self.view.width, 20);
    } else {
        self.bottomImageView.frame = CGRectMake(0, self.view.height - 44 - 20, self.view.width, 20);
    }
}

- (void)updateTiele
{
    static UILabel *titleLabel;
    if (!titleLabel)
    {
        titleLabel = [[UILabel alloc] init];
        titleLabel.textColor = [UIColor blackColor];
        self.navigationItem.titleView = titleLabel;
    }
    
    NSMutableAttributedString *mAString = [[NSMutableAttributedString alloc] initWithString:@"¥" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12.0f]}];
    [mAString appendAttributedString:[[NSAttributedString alloc] initWithString:self.homeInfo.balanceInfo.balance ? : @"" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:28.0f]}]];
    
    titleLabel.attributedText = mAString;
    
    [titleLabel sizeToFit];
}

- (void)setUpRefreshControls
{
    DMWEAKSELFDEFIND
    self.collectionView.mj_header = [RERefreshHeader headerWithRefreshingBlock:^{
        [wSelf loadData];
    }];
}

- (void)loadData
{
    DMWEAKSELFDEFIND
    [[ServiceManager sharedManager] requestHomerInfoWithCompletionHandler:^(BOOL success, HomeInfo *object, NSString *errorMessage) {
        [self.collectionView.mj_header endRefreshing];
        wSelf.homeInfo = object;
        [wSelf.collectionView reloadData];
        [wSelf updateTiele];
    }];
}

#pragma mark - UICollectionViewDelegate / Datasource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.homeInfo ? 1 : 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return MIN(self.homeInfo.redEnvelopList.count + 1, kMaxCount);
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    EnvelopeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    if (self.homeInfo.redEnvelopList.count < kMaxCount && indexPath.row == (self.homeInfo.redEnvelopList.count))
    {
        cell.comingTime = self.homeInfo.nextTime;
    }
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionFooter])
    {
        EnvelopeRefreshReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];
        
        [footer.button removeAllTargets];
        [footer.button addTarget:self action:@selector(shareEvent:) forControlEvents:UIControlEventTouchUpInside];
        
        return footer;
    }
    
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGFloat space = 40.0;
    
    CGFloat width = ceil((self.view.width - space * 4) / 3);
    
    return CGSizeMake(width, ceil(width * 190 / 152));
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return kContentInsets;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 40;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 30;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(collectionView.width, 40);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.homeInfo.redEnvelopList.count < kMaxCount && indexPath.row == (self.homeInfo.redEnvelopList.count))
    {
        return;
    }

    DMWEAKSELFDEFIND
    
    RedEnvelope *redEnvelope = [self.homeInfo.redEnvelopList objectAtIndex:indexPath.row];
    
    OpenEnvelopeViewController *vc = [[OpenEnvelopeViewController alloc] initWithRedEnvelope:redEnvelope CompletionHandler:^(BOOL success, id object) {
        
        if (success)
        {
            [DMModalPresentationViewController dismiss];
            OpenDetailViewController *vc = [[OpenDetailViewController alloc] init];
            vc.info = object;
            vc.hidesBottomBarWhenPushed = YES;
            [wSelf.navigationController pushViewController:vc animated:NO];
        }
        else
        {
//            [self loadData];
        }
    }];
    
    CGFloat ofset = 60;
    CGRect rect = CGRectMake(0, 0, self.view.width - ofset, (self.view.width - ofset) * 827 / 645);
    rect.origin.x = ([UIScreen mainScreen].bounds.size.width - CGRectGetWidth(rect)) / 2;
    rect.origin.y = ([UIScreen mainScreen].bounds.size.height - CGRectGetHeight(rect)) / 2;
    
    [DMModalPresentationViewController presentModeViewController:vc from:self.tabBarController withContentRect:rect];
}

- (void)shareEvent:(id)sender
{
    [kAPPDelegate shareActionWithCode:self.homeInfo.invitationInfo];
}

#pragma mark - property

- (UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.alwaysBounceVertical = YES;
    }
    
    return _collectionView;
}

@end
