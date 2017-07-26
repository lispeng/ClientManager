//
//  VIInquireTableViewCell.h
//  ClientManager
//******************拜访查询的Cell*******************
//  Created by iOS－MacBook on 2017/7/19.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VIInquireModelFrame;
@interface VIInquireTableViewCell : UITableViewCell
/**
 <#annotation#>
 */
@property (nonatomic,strong) VIInquireModelFrame *modelFrame;

+ (instancetype)inquireTableViewCellWithTableView:(UITableView *)tableView;
@end
