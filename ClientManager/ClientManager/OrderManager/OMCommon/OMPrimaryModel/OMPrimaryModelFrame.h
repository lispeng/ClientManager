//
//  OMPrimaryModelFrame.h
//  ClientManager
//
//  Created by iOS－MacBook on 2017/5/10.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class OMPrimaryModel;
@interface OMPrimaryModelFrame : NSObject
/**
 客户frame
 */
@property (nonatomic,assign) CGRect clientSignLabelFrame;
/**
 客户的名称frame
 */

@property (nonatomic,assign) CGRect clientContentLabelFrame;

/**
 订单金额frame
 */
@property (nonatomic,assign) CGRect orderSignLabelFrame;
/**
 订单金额内容frame
 */

@property (nonatomic,assign) CGRect orderContentLabelFrame;
/**
 提交日期frame
 */

@property (nonatomic,assign) CGRect submitDateSignLabelFrame;
/**
 提交具体日期内容frame
 */

@property (nonatomic,assign) CGRect submitDateContentLabelFrame;
/**
 提交人frame
 */
@property (nonatomic,assign) CGRect submitSignLabelFrame;

/**
 提交人具体名称frame
 */

@property (nonatomic,assign) CGRect submitContentLabelFrame;
/**
 底部的分割线frame
 */
@property (nonatomic,assign) CGRect primaryUnderLineFrame;
/**
 审批按钮的frame
 */
@property (nonatomic,assign) CGRect pendLabelFrame;
/**
 cell的高度
 */
@property (nonatomic,assign) CGFloat cellHeight;

@end
