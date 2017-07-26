//
//  OMPendedTableViewCell.h
//  ClientManager
//
//  Created by iOS－MacBook on 2017/5/10.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import "OMPrimaryTableViewCell.h"
@class OMPendedModelFrame;
@interface OMPendedTableViewCell : OMPrimaryTableViewCell
/**
 <#annotation#>
 */
@property (nonatomic,strong) OMPendedModelFrame *modelFrame;

/**
 按钮类型
 */
@property (nonatomic,assign) PrimaryTableViewCellSignType signType;

+ (instancetype)pendedTableViewCellWithTableView:(UITableView *)tableView;

@end
