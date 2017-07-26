//
//  OMSubmitTableViewCell.h
//  ClientManager
//
//  Created by iOS－MacBook on 2017/5/10.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import "OMPrimaryTableViewCell.h"
@class OMSubmitModelFrame;
@interface OMSubmitTableViewCell : OMPrimaryTableViewCell
/**
 按钮类型
 */
@property (nonatomic,assign) PrimaryTableViewCellSignType signType;

+ (instancetype)submitTableViewCellWithTableView:(UITableView *)tableView;

/**
 <#annotation#>
 */
@property (nonatomic,strong) OMSubmitModelFrame *modelFrame;

@end
