//
//  OMStorehouseViewController.m
//  ClientManager
//-----------仓库选择主控制器--------------
//  Created by iOS－MacBook on 2017/5/23.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import "OMStorehouseViewController.h"
#import "OMStorehouseTableViewCell.h"
#import "OMStoreModel.h"
@interface OMStorehouseViewController ()<UITableViewDataSource,UITableViewDelegate>
/**
 <#annotation#>
 */
@property (nonatomic,weak) UITableView *tableView;
/**
 <#annotation#>
 */
@property (nonatomic,strong) NSMutableArray *storeArray;

@end

@implementation OMStorehouseViewController
- (NSMutableArray *)storeArray
{
    if (nil == _storeArray) {
        _storeArray = [NSMutableArray array];
    }
    return _storeArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupStorehouseViewControllerSubviews];
    [self requestStorehouseViewControllerData];
    // Do any additional setup after loading the view.
}
- (void)setupStorehouseViewControllerSubviews
{
    self.title = @"出货仓库";
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.contentInset = UIEdgeInsetsMake(-30, 0, 0, 0);
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;

}
- (void)requestStorehouseViewControllerData
{
    [self.storeArray removeAllObjects];
    for (NSInteger i = 0; i < 50; i ++) {
        OMStoreModel *model = [[OMStoreModel alloc] init];
        model.storehouse = [NSString stringWithFormat:@"Apple International Tec-%ld",i + 1];
        [self.storeArray addObject:model];
    }
    [self.tableView reloadData];
}
#pragma mark--UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.storeArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OMStorehouseTableViewCell *cell = [OMStorehouseTableViewCell storehouseTableViewCellWithTableView:tableView];
    cell.model = self.storeArray[indexPath.row];
    return cell;
}
#pragma mark -- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return OMDetailH;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OMStoreModel *model = self.storeArray[indexPath.row];
    if (self.storeBlcok) {
        self.storeBlcok(model);
    }
    [self.navigationController popViewControllerAnimated:YES];
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
