//
//  DMNavigationViewController.m
//  TicketChecking
//
//  Created by 袁江 on 2018/1/10.
//  Copyright © 2018年 Dealmoon. All rights reserved.
//

#import "DMNavigationViewController.h"

@interface DMNavigationViewController ()

@end

@implementation DMNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationBar setShadowImage:[UIImage imageWithColor:RGBCOLOR(220, 220, 220) size:CGSizeMake(10, 0.5)]];
    // Do any additional setup after loading the view.    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
