//
//  OMStorehouseTableViewCell.m
//  ClientManager
//--------------仓库选择的Cell--------------
//  Created by iOS－MacBook on 2017/5/23.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import "OMStorehouseTableViewCell.h"
#import "OMStoreModel.h"
@interface OMStorehouseTableViewCell()
/**
 <#annotation#>
 */
@property (nonatomic,weak) UILabel *storeLabel;
/**
 <#annotation#>
 */
@property (nonatomic,weak) UIView *underLine;


@end
@implementation OMStorehouseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupStorehouseTableViewCellSubviews];
    }
    return self;
}

- (void)setModel:(OMStoreModel *)model
{
    _model = model;
    //仓库名的Frame
    CGFloat storeLabelX = OMDetailMargin;
    CGFloat storeLabelY = 0;
    CGFloat storeLabelWidth = SCREEN_WIDTH - OMDetailMargin * 2;
    CGFloat storeLabelHeight = OMDetailH;
    self.storeLabel.frame = CGRectMake(storeLabelX, storeLabelY, storeLabelWidth, storeLabelHeight);
    self.storeLabel.text = model.storehouse;
    //下方的分割线frame
    CGFloat underLineX = 0;
    CGFloat underLineY = OMDetailH - 0.4;
    CGFloat underLineWidth = SCREEN_WIDTH;
    CGFloat underLineHeight = 0.4;
    self.underLine.frame = CGRectMake(underLineX, underLineY, underLineWidth, underLineHeight);
}
+ (instancetype)storehouseTableViewCellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"storehouseTableViewCell";
    OMStorehouseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[OMStorehouseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (void)setupStorehouseTableViewCellSubviews
{
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    //仓库名
    UILabel *storeLabel = [[UILabel alloc] init];
    storeLabel.font = OMDetailFont;
    storeLabel.textColor = [UIColor blackColor];
    storeLabel.textAlignment = NSTextAlignmentLeft;
    //clientNameLabel.numberOfLines = 0;
    //orderContentLabel.backgroundColor = [UIColor blueColor];//背景色
    [self.contentView addSubview:storeLabel];
    self.storeLabel = storeLabel;
    //下方分割线
    UIView *underLine = [[UIView alloc] init];
    underLine.backgroundColor = [AppColor appTableCellSeparatLineColor];
    [self.contentView addSubview:underLine];
    self.underLine = underLine;

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
