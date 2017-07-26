//
//  OMAddOrderTableViewCell.h
//  ClientManager
//
//  Created by iOS－MacBook on 2017/5/11.
//  Copyright © 2017年 Lispeng. All rights reserved.
//--------------新增订单的Cell--------------

#import <UIKit/UIKit.h>
@class OMAddModelFrame;
@interface OMAddOrderTableViewCell : UITableViewCell

/**
 <#annotation#>
 */
@property (nonatomic,strong) OMAddModelFrame *modelFrame;


+ (instancetype)addOrderTableViewCellWithTableView:(UITableView *)tableView;

@end
