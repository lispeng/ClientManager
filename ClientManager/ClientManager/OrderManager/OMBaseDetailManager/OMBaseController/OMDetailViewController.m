//
//  OMDetailViewController.m
//  ClientManager
//------------------订单详情的基类控制器-------------
//  Created by iOS－MacBook on 2017/5/19.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import "OMDetailViewController.h"
#import "OMDetailTableViewCell.h"
#import "OMBaseDetailHeaderView.h"
#import "OMBaseDetailFooterView.h"
#import "OMDetailModel.h"
#import "OMDetailModelFrame.h"
#import "OMPrimaryModel.h"
#import "OMAddOrderViewController.h"
#import "OMStorehouseViewController.h"
#import "OMStoreModel.h"
#import "OverallTextView.h"
#import "OverallParentInputView.h"
#import "OverallInputArrowView.h"
@interface OMDetailViewController ()<UITableViewDelegate,UITableViewDataSource,BaseDetailFooterViewDelegate>
/**
 <#annotation#>
 */
@property (nonatomic,weak) UITableView *tableView;
/**
 <#annotation#>
 */
@property (nonatomic,weak) OMBaseDetailHeaderView *tableHeaderView;
/**
 <#annotation#>
 */
@property (nonatomic,weak) OMBaseDetailFooterView *tableFooterView;
/**
 <#annotation#>
 */
@property (nonatomic,strong) NSMutableArray *orderArray;
/**
 <#annotation#>
 */
@property (nonatomic,weak) UIButton *editBtn;
/**
 <#annotation#>
 */
@property (nonatomic,weak) UIButton *repealBtn;
/**
 <#annotation#>
 */
@property (nonatomic,weak) UIView *bottomContentView;

@end

@implementation OMDetailViewController
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
    //数据请求
    [self requestDetailViewControllerData];

    //初始化子控件
    [self setupDetailViewControllerSubviews];
    //[];
}
/**
 初始化子控件
 */
- (void)setupDetailViewControllerSubviews
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = [AppColor appTableViewBackgroundColor];
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.showsVerticalScrollIndicator = NO;
   // if (self.orderType == OMDetailOrderUnapproveType) {
  //  }
    // tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
   //头部控件
    OMBaseDetailHeaderView *tableHeaderView = [[OMBaseDetailHeaderView alloc] init];
    tableHeaderView.backgroundColor = [UIColor whiteColor];
    tableHeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 300);
    self.tableView.tableHeaderView = tableHeaderView;
    self.tableHeaderView = tableHeaderView;
    self.tableHeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, tableHeaderView.headerHeight + 100);
    //底部的控件
    OMBaseDetailFooterView *tableFooterView = [[OMBaseDetailFooterView alloc] init];
    tableFooterView.delegate = self;
    self.tableView.tableFooterView = tableFooterView;
    self.tableFooterView = tableFooterView;
    
    
    NSInteger sign = arc4random() % 19;
    OMDetailModelFrame *modelFrame = self.orderArray[sign];
    OMDetailModel *model = modelFrame.model;
    self.tableHeaderView.model = model;
    self.tableFooterView.model = model;
    [self.tableView reloadData];

}
- (void)setOrderType:(OMDetailOrderType)orderType
{
    _orderType = orderType;
   // [self setupDetailViewControllerBottomViews];

    if (orderType == OMDetailOrderUnapproveType) {//待审批
      //  [self setupDetailViewControllerBottomViews];
    }else if (orderType == OMDetailOrderAgreeType)//已审批（可以变更）
    {
        
    }
}
- (void)setModel:(OMPrimaryModel *)model
{
    _model = model;
    if ([model.orderType isEqualToString:@"1"]) {// 订单审批的类型(0是未审批，1是已同意，2是已拒绝)
        self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 44);
        [self setupDetailViewControllerBottomViews];
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
        [self.editBtn setTitle:@"拒绝" forState:UIControlStateNormal];
        [self.repealBtn setTitle:@"同意" forState:UIControlStateNormal];
    }else if ([model.orderType isEqualToString:@"0"])//0代表未审批
    {
        self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 44);

        [self setupDetailViewControllerBottomViews];
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);

        [self.editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [self.repealBtn setTitle:@"撤销" forState:UIControlStateNormal];
        
    }else{
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
       // [self.bottomContentView removeFromSuperview];
    }

}
/**
 未审批时显示底部底部可编辑和撤销两按钮
 */
- (void)setupDetailViewControllerBottomViews
{
    //背景View
    UIView *bottomContentView = [[UIView alloc] init];
    bottomContentView.backgroundColor = [AppColor appTableViewBackgroundColor];
    CGFloat bottomContentViewX = 0;
    CGFloat bottomContentViewY = SCREEN_HEIGHT - 44;
    CGFloat bottomContentViewWidth = SCREEN_WIDTH;
    CGFloat bottomContentViewHeight = 44;
    bottomContentView.frame = CGRectMake(bottomContentViewX, bottomContentViewY, bottomContentViewWidth, bottomContentViewHeight);
    [self.view addSubview:bottomContentView];
    self.bottomContentView = bottomContentView;
    //编辑按钮
    UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    editBtn.backgroundColor = [UIColor colorWithRed:250 / 255.0 green:250 / 255.0 blue:250 / 255.0 alpha:1.0];
    [editBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    editBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    CGFloat editBtnWidth = SCREEN_WIDTH / 2 - 0.4;
    CGFloat editBtnHeight = bottomContentViewHeight;
    CGFloat editBtnX = 0;
    CGFloat editBtnY = 0;
    editBtn.frame = CGRectMake(editBtnX, editBtnY, editBtnWidth, editBtnHeight);
   // [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [editBtn addTarget:self action:@selector(detailOrderEditBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bottomContentView addSubview:editBtn];
    self.editBtn = editBtn;
    //撤销按钮
    UIButton *repealBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    repealBtn.backgroundColor = [UIColor colorWithRed:250 / 255.0 green:250 / 255.0 blue:250 / 255.0 alpha:1.0];
    [repealBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    repealBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    CGFloat repealBtnWidth = editBtnWidth;
    CGFloat repealBtnHeight = editBtnHeight;
    CGFloat repealBtnX = SCREEN_WIDTH - repealBtnWidth;
    CGFloat repealBtnY = 0;
    repealBtn.frame = CGRectMake(repealBtnX, repealBtnY, repealBtnWidth, repealBtnHeight);
   // [repealBtn setTitle:@"撤销" forState:UIControlStateNormal];
    [repealBtn addTarget:self action:@selector(detailOrderRepealBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bottomContentView addSubview:repealBtn];
    self.repealBtn = repealBtn;

  
    
}
/**
 待审批是拒绝或 已审批是编辑

 @param sender <#sender description#>
 */
- (void)detailOrderEditBtnClick:(UIButton *)sender
{
    NSLog(@"detailOrderEditBtnClick");
    if(self.orderType == OMDetailOrderAgreeType){//已审批
    OMAddOrderViewController *detailAddVC = [[OMAddOrderViewController alloc] init];
    [self.navigationController pushViewController:detailAddVC animated:YES];
    }else{//待审批
        NSLog(@"待审批->拒绝");
    }
}
/**
 待审批是同意或 已审批是撤销

 */
- (void)detailOrderRepealBtnClick:(UIButton *)sender
{
    if(self.orderType == OMDetailOrderAgreeType){//已审批

    NSLog(@"detailOrderRepealBtnClick");
    if (self.repealBlock) {
        self.repealBlock(self.model);
    }
    [self.navigationController popViewControllerAnimated:YES];
    }else{//待审批
        NSLog(@"待审批->同意");

    }
}
/**
 数据请求
 */
- (void)requestDetailViewControllerData
{
    [self.orderArray removeAllObjects];
    for (NSInteger i = 0; i < 20; i ++) {
        OMDetailModelFrame *modelFrame = [[OMDetailModelFrame alloc] init];
        OMDetailModel *model = [[OMDetailModel alloc] init];
        model.commiter = [NSString stringWithFormat:@"特朗普%u世",arc4random() % 100];
        model.clientName = [NSString stringWithFormat:@"Google%u",arc4random() % 100];
        model.receiver = [NSString stringWithFormat:@"iphone%u",arc4random() % 100000];
        model.receiverTelNum = [NSString stringWithFormat:@"1888728%u",arc4random() % 10000];
        model.commodityUrl = [NSString stringWithFormat:@"%ld.jpg",i];
        model.commodityInfo = [NSString stringWithFormat:@"可口可乐 %uml",arc4random() % 10000];
        model.commodityPrice = [NSString stringWithFormat:@"%u",arc4random() % 100];
        model.commodityUnit = @"箱";
        model.dealPrice = [NSString stringWithFormat:@"%u",arc4random() % 10000];
        model.buyNum = [NSString stringWithFormat:@"%u",arc4random() % 10000];
        model.totalMoney = [NSString stringWithFormat:@"%u",arc4random() % 100000000];
        model.remarks = [NSString stringWithFormat:@"轻轻地，初夏的脚步近了，薰衣草丛里飘来阵阵花香。你穿着紫色的衣裙，踏着高跟鞋，戴着紫色的帽子，陶醉在紫色的海洋中。夏光清浅，绿意染心。走在绿色的世界里，你在生机勃勃的初夏时光里，闻花香，跳着曼妙的舞蹈，你是初夏的花朵，你是初夏的绿叶，你是初夏的阳光，与夏日时光缠缠绵绵。%u",arc4random() % 1000];
        if (i % 3 == 0) {
            model.orderType = @"1";
        }else if (i % 3 == 2)
        {
            model.orderType = @"0";
        }else{
            model.orderType = @"2";
        }
        model.storehouse = [NSString stringWithFormat:@"美国苹果科技公司%u",arc4random() % 10000];
        model.delivery = [NSString stringWithFormat:@"贝克汉姆%u",arc4random() % 10000];
        model.verifier = [NSString stringWithFormat:@"比尔.盖茨%u",arc4random() % 10000];
        model.reviewTime = [NSString stringWithFormat:@"2017-5-%u",arc4random() % 30];
        model.reviewIdea = [NSString stringWithFormat:@"夏风微凉，吹过你的发。你的乌发随风飘舞，你像风中的仙女，乌发飘扬，美丽动人。风中的你，轻轻地舞蹈，衣裙在飘舞。你的舞蹈，那样轻灵，那样妩媚。轻舞飞扬，你的心随风荡漾，你的情随风缠绵，你的灵魂随风游走。你的容颜因风清丽，你的生命因风生动深刻，你的心灵因风风景如画。%u",arc4random() % 10000];
        modelFrame.model = model;
        [self.orderArray addObject:modelFrame];
    }
    
}
#pragma mark---UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.orderArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OMDetailTableViewCell *cell = [OMDetailTableViewCell detailTableViewCellWithTableView:tableView];
    cell.modelFrame = self.orderArray[indexPath.row];
    return cell;
}
#pragma mark---UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return self.tableHeaderView.headerHeight - 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}
#pragma mark---BaseDetailFooterViewDelegate
- (void)baseDetailFooterViewArrowViewEditWithArrowView:(OverallInputArrowView *)arrowView
{
    if ([arrowView.titleLabel.text isEqualToString:@"出货仓库"]) {
        OMStorehouseViewController *storehouseVC = [[OMStorehouseViewController alloc] init];
        storehouseVC.storeBlcok = ^(OMStoreModel *model) {
            arrowView.textField.text = model.storehouse;
        };
        [self.navigationController pushViewController:storehouseVC animated:YES];

    }
 
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
