//
//  OMOrderEditScrollView.h
//  ClientManager
//
//  Created by iOS－MacBook on 2017/5/15.
//  Copyright © 2017年 Lispeng. All rights reserved.
//------------可编辑的商品订单信息——————————————————————

#import "OMOrderBaseScrollView.h"
@class OMOrderModel;
@class OMOrderEditTextField;
typedef void(^orderEditTextFieldCallbackBlock)(OMOrderEditTextField *editField,BOOL isInput);
@interface OMOrderEditScrollView : OMOrderBaseScrollView
/**
 <#annotation#>
 */
@property (nonatomic,strong) OMOrderModel *model;
/**
 <#annotation#>
 */
@property (nonatomic,copy) orderEditTextFieldCallbackBlock orderEditBlock;

@end
