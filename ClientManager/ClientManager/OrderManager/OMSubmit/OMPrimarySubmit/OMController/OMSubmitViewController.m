//
//  OMSubmitViewController.m
//  ClientManager
//
//  Created by iOS－MacBook on 2017/5/10.
//  Copyright © 2017年 Lispeng. All rights reserved.
//***********************提交的控制器******************/

#import "OMSubmitViewController.h"
#import "OMPrimaryModel.h"
#import "OMSubmitModel.h"
#import "OMSubmitModelFrame.h"
#import "OMSubmitTableViewCell.h"
#import "MJExtension.h"
#import "OMDetailViewController.h"
@interface OMSubmitViewController ()
/**
 <#annotation#>
 */
@property (nonatomic,strong) NSMutableArray *submitArray;

@end

@implementation OMSubmitViewController
- (NSMutableArray *)submitArray
{
    if (nil == _submitArray) {
        _submitArray = [NSMutableArray array];
    }
    return _submitArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubmitViewControllerData];
    // Do any additional setup after loading the view.
}
- (void)setupSubmitViewControllerData
{
    [self.submitArray removeAllObjects];

    NSMutableArray *dictArray = [NSMutableArray array];
       for (NSInteger i = 0; i < 101; i ++) {
           NSDictionary *dict = @{
                                  @"clientName" : @"Apple Inc",
                                  @"orderMoney" : @"9767789690.789",
                                  @"submitDate" : @"2017-07-28",
                                  @"submitPeople" : @"Jim Green"
                                  
                                  };
           [dictArray addObject:dict];
    }
    for (NSInteger i = 0; i < dictArray.count; i ++) {
        OMSubmitModelFrame *modelFrame = [[OMSubmitModelFrame alloc] init];
        OMSubmitModel *model = [OMSubmitModel mj_objectWithKeyValues:dictArray[i]];
        model.id = [NSString stringWithFormat:@"%ld",i];
        if (i % 2 == 0) {
            model.orderMoney = @"123";
        }
        if (i % 3 == 0) {
            model.orderType = @"1";
        }else if (i % 3 == 2)
        {
            model.orderType = @"0";
        }else{
            model.orderType = @"2";
        }

        modelFrame.model = model;
        [self.submitArray addObject:modelFrame];

    }
//       for (NSInteger i = 0; i < 31; i ++) {
//        OMSubmitModel *model = [[OMSubmitModel alloc] init];
//        OMSubmitModelFrame *modelFrame = [[OMSubmitModelFrame alloc] init];
//        model.clientName = [NSString stringWithFormat:@"Apple International Tec-%ld",i + 1];
//        model.orderMoney = [NSString stringWithFormat:@"7688889.%ld",i];
//        model.submitDate = [NSString stringWithFormat:@"2078-08-%ld",i + 1];
//        model.submitPeople = [NSString stringWithFormat:@"Bill Gaze-%ld",i];
//        modelFrame.model = model;
//        [self.submitArray addObject:modelFrame];
//    }
    [self.tableView reloadData];
}
#pragma mark---UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.submitArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OMSubmitTableViewCell *cell = [OMSubmitTableViewCell submitTableViewCellWithTableView:tableView];
    cell.modelFrame = self.submitArray[indexPath.row];
    return cell;
}

#pragma mark---UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"OMSubmitTableViewCell-->%ld",indexPath.row);
    OMDetailViewController *submitDetailVC = [[OMDetailViewController alloc] init];
    if (indexPath.row % 2 == 0) {
        submitDetailVC.orderType = OMDetailOrderAgreeType;

    }else if(indexPath.row % 2 == 1)
    {
        submitDetailVC.orderType = OMDetailOrderUnapproveType;

    }else{
        submitDetailVC.orderType = OMDetailOrderRefuseType;

    }
    OMSubmitModelFrame *modelFrame = self.submitArray[indexPath.row];
    OMPrimaryModel *model = modelFrame.model;
    submitDetailVC.model = model;
    submitDetailVC.repealBlock = ^(OMPrimaryModel *model){
        [self.submitArray removeObject:modelFrame];
        [self.tableView reloadData];
    };
    [self.navigationController pushViewController:submitDetailVC animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}



- (void)dealloc
{
    NSLog(@"SubmitView---dealloc");
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
