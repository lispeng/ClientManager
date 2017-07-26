//
//  LSPHeaderView.h
//  ClientManager
//
//  Created by iOS－MacBook on 2017/5/27.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Groups;
@class LSPHeaderView;
@protocol LSPHeaderViewClickedNameView <NSObject>

@optional
- (void)headerViewClickedNameViewWithHeaderView:(LSPHeaderView *)headerView;

@end
@interface LSPHeaderView : UITableViewHeaderFooterView

+ (instancetype)headerViewWithTableView:(UITableView *)tableView;

@property (nonatomic, weak) id <LSPHeaderViewClickedNameView> delegate;
/**
 <#annotation#>
 */
@property (nonatomic,strong) Groups *group;

@end
