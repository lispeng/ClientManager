//
//  CIModel.h
//  ClientManager
//**********客户查询的数据模型*******************
//  Created by iOS－MacBook on 2017/7/20.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CIModel : NSObject
/**
 客户id
 */
@property (nonatomic,copy) NSString *_id;
/**
 custNum
 */
@property (nonatomic,copy) NSString *custNum;
/**
 客户名称
 */
@property (nonatomic,copy) NSString *custName;
/**
 客户地址--手动输入
 */
@property (nonatomic,copy) NSString *address;
/**
 坐标转换的地址
 */
@property (nonatomic,copy) NSString *coordinateAddress;
/**
 客户负责人，以逗号分割
 */
@property (nonatomic,copy) NSString *managerDescription;

@end
