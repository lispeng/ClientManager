//
//  OMPendingFooterView.h
//  ClientManager
//
//  Created by iOS－MacBook on 2017/5/22.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OMDetailModel;
@interface OMPendingFooterView : UIView
/**
 <#annotation#>
 */
@property (nonatomic,strong) OMDetailModel *model;
/**
 高度
 */
@property (nonatomic,assign) CGFloat footerHeight;

@end
