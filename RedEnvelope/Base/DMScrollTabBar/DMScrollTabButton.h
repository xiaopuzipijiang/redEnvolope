//
//  DMScrollTabButton.h
//  Dealmoon
//
//  Created by Kai on 9/6/12.
//  Copyright (c) 2012 Dealmoon. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const DMScrollBadgeDotBadgeValue;

@interface DMScrollTabButton : UIButton

@property (nonatomic, assign) UIEdgeInsets edgeInsets;
@property (nonatomic, assign) UIEdgeInsets touchInsets;

@property (nonatomic, copy) NSString *badgeValue;

@end
