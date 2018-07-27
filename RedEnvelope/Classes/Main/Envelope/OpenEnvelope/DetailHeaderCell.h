//
//  DetailHeaderCell.h
//  RedEnvelope
//
//  Created by 袁江 on 2018/7/16.
//  Copyright © 2018年 Envelope. All rights reserved.
//

#import "DMTableViewCell.h"

@interface DetailHeaderCell : DMTableViewCell

@property (nonatomic, strong, readonly) UILabel *nameLabel;
@property (nonatomic, strong, readonly) UILabel *amountLabel;
@property (nonatomic, strong, readonly) UILabel *descLabel;

@property (nonatomic, strong, readonly) UIButton *ticketButton;

@end
