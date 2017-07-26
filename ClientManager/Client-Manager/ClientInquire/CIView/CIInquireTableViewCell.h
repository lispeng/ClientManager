//
//  CIInquireTableViewCell.h
//  ClientManager
//*************客户查询的Cell**************
//  Created by iOS－MacBook on 2017/7/20.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CIModelFrame;
@interface CIInquireTableViewCell : UITableViewCell

/**
 <#annotation#>
 */
@property (nonatomic,strong) CIModelFrame *modelFrame;


+ (instancetype)inquireTableViewCellWithTableView:(UITableView *)tableView;
@end
