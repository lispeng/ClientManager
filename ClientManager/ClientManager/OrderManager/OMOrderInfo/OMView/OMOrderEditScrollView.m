//
//  OMOrderEditScrollView.m
//  ClientManager
//--------------可编辑的商品订单详情-----------------
//  Created by iOS－MacBook on 2017/5/15.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import "OMOrderEditScrollView.h"
#import "OMOrderModel.h"
#import "NSString+Extension.h"
#import "OMOrderEditTextField.h"
#define EditTextFieldWidth 80
#define EditTextFieldHeight 35
@interface OMOrderEditScrollView()<UITextFieldDelegate>
/**
 <#annotation#>
 */
@property (nonatomic,weak) UIView *bottomLineOne;
/**
 <#annotation#>
 */
@property (nonatomic,weak) UIView *bottomLineTwo;


@end
@implementation OMOrderEditScrollView
- (instancetype)init
{
    if (self = [super init]) {
        [self setupOrderEditScrollViewSubviews];
    }
    return self;
}
- (void)setModel:(OMOrderModel *)model
{
    _model = model;
    CGFloat topViewX = 0;
    CGFloat topViewY = 0;
    CGFloat topViewWidth = SCREEN_WIDTH;
    CGFloat topViewHeight = OMOrderTopFormHeight;
    self.topContentView.frame = CGRectMake(topViewX, topViewY, topViewWidth, topViewHeight);
    //商品名称Size
    NSString *commodityNameStr = model.commodityName;
    CGSize commodityNameSize = [commodityNameStr sizeWithFont:OMOrderInfoFont];
    //商品规格Size
    NSString *specsStr = model.specs;
    CGSize specsSize = [specsStr sizeWithFont:OMOrderInfoFont];

    //商品价格标签Size
    NSString *priceSignStr = @"￥";
    CGSize priceSignSize = [priceSignStr sizeWithFont:OMOrderPriceFont];
    CGFloat predictH = ((specsSize.height > commodityNameSize.height) ? specsSize.height : commodityNameSize.height);
   //预留间隔
    CGFloat predictMargin = (topViewHeight - predictH - priceSignSize.height) / 3;
    //商品名称
    CGFloat commodityNameX = OMOrderMargin;
    CGFloat commodityNameY = predictMargin;
    CGFloat commodityNameWidth = commodityNameSize.width;
    CGFloat commdityNameHeight = commodityNameSize.height;
    self.commodityNameLabel.frame = CGRectMake(commodityNameX, commodityNameY, commodityNameWidth, commdityNameHeight);
    self.commodityNameLabel.text = commodityNameStr;
    //商品规格
    CGFloat specsX = OMOrderMargin + commodityNameWidth + OMContentMargin;
    CGFloat specsY = commodityNameY;
    CGFloat specsWidth = specsSize.width;
    CGFloat specsHeight = specsSize.height;
    self.specsLabel.frame = CGRectMake(specsX, specsY, specsWidth, specsHeight);
    self.specsLabel.text = specsStr;
    
    //商品价格标签
    
    CGFloat priceSignWidth = priceSignSize.width;
    CGFloat priceSignHeight = priceSignSize.height;
    CGFloat priceSignX = OMOrderMargin;
   // CGFloat priceSignY = OMOrderTopFormHeight - OMOrderMargin - commdityNameHeight - 5;
    CGFloat priceSignY = predictH + predictMargin * 2;

    self.priceSignLabel.frame = CGRectMake(priceSignX, priceSignY, priceSignWidth, priceSignHeight);
    self.priceSignLabel.text = priceSignStr;
    
    //商品价格
    NSString *priceStr = model.price;
    CGSize priceSize = [priceStr sizeWithFont:OMOrderPriceFont];
    CGFloat priceX = CGRectGetMaxX(self.priceSignLabel.frame);
    CGFloat priceWidth = priceSize.width;
    CGFloat priceHeight = priceSignSize.height;
    CGFloat priceY = priceSignY;
    self.priceLabel.frame = CGRectMake(priceX, priceY, priceWidth, priceHeight);
    self.priceLabel.text = priceStr;
    
    //---------------分割线-----------------
    UIView *topLine = [[UIView alloc] init];
    topLine.backgroundColor = [AppColor appTableCellSeparatLineColor];
    CGFloat topLineX = 0;
    CGFloat topLineY = topViewHeight - 0.4;
    CGFloat topLineWidth = SCREEN_WIDTH;
    CGFloat topLineHeight = 0.4;
    topLine.frame = CGRectMake(topLineX, topLineY, topLineWidth, topLineHeight);
    [self.topContentView addSubview:topLine];
    
    //=============================================================
    CGFloat middleTotalHeight = 0;
    //品牌标签
    NSString *brandSignStr = @"品牌:";
    CGSize brandSignSize = [brandSignStr sizeWithFont:OMOrderInfoFont];
    CGFloat brandSignX = OMOrderMargin;
    CGFloat brandSignY = OMOrderMargin;
    CGFloat brandSignWidth = brandSignSize.width;
    CGFloat brandSignHeight = brandSignSize.height;
    self.brandSignLabel.frame = CGRectMake(brandSignX, brandSignY, brandSignWidth, brandSignHeight);
    self.brandSignLabel.text = brandSignStr;
    
    middleTotalHeight += brandSignHeight + OMOrderMargin;
    
    //1.品牌size
    NSString *brandStr = model.brand;
    CGSize brandSize = [brandStr sizeWithFont:OMOrderInfoFont];
    //2.类别标签Size
    NSString *categorySignStr = @"类别:";
    CGSize categorySignSize = [categorySignStr sizeWithFont:OMOrderInfoFont];
    //3.类别内容的Size
    NSString *categoryStr = model.category;
    CGSize categorySize = [categoryStr sizeWithFont:OMOrderInfoFont];
    //4.品牌的总宽度
    CGFloat brandTotalWidth = brandSignSize.width + OMContentMargin + brandSize.width;
    //5.类别的总宽度
    CGFloat categoryTotalWidth = categorySignSize.width + OMContentMargin + categorySize.width;
    //6.设定预计固定宽度
    CGFloat predictWidth = (SCREEN_WIDTH - brandTotalWidth - categoryTotalWidth - OMOrderMargin * 2) / 2;
    CGFloat estimateWidth = (SCREEN_WIDTH - OMOrderMargin * 2 - brandSize.width * 2) / 2;
    //7.品牌和类别的Size预先设置
    if (brandSize.width > estimateWidth) {
        brandSize = CGSizeMake(estimateWidth, brandSize.height);
    }
    //-------------------------
    if (categorySize.width > estimateWidth) {
        categorySize = CGSizeMake(estimateWidth, categorySize.height);
    }
    //品牌
    CGFloat brandX = CGRectGetMaxX(self.brandSignLabel.frame) + OMContentMargin;
    CGFloat brandY = OMOrderMargin;
    CGFloat brandWidth = brandSize.width;
    CGFloat brandHeight = brandSize.height;
    self.brandLabel.frame = CGRectMake(brandX, brandY, brandWidth, brandHeight);
    self.brandLabel.text = brandStr;
    
    //商品类别标签
    CGFloat categorySignX = SCREEN_WIDTH - categoryTotalWidth - predictWidth;
    CGFloat categorySignY = OMOrderMargin;
    CGFloat categorySignWidth = categorySignSize.width;
    CGFloat categorySignHeight = categorySignSize.height;
    self.categorySignLabel.frame = CGRectMake(categorySignX, categorySignY, categorySignWidth, categorySignHeight);
    self.categorySignLabel.text = categorySignStr;
    
    //商品类别
    CGFloat categoryX = CGRectGetMaxX(self.categorySignLabel.frame) + OMContentMargin;
    CGFloat categoryY = OMOrderMargin;
    CGFloat categoryWidth = categorySize.width;
    CGFloat categoryHeight = categorySize.height;
    self.categoryLabel.frame = CGRectMake(categoryX, categoryY, categoryWidth, categoryHeight);
    self.categoryLabel.text = categoryStr;
    
    
    //商品产地标签
    NSString *productAreaSignStr = @"产地:";
    CGSize productAreaSignSize = [productAreaSignStr sizeWithFont:OMOrderInfoFont];
    CGFloat productAreaSignX = OMOrderMargin;
    CGFloat productAreaSignY = CGRectGetMaxY(self.brandSignLabel.frame) + OMOrderMargin;
    CGFloat productAreaSignWidth = productAreaSignSize.width;
    CGFloat productAreaSignHeight = productAreaSignSize.height;
    self.productAreaSignLabel.frame = CGRectMake(productAreaSignX, productAreaSignY, productAreaSignWidth, productAreaSignHeight);
    self.productAreaSignLabel.text = productAreaSignStr;
    //商品产地
    NSString *productAreaStr = model.productArea;
    CGSize productAreaSize = [productAreaStr sizeWithFont:OMOrderInfoFont];
    //1.预设宽度
    CGFloat predictAreaWidth = SCREEN_WIDTH - productAreaSignWidth - OMOrderMargin * 2 - OMContentMargin;
    if (productAreaSize.width > predictAreaWidth) {
        productAreaSize = [productAreaStr sizeWithFont:OMOrderInfoFont maxW:predictAreaWidth];
    }
    CGFloat productAreaX = CGRectGetMaxX(self.productAreaSignLabel.frame) + OMContentMargin;
    CGFloat productAreaY = CGRectGetMaxY(self.brandSignLabel.frame) + OMOrderMargin;
    CGFloat productAreaWidth = productAreaSize.width;
    CGFloat productAreaHeight = productAreaSize.height;
    self.productAreaLabel.frame = CGRectMake(productAreaX, productAreaY, productAreaWidth, productAreaHeight);
    self.productAreaLabel.text = productAreaStr;
    
    middleTotalHeight += ((productAreaHeight > productAreaSignHeight) ? productAreaHeight : productAreaSignHeight) + OMOrderMargin;
    
    //商品库存标签
    NSString *stockSignStr = @"库存:";
    CGSize stockSignSize = [stockSignStr sizeWithFont:OMOrderInfoFont];
    CGFloat stockSignX = OMOrderMargin;
    CGFloat stockSignY = CGRectGetMaxY(self.productAreaSignLabel.frame) + OMOrderMargin;
    if (productAreaStr != nil) {
        stockSignY = CGRectGetMaxY(self.productAreaLabel.frame) + OMOrderMargin;
    }
    CGFloat stockSignWidth = stockSignSize.width;
    CGFloat stockSignHeight = stockSignSize.height;
    self.stockSignLabel.frame = CGRectMake(stockSignX, stockSignY, stockSignWidth, stockSignHeight);
    self.stockSignLabel.text = stockSignStr;
    
    //商品库存
    NSString *stockStr = model.stock;
    CGSize stockSize = [stockStr sizeWithFont:OMOrderInfoFont];
    //1.商品库存预设宽度
    CGFloat stockPredictWidth = SCREEN_WIDTH - stockSignWidth - OMOrderMargin * 2 - OMContentMargin;
    if (stockSize.width > stockPredictWidth) {
        stockSize = [stockStr sizeWithFont:OMOrderInfoFont maxW:stockPredictWidth];
    }
    CGFloat stockX = CGRectGetMaxX(self.stockSignLabel.frame) + OMContentMargin;
    CGFloat stockY = CGRectGetMaxY(self.productAreaLabel.frame) + OMOrderMargin;
    if (nil == productAreaStr) {
        stockY = CGRectGetMaxY(self.productAreaSignLabel.frame) + OMOrderMargin;
    }
    CGFloat stockWidth = stockSize.width;
    CGFloat stockHeight = stockSize.height;
    self.stockLabel.frame = CGRectMake(stockX, stockY, stockWidth, stockHeight);
    self.stockLabel.text = stockStr;
    
    middleTotalHeight += ((stockHeight > stockSignHeight) ? stockHeight : stockSignHeight) + OMOrderMargin;
    
    UIView *middleLine = [[UIView alloc] init];
    middleLine.backgroundColor = [AppColor appTableCellSeparatLineColor];
    CGFloat middleLineX = 0;
    CGFloat middleLineY = middleTotalHeight + OMDetailMargin - 0.4;
    CGFloat middleLineWidth = SCREEN_WIDTH;
    CGFloat middleLineHeight = 0.4;
    middleLine.frame = CGRectMake(middleLineX, middleLineY, middleLineWidth, middleLineHeight);
    [self.middleContentView addSubview:middleLine];

    //备注标签
    NSString *remarksSignStr = @"备注";
    CGSize remarksSignSize = [remarksSignStr sizeWithFont:OMOrderInfoFont];
    CGFloat remarksSignX = OMOrderMargin;
    CGFloat remarksSignY = CGRectGetMaxY(middleLine.frame) + OMOrderMargin;
    if (nil == stockStr) {
        remarksSignY = CGRectGetMaxY(self.stockSignLabel.frame) + OMOrderMargin;
    }
    CGFloat remarksSignWidth = remarksSignSize.width;
    CGFloat remarksSignHeight = remarksSignSize.height;
    
    self.remarksSignLabel.frame = CGRectMake(remarksSignX, remarksSignY, remarksSignWidth, remarksSignHeight);
    self.remarksSignLabel.text = remarksSignStr;
    middleTotalHeight += remarksSignHeight + OMContentMargin;
    //备注
    NSString *remarksStr = model.remarks;
    CGSize remarksSize = [remarksStr sizeWithFont:OMOrderInfoFont];
    CGFloat remarkPredictWith = SCREEN_WIDTH - OMOrderMargin * 2;
    if (remarksSize.width > remarkPredictWith) {
        remarksSize = [remarksStr sizeWithFont:OMOrderInfoFont maxW:remarkPredictWith];
    }
    CGFloat remarksX = OMOrderMargin;
    CGFloat remarksY = CGRectGetMaxY(self.remarksSignLabel.frame) + OMContentMargin;
    CGFloat remarksWidth = remarksSize.width;
    CGFloat remarksHeight = remarksSize.height;
    self.remarksLabel.frame = CGRectMake(remarksX, remarksY, remarksWidth, remarksHeight);
    self.remarksLabel.text = remarksStr;
    
    middleTotalHeight += remarksHeight + OMOrderMargin + 10;
    //中间的背景View容器
    CGFloat middleViewX = 0;
    CGFloat middleViewY = CGRectGetMaxY(self.topContentView.frame) + 0.4;
    CGFloat middleViewWidth = SCREEN_WIDTH;
    CGFloat middleViewHeight = middleTotalHeight;
    self.middleContentView.frame = CGRectMake(middleViewX, middleViewY, middleViewWidth, middleViewHeight);
    

    //-----------------------------------------------------------------------
    //成交价标签
    NSString *currentRateStr = @"成交价:";
    CGSize currentRateSize = [currentRateStr sizeWithFont:OMOrderInfoFont];
    CGFloat currentRateWidth = currentRateSize.width;
    CGFloat currentRateHeight = currentRateSize.height;
    CGFloat currentRateX = OMOrderMargin;
    CGFloat currentRateY = (OMOrderBottomFormHeight - currentRateHeight) / 2;
    self.currentRateLabel.frame = CGRectMake(currentRateX, currentRateY, currentRateWidth, currentRateHeight);
    self.currentRateLabel.text = currentRateStr;
    
    //成交价
    CGFloat currentRateFieldWidth = EditTextFieldWidth;
    CGFloat currentRateFieldHeight = EditTextFieldHeight;
    CGFloat currentRateFieldX = CGRectGetMaxX(self.currentRateLabel.frame) + OMOrderMargin + 5;
    CGFloat currentRateFieldY = (OMOrderBottomFormHeight - currentRateFieldHeight) / 2;
    self.currentRateField.frame = CGRectMake(currentRateFieldX, currentRateFieldY, currentRateFieldWidth, currentRateFieldHeight);
    //底部分割线一
    self.bottomLineOne.frame = CGRectMake(0, OMOrderBottomFormHeight - 0.4, SCREEN_WIDTH, 0.4);
    
    //购买数量标签
    NSString *purchaseSignStr = @"购买数量:";
    CGSize purchaseSignSize = [purchaseSignStr sizeWithFont:OMOrderInfoFont];
    CGFloat purchaseSignWidth = purchaseSignSize.width;
    CGFloat purchaseSignHeight = purchaseSignSize.height;
    CGFloat purchaseSignX = OMOrderMargin;
    CGFloat purchaseSignY = (OMOrderBottomFormHeight - purchaseSignHeight) / 2 + CGRectGetMaxY(self.bottomLineOne.frame);
      self.purchaseSignLabel.frame = CGRectMake(purchaseSignX, purchaseSignY, purchaseSignWidth, purchaseSignHeight);
    self.purchaseSignLabel.text = purchaseSignStr;
    
    //购买数量具体单位数量
    CGFloat concreteUnitNumWidth = EditTextFieldWidth;
    CGFloat concreteUnitNumHeight = EditTextFieldHeight;
    CGFloat concreteUnitNumX = currentRateFieldX + OMOrderMargin;
    CGFloat concreteUnitNumY = (OMOrderBottomFormHeight - concreteUnitNumHeight) / 2 + CGRectGetMaxY(self.bottomLineOne.frame);
    self.concreteUnitNumField.frame = CGRectMake(concreteUnitNumX, concreteUnitNumY, concreteUnitNumWidth, concreteUnitNumHeight);
    
    //购买数量具体单位数量单位标签
    NSString *concreteUnitNumSignStr = @"件";
    CGSize concreteUnitNumSignSize = [concreteUnitNumSignStr sizeWithFont:OMOrderInfoFont];
    CGFloat concreteUnitNumSignX = CGRectGetMaxX(self.concreteUnitNumField.frame) + 3;
    CGFloat concreteUnitNumSignY = purchaseSignY;
    CGFloat concreteUnitNumSignWidth = concreteUnitNumSignSize.width;
    CGFloat concreteUnitNumSignHeight = concreteUnitNumSignSize.height;
    self.concreteUnitNumSignLabel.frame = CGRectMake(concreteUnitNumSignX, concreteUnitNumSignY, concreteUnitNumSignWidth, concreteUnitNumSignHeight);
    self.concreteUnitNumSignLabel.text = concreteUnitNumSignStr;
    
    //购买数量的辅助单位数量
    CGFloat auxiliaryUnitNumWidth = EditTextFieldWidth;
    CGFloat auxiliaryUnitNumHeight = EditTextFieldHeight;
    CGFloat auxiliaryUnitNumX = CGRectGetMaxX(self.concreteUnitNumSignLabel.frame) + OMOrderMargin;
    CGFloat auxiliaryUnitNumY = concreteUnitNumY;
    self.auxiliaryUnitNumField.frame = CGRectMake(auxiliaryUnitNumX, auxiliaryUnitNumY, auxiliaryUnitNumWidth, auxiliaryUnitNumHeight);
    
    //购买数量的辅助单位数量单位标签
    NSString *auxiliaryUnitNumSignStr = @"瓶";
    CGSize auxiliaryUnitNumSignSize = [auxiliaryUnitNumSignStr sizeWithFont:OMOrderInfoFont];
    CGFloat auxiliaryUnitNumSignX = CGRectGetMaxX(self.auxiliaryUnitNumField.frame) + 3;
    CGFloat auxiliaryUnitNumSignY = purchaseSignY;
    CGFloat auxiliaryUnitNumSignWidth = auxiliaryUnitNumSignSize.width;
    CGFloat auxiliaryUnitNumSignHeight = auxiliaryUnitNumSignSize.height;
    self.auxiliaryUnitNumSignLabel.frame = CGRectMake(auxiliaryUnitNumSignX, auxiliaryUnitNumSignY, auxiliaryUnitNumSignWidth, auxiliaryUnitNumSignHeight);
    self.auxiliaryUnitNumSignLabel.text = auxiliaryUnitNumSignStr;
    //底部的背景容器
    CGFloat bottomContentViewX = 0;
    CGFloat bottomContentViewY = CGRectGetMaxY(self.middleContentView.frame) + 6;
    CGFloat bottomContentViewWidth = SCREEN_WIDTH;
    CGFloat bottomContentViewHeight = OMOrderBottomFormHeight * 2;
    self.bottomContentView.frame = CGRectMake(bottomContentViewX, bottomContentViewY, bottomContentViewWidth, bottomContentViewHeight);
    //底部的分割线二
    self.bottomLineTwo.frame = CGRectMake(0, OMOrderBottomFormHeight * 2 - 0.4, SCREEN_WIDTH, 0.4);

    //中间的背景View和底部的背景View位置设定
   //CGFloat contentViewHeight = OMOrderTopFormHeight + middleTotalHeight + OMOrderBottomFormHeight * 2;
    CGFloat contentViewHeight = CGRectGetMaxY(self.middleContentView.frame) + OMOrderBottomFormHeight * 2 + 6;
    CGFloat predictHeight = SCREEN_HEIGHT - 50 - 64;
    if (contentViewHeight < predictHeight) {
        CGFloat leftHeight = predictHeight - contentViewHeight;
        self.middleContentView.frame = CGRectMake(0, self.middleContentView.frame.origin.y, self.middleContentView.frame.size.width, self.middleContentView.frame.size.height +  leftHeight);
        self.bottomContentView.frame = CGRectMake(bottomContentViewX, CGRectGetMaxY(self.middleContentView.frame) + 6, bottomContentViewWidth, bottomContentViewHeight);
    }
    
}

/**
 设置商品信息的主页面
 */
- (void)setupOrderEditScrollViewSubviews
{
    self.backgroundColor = [AppColor appTableViewBackgroundColor];
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    
    //顶部的容器View
    UIView *topContentView = [[UIView alloc] init];
    topContentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:topContentView];
    self.topContentView = topContentView;
    //中间的的容器View
    UIView *middleContentView = [[UIView alloc] init];
    middleContentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:middleContentView];
    self.middleContentView = middleContentView;
    //底部的容器View
    UIView *bottomContentView = [[UIView alloc] init];
    bottomContentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bottomContentView];
    self.bottomContentView = bottomContentView;
    
    //商品名称
    UILabel *commodityNameLabel = [[UILabel alloc] init];
    commodityNameLabel.font = OMOrderInfoFont;
    commodityNameLabel.textColor = [UIColor blackColor];
    commodityNameLabel.textAlignment = NSTextAlignmentLeft;
    commodityNameLabel.numberOfLines = 0;
    [self.topContentView addSubview:commodityNameLabel];
    self.commodityNameLabel = commodityNameLabel;
    
    //商品规格
    UILabel *specsLabel = [[UILabel alloc] init];
    specsLabel.font = OMOrderInfoFont;
    specsLabel.textColor = [UIColor blackColor];
    specsLabel.textAlignment = NSTextAlignmentLeft;
    specsLabel.numberOfLines = 0;
    [self.topContentView addSubview:specsLabel];
    self.specsLabel = specsLabel;
    //商品价格标签
    UILabel *priceSignLabel = [[UILabel alloc] init];
    priceSignLabel.font = OMOrderPriceFont;
    priceSignLabel.textColor = [UIColor redColor];
    priceSignLabel.textAlignment = NSTextAlignmentLeft;
    priceSignLabel.numberOfLines = 0;
    [self.topContentView addSubview:priceSignLabel];
    self.priceSignLabel = priceSignLabel;
    
    //商品价格
    UILabel *priceLabel = [[UILabel alloc] init];
    priceLabel.font = OMOrderPriceFont;
    priceLabel.textColor = [UIColor redColor];
    priceLabel.textAlignment = NSTextAlignmentLeft;
    priceLabel.numberOfLines = 0;
    [self.topContentView addSubview:priceLabel];
    self.priceLabel = priceLabel;
    
    //品牌标签
    UILabel *brandSignLabel = [[UILabel alloc] init];
    brandSignLabel.font = OMOrderInfoFont;
    brandSignLabel.textColor = [UIColor blackColor];
    brandSignLabel.textAlignment = NSTextAlignmentLeft;
    brandSignLabel.numberOfLines = 0;
    [self.middleContentView addSubview:brandSignLabel];
    self.brandSignLabel = brandSignLabel;
    
    //品牌
    UILabel *brandLabel = [[UILabel alloc] init];
    brandLabel.font = OMOrderInfoFont;
    brandLabel.textColor = [UIColor blackColor];
    brandLabel.textAlignment = NSTextAlignmentLeft;
    brandLabel.numberOfLines = 0;
    [self.middleContentView addSubview:brandLabel];
    self.brandLabel = brandLabel;
    
    //商品类别标签
    UILabel *categorySignLabel = [[UILabel alloc] init];
    categorySignLabel.font = OMOrderInfoFont;
    categorySignLabel.textColor = [UIColor blackColor];
    categorySignLabel.textAlignment = NSTextAlignmentLeft;
    categorySignLabel.numberOfLines = 0;
    [self.middleContentView addSubview:categorySignLabel];
    self.categorySignLabel = categorySignLabel;
    
    
    //商品类别
    UILabel *categoryLabel = [[UILabel alloc] init];
    categoryLabel.font = OMOrderInfoFont;
    categoryLabel.textColor = [UIColor blackColor];
    categoryLabel.textAlignment = NSTextAlignmentLeft;
    categoryLabel.numberOfLines = 0;
    [self.middleContentView addSubview:categoryLabel];
    self.categoryLabel = categoryLabel;
    
    
    //商品产地标签
    UILabel *productAreaSignLabel = [[UILabel alloc] init];
    productAreaSignLabel.font = OMOrderInfoFont;
    productAreaSignLabel.textColor = [UIColor blackColor];
    productAreaSignLabel.textAlignment = NSTextAlignmentLeft;
    productAreaSignLabel.numberOfLines = 0;
    [self.middleContentView addSubview:productAreaSignLabel];
    self.productAreaSignLabel = productAreaSignLabel;
    
    
    //商品产地
    UILabel *productAreaLabel = [[UILabel alloc] init];
    productAreaLabel.font = OMOrderInfoFont;
    productAreaLabel.textColor = [UIColor blackColor];
    productAreaLabel.textAlignment = NSTextAlignmentLeft;
    productAreaLabel.numberOfLines = 0;
    [self.middleContentView addSubview:productAreaLabel];
    self.productAreaLabel = productAreaLabel;
    
    
    //商品库存标签
    UILabel *stockSignLabel = [[UILabel alloc] init];
    stockSignLabel.font = OMOrderInfoFont;
    stockSignLabel.textColor = [UIColor blackColor];
    stockSignLabel.textAlignment = NSTextAlignmentLeft;
    stockSignLabel.numberOfLines = 0;
    [self.middleContentView addSubview:stockSignLabel];
    self.stockSignLabel = stockSignLabel;
    
    
    //商品库存
    UILabel *stockLabel = [[UILabel alloc] init];
    stockLabel.font = OMOrderInfoFont;
    stockLabel.textColor = [UIColor blackColor];
    stockLabel.textAlignment = NSTextAlignmentLeft;
    stockLabel.numberOfLines = 0;
    [self.middleContentView addSubview:stockLabel];
    self.stockLabel = stockLabel;
    
    
    //备注标签
    UILabel *remarksSignLabel = [[UILabel alloc] init];
    remarksSignLabel.font = OMOrderInfoFont;
    remarksSignLabel.textColor = [UIColor blackColor];
    remarksSignLabel.textAlignment = NSTextAlignmentLeft;
    remarksSignLabel.numberOfLines = 0;
    [self.middleContentView addSubview:remarksSignLabel];
    self.remarksSignLabel = remarksSignLabel;
    //备注
    UILabel *remarksLabel = [[UILabel alloc] init];
    remarksLabel.font = OMOrderInfoFont;
    remarksLabel.textColor = [UIColor blackColor];
    remarksLabel.textAlignment = NSTextAlignmentLeft;
    remarksLabel.numberOfLines = 0;
    [self.middleContentView addSubview:remarksLabel];
    self.remarksLabel = remarksLabel;
    
    
    //成交价标签
    UILabel *currentRateLabel = [[UILabel alloc] init];
    currentRateLabel.font = OMOrderInfoFont;
    currentRateLabel.textColor = [UIColor blackColor];
    currentRateLabel.textAlignment = NSTextAlignmentLeft;
    currentRateLabel.numberOfLines = 0;
    [self.bottomContentView addSubview:currentRateLabel];
    self.currentRateLabel = currentRateLabel;
    
    //成交价
    OMOrderEditTextField *currentRateField = [[OMOrderEditTextField alloc] init];
    currentRateField.fieldType = @"price";
    currentRateField.font = OMOrderInfoFont;
    currentRateField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    currentRateField.layer.borderWidth = 0.5;
    currentRateField.textColor = [UIColor blackColor];
    currentRateField.textAlignment = NSTextAlignmentLeft;
    currentRateField.delegate = self;
    [self.bottomContentView addSubview:currentRateField];
    self.currentRateField = currentRateField;
    //底部分割线一
    UIView *bottomLineOne = [[UIView alloc] init];
    bottomLineOne.backgroundColor = [AppColor appTableCellSeparatLineColor];
    [self.bottomContentView addSubview:bottomLineOne];
    self.bottomLineOne = bottomLineOne;
    
    //购买数量标签
    UILabel *purchaseSignLabel = [[UILabel alloc] init];
    purchaseSignLabel.font = OMOrderInfoFont;
    purchaseSignLabel.textColor = [UIColor blackColor];
    purchaseSignLabel.textAlignment = NSTextAlignmentLeft;
    purchaseSignLabel.numberOfLines = 0;
    [self.bottomContentView addSubview:purchaseSignLabel];
    self.purchaseSignLabel = purchaseSignLabel;
    
    //购买数量具体单位数量
    OMOrderEditTextField *concreteUnitNumField = [[OMOrderEditTextField alloc] init];
    concreteUnitNumField.fieldType = @"buyNum";
    concreteUnitNumField.font = OMOrderInfoFont;
    concreteUnitNumField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    concreteUnitNumField.layer.borderWidth = 0.5;
    concreteUnitNumField.textColor = [UIColor blackColor];
    concreteUnitNumField.textAlignment = NSTextAlignmentLeft;
    concreteUnitNumField.text = @"0";//默认
    concreteUnitNumField.delegate = self;
    [self.bottomContentView addSubview:concreteUnitNumField];
    self.concreteUnitNumField = concreteUnitNumField;
    
    //购买数量具体单位数量单位标签
    UILabel *concreteUnitNumSignLabel = [[UILabel alloc] init];
    concreteUnitNumSignLabel.font = OMOrderInfoFont;
    concreteUnitNumSignLabel.textColor = [UIColor blackColor];
    concreteUnitNumSignLabel.textAlignment = NSTextAlignmentLeft;
    concreteUnitNumSignLabel.numberOfLines = 0;
    [self.bottomContentView addSubview:concreteUnitNumSignLabel];
    self.concreteUnitNumSignLabel = concreteUnitNumSignLabel;
    
    
    //购买数量的辅助单位数量
    OMOrderEditTextField *auxiliaryUnitNumField = [[OMOrderEditTextField alloc] init];
    auxiliaryUnitNumField.fieldType = @"buyNum";
    auxiliaryUnitNumField.font = OMOrderInfoFont;
    auxiliaryUnitNumField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    auxiliaryUnitNumField.layer.borderWidth = 0.5;
    auxiliaryUnitNumField.textColor = [UIColor blackColor];
    auxiliaryUnitNumField.textAlignment = NSTextAlignmentLeft;
    auxiliaryUnitNumField.delegate = self;
    [self.bottomContentView addSubview:auxiliaryUnitNumField];
    self.auxiliaryUnitNumField = auxiliaryUnitNumField;
    
    //购买数量的辅助单位数量单位标签
    UILabel *auxiliaryUnitNumSignLabel = [[UILabel alloc] init];
    auxiliaryUnitNumSignLabel.font = OMOrderInfoFont;
    auxiliaryUnitNumSignLabel.textColor = [UIColor blackColor];
    auxiliaryUnitNumSignLabel.textAlignment = NSTextAlignmentLeft;
    auxiliaryUnitNumSignLabel.numberOfLines = 0;
    [self.bottomContentView addSubview:auxiliaryUnitNumSignLabel];
    self.auxiliaryUnitNumSignLabel = auxiliaryUnitNumSignLabel;
    //底部分割线二
    UIView *bottomLineTwo = [[UIView alloc] init];
    bottomLineTwo.backgroundColor = [AppColor appTableCellSeparatLineColor];
    [self.bottomContentView addSubview:bottomLineTwo];
    self.bottomLineTwo = bottomLineTwo;

    
}
#pragma mark---UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    OMOrderEditTextField *editField = (OMOrderEditTextField *)textField;
    if ([editField.fieldType isEqualToString:@"buyNum"] && 0 == [textField.text integerValue]) {
        textField.text = nil;
    }
//    if (nil == self.concreteUnitNumField.text || [self.concreteUnitNumField.text isEqualToString:@""]) {
//        self.concreteUnitNumField.text = @"0";
//    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
   // OMOrderEditTextField *editField = (OMOrderEditTextField *)textField;
    NSLog(@"self.concreteUnitNumField.text = %@",self.concreteUnitNumField.text);
   
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSLog(@"textField的类型 = %@",NSStringFromClass([textField class]));
    if (0 == string.length) {
        return YES;
    }
    OMOrderEditTextField *editField = (OMOrderEditTextField *)textField;
    NSLog(@"editField.fieldType = %@",editField.fieldType);
    if ([editField.fieldType isEqualToString:@"price"]) {
    //第一个参数，被替换字符串的range，第二个参数，即将键入或者粘贴的string，返回的是改变过后的新str，即textfield的新的文本内容
    NSString *checkStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
    //正则表达式
    NSString *regex = @"^\\-?([1-9]\\d*|0)(\\.\\d{0,2})?$";
        BOOL isInput = [self isValid:checkStr withRegex:regex];
        if (self.orderEditBlock) {
            self.orderEditBlock(editField, isInput);
        }
        return isInput;
    }else {
        
        //第一个参数，被替换字符串的range，第二个参数，即将键入或者粘贴的string，返回的是改变过后的新str，即textfield的新的文本内容
        NSString *checkStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
        //正则表达式
        NSString *regex = @"^[1-9]\\d*|0$";
        BOOL isInput = [self isValid:checkStr withRegex:regex];
        if (self.orderEditBlock) {
            self.orderEditBlock(editField, isInput);
        }
        return isInput;

    }

}
//检测改变过的文本是否匹配正则表达式，如果匹配表示可以键入，否则不能键入
- (BOOL) isValid:(NSString*)checkStr withRegex:(NSString*)regex
{
    NSPredicate *predicte = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicte evaluateWithObject:checkStr];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
