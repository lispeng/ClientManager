//
//  OMOrderBaseScrollView.h
//  ClientManager
//
//  Created by iOS－MacBook on 2017/5/15.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#define OMOrderInfoFont [UIFont systemFontOfSize:15]
#define OMOrderPriceFont [UIFont boldSystemFontOfSize:17]
#define OMOrderMargin 10
#define OMContentMargin 10
#define OMOrderTopFormHeight 71//顶部的表单高度
#define OMOrderBottomFormHeight 55//底部的表单高度
@class OMOrderEditTextField;

@interface OMOrderBaseScrollView : UIScrollView
/**
 顶部的容器View
 */
@property (nonatomic,weak) UIView *topContentView;
/**
 中间的容器View
 */
@property (nonatomic,weak) UIView *middleContentView;
/**
 底部的容器View
 */
@property (nonatomic,weak) UIView *bottomContentView;

/**
 商品名称
 */
@property (nonatomic,weak) UILabel *commodityNameLabel;
/**
 商品规格
 */
@property (nonatomic,weak) UILabel *specsLabel;
/**
 商品价格标签
 */
@property (nonatomic,weak) UILabel *priceSignLabel;
/**
 商品价格
 */
@property (nonatomic,weak) UILabel *priceLabel;

/**
 品牌标签
 */
@property (nonatomic,weak) UILabel *brandSignLabel;

/**
 品牌
 */
@property (nonatomic,weak) UILabel *brandLabel;
/**
 商品类别标签
 */
@property (nonatomic,weak) UILabel *categorySignLabel;

/**
 商品类别
 */
@property (nonatomic,weak) UILabel *categoryLabel;
/**
 商品产地标签
 */
@property (nonatomic,weak) UILabel *productAreaSignLabel;

/**
 商品产地
 */
@property (nonatomic,weak) UILabel *productAreaLabel;
/**
 商品库存标签
 */
@property (nonatomic,weak) UILabel *stockSignLabel;

/**
 商品库存
 */
@property (nonatomic,weak) UILabel *stockLabel;
/**
 备注标签
 */
@property (nonatomic,weak) UILabel *remarksSignLabel;

/**
 备注
 */
@property (nonatomic,weak) UILabel *remarksLabel;
/**
 成交价标签
 */
@property (nonatomic,weak) UILabel *currentRateLabel;
/**
 成交价
 */
@property (nonatomic,weak) OMOrderEditTextField *currentRateField;
/**
 购买数量标签
 */
@property (nonatomic,weak) UILabel * purchaseSignLabel;

/**
 购买数量具体单位数量
 */
@property (nonatomic,weak) OMOrderEditTextField * concreteUnitNumField;
/**
 购买数量具体单位数量单位标签
 */
@property (nonatomic,weak) UILabel * concreteUnitNumSignLabel;

/**
 购买数量的辅助单位数量
 */
@property (nonatomic,weak) OMOrderEditTextField *auxiliaryUnitNumField;
/**
 购买数量的辅助单位数量单位标签
 */
@property (nonatomic,weak) UILabel *auxiliaryUnitNumSignLabel;

@end
