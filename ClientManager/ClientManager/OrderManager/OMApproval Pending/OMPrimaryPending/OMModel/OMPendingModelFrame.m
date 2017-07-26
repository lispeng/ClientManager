//
//  OMPendingModelFrame.m
//  ClientManager
//
//  Created by iOS－MacBook on 2017/5/10.
//  Copyright © 2017年 Lispeng. All rights reserved.
//---------------待审批Frame--------------

#import "OMPendingModelFrame.h"
#import "OMPendingModel.h"
@implementation OMPendingModelFrame
- (void)setModel:(OMPendingModel *)model
{
    _model = model;
    //客户
    NSString *clientStr = model.clientName;
    NSString *clientSign = @"客户:";
    CGSize clientSignSize = [clientSign sizeWithFont:OMClientTitleFont];
    CGSize clientSize = [clientStr sizeWithFont:OMClientTitleFont];
    //订单金额Size
    NSString *orderSignStr = @"订单金额:";
    NSString *orderContentStr = model.orderMoney;
    CGSize orderSize = [orderSignStr sizeWithFont:OMFont];
    CGSize orderContentSize = [orderContentStr sizeWithFont:OMFont];
    //提交日期
    NSString *submitDateSignStr = @"提交日期:";
    NSString *submitDateContentStr = model.submitDate;
    CGSize submitDateSize = [submitDateSignStr sizeWithFont:OMFont];
    CGSize submitDateContentSize = [submitDateContentStr sizeWithFont:OMFont];

    //提交人的size
    NSString *submitSignStr = @"提交人:";
    NSString *submitContentStr = model.submitPeople;
    CGSize submitSignSize = [submitSignStr sizeWithFont:OMFont];
    CGSize submitContentSize = [submitContentStr sizeWithFont:OMFont];
    //-------------------------------------------
    CGFloat orderWidth = orderSize.width + OMMargin + orderContentSize.width + OMLRMargin;
    CGFloat maxOrderWidth = orderWidth;
    
    //提交日期与提交人
    CGFloat submitWidth = submitSignSize.width + OMMargin + submitContentSize.width + OMLRMargin;
    CGFloat submitDateTotalWidth = submitDateSize.width + OMMargin + submitDateContentSize.width + OMLRMargin;
    CGFloat leftMargin = (SCREEN_WIDTH - submitWidth - submitDateTotalWidth) / 2;
    //预计的提交人内容宽度
    CGFloat predictSubmitWidth = SCREEN_WIDTH - submitDateTotalWidth - OMLRMargin - submitSignSize.width - OMMargin;
    if (submitContentSize.width > predictSubmitWidth) {
        submitContentSize = CGSizeMake(predictSubmitWidth, submitContentSize.height);
    }
    
    
    CGFloat LeftX = SCREEN_WIDTH - orderWidth;
    if (orderWidth < submitWidth) {
        LeftX = SCREEN_WIDTH - submitWidth;
        maxOrderWidth = submitWidth;
    }
    
    //客户名应该的Width
    CGFloat clientWidth = SCREEN_WIDTH - OMLRMargin - clientSignSize.width - OMLRMargin - maxOrderWidth;
    clientSize = CGSizeMake(clientWidth, clientSize.height);
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
    
    //订单金额标签的frame
    CGFloat orderSignX = LeftX;
    CGFloat orderSignY = OMLRMargin;
    CGFloat orderSignWidth = orderSize.width;
    CGFloat orderSignHeight = orderSize.height;
    self.orderSignLabelFrame = CGRectMake(orderSignX, orderSignY, orderSignWidth, orderSignHeight);
    //订单金额的具体内容frame
    CGFloat orderContentX = CGRectGetMaxX(self.orderSignLabelFrame) + OMMargin;
    CGFloat orderContentY = OMLRMargin;
    CGFloat orderContentWidth = orderContentSize.width;
    CGFloat orderContentHeight = orderContentSize.height;
    self.orderContentLabelFrame = CGRectMake(orderContentX, orderContentY, orderContentWidth, orderContentHeight);
    
     //-------------------------------------
    //提交日期的标签frame
    CGFloat submitDateSignX = OMLRMargin;
    CGFloat submitDateSignY = CGRectGetMaxY(self.clientSignLabelFrame) + OMLRMargin;
    CGFloat submitDateSignWidth = submitDateSize.width;
    CGFloat submitDateSignHeight = submitDateSize.height;
    self.submitDateSignLabelFrame = CGRectMake(submitDateSignX, submitDateSignY, submitDateSignWidth,submitDateSignHeight);
    //提交日期具体内容frame
    CGFloat submitDateContentX = CGRectGetMaxX(self.submitDateSignLabelFrame) + OMMargin;
    CGFloat submitDateContentY = CGRectGetMaxY(self.clientContentLabelFrame) + OMLRMargin;
    CGFloat submitDateContentWidth = submitDateContentSize.width;
    CGFloat submitDateContentHeight =  submitDateContentSize.height;
    self.submitDateContentLabelFrame = CGRectMake(submitDateContentX, submitDateContentY, submitDateContentWidth, submitDateContentHeight);
    
    //提交人标签的frame
    if (submitWidth > orderWidth) {
        LeftX = CGRectGetMaxX(self.submitDateContentLabelFrame) + leftMargin;
    }
    CGFloat submitSignX = LeftX;
    CGFloat submitSignY = CGRectGetMaxY(self.orderSignLabelFrame) + OMLRMargin;
    CGFloat submitSignWidth = submitSignSize.width;
    CGFloat submitSignHeight = submitSignSize.height;
    self.submitSignLabelFrame = CGRectMake(submitSignX, submitSignY, submitSignWidth, submitSignHeight);
    //提交人的具体内容frame
    CGFloat submitContentX = CGRectGetMaxX(self.submitSignLabelFrame) + OMMargin;
    CGFloat submitContentY = CGRectGetMaxY(self.orderContentLabelFrame) + OMLRMargin;
    CGFloat submitContentWidth = submitContentSize.width;
    CGFloat submitContentHeight = submitContentSize.height;
    self.submitContentLabelFrame = CGRectMake(submitContentX, submitContentY, submitContentWidth, submitContentHeight);
    //按钮
  
    //分割线
    self.primaryUnderLineFrame = CGRectMake(0, OMCellHeight - 0.4, SCREEN_WIDTH, 0.4);
    //cell的高度
    self.cellHeight = OMCellHeight;

    
}
@end
