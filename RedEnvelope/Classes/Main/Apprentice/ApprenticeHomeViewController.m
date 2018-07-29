//
//  ApprenticeHomeViewController.m
//  RedEnvelope
//
//  Created by 袁江 on 2018/7/14.
//  Copyright © 2018年 Envelope. All rights reserved.
//

#import "ApprenticeHomeViewController.h"
#import "RewardViewController.h"
#import "ServiceManager.h"
#import "HomeInfo.h"
#import "WebViewController.h"

@interface ApprenticeHomeViewController ()

@property (nonatomic, strong) UIImageView *bottomImageView;

@property (strong, nonatomic) UIScrollView *scrollView;

@property (nonatomic, strong) UIImageView *apprenticeExplainBg;
@property (nonatomic, strong) UILabel *apprenticeExplainTitle;
@property (nonatomic, strong) UILabel *apprenticeExplainAward;
@property (nonatomic, strong) YYLabel *apprenticeInvitationCode;

@property (nonatomic, strong) UIButton *apprenticeButton;
@property (nonatomic, strong) UIButton *apprenticeAwardButton;

@property (nonatomic, strong) HomeInfo *homeInfo;

@end

@implementation ApprenticeHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"师徒";

    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"如何收徒" forState:UIControlStateNormal];
    button.contentEdgeInsets = UIEdgeInsetsMake(3, 10, 3, 10);
    button.tintColor = [UIColor orangeColor];
    [button sizeToFit];
    button.layer.borderColor = [UIColor orangeColor].CGColor;
    button.layer.borderWidth = 1;
    button.layer.cornerRadius = button.height / 2;
    [button addTarget:self action:@selector(rightBarButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.alwaysBounceVertical = YES;
    self.scrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.scrollView];
    
    [self setUpApprenticeExplainView];
    
    [self.scrollView addSubview:self.apprenticeAwardButton];
    [self.scrollView addSubview:self.apprenticeButton];
    self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 25, 0);
    
    self.bottomImageView = [[UIImageView alloc] init];
    self.bottomImageView.image = [UIImage imageNamed:@"底部彩条"];
    [self.view addSubview:self.bottomImageView];
    
    [self updateInfo];
}

- (void)setUpApprenticeExplainView
{
    self.apprenticeExplainBg = [[UIImageView alloc] init];
    self.apprenticeExplainBg.userInteractionEnabled = YES;
    self.apprenticeExplainBg.image = [UIImage imageNamed:@"收徒说明"];
    [self.scrollView addSubview:self.apprenticeExplainBg];
    
    self.apprenticeExplainTitle = [[UILabel alloc] init];
    self.apprenticeExplainTitle.font = [UIFont systemFontOfSize:20];
    self.apprenticeExplainTitle.text = @"邀请好友称为徒弟\n永享奖励";
    self.apprenticeExplainTitle.textColor = [UIColor whiteColor];
    self.apprenticeExplainTitle.numberOfLines = 2;
    self.apprenticeExplainTitle.textAlignment = NSTextAlignmentCenter;
    [self.apprenticeExplainBg addSubview:self.apprenticeExplainTitle];

    self.apprenticeExplainAward = [[UILabel alloc] init];
    self.apprenticeExplainAward.font = [UIFont systemFontOfSize:16];
    self.apprenticeExplainAward.text = @"徒弟领红包，奖励师傅20%\n徒孙领红包，奖励师爷10%";
    self.apprenticeExplainAward.numberOfLines = 2;
    self.apprenticeExplainAward.textColor = [UIColor whiteColor];
    self.apprenticeExplainAward.textAlignment = NSTextAlignmentCenter;
    [self.apprenticeExplainBg addSubview:self.apprenticeExplainAward];

    self.apprenticeInvitationCode = [YYLabel new];
    self.apprenticeInvitationCode.font = [UIFont systemFontOfSize:14];
    self.apprenticeInvitationCode.textAlignment = NSTextAlignmentCenter;
  
    self.apprenticeInvitationCode.textAlignment = NSTextAlignmentCenter;
    [self.apprenticeExplainBg addSubview:self.apprenticeInvitationCode];

    [self.apprenticeExplainTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(110));
        make.centerX.equalTo(self.apprenticeExplainBg);
    }];
    
    [self.apprenticeExplainAward mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.apprenticeExplainTitle.mas_bottom).with.offset(30);
        make.centerX.equalTo(self.apprenticeExplainBg);
    }];

}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.scrollView.frame = self.view.bounds;
    
    self.apprenticeExplainBg.size = CGSizeMake(300, 320);
    self.apprenticeExplainBg.centerX = self.view.width / 2;
    self.apprenticeExplainBg.top = 50;
    
    self.apprenticeInvitationCode.size = CGSizeMake(self.apprenticeExplainBg.width, 20);
    self.apprenticeInvitationCode.centerX = self.apprenticeExplainBg.width / 2;
    self.apprenticeInvitationCode.bottom = self.apprenticeExplainBg.height - 30;
    

    [self.apprenticeAwardButton sizeToFit];
    self.apprenticeAwardButton.layer.cornerRadius = self.apprenticeAwardButton.height / 2;
    self.apprenticeAwardButton.integralCenterX = self.view.width / 2;

    if (@available(iOS 11.0, *)) {
        self.bottomImageView.frame = CGRectMake(0, self.view.height - self.view.safeAreaInsets.bottom - 20, self.view.width, 20);
        self.apprenticeAwardButton.bottom = self.view.height - self.view.safeAreaInsets.top - self.view.safeAreaInsets.bottom - self.bottomImageView.height - 20;

    } else {
        self.bottomImageView.frame = CGRectMake(0, self.view.height - 44 - 20, self.view.width, 20);
        self.apprenticeAwardButton.bottom = self.view.height - 64 - 44 - self.bottomImageView.height - 20;
    }
    
    self.apprenticeButton.size = CGSizeMake(self.view.width - 120, 60);
    self.apprenticeButton.integralCenterX = self.view.width / 2;
    self.apprenticeButton.bottom = self.apprenticeAwardButton.top - 20;

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self loadInfo];
}

- (void)loadInfo
{
    DMWEAKSELFDEFIND
    [[ServiceManager sharedManager]  requestHomerInfoWithCompletionHandler:^(BOOL success, HomeInfo *homeInfo, NSString *errorMessage) {
        wSelf.homeInfo = homeInfo;
        [wSelf updateInfo];
    }];
}

- (void)updateInfo
{
    NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:@"我的邀请码："];
    one.color = [UIColor whiteColor];
    one.font = [UIFont boldSystemFontOfSize:13];
    NSMutableAttributedString *tow = [[NSMutableAttributedString alloc] initWithString:self.homeInfo.invitationInfo.inviteCode ? : @""];
    tow.font = [UIFont boldSystemFontOfSize:13];
    tow.underlineStyle = NSUnderlineStyleSingle;
    DMWEAKSELFDEFIND
    [tow setTextHighlightRange:tow.rangeOfAll
                         color:[UIColor whiteColor]
               backgroundColor:[UIColor colorWithWhite:0.000 alpha:0.220]
                     tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
                         [wSelf showCopy];
                     }];
    [one appendAttributedString:tow];
    one.alignment = NSTextAlignmentCenter;
    self.apprenticeInvitationCode.attributedText = one;
    
    NSMutableAttributedString *mAString = [[NSMutableAttributedString alloc] initWithString:@"已获得收徒奖励" attributes:@{NSForegroundColorAttributeName : HEXCOLOR(0x666666), NSFontAttributeName : [UIFont systemFontOfSize:16.0f]}];
    [mAString appendAttributedString:[[NSAttributedString alloc] initWithString:self.homeInfo.balanceInfo.histricInvitedAmount ? : @"" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16.0f], NSForegroundColorAttributeName : HEXCOLOR(0xe90139)}]];
    [mAString appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@"票票  " attributes:@{NSForegroundColorAttributeName : HEXCOLOR(0x666666), NSFontAttributeName : [UIFont systemFontOfSize:16.0f]}]];
    
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    attachment.image = [UIImage imageNamed:@"提现-微信-选择方式箭头"];
    [mAString appendAttributedString:[NSAttributedString attributedStringWithAttachment:attachment]];
    
    [_apprenticeAwardButton setAttributedTitle:mAString forState:UIControlStateNormal];

    [self.view setNeedsLayout];
}

- (void)rightBarButtonPressed:(id)sender
{
    WebViewController *vc = [[WebViewController alloc] initWithUrl:kInviteHowUrl];
    vc.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (UIButton *)apprenticeButton
{
    if (!_apprenticeButton)
    {
        _apprenticeButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _apprenticeButton.titleLabel.font = [UIFont systemFontOfSize:24.0f];
        [_apprenticeButton setTitle:@"立即收徒" forState:UIControlStateNormal];
        [_apprenticeButton setTitleColor:HEXCOLOR(0xe90139) forState:UIControlStateNormal];
        _apprenticeButton.backgroundColor = HEXCOLOR(0xffce3d);
        _apprenticeButton.layer.cornerRadius = 5;
        [_apprenticeButton addTarget:self action:@selector(shared:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _apprenticeButton;
}

- (UIButton *)apprenticeAwardButton
{
    if (!_apprenticeAwardButton)
    {
        _apprenticeAwardButton = [[UIButton alloc] init];
        _apprenticeAwardButton.backgroundColor = [UIColor whiteColor];
        _apprenticeAwardButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        _apprenticeAwardButton.layer.borderColor = HEXCOLOR(0xaaaaaa).CGColor;
        _apprenticeAwardButton.layer.borderWidth = 1;
        _apprenticeAwardButton.contentEdgeInsets = UIEdgeInsetsMake(10, 20, 10, 20);
        [_apprenticeAwardButton addTarget:self action:@selector(rewardButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _apprenticeAwardButton;
}

#pragma mark - LongPressed copy

- (void)showCopy
{
        [self becomeFirstResponder];
        UIMenuController *menuController = [UIMenuController sharedMenuController];
        menuController.arrowDirection = UIPopoverArrowDirectionDown;
        [menuController setTargetRect:CGRectOffset(self.apprenticeInvitationCode.frame, 20, 0) inView:self.apprenticeExplainBg];
        [menuController setMenuVisible:YES animated:YES];
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(copy:))
    {
        return YES;
    }
    
    return NO;
}

- (void)copy:(id)sender
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.homeInfo.invitationInfo.inviteCode;
}

- (void)shared:(id)sender
{
    [kAPPDelegate shareActionWithCode:self.homeInfo.invitationInfo];
}

- (void)rewardButtonPressed:(id)sender
{
    RewardViewController *vc = [[RewardViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
