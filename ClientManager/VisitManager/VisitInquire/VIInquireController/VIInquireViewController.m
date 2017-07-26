//
//  VIInquireViewController.m
//  ClientManager
//**************拜访查询控制器*******************
//  Created by iOS－MacBook on 2017/7/19.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import "VIInquireViewController.h"
#import "VIInquireTableViewCell.h"
#import "VIInquireModel.h"
#import "VIInquireModelFrame.h"
@interface VIInquireViewController ()<UITableViewDelegate,UITableViewDataSource>
/**
 <#annotation#>
 */
@property (nonatomic,weak) UITableView *tableView;
/**
 <#annotation#>
 */
@property (nonatomic,strong) NSMutableArray <VIInquireModelFrame *> *inquireModelArr;

@end

@implementation VIInquireViewController
- (NSMutableArray<VIInquireModelFrame *> *)inquireModelArr
{
    if (nil == _inquireModelArr) {
        _inquireModelArr = [NSMutableArray array];
    }
    return _inquireModelArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupInquireViewControllerSubviews];
    // Do any additional setup after loading the view.
}
- (void)setupInquireViewControllerSubviews
{
    self.title = @"拜访查询";
    self.view.backgroundColor = [AppColor appTableViewBackgroundColor];
    //UITableView设置
    CGFloat tableViewX = 0;
    CGFloat tableViewY = -20;
    CGFloat tableViewWidth = SCREEN_WIDTH;
    CGFloat tableViewHeight = SCREEN_HEIGHT + 20;
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(tableViewX, tableViewY, tableViewWidth, tableViewHeight) style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
}
#pragma mark --- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VIInquireTableViewCell *cell = [VIInquireTableViewCell inquireTableViewCellWithTableView:tableView];
    
    return cell;
}

#pragma mark --- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
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
