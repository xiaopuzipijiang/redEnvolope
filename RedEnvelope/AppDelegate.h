//
//  AppDelegate.h
//  RedEnvelope
//
//  Created by 袁江 on 2018/7/11.
//  Copyright © 2018年 Envelope. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kAPPDelegate  (AppDelegate *)([UIApplication sharedApplication].delegate)

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (void)showMainViewContorller;

- (void)showGuide;

- (void)shareActionWithCode:(NSString *)code;

@end

