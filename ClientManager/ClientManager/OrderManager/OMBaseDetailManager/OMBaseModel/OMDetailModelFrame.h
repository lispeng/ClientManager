//
//  OMDetailModelFrame.h
//  ClientManager
//
//  Created by iOS－MacBook on 2017/5/18.
//  Copyright © 2017年 Lispeng. All rights reserved.
//-------------商品详情的cell布局模型-------------

#import <Foundation/Foundation.h>
@class OMDetailModel;
@interface OMDetailModelFrame : NSObject
/**
 <#annotation#>
 */
@property (nonatomic,strong) OMDetailModel *model;
/**
 商品的预览图片
 */
@property (nonatomic,assign) CGRect commodityImageViewFrame;
/**
 商品信息
 */
@property (nonatomic,assign) CGRect commodityInfoLabelFrame;
/**
 赠品
 */
@property (nonatomic,assign) CGRect commoditySignLabelFrame;
/**
 成交价
 */
@property (nonatomic,assign) CGRect dealPriceSignLabelFrame;
/**
 成交具体价格
 */
@property (nonatomic,assign) CGRect dealPriceLabelFrame;
/**
 购买数量标签
 */
@property (nonatomic,assign) CGRect buySignNumLabelFrame;
/**
 购买数量
 */
@property (nonatomic,assign) CGRect buyNumLabelFrame;
/**
 <#annotation#>
 */
@property (nonatomic,assign) CGRect addOrderUnderLineFrame;

@end
