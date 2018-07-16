//
//  DMModalPresentationViewController.h
//  Dealmoon
//
//  Created by 袁江 on 17/6/9.
//  Copyright © 2017年 Dealmoon. All rights reserved.
//

#import "DMViewController.h"

@interface DMModalPresentationViewController : UIViewController

+ (void)presentModeViewController:(UIViewController *)viewController from:(UIViewController *)fromViewController withContentRect:(CGRect)contentRect;

+ (void)dismiss;

@end
