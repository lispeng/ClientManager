//
//  VIInquireTableViewCell.m
//  ClientManager
//*******************拜访查询的Cell***************
//  Created by iOS－MacBook on 2017/7/19.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import "VIInquireTableViewCell.h"
#import "VIInquireModel.h"
#import "VIInquireModelFrame.h"
#define InquireCellTopMargin 20
@interface VIInquireTableViewCell()


@end

@implementation VIInquireTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self setupInquireTableViewCellSubViews];
    }
    return self;
}

- (void)setModelFrame:(VIInquireModelFrame *)modelFrame
{
    _modelFrame = modelFrame;
    VIInquireModel *model = modelFrame.model;
    
    
}




- (void)setupInquireTableViewCellSubViews
{
    self.backgroundColor = [UIColor redColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIImageView *iconImageView = [[UIImageView alloc] init];
   // self.contentView addSubview:<#(nonnull UIView *)#>

}

+ (instancetype)inquireTableViewCellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"inquireTableViewCell";
    VIInquireTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[VIInquireTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;

}
- (void)setFrame:(CGRect)frame
{
    frame.origin.y += InquireCellTopMargin;
    frame.size.height = 100 - InquireCellTopMargin;
    [super setFrame:frame];
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
