//
//  OMAddOrderTableViewCell.m
//  ClientManager
//-----------新增订单的Cell----------------
//  Created by iOS－MacBook on 2017/5/11.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import "OMAddOrderTableViewCell.h"
#import "OMAddModel.h"
#import "OMAddModelFrame.h"
#define AddOrderFont [UIFont systemFontOfSize:15]
@interface OMAddOrderTableViewCell()
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
 商品单位
 */
@property (nonatomic,weak) UILabel *unitSignLabel;
/**
 商品具体单位
 */
@property (nonatomic,weak) UILabel *unitLabel;
/**
 商品数量更改容器
 */
//@property (nonatomic,weak) UIView *commodityNumChangeContentView;
/**
 底部的分割线
 */
@property (nonatomic,weak) UIView *addOrderUnderLine;

@end

@implementation OMAddOrderTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupAddOrderTableViewCellSubviews];
    }
    return self;
}
+ (instancetype)addOrderTableViewCellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"addOrderTableViewCell";
    OMAddOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (nil == cell) {
        cell = [[OMAddOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}
- (void)setupAddOrderTableViewCellSubviews
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    //商品的图片
    UIImageView *commodityImageView = [[UIImageView alloc] init];
    commodityImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(commodityImageViewClick:)];
    tap.numberOfTapsRequired = 1;
    [commodityImageView addGestureRecognizer:tap];
    [self.contentView addSubview:commodityImageView];
    self.commodityImageView = commodityImageView;
    
    //商品信息（商品名、规格）
    UILabel *commodityInfoLabel = [[UILabel alloc] init];
    commodityInfoLabel.font = AddOrderFont;
    commodityInfoLabel.textColor = [UIColor blackColor];
    //commodityInfoLabel.backgroundColor = [UIColor orangeColor];
    commodityInfoLabel.textAlignment = NSTextAlignmentLeft;
    commodityInfoLabel.numberOfLines = 2;
    [self.contentView addSubview:commodityInfoLabel];
    self.commodityInfoLabel = commodityInfoLabel;
    
    //是否是赠品的标签
    UILabel *commoditySignLabel = [[UILabel alloc] init];
    commoditySignLabel.font = AddOrderFont;
    commoditySignLabel.textColor = [UIColor redColor];
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
    dealPriceSignLabel.font = AddOrderFont;
    dealPriceSignLabel.text = @"成交价:";
    dealPriceSignLabel.textColor = [UIColor blackColor];
    dealPriceSignLabel.textAlignment = NSTextAlignmentLeft;
    dealPriceSignLabel.numberOfLines = 0;
    [self.contentView addSubview:dealPriceSignLabel];
    self.dealPriceSignLabel = dealPriceSignLabel;
    //具体成交价格
    UILabel *dealPriceLabel = [[UILabel alloc] init];
    dealPriceLabel.font = AddOrderFont;
    dealPriceLabel.textColor = [UIColor blackColor];
    dealPriceLabel.textAlignment = NSTextAlignmentLeft;
    dealPriceLabel.numberOfLines = 0;
    [self.contentView addSubview:dealPriceLabel];
    self.dealPriceLabel = dealPriceLabel;
    
    //商品单位标签
    UILabel *unitSignLabel = [[UILabel alloc] init];
    unitSignLabel.font = AddOrderFont;
    unitSignLabel.text = @"单位:";
    unitSignLabel.textColor = [UIColor blackColor];
    unitSignLabel.textAlignment = NSTextAlignmentLeft;
    unitSignLabel.numberOfLines = 0;
    [self.contentView addSubview:unitSignLabel];
    self.unitSignLabel = unitSignLabel;
    //商品的具体单位
    UILabel *unitLabel = [[UILabel alloc] init];
    unitLabel.font = AddOrderFont;
    unitLabel.textColor = [UIColor blackColor];
    unitLabel.textAlignment = NSTextAlignmentLeft;
    unitLabel.numberOfLines = 0;
    [self.contentView addSubview:unitLabel];
    self.unitLabel = unitLabel;
    
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
- (void)setModelFrame:(OMAddModelFrame *)modelFrame
{
    _modelFrame = modelFrame;
    OMAddModel *model = modelFrame.model;
    //商品的预览图片
    self.commodityImageView.image = [UIImage imageNamed:model.commodityUrl];
    self.commodityImageView.frame = modelFrame.commodityImageViewFrame;
    //商品信息
    self.commodityInfoLabel.text = model.commodityInfo;
    CGRect comFrame = modelFrame.commodityInfoLabelFrame;
    CGPoint comPoint = comFrame.origin;

    NSString *str = @"商品信息";
    CGSize strSize = [str sizeWithFont:OMDetailFont];
    if (comFrame.size.height > strSize.height) {
        comPoint = CGPointMake(comPoint.x, comPoint.y - 38);
    }
     self.commodityInfoLabel.frame = CGRectMake(comPoint.x, comPoint.y, comFrame.size.width, comFrame.size.height);
    [self.commoditySignLabel sizeToFit];

    NSLog(@"self.commoditySignLabel.frame = %@",NSStringFromCGRect(self.commoditySignLabel.frame));
    NSLog(@"vff");
   // self.commoditySignLabel.contentMode = UIViewContentModeTop;
   // self.commodityInfoLabel.frame = modelFrame.commodityInfoLabelFrame;
    
    //商品价格
    self.dealPriceSignLabel.frame = modelFrame.dealPriceSignLabelFrame;
    
    self.dealPriceLabel.text = model.commodityPrice;
    self.dealPriceLabel.frame = modelFrame.dealPriceLabelFrame;
    
    //商品的单位
    self.unitSignLabel.frame = modelFrame.unitSignLabelFrame;
    
    self.unitLabel.text = model.commodityUnit;
    self.unitLabel.frame = modelFrame.unitLabelFrame;
    
    //是否为赠品的显示
    self.commoditySignLabel.frame = modelFrame.commoditySignLabelFrame;
    
    //更改商品数量的控件
   // self.commodityNumChangeContentView.frame = modelFrame.commodityNumChangeContentViewFrame;
    //底部的分割线
    self.addOrderUnderLine.frame = modelFrame.addOrderUnderLineFrame;
}
/**
 点击商品的图片

 @param tap <#tap description#>
 */
- (void)commodityImageViewClick:(UIGestureRecognizer *)tap
{
    NSLog(@"commodityImageViewClick");
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
