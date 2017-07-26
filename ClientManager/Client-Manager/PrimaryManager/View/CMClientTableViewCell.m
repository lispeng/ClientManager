//
//  CMClientTableViewCell.m
//  ClientManager
//
//  Created by iOS－MacBook on 2017/7/14.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import "CMClientTableViewCell.h"
#import "CMClientModel.h"
#import "CMClientModelFrame.h"

#define CMClientCellHeight 80
@interface CMClientTableViewCell()
/**
 客户名称
 */
@property (nonatomic,weak) UILabel *clientNameLabel;
/**
 客户负责人
 */
@property (nonatomic,weak) UILabel *managerDescriptionLabel;

/**
 坐标转换的客户地址
 */
@property (nonatomic,weak) UILabel *coordinateAddressLabel;
/**
 退回天数
 */
@property (nonatomic,weak) UILabel *returnDaysLabel;
/**
 几次拜访
 */
@property (nonatomic,weak) UILabel *visitCountLabel;
/**
 几次未拜访
 */
@property (nonatomic,weak) UILabel *noVisitDaysLabel;
/**
 拜访次数与未拜访天数
 */
@property (nonatomic,weak) UILabel *countOrDaysLabel;
/**
 底部的分割线
 */
@property (nonatomic,weak) UIView *underLine;

@end

@implementation CMClientTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupCMClientTableViewCellSubviews];
    }
    return self;
}
- (void)setModelFrame:(CMClientModelFrame *)modelFrame
{
    _modelFrame = modelFrame;
    CMClientModel *model = modelFrame.model;
    
    //客户名称
    NSString *clientNameStr = model.custName;
    self.clientNameLabel.frame = modelFrame.clientNameLabelFrame;
    self.clientNameLabel.text = clientNameStr;
    
    //客户负责人
    NSString *managerStr = model.managerDescription;
    self.managerDescriptionLabel.frame = modelFrame.managerDescriptionLabelFrame;
    self.managerDescriptionLabel.text = managerStr;
    
    //坐标转换的客户地址
    NSString *coordinateAddressStr = model.address;
    if (nil == coordinateAddressStr || 0 == coordinateAddressStr.length) {
        coordinateAddressStr = model.coordinateAddress;
    }
    if (nil == coordinateAddressStr || 0 == coordinateAddressStr.length) {
        coordinateAddressStr = @"暂无位置坐标";
    }
    self.coordinateAddressLabel.frame = modelFrame.coordinateAddressLabelFrame;
    self.coordinateAddressLabel.text = coordinateAddressStr;
    
    
    //退回天数
    if(model.returnDays != nil)
    {
     NSString *returnDaysStr = [NSString stringWithFormat:@"%@天后退回",model.returnDays];
    self.returnDaysLabel.frame = modelFrame.returnDaysLabelFrame;
    self.returnDaysLabel.text = returnDaysStr;
    }
    //拜访次数与未拜访天数
    if (nil == model.visitCount || model.visitCount.length == 0) {
        
        model.visitCount = @"0";
    }
    if (nil == model.noVisitDays || 0 == model.noVisitDays) {
        model.noVisitDays = @"0";
    }
    NSString *countOrDaysStr = [NSString stringWithFormat:@"%@次拜访  %@天未拜访",model.visitCount,model.noVisitDays];
    self.countOrDaysLabel.frame = modelFrame.countOrDaysLabelFrame;
    if (nil == model.returnDays) {
        self.countOrDaysLabel.textAlignment = NSTextAlignmentLeft;
    }
    self.countOrDaysLabel.text = countOrDaysStr;
    
    //
    self.underLine.frame = modelFrame.underLineFrame;
    
}

+ (instancetype)clientTableViewCellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"OMClientTableViewCell";
    CMClientTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[CMClientTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;

}
- (void)setupCMClientTableViewCellSubviews
{
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    //客户名称
    UILabel *clientNameLabel = [[UILabel alloc] init];
    clientNameLabel.font = CMTitleFont;
    clientNameLabel.textColor = [UIColor blackColor];
    clientNameLabel.textAlignment = NSTextAlignmentLeft;
    //clientNameLabel.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:clientNameLabel];
    self.clientNameLabel = clientNameLabel;
    
    //客户负责人
    UILabel *managerDescriptionLabel = [[UILabel alloc] init];
    managerDescriptionLabel.font = ComAttFont;
    managerDescriptionLabel.textColor = [UIColor blackColor];
    managerDescriptionLabel.textAlignment = NSTextAlignmentLeft;
    //managerDescriptionLabel.backgroundColor = [UIColor blueColor];

    [self.contentView addSubview:managerDescriptionLabel];
    self.managerDescriptionLabel = managerDescriptionLabel;
    
    // 坐标转换的客户地址
    UILabel *coordinateAddressLabel = [[UILabel alloc] init];
    coordinateAddressLabel.font = ComFont;
    coordinateAddressLabel.textColor = [UIColor lightGrayColor];
    coordinateAddressLabel.textAlignment = NSTextAlignmentLeft;
    //coordinateAddressLabel.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:coordinateAddressLabel];
    self.coordinateAddressLabel = coordinateAddressLabel;
    
    // 多少天后退回
    UILabel *returnDaysLabel = [[UILabel alloc] init];
    returnDaysLabel.font = ComFont;
    returnDaysLabel.textColor = [UIColor grayColor];
    returnDaysLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:returnDaysLabel];
    self.returnDaysLabel = returnDaysLabel;

    // 拜访次数，未拜访天数
    UILabel *countOrDaysLabel = [[UILabel alloc] init];
    countOrDaysLabel.font = ComFont;
    countOrDaysLabel.textColor = [UIColor orangeColor];
    countOrDaysLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:countOrDaysLabel];
    self.countOrDaysLabel = countOrDaysLabel;

    
    //底部分割线
    UIView *underLine = [[UIView alloc] init];
    underLine.backgroundColor = [AppColor appTableCellSeparatLineColor];
    [self.contentView addSubview:underLine];
    self.underLine = underLine;


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
