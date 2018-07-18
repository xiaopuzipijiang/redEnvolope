//
//  GuideItemViewController.h
//  RedEnvelope
//
//  Created by 袁江 on 2018/7/13.
//  Copyright © 2018年 Envelope. All rights reserved.
//

#import "DMViewController.h"
#import "GuideContainerViewController.h"

@interface GuideItemViewController : DMViewController <GuideContainerSubViewProtocol>

@property (nonatomic, strong, readonly) UIImageView *bgView;

@property (nonatomic, assign) NSInteger pageIndex;

@end
