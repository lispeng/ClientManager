//
//  OMDetailTableViewCell.m
//  ClientManager
//
//  Created by iOS－MacBook on 2017/5/18.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import "OMDetailTableViewCell.h"
#import "OMDetailModel.h"
#import "OMDetailModelFrame.h"
#import "OMAddModelFrame.h"
@interface OMDetailTableViewCell()
/**
 商品的预览图片
 */
@property (nonatomic,weak) UIImageView *commodityImageView;
/**
 商品信息
 */
@property (nonatomic,weak) UILabel *commodityInfoLabel;
/**
 赠品
 */
@property (nonatomic,weak) UILabel *commoditySignLabel;
/**
 成交价
 */
@property (nonatomic,weak) UILabel *dealPriceSignLabel;
/**
 成交具体价格
 */
@property (nonatomic,weak) UILabel *dealPriceLabel;
/**
 购买数量标签
 */
@property (nonatomic,weak) UILabel *buySignNumLabel;
/**
 购买数量
 */
@property (nonatomic,weak) UILabel *buyNumLabel;
/**
 <#annotation#>
 */
@property (nonatomic,weak) UIView *addOrderUnderLine;


@end

@implementation OMDetailTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupDetailTableViewCellSubviews];
    }
    return self;
}
- (void)setModelFrame:(OMDetailModelFrame *)modelFrame
{
    _modelFrame = modelFrame;
    OMDetailModel *model = modelFrame.model;
    //商品的缩略图
    self.commodityImageView.frame = modelFrame.commodityImageViewFrame;
    self.commodityImageView.image = [UIImage imageNamed:model.commodityUrl];
    //商品的信息
    self.commodityInfoLabel.frame = modelFrame.commodityInfoLabelFrame;
    self.commodityInfoLabel.text = model.commodityInfo;
    //赠品
    self.commoditySignLabel.frame = modelFrame.commoditySignLabelFrame;
    //成交价标签
    self.dealPriceSignLabel.frame = modelFrame.dealPriceSignLabelFrame;
    //成交价具体内容
    self.dealPriceLabel.frame = modelFrame.dealPriceLabelFrame;
    self.dealPriceLabel.text = model.dealPrice;
    //购买数量标签
    self.buySignNumLabel.frame = modelFrame.buySignNumLabelFrame;
    //购买数量具体内容
    self.buyNumLabel.frame = modelFrame.buyNumLabelFrame;
    self.buyNumLabel.text = model.buyNum;
    //底部的分割线
    self.addOrderUnderLine.frame = modelFrame.addOrderUnderLineFrame;
    NSLog(@"底部的分割线:%@",NSStringFromCGRect(self.addOrderUnderLine.frame));
    NSLog(@"jjkk");
}
- (void)setupDetailTableViewCellSubviews
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    //商品的图片
    UIImageView *commodityImageView = [[UIImageView alloc] init];
    commodityImageView.userInteractionEnabled = YES;
    //UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(commodityImageViewClick:)];
    //tap.numberOfTapsRequired = 1;
    //[commodityImageView addGestureRecognizer:tap];
    [self.contentView addSubview:commodityImageView];
    self.commodityImageView = commodityImageView;
    
    //商品信息（商品名、规格）
    UILabel *commodityInfoLabel = [[UILabel alloc] init];
    commodityInfoLabel.font = OMDetailFont;
    commodityInfoLabel.textColor = [UIColor blackColor];
    commodityInfoLabel.textAlignment = NSTextAlignmentLeft;
    commodityInfoLabel.numberOfLines = 0;
    [self.contentView addSubview:commodityInfoLabel];
    self.commodityInfoLabel = commodityInfoLabel;
    
    //是否是赠品的标签
    UILabel *commoditySignLabel = [[UILabel alloc] init];
    commoditySignLabel.font = OMSignFont;
    commoditySignLabel.textColor = [AppColor appMainColor];
    commoditySignLabel.textAlignment = NSTextAlignmentCenter;
    commoditySignLabel.numberOfLines = 0;
    commoditySignLabel.text = @"赠品";
    commoditySignLabel.layer.borderWidth = 1.2;
    commoditySignLabel.layer.borderColor = [UIColor redColor].CGColor;
    commoditySignLabel.layer.cornerRadius = 5;
    commoditySignLabel.layer.masksToBounds = YES;
    [self.contentView addSubview:commoditySignLabel];
    self.commoditySignLabel = commoditySignLabel;
    
    //成交价标签
    UILabel *dealPriceSignLabel = [[UILabel alloc] init];
    dealPriceSignLabel.font = OMDetailFont;
    dealPriceSignLabel.text = @"成交价:";
    dealPriceSignLabel.textColor = [UIColor blackColor];
    dealPriceSignLabel.textAlignment = NSTextAlignmentLeft;
    dealPriceSignLabel.numberOfLines = 0;
    [self.contentView addSubview:dealPriceSignLabel];
    self.dealPriceSignLabel = dealPriceSignLabel;
    //具体成交价格
    UILabel *dealPriceLabel = [[UILabel alloc] init];
    dealPriceLabel.font = OMDetailFont;
    dealPriceLabel.textColor = [UIColor blackColor];
    dealPriceLabel.textAlignment = NSTextAlignmentLeft;
    dealPriceLabel.numberOfLines = 0;
    [self.contentView addSubview:dealPriceLabel];
    self.dealPriceLabel = dealPriceLabel;
    
    //商品单位标签
    UILabel *buySignNumLabel = [[UILabel alloc] init];
    buySignNumLabel.font = OMDetailFont;
    buySignNumLabel.text = @"购买数量:";
    buySignNumLabel.textColor = [UIColor blackColor];
    buySignNumLabel.textAlignment = NSTextAlignmentLeft;
    buySignNumLabel.numberOfLines = 0;
    [self.contentView addSubview:buySignNumLabel];
    self.buySignNumLabel = buySignNumLabel;
    //商品的具体单位
    UILabel *buyNumLabel = [[UILabel alloc] init];
    buyNumLabel.font = OMDetailFont;
    buyNumLabel.textColor = [UIColor blackColor];
    buyNumLabel.textAlignment = NSTextAlignmentLeft;
    buyNumLabel.numberOfLines = 0;
    [self.contentView addSubview:buyNumLabel];
    self.buyNumLabel = buyNumLabel;
    
    //商品数量更改的容器
    //    UIView *commodityNumChangeContentView = [[UIView alloc] init];
    //    commodityNumChangeContentView.backgroundColor = [UIColor lightGrayColor];
    //    [self.contentView addSubview:commodityNumChangeContentView];
    //    self.commodityNumChangeContentView = commodityNumChangeContentView;
    
    //底部分割线
    UIView *addOrderUnderLine = [[UIView alloc] init];
    addOrderUnderLine.backgroundColor = [AppColor appTableCellSeparatLineColor];
    [self.contentView addSubview:addOrderUnderLine];
    self.addOrderUnderLine = addOrderUnderLine;

}
+ (instancetype)detailTableViewCellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"detailTableViewCell";
    OMDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (nil == cell) {
        cell = [[OMDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
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
