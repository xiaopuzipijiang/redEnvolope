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
#import "MiPushSDK.h"
#import "ServiceManager.h"
#import "HomeInfo.h"
#import "WebViewController.h"

@interface AppDelegate () <MiPushSDKDelegate, UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setMinimumDismissTimeInterval:2];
    
    [WXApi registerApp:@"wx18bf772064f24985"];
    
    [MiPushSDK registerMiPush:self];

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
    DMNavigationViewController *nvc = [[DMNavigationViewController alloc] initWithRootViewController:vc];
    self.window.rootViewController = nvc;
    
    [self.window makeKeyAndVisible];
}

- (void)showMainViewContorller
{
    DMTabBarViewController *vc = [[DMTabBarViewController alloc] init];
    
    self.window.rootViewController = vc;
    
    [self.window makeKeyAndVisible];
}

- (void)shareActionWithCode:(HomeInfo *)homeInfo
{
    NSURLComponents *components = [[NSURLComponents alloc] initWithURL:[NSURL URLWithString:homeInfo.morePack] resolvingAgainstBaseURL:NO];
    
    if ([components.scheme isEqualToString:@"hongbao"])
    {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = 'type'"];
        NSURLQueryItem *type = (NSURLQueryItem *)[[components.queryItems filteredArrayUsingPredicate:predicate] firstObject];
        
        if ([type.value isEqualToString:@"webview"])
        {
            predicate = [NSPredicate predicateWithFormat:@"name = 'url'"];
            NSURLQueryItem *url = (NSURLQueryItem *)[[components.queryItems filteredArrayUsingPredicate:predicate] firstObject];
            WebViewController *vc = [[WebViewController alloc] initWithUrl:url.value];
            vc.hidesBottomBarWhenPushed = YES;
            DMNavigationViewController *nvc = [(DMTabBarViewController *)self.window.rootViewController selectedViewController];
            if ([nvc isKindOfClass:[DMNavigationViewController class]])
            {
                [nvc pushViewController:vc animated:YES];
            }
        }
        else if ([type.value isEqualToString:@"share"])
        {
            [self shareImageToWChat:homeInfo];
        }
    }
}

- (void)shareImageToWChat:(HomeInfo *)homeInfo
{
    ShareView *shareView = [[ShareView alloc] initWithFrame:CGRectMake(0, 0, 250, 400)];
    shareView.invitationInfo = homeInfo.invitationInfo;
    
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

#pragma mark 注册push服务.
- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [MiPushSDK bindDeviceToken:deviceToken];
    
    if (![UserAccount currentUserAccount]) return;
    
    [[ServiceManager sharedManager] uploadToken:deviceToken completionHandler:^(BOOL success, NSString *errorMessage) {
        
    }];
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err
{

}

- (void)miPushRequestErrWithSelector:(NSString *)selector error:(int)error data:(NSDictionary *)data
{
    
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
