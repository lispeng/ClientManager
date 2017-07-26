//
//  OMAddModelFrame.m
//  ClientManager
//
//  Created by iOS－MacBook on 2017/5/11.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import "OMAddModelFrame.h"
#import "OMAddModel.h"
#define OMAddLRMargin 10
#define OMAddMargin 7.5
#define OMAddCellHeight 80
#define OMAddModelFont [UIFont systemFontOfSize:15]
@implementation OMAddModelFrame
- (void)setModel:(OMAddModel *)model
{
    _model = model;
    
    //赠品Frame
    CGFloat signWidth = 45;
    CGFloat signHeight = 20;
    CGFloat signX = SCREEN_WIDTH - signWidth - OMLRMargin;
    // CGFloat signX = OMAddLRMargin * 2 + self.commodityImageViewFrame.size.width + infoWidth + OMAddMargin * 2;
    CGFloat signY = OMAddLRMargin;
    self.commoditySignLabelFrame = CGRectMake(signX, signY, signWidth, signHeight);
     //商品的预览图片Frame
    CGFloat imageViewX = OMAddLRMargin;
    CGFloat imageViewY = OMAddMargin;
    CGFloat imageViewWidth = 65;
    CGFloat imageViewHeight = 65;
    self.commodityImageViewFrame = CGRectMake(imageViewX, imageViewY, imageViewWidth, imageViewHeight);
    //商品信息Frame
    NSString *infoStr = model.commodityInfo;
    CGFloat predictMaxInfoWidth = SCREEN_WIDTH - OMAddLRMargin * 2 - imageViewWidth - OMAddMargin - signWidth;
    CGSize infoSize = [infoStr sizeWithFont:OMAddModelFont maxW:predictMaxInfoWidth];
    CGFloat infoX = OMAddLRMargin * 2 + self.commodityImageViewFrame.size.width;
    CGFloat infoY = OMAddLRMargin;
    CGFloat infoWidth = infoSize.width;
    CGFloat infoHeight = infoSize.height;
    
    self.commodityInfoLabelFrame = CGRectMake(infoX, infoY, infoWidth, infoHeight);
    NSLog(@"self.commodityInfoLabelFrame = %@",NSStringFromCGRect(self.commodityInfoLabelFrame));
    NSLog(@"123");
    //成交价Frame
    NSString *dealSignStr = @"成交价:";
    CGSize dealSignSize = [dealSignStr sizeWithFont:OMAddModelFont];
    CGFloat dealSignX = OMAddLRMargin * 2 + imageViewWidth;
    CGFloat dealSignY = OMAddCellHeight - OMAddLRMargin - dealSignSize.height;
    CGFloat dealSignWidth = dealSignSize.width;
    CGFloat dealSignHeight = dealSignSize.height;
    self.dealPriceSignLabelFrame = CGRectMake(dealSignX, dealSignY, dealSignWidth, dealSignHeight);
    //成交具体价格Frame
    NSString *dealPriceStr = model.commodityPrice;
    CGSize dealPriceSize = [dealPriceStr sizeWithFont:OMAddModelFont];
    CGFloat dealPriceX = CGRectGetMaxX(self.dealPriceSignLabelFrame) + OMAddMargin;
    CGFloat dealPriceY = dealSignY;
    CGFloat dealPriceWidth = dealPriceSize.width;
    CGFloat dealPriceHeight = dealSignSize.height;
    self.dealPriceLabelFrame = CGRectMake(dealPriceX, dealPriceY, dealPriceWidth, dealPriceHeight);
    //1.商品单位标签的Size
    NSString *unitSignStr = @"单位:";
    CGSize unitSignSize = [unitSignStr sizeWithFont:OMAddModelFont];
    //2.具体单位(如：瓶、箱、罐、袋等)
    NSString *unitName = model.commodityUnit;
    CGSize unitSize = [unitName sizeWithFont:OMAddModelFont];
    //2.商品单位标签和具体单位的总宽度
    //CGFloat totalUnitWidth = unitSignSize.width + unitSize.width + OMAddMargin;
    //商品单位Frame
    CGFloat unitSignX = OMAddLRMargin * 2 + imageViewWidth + dealSignWidth + OMAddMargin + dealPriceWidth + OMAddLRMargin * 2;
    CGFloat unitSignY = dealSignY;
    CGFloat unitSignWidth = unitSignSize.width;
    CGFloat unitSignHeight = unitSignSize.height;
    self.unitSignLabelFrame = CGRectMake(unitSignX, unitSignY, unitSignWidth, unitSignHeight);
    //商品具体单位Frame
    CGFloat unitX = CGRectGetMaxX(self.unitSignLabelFrame) + OMAddMargin;
    CGFloat unitY = unitSignY;
    CGFloat unitWidth = unitSize.width;
    CGFloat unitHeight = unitSize.height;
    self.unitLabelFrame = CGRectMake(unitX, unitY, unitWidth, unitHeight);
    //商品数量更改容器Frame
//    CGFloat changeWidth = 90;
//    CGFloat changeHeight = 20;
//    CGFloat changeViewX = SCREEN_WIDTH - changeWidth - OMAddMargin;
//    CGFloat changeViewY = (OMCellHeight - changeHeight) / 2;
//    self.commodityNumChangeContentViewFrame = CGRectMake(changeViewX, changeViewY, changeWidth, changeHeight);
    //cell底部的分割线
    CGFloat lineX = 0;
    CGFloat lineY = OMAddCellHeight - 0.4;
    CGFloat lineWidth = SCREEN_WIDTH;
    CGFloat lineHeight = 0.4;
    self.addOrderUnderLineFrame = CGRectMake(lineX, lineY, lineWidth, lineHeight);
}
@end
