//
//  CIInquireTableViewCell.m
//  ClientManager
//
//  Created by iOS－MacBook on 2017/7/20.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import "CIInquireTableViewCell.h"
#import "CIModel.h"
#import "CIModelFrame.h"
@interface CIInquireTableViewCell()
/**
 客户名
 */
@property (nonatomic,weak) UILabel *custNameLabel;
/**
 客户负责人
 */
@property (nonatomic,weak) UILabel *managerDescriptionLabel;
/**
 坐标转换的客户地址
 */
@property (nonatomic,weak) UILabel *addressLabel;
/**
 <#annotation#>
 */
@property (nonatomic,weak) UIView *underLine;


@end

@implementation CIInquireTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupInquireTableViewCellSubviews];
    }
    return self;
}
- (void)setModelFrame:(CIModelFrame *)modelFrame
{
    _modelFrame = modelFrame;
    CIModel *model = modelFrame.model;
    
    //客户名称
    NSString *clientNameStr = model.custName;
    self.custNameLabel.frame = modelFrame.custNameLabelFrame;
    self.custNameLabel.text = clientNameStr;
    
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
    self.addressLabel.frame = modelFrame.addressLabelFrame;
    self.addressLabel.text = coordinateAddressStr;
    
    //底部分割线
    self.underLine.frame = modelFrame.underLineFrame;

}
+ (instancetype)inquireTableViewCellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"inquireTableViewCell";
    CIInquireTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[CIInquireTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;

}

- (void)setupInquireTableViewCellSubviews
{
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //客户名称
    UILabel *custNameLabel = [[UILabel alloc] init];
    custNameLabel.font = CMTitleFont;
    custNameLabel.textColor = [UIColor blackColor];
    custNameLabel.textAlignment = NSTextAlignmentLeft;
    //clientNameLabel.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:custNameLabel];
    self.custNameLabel = custNameLabel;
    
    //客户负责人
    UILabel *managerDescriptionLabel = [[UILabel alloc] init];
    managerDescriptionLabel.font = ComAttFont;
    managerDescriptionLabel.textColor = [UIColor blackColor];
    managerDescriptionLabel.textAlignment = NSTextAlignmentLeft;
    //managerDescriptionLabel.backgroundColor = [UIColor blueColor];
    
    [self.contentView addSubview:managerDescriptionLabel];
    self.managerDescriptionLabel = managerDescriptionLabel;
    
    // 客户地址
    UILabel *addressLabel = [[UILabel alloc] init];
    addressLabel.font = ComFont;
    addressLabel.textColor = [UIColor lightGrayColor];
    addressLabel.textAlignment = NSTextAlignmentLeft;
    //coordinateAddressLabel.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:addressLabel];
    self.addressLabel = addressLabel;

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
