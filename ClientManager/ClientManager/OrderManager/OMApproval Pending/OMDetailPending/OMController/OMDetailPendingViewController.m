//
//  OMDetailPendingViewController.m
//  ClientManager
//
//  Created by iOS－MacBook on 2017/5/22.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import "OMDetailPendingViewController.h"
#import "OMPendingHeaderView.h"
#import "OMPendingFooterView.h"
#import "OMDetailTableViewCell.h"
#import "OMDetailModel.h"
#import "OMDetailModelFrame.h"
@interface OMDetailPendingViewController ()
/**
 <#annotation#>
 */
@property (nonatomic,weak) UITableView *tableView;
/**
 <#annotation#>
 */
@property (nonatomic,weak) OMPendingHeaderView *tableHeaderView;
/**
 <#annotation#>
 */
@property (nonatomic,weak) OMPendingFooterView *tableFooterView;
/**
 <#annotation#>
 */
@property (nonatomic,strong) NSMutableArray *orderArray;

@end

@implementation OMDetailPendingViewController
- (NSMutableArray *)orderArray
{
    if (nil == _orderArray) {
        _orderArray = [NSMutableArray array];
    }
    return _orderArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
