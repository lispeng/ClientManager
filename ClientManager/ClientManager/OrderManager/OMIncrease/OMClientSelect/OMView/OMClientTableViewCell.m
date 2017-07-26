//
//  OMClientTableViewCell.m
//  ClientManager
//
//  Created by iOS－MacBook on 2017/5/22.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import "OMClientTableViewCell.h"
#import "OMClientModel.h"
@interface OMClientTableViewCell()
/**
 <#annotation#>
 */
@property (nonatomic,weak) UILabel *clientLabel;
/**
 <#annotation#>
 */
@property (nonatomic,weak) UIView *underLine;


@end

@implementation OMClientTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupClientTableViewCellSubviews];
    }
    return self;
}
- (void)setupClientTableViewCellSubviews
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    //客户名
    UILabel *clientLabel = [[UILabel alloc] init];
    clientLabel.font = OMDetailFont;
    clientLabel.textColor = [UIColor blackColor];
    clientLabel.textAlignment = NSTextAlignmentLeft;
    clientLabel.numberOfLines = 0;
    [self.contentView addSubview:clientLabel];
    self.clientLabel = clientLabel;
    //底部的分割线
    UIView *underLine = [[UIView alloc] init];
    underLine.backgroundColor = [AppColor appTableCellSeparatLineColor];
    [self.contentView addSubview:underLine];
    self.underLine = underLine;
}
- (void)setModel:(OMClientModel *)model
{
    _model = model;
    //客户名frame
    CGFloat clientLabelX = OMDetailMargin;
    CGFloat clientLabelY = 0;
    CGFloat clientLabelWidth = SCREEN_WIDTH - OMDetailMargin * 2;
    CGFloat OMDetailMargiHeight = OMDetailH;
    self.clientLabel.frame = CGRectMake(clientLabelX, clientLabelY, clientLabelWidth, OMDetailMargiHeight);
    self.clientLabel.text = model.client;
    //分割线的Frame
    CGFloat underLineX = 0;
    CGFloat underLineY = OMDetailH - 0.4;
    CGFloat underLineWidth = SCREEN_WIDTH;
    CGFloat underLineHeight = 0.4;
    self.underLine.frame = CGRectMake(underLineX, underLineY, underLineWidth, underLineHeight);
}
+ (instancetype)clientTableViewCellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"clientTableViewCell";
    OMClientTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (nil == cell) {
        cell = [[OMClientTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
