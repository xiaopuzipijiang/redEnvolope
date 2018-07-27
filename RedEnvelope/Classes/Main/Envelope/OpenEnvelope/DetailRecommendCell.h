//
//  DetailRecommendCell.h
//  RedEnvelope
//
//  Created by 袁江 on 2018/7/16.
//  Copyright © 2018年 Envelope. All rights reserved.
//

#import "DMTableViewCell.h"

@class DetailRecommendCell;

@protocol DetailRecommendCellDelegate <NSObject>

- (void)updateCellHeight:(DetailRecommendCell *)cell height:(CGFloat)height;

- (void)detailRecommendCell:(DetailRecommendCell *)cell navigate:(NSString *)url;

@end

@interface DetailRecommendCell : DMTableViewCell

@property (nonatomic, weak) id <DetailRecommendCellDelegate> delegate;

@end
