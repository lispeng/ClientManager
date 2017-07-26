//
//  OMIncreaseHeaderView.h
//  ClientManager
//
//  Created by iOS－MacBook on 2017/5/16.
//  Copyright © 2017年 Lispeng. All rights reserved.
//------------------新增订单页面头部View控件----------------

#import <UIKit/UIKit.h>
@class OverallInputArrowView;
@class OverallInputView;
typedef void(^handAddOrderBlock)();
@protocol OMIncreaseHeaderViewDelegate <NSObject>

- (void)increaseHeaderViewArrowViewEditWithArrowView:(OverallInputArrowView *)arrowView;


@end
@interface OMIncreaseHeaderView : UIView
/**
 客户名称
 */
@property (nonatomic,weak) OverallInputArrowView *clientInputArrowView;
/**
 收货人
 */
@property (nonatomic,weak) OverallInputArrowView *receiverInputArrowView;
/**
 收货人电话
 */
@property (nonatomic,weak) OverallInputView *receiverNumInputView;
/**
 顶部背景View
 */
@property (nonatomic,weak) UIView *topContentView;

/**
 “扫码添加”和"手动添加"背景View
 
 */
@property (nonatomic,weak) UIView *addOrderView;
/**
 <#annotation#>
 */
@property (nonatomic,weak) UIButton *sweepBtn;
/**
 <#annotation#>
 */
@property (nonatomic,weak) UIButton *handBtn;
/**
 <#annotation#>
 */
/**
 <#annotation#>
 */
@property (nonatomic,copy) handAddOrderBlock handBlock;

@property (nonatomic,weak) id<OMIncreaseHeaderViewDelegate> delegate;


@end
