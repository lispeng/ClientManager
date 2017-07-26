//
//  OMOrderModel.h
//  ClientManager
//
//  Created by iOS－MacBook on 2017/5/12.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OMOrderModel : NSObject
//---------------------
/**
 提交人
 */
@property (nonatomic,copy) NSString *commiter;
/**
 客户名称
 */
@property (nonatomic,copy) NSString *client;
/**
 收货人
 */
@property (nonatomic,copy) NSString *receiver;
/**
 收货人电话
 */
@property (nonatomic,copy) NSString *receiverNum;


//=================================
/**
 商品名称
 */
@property (nonatomic,copy) NSString *commodityName;
/**
 商品规格
 */
@property (nonatomic,copy) NSString *specs;
/**
 商品价格
 */
@property (nonatomic,copy) NSString *price;

/**
 品牌
 */
@property (nonatomic,copy) NSString *brand;
/**
 商品类别
 */
@property (nonatomic,copy) NSString *category;
/**
 商品产地
 */
@property (nonatomic,copy) NSString *productArea;
/**
 商品库存
 */
@property (nonatomic,copy) NSString *stock;
/**
 备注
 */
@property (nonatomic,copy) NSString *remarks;
/**
 成交价
 */
@property (nonatomic,copy) NSString *currentRate;
/**
 购买数量具体单位数量
 */
@property (nonatomic,copy) NSString * concreteUnitNum;
/**
 购买数量的辅助单位数量
 */
@property (nonatomic,copy) NSString *auxiliaryUnitNum;



@end
