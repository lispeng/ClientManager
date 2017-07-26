//
//  OMPendingViewController.m
//  ClientManager
//
//  Created by iOS－MacBook on 2017/5/10.
//  Copyright © 2017年 Lispeng. All rights reserved.
//*********************待审批控制器*************************

#import "OMPendingViewController.h"
#import "OMPendingModel.h"
#import "OMPendingModelFrame.h"
#import "OMPendingTableViewCell.h"
#import "OMDetailViewController.h"
@interface OMPendingViewController ()
/**
 <#annotation#>
 */
@property (nonatomic,strong) NSMutableArray *pendingArray;
/**
 待审批的数据
 */
@property (nonatomic,strong) NSMutableArray *pendingDataArray;

@end

@implementation OMPendingViewController
-(NSMutableArray *)pendingArry
{
    if (nil == _pendingArray) {
        _pendingArray = [NSMutableArray array];
    }
    return _pendingArray;
}
- (NSMutableArray *)pendingDataArray
{
    if (nil == _pendingDataArray) {
        _pendingDataArray = [NSMutableArray array];
    }
    return _pendingDataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupPendingViewControllerData];
}
- (void)setupPendingViewControllerData
{
    [self.pendingDataArray removeAllObjects];
    for (NSInteger i = 0; i < 31; i ++) {
        OMPendingModel *model = [[OMPendingModel alloc] init];
        OMPendingModelFrame *modelFrame = [[OMPendingModelFrame alloc] init];
        model.clientName = [NSString stringWithFormat:@"Google%ld",i + 1];
        model.orderMoney = [NSString stringWithFormat:@"7688889.%ld",i];
        model.submitDate = [NSString stringWithFormat:@"2078-08-%ld",i + 1];
        model.submitPeople = [NSString stringWithFormat:@"Bill Gaze-%ld",i];
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
        [self.pendingDataArray addObject:modelFrame];
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
    return self.pendingDataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OMPendingTableViewCell *cell = [OMPendingTableViewCell pendingTableViewCellWithTableView:tableView];
    cell.modelFrame = self.pendingDataArray[indexPath.row];
    return cell;
}

#pragma mark---UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"OMPendingTableViewCell-->%ld",indexPath.row);
    OMDetailViewController *pendingDetailVC = [[OMDetailViewController alloc] init];
    if (indexPath.row % 2 == 1) {
        pendingDetailVC.orderType = OMDetailOrderAgreeType;
        
    }else if(indexPath.row % 2 == 0)
    {
        pendingDetailVC.orderType = OMDetailOrderUnapproveType;
        
    }else{
        pendingDetailVC.orderType = OMDetailOrderRefuseType;
        
    }
    OMPendingModelFrame *modelFrame = self.pendingDataArray[indexPath.row];
    OMPrimaryModel *model = modelFrame.model;
    pendingDetailVC.model = model;
    pendingDetailVC.repealBlock = ^(OMPrimaryModel *model){
        [self.pendingDataArray removeObject:modelFrame];
        [self.tableView reloadData];
    };

    [self.navigationController pushViewController:pendingDetailVC animated:YES];
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
