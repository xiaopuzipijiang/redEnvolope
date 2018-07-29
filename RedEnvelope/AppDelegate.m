//
//  AppDelegate.m
//  RedEnvelope
//
//  Created by 袁江 on 2018/7/11.
//  Copyright © 2018年 Envelope. All rights reserved.
//

#import "AppDelegate.h"
#import "GuideContainerViewController.h"
#import "DMTabBarViewController.h"
#import "WechatManager.h"
#import "ShareActionSheetViewController.h"
#import "WechatManager.h"
#import "InvitationInfo.h"
#import "ShareView.h"
#import "SaveImageViewController.h"

@interface AppDelegate () 

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [WXApi registerApp:@"wx18bf772064f24985"];
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setMinimumDismissTimeInterval:2];
    
    if ([UserAccount currentUserAccount])
    {
        [self showMainViewContorller];
    }
    else
    {
        [self showGuide];
    }
    
    return YES;
}

- (void)showGuide
{
    GuideContainerViewController *vc = [[GuideContainerViewController alloc] init];
    
    self.window.rootViewController = vc;
    
    [self.window makeKeyAndVisible];
}

- (void)showMainViewContorller
{
    DMTabBarViewController *vc = [[DMTabBarViewController alloc] init];
    
    self.window.rootViewController = vc;
    
    [self.window makeKeyAndVisible];
}

- (void)shareActionWithCode:(InvitationInfo *)invitationInfo
{
    ShareView *shareView = [[ShareView alloc] initWithFrame:CGRectMake(0, 0, 250, 400)];
    shareView.invitationInfo = invitationInfo;
    
    

    
    [ShareActionSheetViewController showShareActionSheetWithCompletionHandler:^(NSInteger type) {

        [SVProgressHUD show];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            
            UIImage *shareImage = [shareView makeImage];
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
                switch (type) {
                    case 0:
                        [[WechatManager sharedManager] shareToSessionWithImage:shareImage];
                        break;
                    case 1:
                        [[WechatManager sharedManager] shareToTimelineWithImage:shareImage];
                        break;
                    case 2:
                        [SaveImageViewController showSaveImageViewControllerWithImage:shareImage];
                        break;
                    default:
                        break;
                }
            });
        });
    }];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [[WechatManager sharedManager] handleURL:url];
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
    return [[WechatManager sharedManager] handleURL:url];
}


@end
