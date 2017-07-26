//
//  OMDetailModel.h
//  ClientManager
//
//  Created by iOS－MacBook on 2017/5/11.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OMDetailModel : NSObject
/**
 订单审批的类型(0是未审批，1是已同意，2是已拒绝)
 */
@property (nonatomic,copy) NSString *orderType;

/**
 提交人
 */
@property (nonatomic,copy) NSString *commiter;

/**
 客户名
 */
@property (nonatomic,copy) NSString *clientName;
/**
 收货人
 */
@property (nonatomic,copy) NSString *receiver;
/**
 收货人电话
 */
@property (nonatomic,copy) NSString *receiverTelNum;
/**
 商品预览图
 */
@property (nonatomic,copy) NSString *commodityUrl;
/**
 商品信息
 */
@property (nonatomic,copy) NSString *commodityInfo;
/**
 商品价格
 */
@property (nonatomic,copy) NSString *commodityPrice;
/**
 商品单位
 */
@property (nonatomic,copy) NSString *commodityUnit;
/**
 成交价
 */
@property (nonatomic,copy) NSString *dealPrice;
/**
 购买数量
 */
@property (nonatomic,copy) NSString *buyNum;
/**
 合计金额
 */
@property (nonatomic,copy) NSString *totalMoney;
/**
 备注信息
 */
@property (nonatomic,copy) NSString *remarks;
/**
 出货仓库
 */
@property (nonatomic,copy) NSString *storehouse;
/**
 送货人
 */
@property (nonatomic,copy) NSString *delivery;
/**
 审核人
 */
@property (nonatomic,copy) NSString *verifier;
/**
 审核时间
 */
@property (nonatomic,copy) NSString *reviewTime;
/**
 审核意见
 */
@property (nonatomic,copy) NSString *reviewIdea;

@end
