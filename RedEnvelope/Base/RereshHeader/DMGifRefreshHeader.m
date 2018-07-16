//
//  MJChiBaoZiHeader.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/6/12.
//  Copyright © 2015年 小码哥. All rights reserved.
//

#import "DMGifRefreshHeader.h"
#import "UIImage+GIF.h"

@implementation DMGifRefreshHeader
#pragma mark - 重写方法
#pragma mark 基本设置
- (void)prepare
{
    [super prepare];
    
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=13; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"pull_load_offset_%zd", i]];
        [idleImages addObject:image];
    }
     [self setImages:idleImages forState:MJRefreshStateIdle];
    
//    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=12; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"pull_load_loading_%zd", i]];
        [refreshingImages addObject:image];
    }

    [self setImages:refreshingImages forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
    
    self.gifView.tintColor = DMSkinColorKeyAppTintColor;
    
    self.lastUpdatedTimeLabel.hidden = YES;
    self.stateLabel.hidden = YES;
}

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState
    // 根据状态做事情
    if (state == MJRefreshStateRefreshing) {
        
    }else if (state == MJRefreshStatePulling){
        
        if (@available(iOS 10.0, *)) {
            UIImpactFeedbackGenerator *impactLight = [[UIImpactFeedbackGenerator alloc]initWithStyle:UIImpactFeedbackStyleLight];
            [impactLight impactOccurred];
        }
        
        [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.gifView.transform = CGAffineTransformScale(self.gifView.transform, 1.2, 1.2);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.gifView.transform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI_4);
            } completion:^(BOOL finished) {
                
            }];
        }];
        
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.gifView.transform = CGAffineTransformRotate(self.gifView.transform, M_PI_4);
        }completion:^(BOOL finished) {
            
        }];
    }
    else if (state == MJRefreshStateIdle && oldState != MJRefreshStateRefreshing) {
        [self.gifView stopAnimating];
    }
    else if (state == MJRefreshStateIdle && oldState == MJRefreshStateRefreshing)
    {
        [self.gifView startAnimating];
        [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.gifView.transform = CGAffineTransformRotate(self.gifView.transform, M_PI_2 * 1.1);
            self.gifView.transform = CGAffineTransformScale(self.gifView.transform, 0.1, 0.1);
        }completion:^(BOOL finished) {
            self.gifView.transform = CGAffineTransformIdentity;
            [self.gifView stopAnimating];
        }];
    }
}

@end
