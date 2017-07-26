//
//  OMOrderInfoViewController.m
//  ClientManager
//***************商品信息主页*********************
//  Created by iOS－MacBook on 2017/5/12.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import "OMOrderInfoViewController.h"
#import "OMOrderModel.h"
#import "OMOrderScrollView.h"
//#import "LSPSlideShowView.h"
@interface OMOrderInfoViewController ()
/**
 滚动视图背景
 */
@property (nonatomic,weak) OMOrderScrollView *orderScrollView;
/**
 <#annotation#>
 */
@property (nonatomic,strong) OMOrderModel *model;

@end

@implementation OMOrderInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //创建模拟数据
    [self createOrderInfoData];
    //初始化视图背景
    [self setupOrderInfoViewControllerSubviews];
}
- (void)createOrderInfoData
{
    OMOrderModel *model = [[OMOrderModel alloc] init];
    model.commodityName = @"iphone8s";
    model.specs = @"台";
    model.price = @"6888";
    model.brand = @"Apple Inc";
    model.category = @"科技产品";
    model.productArea = @"美国加州库比蒂诺";
    model.stock = @"8900";
    model.remarks = @"Apple 致力于设计、开发和销售消费电子产品、计算机软件、在线服务和个人计算机，总部位于美国加利福尼亚州库比蒂诺。凭借 iPhone、iPad、Mac、Apple Watch、iOS、MacOS、watchOS 等产品推动了全球创新。你可以访问网站，了解和购买产品，并获得技术支持。";
    self.model = model;
}
/**
 初始化视图背景
 */
- (void)setupOrderInfoViewControllerSubviews
{
    OMOrderScrollView *orderScrollView = [[OMOrderScrollView alloc] init];
    orderScrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    orderScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
    orderScrollView.model = self.model;
    [self.view addSubview:orderScrollView];
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
