//
//  OMBaseDetailHeaderView.h
//  ClientManager
//
//  Created by iOS－MacBook on 2017/5/18.
//  Copyright © 2017年 Lispeng. All rights reserved.
//------------------订单详情的基类tableHeaderView---------------

#import <UIKit/UIKit.h>
@class OMOrderModel;
@class OMDetailModel;
@interface OMBaseDetailHeaderView : UIView
/**
 订单模型
 */
@property (nonatomic,strong) OMDetailModel *model;

/**
 提交人标签
 */
@property (nonatomic,weak) UILabel *commitSignLabel;
/**
 提交人
 */
@property (nonatomic,weak) UILabel *commitLabel;
/**
 客户名称标签
 */
@property (nonatomic,weak) UILabel *clientSignLabel;
/**
 客户名称
 */
@property (nonatomic,weak) UILabel *clientLabel;
/**
 收货人标签
 */
@property (nonatomic,weak) UILabel *receiverSignLabel;
/**
 收货人
 */
@property (nonatomic,weak) UILabel *receiverLabel;
/**
 收货人电话标签
 */
@property (nonatomic,weak) UILabel *receiverSignNumLabel;
/**
 收货人电话
 */
@property (nonatomic,weak) UILabel *receiverNumLabel;
/**
 总高度
 */
@property (nonatomic,assign) CGFloat headerHeight;

@end
