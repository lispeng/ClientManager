//
//  OMBaseDetailHeaderView.m
//  ClientManager
//+++++++++++++订单详情的基类tableHeaderView
//  Created by iOS－MacBook on 2017/5/18.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import "OMBaseDetailHeaderView.h"
#import "OMDetailModel.h"
#import "NSString+Extension.h"
@interface OMBaseDetailHeaderView()
/**
 <#annotation#>
 */
@property (nonatomic,weak) UIView *contentView;

@end
@implementation OMBaseDetailHeaderView
- (instancetype)init
{
    if (self = [super init]) {
        [self setupBaseDetailHeaderViewSubviews];
    }
    return self;
}
- (void)setupBaseDetailHeaderViewSubviews
{
    self.backgroundColor = [AppColor appTableViewBackgroundColor];
    //背景VIew
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:contentView];
    self.contentView = contentView;
    //提交人标签
    UILabel *commitSignLabel = [[UILabel alloc] init];
    commitSignLabel.textColor = [UIColor blackColor];
    commitSignLabel.font = OMDetailFont;
    commitSignLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:commitSignLabel];
    self.commitSignLabel = commitSignLabel;
    //提交人
    UILabel *commitLabel = [[UILabel alloc] init];
    commitLabel.textColor = [UIColor lightGrayColor];
    commitLabel.font = OMDetailFont;
    commitLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:commitLabel];
    self.commitLabel = commitLabel;
    //-----
    //客户名称标签
    UILabel *clientSignLabel = [[UILabel alloc] init];
    clientSignLabel.textColor = [UIColor blackColor];
    clientSignLabel.font = OMDetailFont;
    clientSignLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:clientSignLabel];
    self.clientSignLabel = clientSignLabel;
    //客户名称
    UILabel *clientLabel = [[UILabel alloc] init];
    clientLabel.textColor = [UIColor lightGrayColor];
    clientLabel.font = OMDetailFont;
    clientLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:clientLabel];
    self.clientLabel = clientLabel;
    //----------------
    //收货人标签
    UILabel *receiverSignLabel = [[UILabel alloc] init];
    receiverSignLabel.textColor = [UIColor blackColor];
    receiverSignLabel.font = OMDetailFont;
    receiverSignLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:receiverSignLabel];
    self.receiverSignLabel = receiverSignLabel;
    //收货人
    UILabel *receiverLabel = [[UILabel alloc] init];
    receiverLabel.textColor = [UIColor lightGrayColor];
    receiverLabel.font = OMDetailFont;
    receiverLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:receiverLabel];
    self.receiverLabel = receiverLabel;
   //-----------------------------
    //收货人电话标签
    UILabel *receiverSignNumLabel = [[UILabel alloc] init];
    receiverSignNumLabel.textColor = [UIColor blackColor];
    receiverSignNumLabel.font = OMDetailFont;
    receiverSignNumLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:receiverSignNumLabel];
    self.receiverSignNumLabel = receiverSignNumLabel;
    //收货人电话
    UILabel *receiverNumLabel = [[UILabel alloc] init];
    receiverNumLabel.textColor = [UIColor lightGrayColor];
    receiverNumLabel.font = OMDetailFont;
    receiverNumLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:receiverNumLabel];
    self.receiverNumLabel = receiverNumLabel;

}
- (void)setModel:(OMDetailModel *)model
{
    _model = model;
    //提交人标签
    NSString *commitSignStr = @"提交人";
    CGSize commitSignSize = [commitSignStr sizeWithFont:OMDetailFont];
    CGFloat commitSignX = OMDetailMargin;
    CGFloat commitSignY = 0;
    CGFloat commitSignWidth = commitSignSize.width;
    CGFloat commitSignHeight = OMDetailH;
    self.commitSignLabel.frame = CGRectMake(commitSignX, commitSignY, commitSignWidth, commitSignHeight);
    self.commitSignLabel.text = commitSignStr;
    
    //提交人
    NSString *commitStr = model.commiter;
   // CGSize commitSize = [commitSignStr sizeWithFont:OMDetailFont];
    CGFloat commitWidth = SCREEN_WIDTH - commitSignWidth - OMDetailMargin * 2 - OMDetailContentMargin;
    CGFloat commitHeight = OMDetailH;
    CGFloat commitX = SCREEN_WIDTH - commitWidth - OMDetailMargin;
    CGFloat commitY = 0;
    self.commitLabel.frame = CGRectMake(commitX, commitY, commitWidth, commitHeight);
    self.commitLabel.text = commitStr;
    //提交人底部分割线
    UIView *commitLine = [[UIView alloc] init];
    commitLine.backgroundColor = [AppColor appTableCellSeparatLineColor];
    commitLine.frame = CGRectMake(0, OMDetailH - 0.4, SCREEN_WIDTH, 0.4);
    [self.contentView addSubview:commitLine];
    //-----
    //客户名称标签
    NSString *clientSignStr = @"客户名称";
    CGSize clientSignSize = [clientSignStr sizeWithFont:OMDetailFont];
    CGFloat clientSignX = OMDetailMargin;
    CGFloat clientSignY = CGRectGetMaxY(self.commitSignLabel.frame) + 0.4;
    CGFloat clientSignWidth = clientSignSize.width;
    CGFloat clientSignHeight = OMDetailH;
    self.clientSignLabel.frame = CGRectMake(clientSignX, clientSignY, clientSignWidth, clientSignHeight);
    self.clientSignLabel.text = clientSignStr;
    //客户名称
    NSString *clientStr = model.clientName;
    // CGSize commitSize = [commitSignStr sizeWithFont:OMDetailFont];
    CGFloat clientWidth = SCREEN_WIDTH - clientSignWidth - OMDetailMargin * 2 - OMDetailContentMargin;
    CGFloat clientHeight = OMDetailH;
    CGFloat clientX = SCREEN_WIDTH - clientWidth - OMDetailMargin;
    CGFloat clientY = clientSignY;
    self.clientLabel.frame = CGRectMake(clientX, clientY, clientWidth, clientHeight);
    self.clientLabel.text = clientStr;
    //客户名称底部分割线
    UIView *clientLine = [[UIView alloc] init];
    clientLine.backgroundColor = [AppColor appTableCellSeparatLineColor];
    clientLine.frame = CGRectMake(0, OMDetailH * 2 - 0.4, SCREEN_WIDTH, 0.4);
    [self.contentView addSubview:clientLine];

    //----------------
    //收货人标签
    NSString *receiverSignStr = @"收货人";
    CGSize receiverSignSize = [receiverSignStr sizeWithFont:OMDetailFont];
    CGFloat receiverSignX = OMDetailMargin;
    CGFloat receiverSignY = CGRectGetMaxY(self.clientSignLabel.frame) + 0.4;
    CGFloat receiverSignWidth = receiverSignSize.width;
    CGFloat receiverSignHeight = OMDetailH;
    self.receiverSignLabel.frame = CGRectMake(receiverSignX, receiverSignY, receiverSignWidth, receiverSignHeight);
    self.receiverSignLabel.text = receiverSignStr;
    //收货人
    NSString *receiverStr = model.receiver;
    // CGSize commitSize = [commitSignStr sizeWithFont:OMDetailFont];
    CGFloat receiverWidth = SCREEN_WIDTH - receiverSignWidth - OMDetailMargin * 2 - OMDetailContentMargin;
    CGFloat receiverHeight = OMDetailH;
    CGFloat receiverX = SCREEN_WIDTH - receiverWidth - OMDetailMargin;
    CGFloat receiverY = receiverSignY;
    self.receiverLabel.frame = CGRectMake(receiverX, receiverY, receiverWidth, receiverHeight);
    self.receiverLabel.text = receiverStr;
    //客户名称底部分割线
    UIView *receiverLine = [[UIView alloc] init];
    receiverLine.backgroundColor = [AppColor appTableCellSeparatLineColor];
    receiverLine.frame = CGRectMake(0, OMDetailH * 3 - 0.4, SCREEN_WIDTH, 0.4);
    [self.contentView addSubview:receiverLine];

    //-----------------------------
    //收货人电话标签
    NSString *receiverSignNumStr = @"收货人电话";
    CGSize receiverSignNumSize = [receiverSignNumStr sizeWithFont:OMDetailFont];
    CGFloat receiverSignNumX = OMDetailMargin;
    CGFloat receiverSignNumY = CGRectGetMaxY(self.receiverSignLabel.frame) + 0.4;
    CGFloat receiverSignNumWidth = receiverSignNumSize.width;
    CGFloat receiverSignNumHeight = OMDetailH;
    self.receiverSignNumLabel.frame = CGRectMake(receiverSignNumX, receiverSignNumY, receiverSignNumWidth, receiverSignNumHeight);
    self.receiverSignNumLabel.text = receiverSignNumStr;
    //收货人电话
    NSString *receiverNumStr = model.receiverTelNum;
    // CGSize commitSize = [commitSignStr sizeWithFont:OMDetailFont];
    CGFloat receiverNumWidth = SCREEN_WIDTH - receiverSignNumWidth - OMDetailMargin * 2 - OMDetailContentMargin;
    CGFloat receiverNumHeight = OMDetailH;
    CGFloat receiverNumX = SCREEN_WIDTH - receiverNumWidth - OMDetailMargin;
    CGFloat receiverNumY = receiverSignNumY;
    self.receiverNumLabel.frame = CGRectMake(receiverNumX, receiverNumY, receiverNumWidth, receiverNumHeight);
    self.receiverNumLabel.text = receiverNumStr;

     //总高度
    self.headerHeight = OMDetailH * 3 + 0.4 * 3;
    //
    self.contentView.frame = CGRectMake(0, 0, SCREEN_WIDTH, OMDetailH * 4 + 0.4 * 3);
   
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
