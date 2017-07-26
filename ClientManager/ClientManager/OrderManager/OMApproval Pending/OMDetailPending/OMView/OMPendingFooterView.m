//
//  OMPendingFooterView.m
//  ClientManager
//
//  Created by iOS－MacBook on 2017/5/22.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import "OMPendingFooterView.h"
#import "NSString+Extension.h"
#import "OMDetailModel.h"
#import "OverallInputArrowView.h"
@interface OMPendingFooterView()<OverallInputArrowViewDelegate>

/**
 顶部背景容器
 */
@property (nonatomic,weak) UIView *topContentView;
/**
 中间的背景容器
 */
@property (nonatomic,weak) UIView *middleContentView;

/**
 底部背景容器
 */
@property (nonatomic,weak) UIView *bottomContentView;

/**
 合计金额标签
 */
@property (nonatomic,weak) UILabel *totalSignLabel;
/**
 具体金额
 */
@property (nonatomic,weak) UILabel *totalLabel;
/**
 备注标签
 */
@property (nonatomic,weak) UILabel *remarkSignLabel;
/**
 备注内容
 */
@property (nonatomic,weak) UILabel *remarkLabel;
//----------------底部的子控件-------------
/**
 出货仓库
 */
@property (nonatomic,weak) OverallInputArrowView *storehouseArrowView;
/**
 送货人
 */
@property (nonatomic,weak) OverallInputArrowView *deliveryArrowView;


@end
@implementation OMPendingFooterView
- (instancetype)init
{
    if (self = [super init]) {
        [self setupPendingFooterViewSubviews];
    }
    return self;
}
- (void)setModel:(OMDetailModel *)model
{
    _model = model;
    //顶部背景容器Frame
    CGFloat topH = OMDetailH;
    CGFloat topX = 0;
    CGFloat topY = 0;
    CGFloat topWidth = SCREEN_WIDTH;
    CGFloat topHeight = topH;
    self.topContentView.frame = CGRectMake(topX, topY, topWidth, topHeight);
    //1.合计金额标签Frame
    //1.1合计金额标签的Size
    NSString *totalSignStr = @"合计金额:";
    CGSize totalSignSize = [totalSignStr sizeWithFont:OMDetailFont];
    //1.2合计金额的Size
    NSString *totalStr = model.totalMoney;
    CGSize totalSize = [totalStr sizeWithFont:OMDetailFont];
    //1.3合计金额(标签和内容)的总宽度
    CGFloat totalMoneyWidth = totalSignSize.width + totalSize.width + OMDetailContentMargin;
    //1.4合计金额内容预留的最大宽度
    CGFloat predictTotalWidth = SCREEN_WIDTH - totalSignSize.width - OMDetailMargin * 2 - OMDetailContentMargin;
    
    CGFloat totalSignX = SCREEN_WIDTH - totalMoneyWidth - OMDetailMargin;
    CGFloat totalSignY = 0;
    CGFloat totalSignWidth = totalSignSize.width;
    CGFloat totalSignHeight = OMDetailH;
    self.totalSignLabel.frame = CGRectMake(totalSignX, totalSignY, totalSignWidth, totalSignHeight);
    self.totalSignLabel.text = totalSignStr;
    //2.合计金额Frame
    
    CGFloat totalX = CGRectGetMaxX(self.totalSignLabel.frame) + OMDetailContentMargin;
    CGFloat totalY = 0;
    CGFloat totalWidth = totalSize.width;
    if (totalWidth > predictTotalWidth) {
        totalWidth = predictTotalWidth;
    }
    CGFloat totalHeight = OMDetailH;
    self.totalLabel.frame = CGRectMake(totalX, totalY, totalWidth, totalHeight);
    self.totalLabel.text = totalStr;
    //-----------------中间控件的Frame------------------
    CGFloat totalMiddleH = 0;
    //1.备注标签Frame
    NSString *remarkSignStr = @"备注:";
    CGSize remarkSignSize = [remarkSignStr sizeWithFont:OMDetailFont];
    CGFloat remarkSignX = OMDetailMargin;
    CGFloat remarkSignY = OMDetailMargin;
    CGFloat remarkSignWidth = remarkSignSize.width;
    CGFloat remarkSignHeight = remarkSignSize.height;
    self.remarkSignLabel.frame = CGRectMake(remarkSignX, remarkSignY, remarkSignWidth, remarkSignHeight);
    self.remarkSignLabel.text = remarkSignStr;
    //2.备注内容Frame
    NSString *remarkStr = model.remarks;
    CGFloat predictRemarkWidth = SCREEN_WIDTH - remarkSignWidth - OMDetailMargin * 2 - OMDetailContentMargin;
    CGSize remarkSize = [remarkStr sizeWithFont:OMDetailFont maxW:predictRemarkWidth];
    CGFloat remarkX = CGRectGetMaxX(self.remarkSignLabel.frame) + OMDetailMargin;
    CGFloat remarkY = remarkSignY - 5;
    CGFloat remarkWidth = predictRemarkWidth;
    CGFloat remarkHeight = remarkSize.height + OMDetailMargin;
    self.remarkLabel.frame = CGRectMake(remarkX, remarkY, remarkWidth, remarkHeight);
    self.remarkLabel.text = remarkStr;
    CGFloat predctH = CGRectGetMaxY(self.remarkLabel.frame);
    totalMiddleH += ((predctH > remarkSignHeight) ? predctH : remarkSignHeight);
    
    //3.自定义的内容Frame
    
    /*....totalMiddleH = .......*/
    
    //中间的背景容器Frame
    CGFloat middleX = 0;
    CGFloat middleY = CGRectGetMaxY(self.topContentView.frame) + OMDetailContentMargin;
    CGFloat middleWidth = SCREEN_WIDTH;
    CGFloat middleHeight = totalMiddleH;
    self.middleContentView.frame = CGRectMake(middleX, middleY, middleWidth, middleHeight);
    //////////////////////底部的控件///////////////////
    CGFloat bottomH = 0;
    //出货仓库的frame
    CGFloat storehouseArrowViewX = OMDetailMargin;
    CGFloat storehouseArrowViewY = 0;
    CGFloat storehouseArrowViewWidth = SCREEN_WIDTH - OMDetailMargin * 2;
    CGFloat storehouseArrowViewHeight = OMDetailH;
    self.storehouseArrowView.frame = CGRectMake(storehouseArrowViewX, storehouseArrowViewY, storehouseArrowViewWidth, storehouseArrowViewHeight);
    //送货人的Frame
    CGFloat deliveryArrowViewX = storehouseArrowViewX;
    CGFloat deliveryArrowViewY = CGRectGetMaxY(self.storehouseArrowView.frame);
    CGFloat deliveryArrowViewWidth = storehouseArrowViewWidth;
    CGFloat deliveryArrowViewHeight = storehouseArrowViewHeight;
    self.deliveryArrowView.frame = CGRectMake(deliveryArrowViewX, deliveryArrowViewY, deliveryArrowViewWidth, deliveryArrowViewHeight);
    bottomH += storehouseArrowViewHeight * 2;
      //底部的背景容器Frame
   
    CGFloat bottomContentViewX = 0;
    CGFloat bottomContentViewY = CGRectGetMaxY(self.middleContentView.frame) + OMDetailContentMargin;
    CGFloat bottomContentViewWidth = SCREEN_WIDTH;
    CGFloat bottomContentViewHeight = bottomH;
    self.bottomContentView.frame = CGRectMake(bottomContentViewX, bottomContentViewY, bottomContentViewWidth, bottomContentViewHeight);
    
    self.footerHeight = topH + totalMiddleH + bottomH + OMDetailContentMargin * 2;
    //本身的frame设置
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.footerHeight);
}
- (void)setupPendingFooterViewSubviews
{
    self.backgroundColor = [AppColor appTableViewBackgroundColor];
    //顶部背景容器
    UIView *topContentView = [[UIView alloc] init];
    topContentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:topContentView];
    self.topContentView = topContentView;
    //中间的背景容器
    UIView *middleContentView = [[UIView alloc] init];
    middleContentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:middleContentView];
    self.middleContentView = middleContentView;
    
    //底部背景容器
    UIView *bottomContentView = [[UIView alloc] init];
    bottomContentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bottomContentView];
    self.bottomContentView = bottomContentView;
    
    //---------------顶部的子控件------------------
    //合计金额标签
    UILabel *totalSignLabel = [[UILabel alloc] init];
    totalSignLabel.textColor = [UIColor blackColor];
    totalSignLabel.font = OMDetailFont;
    totalSignLabel.textAlignment = NSTextAlignmentLeft;
    [self.topContentView addSubview:totalSignLabel];
    self.totalSignLabel = totalSignLabel;
    //合计金额具体内容
    UILabel *totalLabel = [[UILabel alloc] init];
    totalLabel.textColor = [UIColor blackColor];
    totalLabel.font = OMDetailFont;
    totalLabel.textAlignment = NSTextAlignmentLeft;
    [self.topContentView addSubview:totalLabel];
    self.totalLabel = totalLabel;
    //------------------中间子控件-------------
    //备注标签
    UILabel *remarkSignLabel = [[UILabel alloc] init];
    remarkSignLabel.textColor = [UIColor blackColor];
    remarkSignLabel.font = OMDetailFont;
    remarkSignLabel.textAlignment = NSTextAlignmentLeft;
    [self.middleContentView addSubview:remarkSignLabel];
    self.remarkSignLabel = remarkSignLabel;
    //备注内容
    UILabel *remarkLabel = [[UILabel alloc] init];
    remarkLabel.textColor = [UIColor grayColor];
    remarkLabel.font = OMDetailFont;
    remarkLabel.textAlignment = NSTextAlignmentLeft;
    remarkLabel.numberOfLines = 0;
    [self.middleContentView addSubview:remarkLabel];
    self.remarkLabel = remarkLabel;
    
    //-----------------底部的子控件-------------
    //出货仓库标签
    OverallInputArrowView *storehouseArrowView = [[OverallInputArrowView alloc] init];
    storehouseArrowView.titleLabel.text = @"出货仓库";
    storehouseArrowView.delegate = self;
    storehouseArrowView.isRight = YES;
    [self.bottomContentView addSubview:storehouseArrowView];
    self.storehouseArrowView = storehouseArrowView;
    //送货人标签
    OverallInputArrowView *deliveryArrowView = [[OverallInputArrowView alloc] init];
    deliveryArrowView.titleLabel.text = @"送货人";
    deliveryArrowView.delegate = self;
    deliveryArrowView.isRight = YES;
    [self.bottomContentView addSubview:deliveryArrowView];
    self.deliveryArrowView = deliveryArrowView;

}
#pragma mark---OverallInputArrowViewDelegate
- (void)overallInputArrowViewEditWithArrowView:(OverallInputArrowView *)arrowView
{
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
