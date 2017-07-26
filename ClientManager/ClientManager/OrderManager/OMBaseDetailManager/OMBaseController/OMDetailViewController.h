//
//  OMDetailViewController.h
//  ClientManager
//
//  Created by iOS－MacBook on 2017/5/19.
//  Copyright © 2017年 Lispeng. All rights reserved.
//----------------订单详情的基类控制器----------------

#import <UIKit/UIKit.h>
 typedef NS_ENUM(NSInteger,OMDetailOrderType)
{
    OMDetailOrderUnapproveType,//待审批
    OMDetailOrderAgreeType,//已同意
    OMDetailOrderRefuseType//已拒绝
};
@class OMDetailModel;
@class OMPrimaryModel;
typedef void(^repealOrderBlock)(OMPrimaryModel *model);
@interface OMDetailViewController : UIViewController
///**
// <#annotation#>
// */
//@property (nonatomic,copy) NSString *id;

/**
 <#annotation#>
 */
@property (nonatomic,strong) OMPrimaryModel *model;

/**
 <#annotation#>
 */
@property (nonatomic,assign) OMDetailOrderType orderType;
/**
 点击撤销的block回调
 */
@property (nonatomic,copy) repealOrderBlock repealBlock;

@end
