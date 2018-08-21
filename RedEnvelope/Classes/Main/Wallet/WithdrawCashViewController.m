//
//  WithdrawCashViewController.m
//  RedEnvelope
//
//  Created by 袁江 on 2018/7/16.
//  Copyright © 2018年 Envelope. All rights reserved.
//

#import "WithdrawCashViewController.h"
#import "WithdrawRecordViewController.h"

@interface WithdrawCashViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *amountTextField;
@property (weak, nonatomic) IBOutlet UILabel *balanceLabel;
@property (weak, nonatomic) IBOutlet UIButton *commitButton;
@property (weak, nonatomic) IBOutlet UILabel *noticeLabel;
@property (weak, nonatomic) IBOutlet UILabel *piaopiaoAmountLabel;
@property (weak, nonatomic) IBOutlet UIButton *weixinButton;

@end

@implementation WithdrawCashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"提现";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提现记录" style:UIBarButtonItemStylePlain target:self action:@selector(withdrawRecord:)];
    self.navigationItem.rightBarButtonItem.tintColor = HEXCOLOR(0x333333);
    
    self.scrollView.contentSize = CGSizeMake(self.view.width, self.view.height);
    
    self.scrollView.alwaysBounceVertical = YES;
    self.scrollView.alwaysBounceHorizontal = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        
    self.balanceLabel.text = [NSString stringWithFormat:@"可转出金额%@元", self.balanceInfo.balance];
    
    [self.amountTextField addTarget:self action:@selector(amountTextFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    self.amountTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.amountTextField.tintColor = [UIColor blackColor];
    self.amountTextField.adjustsFontSizeToFitWidth = NO;
    self.amountTextField.keyboardType = UIKeyboardTypeDecimalPad;
    self.amountTextField.delegate = self;
    
    [self.commitButton setBackgroundImage:[UIImage imageWithColor:HEXCOLOR(0xe26f4f) size:CGSizeMake(10, 10)] forState:UIControlStateNormal];
    [self.commitButton setBackgroundImage:[UIImage imageWithColor:HEXCOLOR(0xdddddd) size:CGSizeMake(10, 10)] forState:UIControlStateDisabled];
    self.commitButton.clipsToBounds = YES;
    self.commitButton.layer.cornerRadius = 22.5;

    self.commitButton.enabled = NO;
    
    [self.amountTextField becomeFirstResponder];
}

- (void)withdrawRecord:(id)sender
{
    WithdrawRecordViewController *vc = [[WithdrawRecordViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)amountTextFieldChanged:(id)sender
{
    [self updatePiaoPiaoText:self.amountTextField.text];
}

- (void)updatePiaoPiaoText:(NSString *)amountString
{
    NSString *countString = [amountString trimWhitespaceAndNewline];
    NSDecimalNumber *decimalNumber = [[NSDecimalNumber alloc] initWithString:countString];
    
    float piaopiaoAmount = (!isnan(decimalNumber.floatValue) ? decimalNumber.floatValue : 0) / self.balanceInfo.price.floatValue;
    self.piaopiaoAmountLabel.text = [NSString stringWithFormat:@"=%f股", piaopiaoAmount];
    
    if (decimalNumber.floatValue < 1.0 || isnan(decimalNumber.floatValue))
    {
        self.noticeLabel.hidden = NO;
        self.noticeLabel.text = @"提示金额小于1元时不可提现";
        self.commitButton.enabled = NO;
    }
    
    else if(decimalNumber.floatValue > self.balanceInfo.balance.floatValue)
    {
        self.noticeLabel.hidden = NO;
        self.noticeLabel.text = @"输入金额超过余额";
        self.commitButton.enabled = NO;
    }
    else
    {
        self.noticeLabel.hidden = YES;
        self.commitButton.enabled = YES;
    }
}

- (IBAction)allButtonPressed:(id)sender {
    NSDecimalNumber *decimalNumber = [[NSDecimalNumber alloc] initWithString:self.balanceInfo.balance];
    NSDecimalNumberHandler *roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown
                                                                                                      scale:2
                                                                                           raiseOnExactness:NO
                                                                                            raiseOnOverflow:NO
                                                                                           raiseOnUnderflow:NO
                                                                                        raiseOnDivideByZero:NO];
    
    NSDecimalNumber *resultDN = [decimalNumber decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    
    self.amountTextField.text = [NSString stringWithFormat:@"%@", resultDN];
    [self updatePiaoPiaoText:self.amountTextField.text];
}

- (IBAction)commitButtonPressed:(id)sender {
    
    NSString *countString = [self.amountTextField.text trimWhitespaceAndNewline];
    
    if (![countString isPureFloat])
    {
        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"请输入正确金额", nil)];
        return;
    }
    
    [self.amountTextField resignFirstResponder];
    
    NSDecimalNumber *decimalNumber = [[NSDecimalNumber alloc] initWithString:countString];
    NSInteger amount = [decimalNumber decimalNumberByMultiplyingByPowerOf10:2].integerValue;

    [SVProgressHUD show];
    [[ServiceManager sharedManager] requestWithdrawWithCount:amount completionHandler:^(BOOL success, NSString *errorMessage) {
        if (success)
        {
            [SVProgressHUD dismiss];
            DMWEAKSELFDEFIND
            NSString *alertString = [NSString stringWithFormat:@"您已成功提现%@元到微信，预计24小时以内到账，请耐心等待", countString];
            PSTAlertController *alert = [PSTAlertController alertWithTitle:@"提现成功" message:alertString];
            [alert addAction:[PSTAlertAction actionWithTitle:@"确定" handler:^(PSTAlertAction * _Nonnull action) {
                [wSelf.navigationController popViewControllerAnimated:YES];
            }]];
            
            [alert showWithSender:self controller:self animated:YES completion:nil];
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:errorMessage];
        }
    }];
    
}

- (IBAction)withdrawInfoButtonPressed:(id)sender {
    
    PSTAlertController *alter = [PSTAlertController alertWithTitle:@"提现须知" message:@"\n提现资金包含数值不低于1元，可提现至微信。"];
    [alter addAction:[PSTAlertAction actionWithTitle:@"知道了" style:PSTAlertActionStyleDestructive handler:nil]];
    
    [alter showWithSender:self controller:self animated:YES completion:nil];
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *amoumtString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (amoumtString.length == 0)
    {
        return YES;
    }
    
    if (![amoumtString isPureFloat])
    {
        return NO;
    }
    
    NSArray *strings = [amoumtString componentsSeparatedByString:@"."];
    if (strings.count == 2)
    {
        NSString *string = strings.lastObject;
        if (string.length > 2)
        {
            return NO;
        }
    }
    
    return YES;
}

@end
