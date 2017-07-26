//
//  CMClientModelFrame.m
//  ClientManager
//
//  Created by iOS－MacBook on 2017/7/17.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import "CMClientModelFrame.h"
#import "CMClientModel.h"

@implementation CMClientModelFrame
- (void)setModel:(CMClientModel *)model
{
    _model = model;
    //客户负责人size
    CGFloat managerWidth = 90;
    NSString *managerStr = model.managerDescription;
  //  CGSize managerSize = [managerStr sizeWithFont:ComAttFont maxW:managerWidth];
    CGSize managerSize = [managerStr sizeWithFont:ComAttFont];
    if (managerSize.width > managerWidth) {
        managerSize = CGSizeMake(managerWidth, managerSize.height);
    }
    //客户名称Size
    CGFloat clientNameWidth = SCREEN_WIDTH - ComMargin * 2 - 5 - managerWidth;
    NSString *clientNameStr = model.custName;
   // CGSize clientNameSize = [clientNameStr sizeWithFont:CMTitleFont maxW:clientNameWidth];
    CGSize clientNameSize = [clientNameStr sizeWithFont:CMTitleFont];
    if (clientNameSize.width > clientNameWidth) {
        clientNameSize = CGSizeMake(clientNameWidth, clientNameSize.height);
    }
    
    //坐标转换的客户地址的size
    CGFloat coordinateAddressWidth = SCREEN_WIDTH - ComMargin * 2;
    NSString *coordinateAddressStr = model.address;
    if (nil == coordinateAddressStr) {
        
        coordinateAddressStr = model.coordinateAddress;
    }
    
    if (nil == coordinateAddressStr || 0 == coordinateAddressStr.length) {
        coordinateAddressStr = @"暂无位置坐标";
    }
    CGSize coordinateAddressSize = [coordinateAddressStr sizeWithFont:ComFont];
    if (coordinateAddressSize.width > coordinateAddressWidth) {
        coordinateAddressSize = CGSizeMake(coordinateAddressWidth, coordinateAddressSize.height);
    }
    
    //多少天退回的size
    CGFloat returnDaysWidth = (SCREEN_WIDTH - ComMargin * 2 - 5) / 3;
    NSString *returnDaysStr = nil;
    CGSize returnDaysSize =  CGSizeZero;
    if (nil != model.returnDays) {
    returnDaysStr = [NSString stringWithFormat:@"%@天后退回",model.returnDays];
    returnDaysSize = [returnDaysStr sizeWithFont:ComFont];
        if (returnDaysSize.width > returnDaysWidth) {
            returnDaysSize = CGSizeMake(returnDaysWidth, returnDaysSize.height);
        }

    }else{
        returnDaysWidth = 0;
    }
    //多少次拜访与多少天未拜访的Size
    CGFloat countOrDaysWidth = returnDaysWidth * 2;
    
    if (nil == model.visitCount || model.visitCount.length == 0) {
        
        model.visitCount = @"0";
    }
    if (nil == model.noVisitDays || 0 == model.noVisitDays) {
        model.noVisitDays = @"0";
    }
    NSString *countOrDaysStr = [NSString stringWithFormat:@"%@次拜访  %@天未拜访",model.visitCount,model.noVisitDays];
    CGSize countOrDaysSize = [countOrDaysStr sizeWithFont:ComFont];
    if (countOrDaysSize.width > countOrDaysWidth) {
        countOrDaysSize = CGSizeMake(countOrDaysWidth, countOrDaysSize.height);
    }
    //客户名称Frame
    CGFloat clientNameLabelX = ComMargin;
    CGFloat clientNameLabelY = ComMargin;
    CGFloat clientNameLabelWidth = clientNameWidth;
    CGFloat clientNameLabelHeight = clientNameSize.height;
    self.clientNameLabelFrame = CGRectMake(clientNameLabelX, clientNameLabelY, clientNameLabelWidth, clientNameLabelHeight);
    //客户负责人Frame
    CGFloat managerDescriptionLabelX = SCREEN_WIDTH - managerWidth - ComMargin;
    CGFloat managerDescriptionLabelY = clientNameLabelY;
    CGFloat managerDescriptionLabelWidth = managerWidth;
    CGFloat managerDescriptionLabelHeight = managerSize.height;
    self.managerDescriptionLabelFrame = CGRectMake(managerDescriptionLabelX, managerDescriptionLabelY, managerDescriptionLabelWidth, managerDescriptionLabelHeight);
    //坐标转换的客户地址Frame
    CGFloat coordinateAddressLabelX = ComMargin;
    CGFloat coordinateAddressLabelY = CGRectGetMaxY(self.clientNameLabelFrame) + 5;
    CGFloat coordinateAddressLabelWidth = coordinateAddressWidth;
    CGFloat coordinateAddressLabelHeight = coordinateAddressSize.height;
    self.coordinateAddressLabelFrame = CGRectMake(coordinateAddressLabelX, coordinateAddressLabelY, coordinateAddressLabelWidth, coordinateAddressLabelHeight);
    //多少天后退回Frame
    CGFloat returnDaysLabelX = ComMargin;
    CGFloat returnDaysLabelY = CGRectGetMaxY(self.coordinateAddressLabelFrame) + ComMargin;
    CGFloat returnDaysLabelWidth = returnDaysWidth;
    CGFloat returnDaysLabelHeight = returnDaysSize.height;
    self.returnDaysLabelFrame = CGRectMake(returnDaysLabelX, returnDaysLabelY, returnDaysLabelWidth, returnDaysLabelHeight);
    
    //拜访次数，未拜访天数Frame
    CGFloat countOrDaysLabelX = returnDaysWidth + ComMargin;
    CGFloat countOrDaysLabelY = CGRectGetMaxY(self.coordinateAddressLabelFrame) + ComMargin;
    CGFloat countOrDaysLabelWidth = countOrDaysWidth;
    CGFloat countOrDaysLabelHeight = countOrDaysSize.height;
    self.countOrDaysLabelFrame = CGRectMake(countOrDaysLabelX, countOrDaysLabelY, countOrDaysLabelWidth, countOrDaysLabelHeight);
    
    //底部分割线的Frame
    CGFloat underLineX = ComMargin;
    CGFloat underLineY = 90 - 0.4;
    CGFloat underLineWidth = SCREEN_WIDTH - ComMargin;
    CGFloat underLineHeight = 0.4;
    self.underLineFrame = CGRectMake(underLineX, underLineY, underLineWidth, underLineHeight);
    
}

@end
