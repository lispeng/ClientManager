//
//  OMOrderScrollView.m
//  ClientManager
//--------------------产品信息详情（不可编辑的）-------------------
//  Created by iOS－MacBook on 2017/5/15.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import "OMOrderScrollView.h"
#import "OMOrderEditTextField.h"
#import "OMOrderModel.h"
#import "LSPSlideView.h"
#define OrderImageHeight 150
@interface OMOrderScrollView()
/**
 头部的商品图片展示
 */
@property (nonatomic,weak) UIImageView *orderImageView;
/**
 图片轮播器
 */
@property (nonatomic,weak) LSPSlideView *slidView;

/**
 <#annotation#>
 */
@property (nonatomic,weak) UIView *bottomLineOne;

@end

@implementation OMOrderScrollView
- (instancetype)init
{
    if (self = [super init]) {
        [self setupOrderScrollViewSubviews];
    }
    return self;
}
- (void)setModel:(OMOrderModel *)model
{
    _model = model;
 //顶部的商品图片容器
//    CGFloat orderImageX = 0;
//    CGFloat orderImageY = 0;
//    CGFloat orderImageWidth = SCREEN_WIDTH;
//    CGFloat orderImageHeight = OrderImageHeight;
//    self.orderImageView.frame = CGRectMake(orderImageX, orderImageY, orderImageWidth, orderImageHeight);
    
    //顶部的图片轮播器
    CGFloat slidViewX = 0;
    CGFloat slidViewY = 0;
    CGFloat slidViewWidth = SCREEN_WIDTH;
    CGFloat slidViewHeight = SCREEN_WIDTH / 320 * 150;;
    self.slidView.frame = CGRectMake(slidViewX, slidViewY, slidViewWidth, slidViewHeight);
    NSMutableArray *imageArray = [NSMutableArray array];
    for (NSInteger i = 0; i < 20; i ++) {
        NSString *imageStr = [NSString stringWithFormat:@"%ld.jpg",i + 1];
        UIImage *image = [UIImage imageNamed:imageStr];
        [imageArray addObject:image];
        
    }
    self.slidView.imageArray = imageArray;
    //顶部的背景容器
    CGFloat topViewX = 0;
    CGFloat topViewY = CGRectGetMaxY(self.slidView.frame);
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
    CGFloat priceSignX = OMOrderMargin;
    CGFloat priceSignY = predictH + predictMargin * 2;
    CGFloat priceSignWidth = priceSignSize.width;
    CGFloat priceSignHeight = priceSignSize.height;
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
    //顶部分割线一
    self.bottomLineOne.frame = CGRectMake(0, OMOrderTopFormHeight - 0.4, SCREEN_WIDTH, 0.4);
    
    
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
    //分割线
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
    CGFloat middleViewY = CGRectGetMaxY(self.topContentView.frame);
    CGFloat middleViewWidth = SCREEN_WIDTH;
    CGFloat middleViewHeight = SCREEN_HEIGHT - slidViewHeight - topViewHeight;
    self.middleContentView.frame = CGRectMake(middleViewX, middleViewY, middleViewWidth, middleViewHeight);
    //-----------------------------------------------------------------------
    
    //中间的背景View和底部的背景View位置设定
    //CGFloat contentViewHeight = OMOrderTopFormHeight + middleTotalHeight + OMOrderBottomFormHeight * 2;
    /*
    CGFloat contentViewHeight = CGRectGetMaxY(self.middleContentView.frame) + OMOrderBottomFormHeight * 2 + 6;
    CGFloat predictHeight = SCREEN_HEIGHT - 50 - 64;
    if (contentViewHeight < predictHeight) {
        CGFloat leftHeight = predictHeight - contentViewHeight;
       // self.middleContentView.frame = CGRectMake(0, self.middleContentView.frame.origin.y, self.middleContentView.frame.size.width, self.middleContentView.frame.size.height +  leftHeight);
      //  self.bottomContentView.frame = CGRectMake(bottomContentViewX, CGRectGetMaxY(self.middleContentView.frame) + 6, bottomContentViewWidth, bottomContentViewHeight);
    }
*/

}
/**
 设置商品信息的主页面
 */
- (void)setupOrderScrollViewSubviews
{
    self.backgroundColor = [AppColor appTableViewBackgroundColor];
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    //头部的商品图片展示
//    UIImageView *orderImageView = [[UIImageView alloc] init];
//    orderImageView.userInteractionEnabled = YES;
//    orderImageView.contentMode = UIViewContentModeCenter;
//    orderImageView.contentMode = UIViewContentModeScaleToFill;
//    [orderImageView setContentScaleFactor:[[UIScreen mainScreen] scale]];
//    orderImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
//    orderImageView.clipsToBounds  = YES;
//    orderImageView.image = [UIImage imageNamed:@"8.jpg"];
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(orderImageViewClick:)];
//    tap.numberOfTapsRequired = 1;
//    [orderImageView addGestureRecognizer:tap];
//    [self addSubview:orderImageView];
//    self.orderImageView = orderImageView;
    
    //图片轮播器
    LSPSlideView *slidView = [[LSPSlideView alloc] init];
    [self addSubview:slidView];
    self.slidView = slidView;
     
    
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
    //顶部分割线
    UIView *bottomLineOne = [[UIView alloc] init];
    bottomLineOne.backgroundColor = [AppColor appTableCellSeparatLineColor];
    [self.topContentView addSubview:bottomLineOne];
    self.bottomLineOne = bottomLineOne;

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
}
- (void)orderImageViewClick:(UIGestureRecognizer *)tap
{
    NSLog(@"OrderImageViewClick");
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
