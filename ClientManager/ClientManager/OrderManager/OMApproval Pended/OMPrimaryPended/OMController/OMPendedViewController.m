//
//  OMPendedViewController.m
//  ClientManager
//*****************已审批控制器***************/
//  Created by iOS－MacBook on 2017/5/10.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import "OMPendedViewController.h"
#import "OMPendedModel.h"
#import "OMPendedModelFrame.h"
#import "OMPendedTableViewCell.h"
#import "OMDetailViewController.h"
@interface OMPendedViewController ()
/**
 <#annotation#>
 */
@property (nonatomic,strong) NSMutableArray *pendedArray;

@end

@implementation OMPendedViewController
- (NSMutableArray *)pendedArray
{
    if (nil == _pendedArray) {
        _pendedArray = [NSMutableArray array];
    }
    return _pendedArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupPendedViewControllerData];
}
- (void)setupPendedViewControllerData
{
    [self.pendedArray removeAllObjects];
    for (NSInteger i = 0; i < 31; i ++) {
        OMPendedModel *model = [[OMPendedModel alloc] init];
        OMPendedModelFrame *modelFrame = [[OMPendedModelFrame alloc] init];
        model.clientName = [NSString stringWithFormat:@"Facebook International Tec-%ld",i + 1];
        model.orderMoney = [NSString stringWithFormat:@"76.%ld",i];
        model.submitDate = [NSString stringWithFormat:@"2078-08-%ld",i + 1];
        model.submitPeople = [NSString stringWithFormat:@"Bill-%ld",i];
        model.id = [NSString stringWithFormat:@"%ld",i];
        if (i % 3 == 0) {
            model.orderType = @"1";
        }else if (i % 3 == 2)
        {
            model.orderType = @"0";
        }else{
            model.orderType = @"2";
        }

        modelFrame.model = model;
        [self.pendedArray addObject:modelFrame];
    }
    [self.tableView reloadData];
}
#pragma mark---UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.pendedArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OMPendedTableViewCell *cell = [OMPendedTableViewCell pendedTableViewCellWithTableView:tableView];
    cell.modelFrame = self.pendedArray[indexPath.row];
    return cell;
}

#pragma mark---UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"OMPendingTableViewCell-->%ld",indexPath.row);
    OMDetailViewController *pendedDetailVC = [[OMDetailViewController alloc] init];
    if (indexPath.row % 3 == 2) {
        pendedDetailVC.orderType = OMDetailOrderAgreeType;
        
    }else if(indexPath.row % 2 == 1)
    {
        pendedDetailVC.orderType = OMDetailOrderUnapproveType;
        
    }else{
        pendedDetailVC.orderType = OMDetailOrderRefuseType;
        
    }
    OMPendedModelFrame *modelFrame = self.pendedArray[indexPath.row];
    OMPrimaryModel *model = modelFrame.model;
    pendedDetailVC.model = model;
    pendedDetailVC.repealBlock = ^(OMPrimaryModel *model){
        [self.pendedArray removeObject:modelFrame];
        [self.tableView reloadData];
    };
    [self.navigationController pushViewController:pendedDetailVC animated:YES];

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
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
