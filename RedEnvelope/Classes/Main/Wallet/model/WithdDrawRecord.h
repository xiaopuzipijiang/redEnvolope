//
//  WithdDrawRecord.h
//  RedEnvelope
//
//  Created by 袁江 on 2018/7/31.
//  Copyright © 2018年 Envelope. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WithdDrawRecord : NSObject

@property (nonatomic, assign) NSInteger bonus;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, assign) NSInteger recordId;
@property (nonatomic, assign) NSInteger money;

@property (nonatomic, strong) NSString *statusStr;
@property (nonatomic, strong) NSString *moneyStr;

@end
