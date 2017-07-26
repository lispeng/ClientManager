//
//  OMBaseDetailFooterView.h
//  ClientManager
//
//  Created by iOS－MacBook on 2017/5/18.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OMDetailModel;
@class OverallInputArrowView;
@protocol BaseDetailFooterViewDelegate <NSObject>

@optional
- (void)baseDetailFooterViewArrowViewEditWithArrowView:(OverallInputArrowView *)arrowView;

@end
@interface OMBaseDetailFooterView : UIView
/**
 <#annotation#>
 */
@property (nonatomic,strong) OMDetailModel *model;
/**
 高度
 */
@property (nonatomic,assign) CGFloat footerHeight;
/**
 <#annotation#>
 */
@property (nonatomic,weak) id<BaseDetailFooterViewDelegate> delegate;

@end
