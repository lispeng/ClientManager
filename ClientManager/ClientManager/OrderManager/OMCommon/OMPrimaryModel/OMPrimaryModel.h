//
//  OMPrimaryModel.h
//  ClientManager
////////   已提交、待审批、已审批的公有数据模型
//  Created by iOS－MacBook on 2017/5/10.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OMPrimaryModel : NSObject
/**
 <#annotation#>
 */
@property (nonatomic,copy) NSString *orderType;

/**
 客户名称
 */
@property (nonatomic,copy) NSString *clientName;
/**
 订单金额
 */
@property (nonatomic,copy) NSString *orderMoney;
/**
 提交日期
 */
@property (nonatomic,copy) NSString *submitDate;
/**
 提交人
 */
@property (nonatomic,copy) NSString *submitPeople;
/**
 审批类型
 */
@property (nonatomic,copy) NSString *pendType;
/**
 <#annotation#>
 */
@property (nonatomic,copy) NSString *id;

@end
