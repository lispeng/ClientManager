//
//  OMStorehouseTableViewCell.h
//  ClientManager
//
//  Created by iOS－MacBook on 2017/5/23.
//  Copyright © 2017年 Lispeng. All rights reserved.
//--------------仓库选择的Cell--------------

#import <UIKit/UIKit.h>
@class OMStoreModel;
@interface OMStorehouseTableViewCell : UITableViewCell
/**
 <#annotation#>
 */
@property (nonatomic,strong) OMStoreModel *model;
+ (instancetype)storehouseTableViewCellWithTableView:(UITableView *)tableView;
@end
