//
//  OMDetailTableViewCell.h
//  ClientManager
//
//  Created by iOS－MacBook on 2017/5/18.
//  Copyright © 2017年 Lispeng. All rights reserved.
//******************订单详情的统一Cell**************

#import <UIKit/UIKit.h>
@class OMDetailModelFrame;
@interface OMDetailTableViewCell : UITableViewCell
/**
 <#annotation#>
 */
@property (nonatomic,strong) OMDetailModelFrame *modelFrame;

+ (instancetype)detailTableViewCellWithTableView:(UITableView *)tableView;

@end
