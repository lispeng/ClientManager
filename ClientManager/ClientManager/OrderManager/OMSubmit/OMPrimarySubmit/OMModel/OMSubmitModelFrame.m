//
//  OMSubmitModelFrame.m
//  ClientManager
//
//  Created by iOS－MacBook on 2017/5/10.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import "OMSubmitModelFrame.h"
#import "OMSubmitModel.h"

@implementation OMSubmitModelFrame
- (void)setModel:(OMSubmitModel *)model
{
    _model = model;
    //客户
    NSString *clientStr = model.clientName;
    NSString *clientSign = @"客户:";
    CGSize clientSignSize = [clientSign sizeWithFont:OMClientTitleFont];
    CGSize clientSize = [clientStr sizeWithFont:OMClientTitleFont];
    
    //提交日期
    NSString *submitDateSignStr = @"提交日期:";
    NSString *submitDateContentStr = model.submitDate;
    CGSize submitDateSize = [submitDateSignStr sizeWithFont:OMFont];
    CGSize submitDateContentSize = [submitDateContentStr sizeWithFont:OMFont];

    //订单金额Size
    NSString *orderSignStr = @"订单金额:";
    NSString *orderContentStr = model.orderMoney;
    CGSize orderSize = [orderSignStr sizeWithFont:OMFont];
    CGFloat maxOrderWidth = SCREEN_WIDTH - OMLRMargin * 3 - submitDateSize.width - OMMargin - submitDateContentSize.width - orderSize.width;
    
    CGSize orderContentSize = [orderContentStr sizeWithFont:OMFont];
    if (orderContentSize.width > maxOrderWidth) {
        orderContentSize = CGSizeMake(maxOrderWidth, orderContentSize.height);
    }
        //-------------------------------------------
    
    //客户名应该的Width
    CGFloat clientWidth = SCREEN_WIDTH - OMLRMargin * 2 - OMMargin - OMCellSignWidth - clientSignSize.width;
    if (clientSize.width > clientWidth) {
        clientSize = CGSizeMake(clientWidth, clientSize.height);

    }
    // --------------------------------
    //客户标签的Frame
    CGFloat clientSignX = OMLRMargin;
    CGFloat clientSignY = OMLRMargin;
    CGFloat clientSignWidth = clientSignSize.width;
    CGFloat clientSignHeight = clientSignSize.height;
    self.clientSignLabelFrame = CGRectMake(clientSignX, clientSignY, clientSignWidth, clientSignHeight);
    //客户具体名称frame
    CGFloat clientContentX = CGRectGetMaxX(self.clientSignLabelFrame) + OMMargin;
    CGFloat clientContentY = OMLRMargin;
    CGFloat clientContentWidth = clientSize.width;
    CGFloat clientContentHeight = clientSize.height;
    self.clientContentLabelFrame = CGRectMake(clientContentX, clientContentY, clientContentWidth, clientContentHeight);
    
     //-------------------------------------
    //提交日期的标签frame
    CGFloat submitDateSignX = OMLRMargin;
    CGFloat submitDateSignY = CGRectGetMaxY(self.clientSignLabelFrame) + OMLRMargin;
    CGFloat submitDateSignWidth = submitDateSize.width;
    CGFloat submitDateSignHeight = submitDateSize.height;
    self.submitDateSignLabelFrame = CGRectMake(submitDateSignX, submitDateSignY, submitDateSignWidth, submitDateSignHeight);
    //提交日期具体内容frame
    CGFloat submitDateContentX = CGRectGetMaxX(self.submitDateSignLabelFrame) + OMMargin;
    CGFloat submitDateContentY = CGRectGetMaxY(self.clientContentLabelFrame) + OMLRMargin;
    CGFloat submitDateContentWidth = submitDateContentSize.width;
    CGFloat submitDateContentHeight =  submitDateContentSize.height;
    self.submitDateContentLabelFrame = CGRectMake(submitDateContentX, submitDateContentY, submitDateContentWidth, submitDateContentHeight);
    
    //订单金额的标签frame
    CGFloat orderSignX = CGRectGetMaxX(self.submitDateContentLabelFrame) + OMLRMargin;
    CGFloat orderSignY = self.submitDateSignLabelFrame.origin.y;
    CGFloat orderSignWidth = orderSize.width;
    CGFloat orderSignHeight = orderSize.height;
    self.orderSignLabelFrame = CGRectMake(orderSignX, orderSignY, orderSignWidth, orderSignHeight);
    //订单金额的具体内容frame
    CGFloat orderContentX = CGRectGetMaxX(self.orderSignLabelFrame) + OMMargin;
    CGFloat orderContentY = self.orderSignLabelFrame.origin.y;
    CGFloat orderContentWidth = orderContentSize.width;
    CGFloat orderContentHeight = orderContentSize.height;
    self.orderContentLabelFrame = CGRectMake(orderContentX, orderContentY, orderContentWidth, orderContentHeight);
    
    //标签的frame
    CGFloat pendWidth = OMCellSignWidth;
    CGFloat pendHeight = OMCellSignHeight;
    CGFloat pendX = SCREEN_WIDTH - pendWidth - OMMargin;
    CGFloat pendY = (OMCellHeight - pendHeight) / 2 - 5;
    self.pendLabelFrame = CGRectMake(pendX, pendY, pendWidth, pendHeight);
    //分割线frame
    self.primaryUnderLineFrame = CGRectMake(0, OMCellHeight - 0.4, SCREEN_WIDTH, 0.4);
    //cell的高度
    self.cellHeight = OMCellHeight;
}

@end
