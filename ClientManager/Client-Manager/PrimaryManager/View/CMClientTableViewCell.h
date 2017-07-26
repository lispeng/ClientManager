//
//  CMClientTableViewCell.h
//  ClientManager
//
//  Created by iOS－MacBook on 2017/7/14.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CMClientModelFrame;
@interface CMClientTableViewCell : UITableViewCell
/**
 <#annotation#>
 */
@property (nonatomic,strong) CMClientModelFrame *modelFrame;


+ (instancetype)clientTableViewCellWithTableView:(UITableView *)tableView;

@end
