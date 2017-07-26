//
//  CIInquireViewController.m
//  ClientManager
//******************客户查询主控制器*****************
//  Created by iOS－MacBook on 2017/7/20.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import "CIInquireViewController.h"
#import "CIModel.h"
#import "CIModelFrame.h"
#import "CIInquireTableViewCell.h"
@interface CIInquireViewController ()<UITableViewDelegate,UITableViewDataSource>
/**
 <#annotation#>
 */
@property (nonatomic,weak) UITableView *tableView;
/**
 <#annotation#>
 */
@property (nonatomic,strong) NSMutableArray <CIModelFrame *> *inquireArr;

@end

@implementation CIInquireViewController
- (NSMutableArray<CIModelFrame *> *)inquireArr
{
    if (nil == _inquireArr) {
        _inquireArr = [NSMutableArray array];
    }
    return _inquireArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupInquireViewControllerSubviews];
    // Do any additional setup after loading the view.
}
- (void)setupInquireViewControllerSubviews
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:tableView];
    [self.view insertSubview:tableView atIndex:0];
    self.tableView = tableView;
    
    //测试数据
    [self.inquireArr removeAllObjects];
    for (NSInteger i = 0; i < 30; i ++) {
        CIModelFrame *modelFrame = [[CIModelFrame alloc] init];
        CIModel *model = [[CIModel alloc] init];
        model.custName = @"杭州阿里巴巴集团有限公司";
        model.managerDescription = @"迪丽热巴.买买提.阿拉丁神灯";
        model.coordinateAddress = @"中国浙江省杭州市慈溪路788号阿里巴巴科技大厦";
       
        modelFrame.model = model;
        [self.inquireArr addObject:modelFrame];
    }
    [self.tableView reloadData];


}
#pragma mark--- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return self.inquireArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CIInquireTableViewCell *cell = [CIInquireTableViewCell inquireTableViewCellWithTableView:tableView];
    CIModelFrame *modelFrame = self.inquireArr[indexPath.row];
    cell.modelFrame = modelFrame;
    return cell;
}
#pragma mark --- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CIModelFrame *modelFrame = self.inquireArr[indexPath.row];
    CIModel *model = modelFrame.model;
   NSLog(@"model.title = %@,indexPath.row = %ld",model.custName,indexPath.row);
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
