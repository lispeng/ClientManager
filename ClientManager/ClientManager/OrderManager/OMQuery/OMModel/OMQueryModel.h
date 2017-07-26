//
//  OMQueryModel.h
//  ClientManager
//
//  Created by iOS－MacBook on 2017/5/22.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OMQueryModel : NSObject
/**
 客户名称
 */
@property (nonatomic,copy) NSString *client;
/**
 开始日期
 */
@property (nonatomic,copy) NSString *startDate;
/**
 结束日期
 */
@property (nonatomic,copy) NSString *endDate;

@end
