//
//  OMPendingTableViewCell.h
//  ClientManager
//
//  Created by iOS－MacBook on 2017/5/10.
//  Copyright © 2017年 Lispeng. All rights reserved.
//------------------待审批Cell

#import "OMPrimaryTableViewCell.h"
@class OMPendingModelFrame;
@interface OMPendingTableViewCell : OMPrimaryTableViewCell
/**
 <#annotation#>
 */
@property (nonatomic,strong) OMPendingModelFrame *modelFrame;

+ (instancetype)pendingTableViewCellWithTableView:(UITableView *)tableView;

@end
