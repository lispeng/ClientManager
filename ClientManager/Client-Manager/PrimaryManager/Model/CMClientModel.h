//
//  CMClientModel.h
//  ClientManager
//
//  Created by iOS－MacBook on 2017/7/17.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMClientModel : NSObject
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
/**
 退回天数
 */
@property (nonatomic,copy) NSString *returnDays;
/**
 几次拜访
 */
@property (nonatomic,copy) NSString *visitCount;
/**
 几天未拜访
 */
@property (nonatomic,copy) NSString *noVisitDays;

@end
