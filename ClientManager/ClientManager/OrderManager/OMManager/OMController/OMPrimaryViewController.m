//
//  OMPrimaryViewController.m
//  ClientManager
//
//  Created by iOS－MacBook on 2017/5/10.
//  Copyright © 2017年 Lispeng. All rights reserved.
//********************订单管理主页控制器*****************

#import "OMPrimaryViewController.h"
#import "OMQueryViewController.h"//查询订单
#import "OMAddOrderViewController.h"//新增订单
#import "OMPrimaryTableViewController.h"//父控制器
#import "OMSubmitViewController.h"//已提交
#import "OMPendingViewController.h"//待审批
#import "OMPendedViewController.h"//已审批
@interface OMPrimaryViewController ()<UIScrollViewDelegate>
/**
 *  导航栏下面的导航条
 */
@property (nonatomic,weak) UIView *titlesView;
/**
 *  导航栏按钮下面的红色指示器
 */
@property (nonatomic,weak) UIView *indicatorView;
/**
 选中的按钮
 */
@property (nonatomic,strong) UIButton *selectedBtn;
/**
 <#annotation#>
 */
@property (nonatomic,weak) UIView *verticalBgLine;
/**
 <#annotation#>
 */
@property (nonatomic,weak) UIScrollView *scrollView;
/**
 <#annotation#>
 */
@property (nonatomic,weak) UIBarButtonItem *searchItem;

@end

@implementation OMPrimaryViewController
{
    OMSubmitViewController *submitVC;
    OMPendingViewController *pendingVC;
    OMPendedViewController *pendedVC;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [AppColor appTableViewBackgroundColor];
    
    // Do any additional setup after loading the view.
    //初始化NavigationBar上面的查询和添加的按钮
    [self setupPrimaryViewForNavigationBar];
    //初始化scrollView内部的子控件
    [self setupPrimaryViewForChildViewControllers];
    //初始化标题栏的按钮
    [self setupPrimaryViewForTitlesLineView];
    //初始化子控件的背景容器ScrollView
    [self setupPrimaryViewForBackgroundScrollView];
    
    
}
/**
 初始化NavigationBar上面的查询和添加的按钮
 */
- (void)setupPrimaryViewForNavigationBar
{
    
    self.navigationItem.title = @"订单管理";
    //设置导航栏左边的按钮
    UIBarButtonItem *addItem = [UIBarButtonItem itemWithImage:@"s-3.0-j" highlightImage:@"s-3.0-j" target:self action:@selector(addOrderButtonClick:)];
    // UIBarButtonItem *tempItem = [UIBarButtonItem itemWithImage:@"" highlightImage:@"" target:self action:nil];
    UIView *tempView = [[UIView alloc] init];
    tempView.backgroundColor = [UIColor clearColor];
    tempView.frame = CGRectMake(0, 0, 10, 10);
    UIBarButtonItem *tempItem = [[UIBarButtonItem alloc] initWithCustomView:tempView];
    UIBarButtonItem *searchItem = [UIBarButtonItem itemWithImage:@"s-3.0-ss" highlightImage:@"s-3.0-ss@2x" target:self action:@selector(searchOrderButtonClick:)];
    self.navigationItem.rightBarButtonItems = @[addItem,tempItem,searchItem];
    self.searchItem = searchItem;
    
}
/**
 添加订单

 @param item <#item description#>
 */
- (void)addOrderButtonClick:(UIBarButtonItem *)item
{
    NSLog(@"addOrderButtonClick");
    OMAddOrderViewController *addOrderVC = [[OMAddOrderViewController alloc] init];
    [self.navigationController pushViewController:addOrderVC animated:YES];
}
/**
 查询订单

 @param Item <#Item description#>
 */
- (void)searchOrderButtonClick:(UIBarButtonItem *)Item
{
    NSLog(@"searchOrderButtonClick");
    OMQueryViewController *orderVC = [[OMQueryViewController alloc] init];
    [self.navigationController pushViewController:orderVC animated:YES];
}
/**
 初始化标题栏的按钮

 */
- (void)setupPrimaryViewForTitlesLineView
{
    //背景容器设置
    UIView *bgView = [[UIView alloc] init];
    bgView.y = 64;
    bgView.width = self.view.width;
    bgView.height = 44;
    bgView.backgroundColor = [UIColor whiteColor];
    // bgView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:bgView];
    self.titlesView = bgView;
    //创建导航条按钮下面的红色指示器
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.height = 2;
    indicatorView.y = bgView.height - indicatorView.height;
    indicatorView.backgroundColor = [UIColor orangeColor];
    self.indicatorView = indicatorView;
    
    //背景容器里面的点击按钮设置
    NSInteger count = 3;
    CGFloat btnW = self.view.width / count;
    CGFloat btnH = bgView.height;
    CGFloat btnY = 0;
    for (NSInteger i = 0; i < count; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        btn.frame = CGRectMake(i * btnW, btnY, btnW, btnH);
        //        UIViewController *childVC = self.childViewControllers[i];
        NSString *titleText;
        if (i == 0) {
            titleText = submitVC.title;
        } else if (i == 1) {
            titleText = pendingVC.title;
        } else if (i == 2) {
            titleText = pendedVC.title;
        }
        [btn setTitle:titleText forState:UIControlStateNormal];
        // [btn layoutIfNeeded];//更新布局控件
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateDisabled];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn addTarget:self action:@selector(orderManagerPrimaryTitleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:btn];
        
        //默认点击了第一个按钮
        if (0 == i) {
            btn.enabled = NO;
            self.selectedBtn = btn;
            //让按钮内部的label根据文字大小来计算尺寸
            [btn.titleLabel sizeToFit];
            self.indicatorView.width = btn.width;
            self.indicatorView.centerX = btn.centerX;
        }
        
    }
    CGFloat lineMargin = 6;
    CGFloat lineH = btnH - lineMargin * 2;
    UIView *line1 = [[UIView alloc] init];
    line1.backgroundColor = [AppColor appTableCellSeparatLineColor];
    line1.frame = CGRectMake(btnW - 0.25, lineMargin, 0.5, lineH);
    [self.titlesView addSubview:line1];
    
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = [AppColor appTableCellSeparatLineColor];
    line2.frame = CGRectMake(btnW * 2 - 0.25, lineMargin, 0.5, lineH);
    [self.titlesView addSubview:line2];
    
    UIView *verticalBgLine = [[UIView alloc] init];
    verticalBgLine.backgroundColor = [AppColor appTableCellSeparatLineColor];
    verticalBgLine.frame = CGRectMake(0, 43, SCREEN_WIDTH, 1.5);
    [self.titlesView addSubview:verticalBgLine];
    self.verticalBgLine = verticalBgLine;
    [bgView addSubview:indicatorView];
  
}
/**
 初始化ScrollView内部的子控件
 */
- (void)setupPrimaryViewForChildViewControllers
{
    //提交的
    submitVC = [[OMSubmitViewController alloc] init];
    submitVC.title = @"提交的";
    [self addChildViewController:submitVC];
    
    //待审批
    pendingVC = [[OMPendingViewController alloc] init];
    pendingVC.title = @"待审批";
    [self addChildViewController:pendingVC];
    
    //已审批
    pendedVC = [[OMPendedViewController alloc] init];
    pendedVC.title = @"已审批";
    [self addChildViewController:pendedVC];

}
/**
 初始化背景ScrollView
 */
- (void)setupPrimaryViewForBackgroundScrollView
{
    //不要自动调整scrollView的内边距
    //self.automaticallyAdjustsScrollViewInsets = NO;
    //创建UISCrollView对象
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = CGRectMake(0, 45, SCREEN_WIDTH, SCREEN_HEIGHT - 45);//45->64
    // scrollView.backgroundColor = [UIColor orangeColor];
    scrollView.contentSize = CGSizeMake(scrollView.width * 3, 0);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.backgroundColor = [AppColor appTableViewBackgroundColor];
    [self.view insertSubview:scrollView atIndex:0];
    self.scrollView = scrollView;
    
    //添加第一个控制器的View
    [self scrollViewDidEndScrollingAnimation:scrollView];
  
}
/**
 点击导航条的按钮触发的方法

 @param sender <#sender description#>
 */
- (void)orderManagerPrimaryTitleBtnClick:(UIButton *)sender
{
    //修改按钮的状态
    self.selectedBtn.enabled = YES;
    sender.enabled = NO;
    self.selectedBtn = sender;
    //按钮底部指示器动画
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = sender.width;
        self.indicatorView.x = sender.x;
    }];

    if ([sender.currentTitle isEqualToString:@"提交的"]) {//点击提交的按钮
        [self setupPrimaryViewForNavigationBar];
        NSLog(@"%@",sender.currentTitle);
    }else if ([sender.currentTitle isEqualToString:@"待审批"])
    {
        self.navigationItem.rightBarButtonItems = @[self.searchItem];
        NSLog(@"%@",sender.currentTitle);

    }else if ([sender.currentTitle isEqualToString:@"已审批"])
    {
        self.navigationItem.rightBarButtonItems = @[self.searchItem];
        NSLog(@"%@",sender.currentTitle);


    }
    
    
    //滚动
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = sender.tag * self.scrollView.width;
    [self.scrollView setContentOffset:offset animated:YES];
    

}



#pragma mark----<UIScrollViewDelegate>
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    //获取当前的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    //取出子控制器
    UITableViewController *childVC;
    if (index == 0) {
        childVC = submitVC;
        NSLog(@"OMSubmitViewController");
    } else if (index == 1) {
        childVC = pendingVC;
        NSLog(@"OMPendingViewController");
    } else if (index == 2) {
        childVC = pendedVC;
        NSLog(@"OMPendedViewController");
    }
    
    childVC.view.x = scrollView.contentOffset.x;
    childVC.view.y = 10;
    childVC.view.height = scrollView.height;//设置控制器的view的高度为整个屏幕的高度
    childVC.view.backgroundColor = [AppColor appTableViewBackgroundColor];
    [scrollView addSubview:childVC.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    //点击按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self orderManagerPrimaryTitleBtnClick:self.titlesView.subviews[index]];
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
