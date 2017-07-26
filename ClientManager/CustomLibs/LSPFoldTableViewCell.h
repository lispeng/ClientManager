//
//  LSPFoldTableViewCell.h
//  ClientManager
//
//  Created by iOS－MacBook on 2017/5/26.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ModelFrame;
@interface LSPFoldTableViewCell : UITableViewCell
/**
 <#annotation#>
 */
@property (nonatomic,strong) ModelFrame *modelFrame;

+ (instancetype)foldTableViewCellWithTableView:(UITableView *)tableView;
@end
