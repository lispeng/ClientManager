//
//  OMPrimaryTableViewCell.h
//  ClientManager
//已提交、待审批、已审批的cell
//  Created by iOS－MacBook on 2017/5/10.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,PrimaryTableViewCellSignType) {
    PrimaryTableViewCellSignUnpendType,//未审批
    PrimaryTableViewCellSignAgreeType,//已同意
    PrimaryTableViewCellSignUnagreeType//未同意
};
#define ClientListNameFont [UIFont systemFontOfSize:15]
#define OMBtnFont [UIFont systemFontOfSize:13]
@interface OMPrimaryTableViewCell : UITableViewCell
/**
 客户
 */
@property (nonatomic,weak) UILabel *clientSignLabel;
/**
 客户的名称
 */
@property (nonatomic,weak) UILabel *clientContentLabel;
/**
 订单金额
 */
@property (nonatomic,weak) UILabel *orderSignLabel;
/**
 订单金额内容
 */
@property (nonatomic,weak) UILabel *orderContentLabel;
/**
 提交日期
 */
@property (nonatomic,weak) UILabel *submitDateSignLabel;
/**
 提交具体日期内容
 */
@property (nonatomic,weak) UILabel *submitDateContentLabel;
/**
 提交人
 */
@property (nonatomic,weak) UILabel *submitSignLabel;
/**
 提交人具体名称
 */
@property (nonatomic,weak) UILabel *submitContentLabel;
/**
 底部的分割线
 */
@property (nonatomic,weak) UIView *primaryUnderLine;

/**
 审批按钮三种状态:未审批，已同意，已拒绝
 */
//@property (nonatomic,weak) UIButton *pendBtn;

@end
