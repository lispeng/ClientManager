//
//  CMClientModelFrame.h
//  ClientManager
//
//  Created by iOS－MacBook on 2017/7/17.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CMClientModel;

@interface CMClientModelFrame : NSObject
/**
 客户名称
 */
@property (nonatomic,assign) CGRect clientNameLabelFrame;
/**
 客户负责人
 */
@property (nonatomic,assign) CGRect managerDescriptionLabelFrame;

/**
 坐标转换的客户地址
 */
@property (nonatomic,assign) CGRect coordinateAddressLabelFrame;
/**
 退回天数
 */
@property (nonatomic,assign) CGRect returnDaysLabelFrame;
///**
// 几次拜访
// */
//@property (nonatomic,assign) UILabel *visitCountLabel;
///**
// 几次未拜访
// */
//@property (nonatomic,weak) UILabel *noVisitDaysLabel;
/**
 拜访次数与未拜访天数
 */
@property (nonatomic,assign) CGRect countOrDaysLabelFrame;
/**
 <#annotation#>
 */
@property (nonatomic,assign) CGRect underLineFrame;

/**
 客户模型
 */
@property (nonatomic,strong) CMClientModel *model;


@end
