//
//  OMAddModelFrame.h
//  ClientManager
//
//  Created by iOS－MacBook on 2017/5/11.
//  Copyright © 2017年 Lispeng. All rights reserved.
//------------------增加商品的数据Frame---------------

#import <Foundation/Foundation.h>
@class OMAddModel;
@interface OMAddModelFrame : NSObject
/**
 <#annotation#>
 */
@property (nonatomic,strong) OMAddModel *model;

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
 商品单位
 */
@property (nonatomic,assign) CGRect unitSignLabelFrame;

/**
 商品具体单位
 */
@property (nonatomic,assign) CGRect unitLabelFrame;

/**
 商品数量更改容器
 */
//@property (nonatomic,assign) CGRect commodityNumChangeContentViewFrame;
/**
 底部的分割线
 */
@property (nonatomic,assign) CGRect addOrderUnderLineFrame;


@end
