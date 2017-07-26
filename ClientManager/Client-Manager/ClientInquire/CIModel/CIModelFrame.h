//
//  CIModelFrame.h
//  ClientManager
//**********客户查询的数据模型Frame*******************
//  Created by iOS－MacBook on 2017/7/20.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CIModel;
@interface CIModelFrame : NSObject

/**
 客户名称
 */
@property (nonatomic,assign) CGRect custNameLabelFrame;
/**
 客户负责人
 */
@property (nonatomic,assign) CGRect managerDescriptionLabelFrame;

/**
 坐标转换的客户地址
 */
@property (nonatomic,assign) CGRect addressLabelFrame;
/**
 <#annotation#>
 */
@property (nonatomic,assign) CGRect underLineFrame;


/**
 <#annotation#>
 */
@property (nonatomic,strong) CIModel *model;

@end
