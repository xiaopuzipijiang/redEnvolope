//
//  WithdrawCashViewController.m
//  RedEnvelope
//
//  Created by 袁江 on 2018/7/16.
//  Copyright © 2018年 Envelope. All rights reserved.
//

#import "WithdrawCashViewController.h"
#import "WithdrawRecordViewController.h"

@interface WithdrawCashViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation WithdrawCashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"提现";
    
    self.scrollView.contentSize = CGSizeMake(self.view.width, self.view.height);
    
    self.scrollView.alwaysBounceVertical = YES;
    self.scrollView.alwaysBounceHorizontal = NO;

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提现记录" style:UIBarButtonItemStylePlain target:self action:@selector(withdrawRecord:)];
}

- (void)withdrawRecord:(id)sender
{
    WithdrawRecordViewController *vc = [[WithdrawRecordViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)withdrawInfoButtonPressed:(id)sender {
    
    PSTAlertController *alter = [PSTAlertController alertWithTitle:@"提现须知" message:@"\n提现资金包含数值不低于1元，可提现至微信。"];
    [alter addAction:[PSTAlertAction actionWithTitle:@"知道了" style:PSTAlertActionStyleDestructive handler:nil]];
    
    [alter showWithSender:self controller:self animated:YES completion:nil];
    
}

@end
