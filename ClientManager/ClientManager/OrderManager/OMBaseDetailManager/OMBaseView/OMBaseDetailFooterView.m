//
//  OMBaseDetailFooterView.m
//  ClientManager
//
//  Created by iOS－MacBook on 2017/5/18.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import "OMBaseDetailFooterView.h"
#import "NSString+Extension.h"
#import "OMDetailModel.h"
#import "OverallInputArrowView.h"

@interface OMBaseDetailFooterView()<OverallInputArrowViewDelegate>
/**
 顶部背景容器
 */
@property (nonatomic,weak) UIView *topContentView;
/**
 中间的背景容器
 */
@property (nonatomic,weak) UIView *middleContentView;
/**
 自定义标签的背景容器
 */
@property (nonatomic,weak) UIView *customContentView;


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
 出货仓库标签
 */
@property (nonatomic,weak) UILabel *storehouseSignLabel;
/**
 出货仓库
 */
@property (nonatomic,weak) UILabel *storehouseLabel;

/**
 送货人标签
 */
@property (nonatomic,weak) UILabel *deliverySignLabel;
/**
 送货人
 */
@property (nonatomic,weak) UILabel *deliveryLabel;
/**
 电话按钮
 */
@property (nonatomic,weak) UIButton *telBtn;

/**
 审核人标签
 */
@property (nonatomic,weak) UILabel *verifierSignLabel;
/**
 审核人
 */
@property (nonatomic,weak) UILabel *verifierLabel;
/**
 审核时间标签
 */
@property (nonatomic,weak) UILabel *reviewTimeSignLabel;
/**
 审核时间
 */
@property (nonatomic,weak) UILabel *reviewTimeLabel;
/**
 审核意见标签
 */
@property (nonatomic,weak) UILabel *reviewIdeaSignLabel;
/**
 审核意见
 */
@property (nonatomic,weak) UILabel *reviewIdeaLabel;
//------------------以下是订单审批才有的功能
/**
 出货仓库选择
 */
@property (nonatomic,weak) OverallInputArrowView *storehouseArrowView;
/**
 送货人选择--
 */
@property (nonatomic,weak) OverallInputArrowView *deliveryArrowView;

@end
@implementation OMBaseDetailFooterView
- (instancetype)init
{
    if (self = [super init]) {
        [self setupBaseDetailFooterViewSubviews];
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
    //中间的背景容器Frame
    CGFloat middleX = 0;
    CGFloat middleY = CGRectGetMaxY(self.topContentView.frame) + OMDetailContentMargin;
    CGFloat middleWidth = SCREEN_WIDTH;
    CGFloat middleHeight = totalMiddleH;
    self.middleContentView.frame = CGRectMake(middleX, middleY, middleWidth, middleHeight);

    //3.自定义的内容Frame
    
    CGFloat customContentViewX = 0;
    CGFloat customContentViewY = CGRectGetMaxY(self.middleContentView.frame) + OMDetailContentMargin;
    CGFloat customContentViewWidth = SCREEN_WIDTH;
    CGFloat customContentViewHeight = 50;
    self.customContentView.frame = CGRectMake(customContentViewX, customContentViewY, customContentViewWidth, customContentViewHeight);
    /*....totalMiddleH = .......*/
    
    //////////////////////底部的控件///////////////////
    CGFloat bottomH = 0;
//-----------------下面只有订单审批才有的控件-------------
    if([model.orderType isEqualToString:@"0"])
    {//订单审批的类型(0是未审批，1是已同意，2是已拒绝)

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
    }else if ([model.orderType isEqualToString:@"1"] || [model.orderType isEqualToString:@"2"])
    {
        [self.storehouseArrowView removeFromSuperview];
        [self.deliveryArrowView removeFromSuperview];
    
    //1.出货仓库标签Frame
    //1.1 出货仓库标签Size
    NSString *storehouseSignStr = @"出货仓库:";
    CGSize storehouseSignSize = [storehouseSignStr sizeWithFont:OMDetailFont];
    bottomH += storehouseSignSize.height;
    //1.2出货仓库的Size
    NSString *storehouseStr = model.storehouse;
    CGSize storehouseSize = [storehouseStr sizeWithFont:OMDetailFont];
    //1.3送货人标签的Size
    NSString *deliverySignStr = @"送货人:";
    CGSize deliverySignSize = [deliverySignStr sizeWithFont:OMDetailFont];
    //1.4送货人的Size
    NSString *deliveryStr = model.delivery;
    CGSize deliverySize = [deliveryStr sizeWithFont:OMDetailFont];
    //1.5电话按钮的宽度
    CGFloat telBtnPredictWidth = 25;
    //1.6出货仓库总宽度
   // CGFloat storehouseTotalWidth = storehouseSignSize.width + OMDetailContentMargin + storehouseSize.width;
    //1.7送货人总宽度
    CGFloat  predictDeliverySignWidth = (SCREEN_WIDTH - OMDetailMargin * 2) / 2;
    //1.8送货人内容预留最大宽度
    CGFloat predictDeliveryWidth = (SCREEN_WIDTH - OMDetailMargin * 2) / 2 - deliverySignSize.width - OMDetailContentMargin - telBtnPredictWidth - OMDetailMargin * 2;
    //1.9送货人+电话按钮的总宽度
    CGFloat diliveryTelTotalWidth = deliverySignSize.width + OMDetailContentMargin + deliverySize.width + telBtnPredictWidth + OMDetailMargin;
    
    CGFloat deliveryPredictSignX = SCREEN_WIDTH - diliveryTelTotalWidth;
    if (diliveryTelTotalWidth > predictDeliverySignWidth) {
        deliveryPredictSignX = SCREEN_WIDTH / 2;
        deliverySize = CGSizeMake(predictDeliveryWidth, deliverySize.height);
    }

   // CGFloat diliveryTotalWidth = deliverySignSize.width + OMDetailContentMargin + deliverySize.width;
      //1.10出货仓库内容预留最大宽度
    CGFloat predictStorehouseWidth = (SCREEN_WIDTH - OMDetailMargin * 2) / 2 - storehouseSignSize.width;
    if (storehouseSize.width > predictStorehouseWidth) {
        storehouseSize = CGSizeMake(predictStorehouseWidth, storehouseSize.height);
    }
    //1.11 送货人内容和电话按钮的总宽度
   // CGFloat totalDilTelWidth = deliverySize.width + OMDetailMargin + telBtnPredictWidth;
    //------------
    CGFloat storehouseSignX = OMDetailMargin;
    CGFloat storehouseSignY = OMDetailMargin;
    CGFloat storehouseSignWidth = storehouseSignSize.width;
    CGFloat storehouseSignHeight = storehouseSignSize.height;
    self.storehouseSignLabel.frame = CGRectMake(storehouseSignX, storehouseSignY, storehouseSignWidth, storehouseSignHeight);
    self.storehouseSignLabel.text = storehouseSignStr;

    //1.出货仓库Frame
    CGFloat storehouseX = CGRectGetMaxX(self.storehouseSignLabel.frame) + OMDetailContentMargin;
    CGFloat storehouseY = storehouseSignY;
    CGFloat storehouseWidth = storehouseSize.width;
    CGFloat storehouseHeight = storehouseSize.height;
    self.storehouseLabel.frame = CGRectMake(storehouseX, storehouseY, storehouseWidth, storehouseHeight);
    self.storehouseLabel.text = storehouseStr;

    //2.送货人标签Frame
    CGFloat deliverySignX = deliveryPredictSignX;
       CGFloat deliverySignY = storehouseSignY;
    CGFloat deliverySignWidth = deliverySignSize.width;
    CGFloat deliverySignHeight = deliverySignSize.height;
    self.deliverySignLabel.frame = CGRectMake(deliverySignX, deliverySignY, deliverySignWidth, deliverySignHeight);
    self.deliverySignLabel.text = deliverySignStr;
    //2.送货人Frame
    CGFloat deliveryX = CGRectGetMaxX(self.deliverySignLabel.frame) + OMDetailContentMargin;
    CGFloat deliveryY = deliverySignY;
    CGFloat deliveryWidth = deliverySize.width;
    CGFloat deliveryHeight = deliverySize.height;
    self.deliveryLabel.frame = CGRectMake(deliveryX, deliveryY, deliveryWidth, deliveryHeight);
    self.deliveryLabel.text = deliveryStr;
    //3.电话按钮Frame
    CGFloat telBtnX = CGRectGetMaxX(self.deliverySignLabel.frame) + OMDetailContentMargin + deliveryWidth + OMDetailContentMargin;
    CGFloat telBtnY = 3;
    CGFloat telBtnWidth = telBtnPredictWidth;
    CGFloat telBtnHeight = telBtnPredictWidth;
    self.telBtn.frame = CGRectMake(telBtnX, telBtnY, telBtnWidth, telBtnHeight);
    bottomH += OMDetailContentMargin;
    
    //审核人和审核时间
    //1.1审核人标签的Size
    NSString *verifierSignStr = @"审核人:";
    CGSize verifierSignSize = [verifierSignStr sizeWithFont:OMDetailFont];
    bottomH += verifierSignSize.height;
    //1.2审核人的Size
    NSString *verifierStr = model.verifier;
    CGSize verifierSize = [verifierStr sizeWithFont:OMDetailFont];
    CGFloat predictMaxVerifierWidth = (SCREEN_WIDTH - OMDetailMargin * 2) / 2 - verifierSignSize.width - OMDetailContentMargin;
    if (verifierSize.width > predictMaxVerifierWidth) {
        verifierSize = CGSizeMake(predictMaxVerifierWidth, verifierSize.height);
    }
    //1.3审核时间标签的Size
    NSString *reviewTimeSignStr = @"审核时间:";
    CGSize reviewTimeSignSize = [reviewTimeSignStr sizeWithFont:OMDetailFont];
    //1.4审核时间的Size
    NSString *reviewTimeStr = model.reviewTime;
    CGSize reviewTimeSize = [reviewTimeStr sizeWithFont:OMDetailFont];
    
    //4.审核人标签Frame
    CGFloat verifierSignX = OMDetailMargin;
    CGFloat verifierSignY = CGRectGetMaxY(self.storehouseSignLabel.frame) + OMDetailMargin;
    CGFloat verifierSignWidth = verifierSignSize.width;
    CGFloat verifierSignHeight = verifierSignSize.height;
    self.verifierSignLabel.frame = CGRectMake(verifierSignX, verifierSignY, verifierSignWidth, verifierSignHeight);
    self.verifierSignLabel.text = verifierSignStr;
    
    //4.审核人Frame
    CGFloat verifierX = CGRectGetMaxX(self.verifierSignLabel.frame) + OMDetailContentMargin;
    CGFloat verifierY = verifierSignY;
    CGFloat verifierWidth = verifierSize.width;
    CGFloat verifierHeight = verifierSize.height;
    self.verifierLabel.frame = CGRectMake(verifierX, verifierY, verifierWidth, verifierHeight);
    self.verifierLabel.text = verifierStr;
    //5.审核时间标签Frame
    CGFloat reviewTimeSignX = deliverySignX;
    CGFloat reviewTimeSignY = CGRectGetMaxY(self.deliverySignLabel.frame) + OMDetailMargin;
    CGFloat reviewTimeSignWidth = reviewTimeSignSize.width;
    CGFloat reviewTimeSignHeight = reviewTimeSignSize.height;
    self.reviewTimeSignLabel.frame = CGRectMake(reviewTimeSignX, reviewTimeSignY, reviewTimeSignWidth, reviewTimeSignHeight);
    self.reviewTimeSignLabel.text = reviewTimeSignStr;
    //5.审核时间Frame
    CGFloat reviewTimeX = CGRectGetMaxX(self.reviewTimeSignLabel.frame) + OMDetailContentMargin;
    CGFloat reviewTimeY = reviewTimeSignY;
    CGFloat reviewTimeWidth = reviewTimeSize.width;
    CGFloat reviewTimeHeight = reviewTimeSize.height;
    self.reviewTimeLabel.frame = CGRectMake(reviewTimeX, reviewTimeY, reviewTimeWidth, reviewTimeHeight);
    self.reviewTimeLabel.text = reviewTimeStr;
    bottomH += OMDetailMargin;
    //6.审核意见标签Frame
    //6.1审核意见标签的Size
    bottomH += OMDetailMargin;
    NSString *reviewIdeaSignStr = @"审核意见:";
    CGSize reviewIdeaSignSize = [reviewIdeaSignStr sizeWithFont:OMDetailFont];
    
    CGFloat reviewIdeaSignX = OMDetailMargin;
    CGFloat reviewIdeaSignY = CGRectGetMaxY(self.verifierSignLabel.frame) + OMDetailMargin;
    CGFloat reviewIdeaSignWidth = reviewIdeaSignSize.width;
    CGFloat reviewIdeaSignHeight = reviewIdeaSignSize.height;
    self.reviewIdeaSignLabel.frame = CGRectMake(reviewIdeaSignX, reviewIdeaSignY, reviewIdeaSignWidth, reviewIdeaSignHeight);
    self.reviewIdeaSignLabel.text = reviewIdeaSignStr;
    //6.审核意见Frame
    //6.1审核意见的Size
    NSString *reviewIdeaStr = model.reviewIdea;
    CGFloat predictReviewIdeaWidth = SCREEN_WIDTH - reviewIdeaSignWidth - OMDetailMargin * 2 - OMDetailContentMargin;
    CGSize reviewIdeaSize = [reviewIdeaStr sizeWithFont:OMDetailFont maxW:predictReviewIdeaWidth];
    
    CGFloat reviewIdeaX = CGRectGetMaxX(self.reviewIdeaSignLabel.frame) + OMDetailContentMargin;
    CGFloat reviewIdeaY = reviewIdeaSignY;
    CGFloat reviewIdeaWidth = reviewIdeaSize.width;
    CGFloat reviewIdeaHeight = reviewIdeaSize.height;
    self.reviewIdeaLabel.frame = CGRectMake(reviewIdeaX, reviewIdeaY, reviewIdeaWidth, reviewIdeaHeight);
    self.reviewIdeaLabel.text = reviewIdeaStr;
         bottomH += ((reviewIdeaHeight > reviewIdeaSignHeight) ? reviewIdeaHeight : reviewIdeaSignHeight)  + OMDetailMargin;
    }
    //底部的背景容器Frame
    CGFloat cusMaxY = CGRectGetMaxY(self.customContentView.frame);
    CGFloat middleMaxY = CGRectGetMaxY(self.middleContentView.frame);
    CGFloat bottomY = ((cusMaxY > middleMaxY) ? cusMaxY : middleMaxY);
    CGFloat bottomContentViewX = 0;
    CGFloat bottomContentViewY = bottomY + OMDetailContentMargin;
    CGFloat bottomContentViewWidth = SCREEN_WIDTH;
    CGFloat bottomContentViewHeight = bottomH;
    self.bottomContentView.frame = CGRectMake(bottomContentViewX, bottomContentViewY, bottomContentViewWidth, bottomContentViewHeight);
    
    self.footerHeight = topH + totalMiddleH + bottomH + OMDetailContentMargin * 2 + customContentViewHeight + OMDetailContentMargin * 2;
    //本身的frame设置
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.footerHeight);
}
- (void)setupBaseDetailFooterViewSubviews
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
    //自定义标签的背景容器
    UIView *customContentView = [[UIView alloc] init];
    customContentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:customContentView];
    self.customContentView = customContentView;
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
    totalLabel.textColor = [AppColor appMainColor];
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
    UILabel *storehouseSignLabel = [[UILabel alloc] init];
    storehouseSignLabel.textColor = [UIColor blackColor];
    storehouseSignLabel.font = OMDetailFont;
    storehouseSignLabel.textAlignment = NSTextAlignmentLeft;
    [self.bottomContentView addSubview:storehouseSignLabel];
    self.storehouseSignLabel = storehouseSignLabel;
    //出货仓库
    UILabel *storehouseLabel = [[UILabel alloc] init];
    storehouseLabel.textColor = [UIColor grayColor];
    storehouseLabel.font = OMDetailFont;
    storehouseLabel.textAlignment = NSTextAlignmentLeft;
    [self.bottomContentView addSubview:storehouseLabel];
    self.storehouseLabel = storehouseLabel;

    //送货人标签
    UILabel *deliverySignLabel = [[UILabel alloc] init];
    deliverySignLabel.textColor = [UIColor blackColor];
    deliverySignLabel.font = OMDetailFont;
    deliverySignLabel.textAlignment = NSTextAlignmentLeft;
    [self.bottomContentView addSubview:deliverySignLabel];
    self.deliverySignLabel = deliverySignLabel;
    //送货人
    UILabel *deliveryLabel = [[UILabel alloc] init];
    deliveryLabel.textColor = [UIColor grayColor];
    deliveryLabel.font = OMDetailFont;
    deliveryLabel.textAlignment = NSTextAlignmentLeft;
    [self.bottomContentView addSubview:deliveryLabel];
    self.deliveryLabel = deliveryLabel;
    
    //电话按钮
    UIButton *telBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [telBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    telBtn.backgroundColor = [UIColor greenColor];
    telBtn.titleLabel.font = OMDetailFont;
    telBtn.layer.borderColor = [AppColor appTableCellGrayTextColor].CGColor;
    telBtn.layer.borderWidth = 0.5;
    telBtn.layer.cornerRadius = 12.5;
    telBtn.layer.masksToBounds = YES;
    [telBtn addTarget:self action:@selector(detailOrderTelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomContentView addSubview:telBtn];
    self.telBtn = telBtn;

    //审核人标签
    UILabel *verifierSignLabel = [[UILabel alloc] init];
    verifierSignLabel.textColor = [UIColor blackColor];
    verifierSignLabel.font = OMDetailFont;
    verifierSignLabel.textAlignment = NSTextAlignmentLeft;
    [self.bottomContentView addSubview:verifierSignLabel];
    self.verifierSignLabel = verifierSignLabel;
    //审核人
    UILabel *verifierLabel = [[UILabel alloc] init];
    verifierLabel.textColor = [UIColor grayColor];
    verifierLabel.font = OMDetailFont;
    verifierLabel.textAlignment = NSTextAlignmentLeft;
    [self.bottomContentView addSubview:verifierLabel];
    self.verifierLabel = verifierLabel;

    //审核时间标签
    UILabel *reviewTimeSignLabel = [[UILabel alloc] init];
    reviewTimeSignLabel.textColor = [UIColor blackColor];
    reviewTimeSignLabel.font = OMDetailFont;
    reviewTimeSignLabel.textAlignment = NSTextAlignmentLeft;
    [self.bottomContentView addSubview:reviewTimeSignLabel];
    self.reviewTimeSignLabel = reviewTimeSignLabel;

    //审核时间
    UILabel *reviewTimeLabel = [[UILabel alloc] init];
    reviewTimeLabel.textColor = [UIColor grayColor];
    reviewTimeLabel.font = OMDetailFont;
    reviewTimeLabel.textAlignment = NSTextAlignmentLeft;
    [self.bottomContentView addSubview:reviewTimeLabel];
    self.reviewTimeLabel = reviewTimeLabel;

    //审核意见标签
    UILabel *reviewIdeaSignLabel = [[UILabel alloc] init];
    reviewIdeaSignLabel.textColor = [UIColor blackColor];
    reviewIdeaSignLabel.font = OMDetailFont;
    reviewIdeaSignLabel.textAlignment = NSTextAlignmentLeft;
    [self.bottomContentView addSubview:reviewIdeaSignLabel];
    self.reviewIdeaSignLabel = reviewIdeaSignLabel;
    //审核意见
    UILabel *reviewIdeaLabel = [[UILabel alloc] init];
    reviewIdeaLabel.textColor = [UIColor grayColor];
    reviewIdeaLabel.font = OMDetailFont;
    reviewIdeaLabel.textAlignment = NSTextAlignmentLeft;
    reviewIdeaLabel.numberOfLines = 0;
    [self.bottomContentView addSubview:reviewIdeaLabel];
    self.reviewIdeaLabel = reviewIdeaLabel;
    //-------------以下是订单审批才有的控件
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
/**
 打电话

 @param sender <#sender description#>
 */
- (void)detailOrderTelBtnClick:(UIButton *)sender
{
    NSLog(@"给送货人打电话");
}
#pragma mark--OverallInputArrowViewDelegate
- (void)overallInputArrowViewEditWithArrowView:(OverallInputArrowView *)arrowView
{
    NSLog(@"arrowView.titleLabel.text = %@",arrowView.titleLabel.text);
    if (_delegate && [_delegate respondsToSelector:@selector(baseDetailFooterViewArrowViewEditWithArrowView:)]) {
        [_delegate baseDetailFooterViewArrowViewEditWithArrowView:arrowView];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
