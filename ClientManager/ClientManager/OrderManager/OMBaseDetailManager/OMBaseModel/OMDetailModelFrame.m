//
//  OMDetailModelFrame.m
//  ClientManager
//
//  Created by iOS－MacBook on 2017/5/18.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import "OMDetailModelFrame.h"
#import "OMDetailModel.h"
#import "NSString+Extension.h"
@implementation OMDetailModelFrame
- (void)setModel:(OMDetailModel *)model
{
    _model = model;
    //商品的预览图片frame
    CGFloat imageViewX = OMDetailMargin;
    CGFloat imageViewY = OMDetailContentMargin;
    CGFloat imageViewWidth = 42.5;
    CGFloat imageViewHeight = 42.5;
    self.commodityImageViewFrame = CGRectMake(imageViewX, imageViewY, imageViewWidth, imageViewHeight);
    //商品信息Frame
    NSString *infoStr = model.commodityInfo;
    CGSize infoSize = [infoStr sizeWithFont:OMDetailFont];
    CGFloat infoX = OMDetailMargin * 2 + self.commodityImageViewFrame.size.width;
    CGFloat infoY = OMDetailContentMargin;
    CGFloat infoWidth = infoSize.width;
    CGFloat infoHeight = infoSize.height;
    self.commodityInfoLabelFrame = CGRectMake(infoX, infoY, infoWidth, infoHeight);
    //赠品Frame
    CGFloat signX = OMDetailMargin * 2 + self.commodityImageViewFrame.size.width + infoWidth + OMDetailContentMargin * 2;
    CGFloat signY = OMDetailContentMargin + 2;
    CGFloat signWidth = 40;
    CGFloat signHeight = 18;
    self.commoditySignLabelFrame = CGRectMake(signX, signY, signWidth, signHeight);
    //成交价Frame
    NSString *dealSignStr = @"成交价:";
    CGSize dealSignSize = [dealSignStr sizeWithFont:OMDetailFont];
    CGFloat dealSignX = OMDetailMargin * 2 + imageViewWidth;
    CGFloat dealSignY = OMCellHeight - OMDetailContentMargin - dealSignSize.height;
    CGFloat dealSignWidth = dealSignSize.width;
    CGFloat dealSignHeight = dealSignSize.height;
    self.dealPriceSignLabelFrame = CGRectMake(dealSignX, dealSignY, dealSignWidth, dealSignHeight);
    //成交具体价格Frame
    NSString *dealPriceStr = model.dealPrice;
    CGSize dealPriceSize = [dealPriceStr sizeWithFont:OMDetailFont];
    CGFloat dealPriceX = CGRectGetMaxX(self.dealPriceSignLabelFrame) + OMDetailContentMargin;
    CGFloat dealPriceY = dealSignY;
    CGFloat dealPriceWidth = dealPriceSize.width;
    CGFloat dealPriceHeight = dealSignSize.height;
    self.dealPriceLabelFrame = CGRectMake(dealPriceX, dealPriceY, dealPriceWidth, dealPriceHeight);
   //购买数量标签的Frame
    //1.购买数量标签的Size
    NSString *buySignNumStr = @"购买数量:";
    CGSize buySignNumSize = [buySignNumStr sizeWithFont:OMDetailFont];
    //2.购买数量的Size
    NSString *buyNumStr = model.buyNum;
    CGSize buyNumSize = [buyNumStr sizeWithFont:OMDetailFont];
    //3."购买数量"标签和内容的总宽度
    CGFloat totalBuyNumWidth = buySignNumSize.width + buyNumSize.width + OMDetailContentMargin;
    //4.成交价的标签和内容总宽度
    CGFloat totalDealPriceWidth = dealSignWidth + dealPriceWidth + OMDetailContentMargin;
    //5.预留购买数量总的最大宽度
    CGFloat predictWidth = SCREEN_WIDTH - OMDetailMargin * 3 + OMDetailContentMargin * 2 - imageViewWidth - totalDealPriceWidth;
    //6.预留的购买数量的最大内容宽度
    CGFloat predictBuyNumWidth = predictWidth - buySignNumSize.width - OMDetailContentMargin;
    
    CGFloat buySignX = SCREEN_WIDTH - totalBuyNumWidth - OMDetailMargin;
    CGFloat maxDealPriceX = CGRectGetMaxX(self.dealPriceLabelFrame);
    CGFloat predictBuyWidth = buyNumSize.width;
    if (buySignX < maxDealPriceX) {
        buySignX = maxDealPriceX;
        predictBuyWidth = predictBuyNumWidth;
    }
    
    CGFloat buySignY = dealSignY;
    CGFloat buySignWidth = buySignNumSize.width;
    CGFloat buySignHeight = buySignNumSize.height;
    self.buySignNumLabelFrame = CGRectMake(buySignX, buySignY, buySignWidth, buySignHeight);
    //购买数量具体内容的Frame
    
    CGFloat buyX = CGRectGetMaxX(self.buySignNumLabelFrame) + OMDetailContentMargin;
    
    CGFloat buyY = buySignY;
    CGFloat buyHeight = buyNumSize.height;
    self.buyNumLabelFrame = CGRectMake(buyX, buyY, predictBuyWidth, buyHeight);
    
    //cell底部的分割线
    CGFloat lineX = 0;
    CGFloat lineY = OMDetailCellH - 0.5;
    CGFloat lineWidth = SCREEN_WIDTH;
    CGFloat lineHeight = 0.5;
    self.addOrderUnderLineFrame = CGRectMake(lineX, lineY, lineWidth, lineHeight);


}
@end
