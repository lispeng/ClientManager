//
//  OMSubmitTableViewCell.m
//  ClientManager
//
//  Created by iOS－MacBook on 2017/5/10.
//  Copyright © 2017年 Lispeng. All rights reserved.
//-------------提交的Cell------------

#import "OMSubmitTableViewCell.h"
#import "OMSubmitModel.h"
#import "OMSubmitModelFrame.h"
@interface OMSubmitTableViewCell()
/**
 审批按钮
 */
@property (nonatomic,weak) UILabel *examineLabel;

@end

@implementation OMSubmitTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupSubmitTableViewCellExamineBtn];
    }
    return self;
}
- (void)setupSubmitTableViewCellExamineBtn
{
    
    self.examineLabel = PrimaryTableViewCellSignUnpendType;//默认是未同意
    UILabel *examineLabel = [[UILabel alloc] init];
    examineLabel.text = @"未同意";
    examineLabel.font = OMBtnFont;
    examineLabel.textColor = [UIColor orangeColor];
    examineLabel.textAlignment = NSTextAlignmentCenter;

    //////////////////////////////
    examineLabel.layer.cornerRadius = 3;
    examineLabel.layer.masksToBounds = YES;
    examineLabel.layer.borderWidth = 0.9;
    examineLabel.layer.borderColor = [UIColor orangeColor].CGColor;
    ///////////////////////////////////////////
    [self.contentView addSubview:examineLabel];
    self.examineLabel = examineLabel;
}
-(void)setModelFrame:(OMSubmitModelFrame *)modelFrame
{
    _modelFrame = modelFrame;
    OMSubmitModel *model = modelFrame.model;
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
    //按钮
    self.examineLabel.frame = modelFrame.pendLabelFrame;
    //分割线
    self.primaryUnderLine.frame = modelFrame.primaryUnderLineFrame;
}
- (void)submitTableViewCellExamineBtnClick:(UIButton *)sender
{
    NSLog(@"submitTableViewCellExamineBtnClick");
}
- (void)setSignType:(PrimaryTableViewCellSignType)signType
{
    _signType = signType;
    if (signType == PrimaryTableViewCellSignUnpendType) { //未同意
       
        self.examineLabel.text = @"未同意";
        self.examineLabel.layer.cornerRadius = 3;
        self.examineLabel.layer.masksToBounds = YES;
        self.examineLabel.layer.borderWidth = 0.9;
        self.examineLabel.layer.borderColor = [UIColor orangeColor].CGColor;

    }else if(signType == PrimaryTableViewCellSignAgreeType)//已同意
    {
      
        self.examineLabel.text = @"已同意";
        self.examineLabel.layer.cornerRadius = 3;
        self.examineLabel.layer.masksToBounds = YES;
        self.examineLabel.layer.borderWidth = 0.9;
        self.examineLabel.layer.borderColor = [UIColor greenColor].CGColor;

    }else if(signType == PrimaryTableViewCellSignUnagreeType)//已拒绝
    {
        self.examineLabel.text = @"已拒绝";
        self.examineLabel.layer.cornerRadius = 3;
        self.examineLabel.layer.masksToBounds = YES;
        self.examineLabel.layer.borderWidth = 0.9;
        self.examineLabel.layer.borderColor = [UIColor redColor].CGColor;

    }
}
+ (instancetype)submitTableViewCellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"submitTableViewCell";
    
    OMSubmitTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[OMSubmitTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    return cell;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
