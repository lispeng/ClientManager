//
//  LSPFoldTableViewCell.m
//  ClientManager
//
//  Created by iOS－MacBook on 2017/5/26.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import "LSPFoldTableViewCell.h"
#import "ModelFrame.h"
#import "Model.h"
@interface LSPFoldTableViewCell()
/**
 <#annotation#>
 */
@property (nonatomic,weak) UIImageView *imageViews;
/**
 <#annotation#>
 */
@property (nonatomic,weak) UILabel *nameLabel;
/**
 <#annotation#>
 */
@property (nonatomic,weak) UILabel *infoLabel;


@end

@implementation LSPFoldTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupFoldTableViewCellSubviews];
    }
    return self;
}
- (void)setModelFrame:(ModelFrame *)modelFrame
{
    _modelFrame = modelFrame;
    Model *model = modelFrame.model;
    
    self.imageViews.frame = modelFrame.imageViewFrame;
    self.imageViews.image = [UIImage imageNamed:model.imageUrl];
   // self.imageView.image = [UIImage imageNamed:@"2.jpg"];

    self.nameLabel.frame = modelFrame.nameLabelFrame;
    self.nameLabel.text = model.name;
    
    self.infoLabel.frame = modelFrame.infoLabelFrame;
    self.infoLabel.text = model.info;
    
    UIView *underLine = [[UIView alloc] init];
    underLine.backgroundColor = [AppColor appTableCellSeparatLineColor];
    underLine.frame = modelFrame.underLineFrame;
    [self.contentView addSubview:underLine];
}

- (void)setupFoldTableViewCellSubviews
{
    UIImageView *imageViews = [[UIImageView alloc] init];
    imageViews.contentMode = UIViewContentModeCenter;
    imageViews.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:imageViews];
    self.imageViews = imageViews;
    
    //具体成交价格
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = OMDetailFont;
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.numberOfLines = 0;
    [self.contentView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    
    UILabel *infoLabel = [[UILabel alloc] init];
    infoLabel.font = OMDetailFont;
    infoLabel.textColor = [UIColor blackColor];
    infoLabel.textAlignment = NSTextAlignmentLeft;
    infoLabel.numberOfLines = 0;
    [self.contentView addSubview:infoLabel];
    self.infoLabel = infoLabel;



}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+ (instancetype)foldTableViewCellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"foldTableViewCell";
    LSPFoldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[LSPFoldTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
