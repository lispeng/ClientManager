//
//  OMPendingTableViewCell.m
//  ClientManager
//
//  Created by iOS－MacBook on 2017/5/10.
//  Copyright © 2017年 Lispeng. All rights reserved.
//----------------待审批的Cell

#import "OMPendingTableViewCell.h"
#import "OMPendingModel.h"
#import "OMPendingModelFrame.h"
@interface OMPendingTableViewCell()


@end
@implementation OMPendingTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    }
    return self;
}
+ (instancetype)pendingTableViewCellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"pendingTableViewCell";
    
    OMPendingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        
        cell = [[OMPendingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    return cell;
}
- (void)setModelFrame:(OMPendingModelFrame *)modelFrame
{
    _modelFrame = modelFrame;
    OMPendingModel *model = modelFrame.model;
    
    //客户
    self.clientSignLabel.frame = modelFrame.clientSignLabelFrame;
    self.clientContentLabel.text = model.clientName;
    self.clientContentLabel.frame = modelFrame.clientContentLabelFrame;
    
    //订单
    self.orderSignLabel.frame = modelFrame.orderSignLabelFrame;
    self.orderContentLabel.text = model.orderMoney;
    self.orderContentLabel.frame = modelFrame.orderContentLabelFrame;
    
    //提交日期
    self.submitDateSignLabel.frame = modelFrame.submitDateSignLabelFrame;
    
    self.submitDateContentLabel.text = model.submitDate;
    self.submitDateContentLabel.frame = modelFrame.submitDateContentLabelFrame;
    
    //提交人
    self.submitSignLabel.frame = modelFrame.submitSignLabelFrame;
    self.submitContentLabel.text = model.submitPeople;
    self.submitContentLabel.frame = modelFrame.submitContentLabelFrame;
    
    //分割线
    self.primaryUnderLine.frame = modelFrame.primaryUnderLineFrame;

    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
