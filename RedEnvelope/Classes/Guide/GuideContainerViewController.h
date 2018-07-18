//
//  GuideContainerViewController.h
//  RedEnvelope
//
//  Created by 袁江 on 2018/7/13.
//  Copyright © 2018年 Envelope. All rights reserved.
//

#import "DMViewController.h"

@protocol GuideContainerSubViewProtocol <NSObject>

@property (nonatomic, assign) NSInteger pageIndex;

@end


@interface GuideContainerViewController : DMViewController

@end
