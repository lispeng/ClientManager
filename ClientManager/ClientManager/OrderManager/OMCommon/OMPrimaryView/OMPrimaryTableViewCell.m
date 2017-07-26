//
//  OMPrimaryTableViewCell.m
//  ClientManager
//
//  Created by iOS－MacBook on 2017/5/10.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import "OMPrimaryTableViewCell.h"

#define OMPrimaryColor [UIColor grayColor]
@interface OMPrimaryTableViewCell()


@end

@implementation OMPrimaryTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupPrimaryTableViewCellSubviews];
    }
    return self;
}
- (void)setupPrimaryTableViewCellSubviews
{
    
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    //客户
    UILabel *clientSignLabel = [[UILabel alloc] init];
    clientSignLabel.font = OMClientTitleFont;
    clientSignLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    clientSignLabel.textColor = [UIColor blackColor];
    clientSignLabel.textAlignment = NSTextAlignmentLeft;
    //clientNameLabel.numberOfLines = 0;
    //clientNameLabel.backgroundColor = [UIColor orangeColor];//背景色
    clientSignLabel.text = @"客户:";
    [self.contentView addSubview:clientSignLabel];
    self.clientSignLabel = clientSignLabel;
    
    //客户的名称
    UILabel *clientContentLabel = [[UILabel alloc] init];
    clientContentLabel.font = OMClientTitleFont;
    clientContentLabel.textColor = [UIColor blackColor];
    clientContentLabel.textAlignment = NSTextAlignmentLeft;
    //clientNameLabel.numberOfLines = 0;
    clientContentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    //clientNameLabel.backgroundColor = [UIColor orangeColor];//背景色
    [self.contentView addSubview:clientContentLabel];
    self.clientContentLabel = clientContentLabel;
    
    
    //订单金额
    UILabel *orderSignLabel = [[UILabel alloc] init];
    orderSignLabel.font = OMFont;
    orderSignLabel.textColor = OMPrimaryColor;
    orderSignLabel.textAlignment = NSTextAlignmentLeft;
    //clientNameLabel.numberOfLines = 0;
    //clientNameLabel.backgroundColor = [UIColor orangeColor];//背景色
    orderSignLabel.text = @"订单金额:";
    [self.contentView addSubview:orderSignLabel];
    self.orderSignLabel = orderSignLabel;
    
    //订单具体金额
    UILabel *orderContentLabel = [[UILabel alloc] init];
    orderContentLabel.font = OMFont;
    orderContentLabel.textColor = OMPrimaryColor;
    orderContentLabel.textAlignment = NSTextAlignmentLeft;
    //clientNameLabel.numberOfLines = 0;
    //orderContentLabel.backgroundColor = [UIColor blueColor];//背景色
    [self.contentView addSubview:orderContentLabel];
    self.orderContentLabel = orderContentLabel;

    
    //提交日期
    UILabel *submitDateSignLabel = [[UILabel alloc] init];
    submitDateSignLabel.font = OMFont;
    submitDateSignLabel.textColor = OMPrimaryColor;
    submitDateSignLabel.textAlignment = NSTextAlignmentLeft;
    //clientNameLabel.numberOfLines = 0;
    submitDateSignLabel.text = @"提交日期:";
    [self.contentView addSubview:submitDateSignLabel];
    self.submitDateSignLabel = submitDateSignLabel;
    
    //提交日期具体内容
    UILabel *submitDateContentLabel = [[UILabel alloc] init];
    submitDateContentLabel.font = OMFont;
    submitDateContentLabel.textColor = OMPrimaryColor;
    submitDateContentLabel.textAlignment = NSTextAlignmentLeft;
    //clientNameLabel.numberOfLines = 0;
    //submitDateContentLabel.backgroundColor = [UIColor orangeColor];//背景色
    [self.contentView addSubview:submitDateContentLabel];
    self.submitDateContentLabel = submitDateContentLabel;
   
    
    //提交人
    UILabel *submitSignLabel = [[UILabel alloc] init];
    submitSignLabel.font = OMFont;
    submitSignLabel.textColor = OMPrimaryColor;
    submitSignLabel.textAlignment = NSTextAlignmentLeft;
    //clientNameLabel.numberOfLines = 0;
    //clientNameLabel.backgroundColor = [UIColor orangeColor];//背景色
    submitSignLabel.text = @"提交人:";
    [self.contentView addSubview:submitSignLabel];
    self.submitSignLabel = submitSignLabel;
    
    //提交人具体内容
    UILabel *submitContentLabel = [[UILabel alloc] init];
    submitContentLabel.font = OMFont;
    submitContentLabel.textColor = OMPrimaryColor;
    submitContentLabel.textAlignment = NSTextAlignmentLeft;
    //clientNameLabel.numberOfLines = 0;
    //clientNameLabel.backgroundColor = [UIColor orangeColor];//背景色
    [self.contentView addSubview:submitContentLabel];
    self.submitContentLabel = submitContentLabel;
    
    
    //底部分割线
    UIView *primaryUnderLine = [[UIView alloc] init];
    primaryUnderLine.backgroundColor = [AppColor appTableCellSeparatLineColor];
    [self.contentView addSubview:primaryUnderLine];
    self.primaryUnderLine = primaryUnderLine;
    
    
    
 
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
