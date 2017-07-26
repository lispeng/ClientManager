//
//  OMClientTableViewCell.h
//  ClientManager
//
//  Created by iOS－MacBook on 2017/5/22.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OMClientModel;
@interface OMClientTableViewCell : UITableViewCell
/**
 <#annotation#>
 */
@property (nonatomic,strong) OMClientModel *model;

+ (instancetype)clientTableViewCellWithTableView:(UITableView *)tableView;
@end
