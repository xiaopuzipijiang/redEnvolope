//
//  DMEmptyView.h
//  Dealmoon
//
//  Created by Kai on 5/6/15.
//  Copyright (c) 2015 Dealmoon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DMEmptyView : UIView

@property (nonatomic, readonly, strong) UIImageView *imageView;
@property (nonatomic, readonly, strong) UILabel *textLabel;
@property (nonatomic, readonly, strong) UIButton *signInButton;  // create on demand

- (instancetype)initWithText:(NSString *)text;

- (CGFloat)heightWithWidth:(CGFloat)width;

@end
