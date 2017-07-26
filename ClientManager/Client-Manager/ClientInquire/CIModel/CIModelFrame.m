//
//  CIModelFrame.m
//  ClientManager
//
//  Created by iOS－MacBook on 2017/7/20.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import "CIModelFrame.h"
#import "CIModel.h"
#define CICellH 55
@implementation CIModelFrame
- (void)setModel:(CIModel *)model
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

    CGFloat margin = (55 - clientNameSize.height - coordinateAddressSize.height - 5) / 2;
    //客户名称Frame
    CGFloat clientNameLabelX = ComMargin;
    CGFloat clientNameLabelY = margin;
    CGFloat clientNameLabelWidth = clientNameWidth;
    CGFloat clientNameLabelHeight = clientNameSize.height;
    self.custNameLabelFrame = CGRectMake(clientNameLabelX, clientNameLabelY, clientNameLabelWidth, clientNameLabelHeight);
    //客户负责人Frame
    CGFloat managerDescriptionLabelX = SCREEN_WIDTH - managerWidth - ComMargin;
    CGFloat managerDescriptionLabelY = clientNameLabelY;
    CGFloat managerDescriptionLabelWidth = managerWidth;
    CGFloat managerDescriptionLabelHeight = managerSize.height;
    self.managerDescriptionLabelFrame = CGRectMake(managerDescriptionLabelX, managerDescriptionLabelY, managerDescriptionLabelWidth, managerDescriptionLabelHeight);
    //坐标转换的客户地址Frame
    CGFloat coordinateAddressLabelX = ComMargin;
    CGFloat coordinateAddressLabelY = CGRectGetMaxY(self.custNameLabelFrame) + 5;
    CGFloat coordinateAddressLabelWidth = coordinateAddressWidth;
    CGFloat coordinateAddressLabelHeight = coordinateAddressSize.height;
    self.addressLabelFrame = CGRectMake(coordinateAddressLabelX, coordinateAddressLabelY, coordinateAddressLabelWidth, coordinateAddressLabelHeight);
    
    //底部分割线的Frame
    CGFloat underLineX = ComMargin;
    CGFloat underLineY = CICellH - 0.4;
    CGFloat underLineWidth = SCREEN_WIDTH - ComMargin;
    CGFloat underLineHeight = 0.4;
    self.underLineFrame = CGRectMake(underLineX, underLineY, underLineWidth, underLineHeight);

    
}
@end
