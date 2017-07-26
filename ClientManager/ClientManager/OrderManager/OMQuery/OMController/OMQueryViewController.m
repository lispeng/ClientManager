//
//  OMQueryViewController.m
//  ClientManager
//
//  Created by iOS－MacBook on 2017/5/11.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import "OMQueryViewController.h"
#import "NSString+Extension.h"
#import "OverallTextView.h"
#import "OMQueryModel.h"
@interface OMQueryViewController ()<UITextViewDelegate,UITextFieldDelegate>
/**
 <#annotation#>
 */
@property (nonatomic,weak) UIScrollView *scrollView;
/**
 客户名称
 */
@property (nonatomic,weak) OverallTextView *clientTextView;

/**
 开始日期
 */
@property (nonatomic,weak) OverallTextView *beginDateTextView;
/**
 结束日期
 */
@property (nonatomic,weak) OverallTextView *endDateTextView;

@end

@implementation OMQueryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //初始化导航栏
    [self setupOrderQueryViewControllerNavigationBar];
    //初始化控件
    [self setupOrderQueryViewControllerSubviews];
}
/**
 初始化查询的导航栏
 */
- (void)setupOrderQueryViewControllerNavigationBar
{
    self.navigationController.title = @"筛选";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStyleDone target:self action:@selector(orderQueryCommit)];
}
/**
 初始化查询的内部子控件
 */
- (void)setupOrderQueryViewControllerSubviews
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    //背景容器
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor whiteColor];
    CGFloat contentViewX = 0;
    CGFloat contentViewY = 0;
    CGFloat contentViewWidth = SCREEN_WIDTH;
    CGFloat contentViewHeight = OMDetailH * 4;
    contentView.frame = CGRectMake(contentViewX, contentViewY, contentViewWidth, contentViewHeight);
    [self.scrollView addSubview:contentView];
    //客户名称
    NSString *clientStr = @"客户名称";
    CGSize clientSize = [clientStr sizeWithFont:OMDetailFont];
    UILabel *clientLalbel = [[UILabel alloc] init];
    clientLalbel.textColor = [UIColor blackColor];
    clientLalbel.font = OMDetailFont;
    CGFloat clientLalbelX = OMDetailMargin;
    CGFloat clientLalbelY = 0;
    CGFloat clientLalbelWidth = clientSize.width;
    CGFloat clientLalbelHeight = OMDetailH;
    clientLalbel.frame = CGRectMake(clientLalbelX, clientLalbelY, clientLalbelWidth, clientLalbelHeight);
    clientLalbel.text = clientStr;
    [contentView addSubview:clientLalbel];
    
    OverallTextView *clientTextView = [[OverallTextView alloc] init];
    clientTextView.placeholder = @"请输入";
    CGFloat clientTextViewX = CGRectGetMaxX(clientLalbel.frame) + OMDetailContentMargin;
    CGFloat clientTextViewY = clientLalbelY;
    CGFloat clientTextViewWidth = SCREEN_WIDTH - clientTextViewX - OMDetailMargin;
    CGFloat clientTextViewHeight = clientLalbelHeight;
    clientTextView.frame = CGRectMake(clientTextViewX, clientTextViewY, clientTextViewWidth, clientTextViewHeight);
    clientTextView.isRight = YES;
    clientTextView.delegate = self;
    [contentView addSubview:clientTextView];
    self.clientTextView = clientTextView;
    //客户名称底部的分割线
    UIView *clientUnderLine = [[UIView alloc] init];
    CGFloat clientUnderLineX = 0;
    CGFloat clientUnderLineY = clientLalbelHeight - 0.4;
    CGFloat clientUnderLineWidth = SCREEN_WIDTH;
    CGFloat clientUnderLineHeight = 0.4;
    clientUnderLine.frame = CGRectMake(clientUnderLineX, clientUnderLineY, clientUnderLineWidth, clientUnderLineHeight);
    clientUnderLine.backgroundColor = [AppColor appTableCellSeparatLineColor];
    [contentView addSubview:clientUnderLine];

    
    //提交日期
    NSString *commitDateStr = @"提交日期";
    CGSize commitDateSize = [clientStr sizeWithFont:OMDetailFont];
    UILabel *commitDateLalbel = [[UILabel alloc] init];
    commitDateLalbel.textColor = [UIColor blackColor];
    commitDateLalbel.font = OMDetailFont;
    CGFloat commitDateLalbelX = OMDetailMargin;
    CGFloat commitDateLalbelY = CGRectGetMaxY(clientLalbel.frame) + (OMDetailH * 2 - commitDateSize.height) / 2;
    CGFloat commitDateLalbelWidth = commitDateSize.width;
    CGFloat commitDateLalbelHeight = commitDateSize.height;
    commitDateLalbel.frame = CGRectMake(commitDateLalbelX, commitDateLalbelY, commitDateLalbelWidth, commitDateLalbelHeight);
    commitDateLalbel.text = commitDateStr;
    [contentView addSubview:commitDateLalbel];
    //选择开始的日期
    OverallTextView *beginDateTextView = [[OverallTextView alloc] init];
    beginDateTextView.placeholder = @"请选择开始日期";
    CGFloat beginDateTextViewX = CGRectGetMaxX(commitDateLalbel.frame) + OMDetailMargin;
    CGFloat beginDateTextViewY = CGRectGetMaxY(clientLalbel.frame);
    CGFloat beginDateTextViewWidth = SCREEN_WIDTH - beginDateTextViewX - OMDetailMargin;
    CGFloat beginDateTextViewHeight = clientLalbelHeight;
    beginDateTextView.frame = CGRectMake(beginDateTextViewX, beginDateTextViewY, beginDateTextViewWidth, beginDateTextViewHeight);
    beginDateTextView.isRight = YES;
    beginDateTextView.delegate = self;
    [contentView addSubview:beginDateTextView];
    self.beginDateTextView = beginDateTextView;
    //开始日期的点击事件
    UIButton *beginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    beginBtn.backgroundColor = [UIColor clearColor];
    CGFloat beginBtnX = 0;
    CGFloat beginBtnY = 0;
    CGFloat beginBtnWidth = beginDateTextViewWidth;
    CGFloat beginBtnHeight = beginDateTextViewHeight;
    beginBtn.frame = CGRectMake(beginBtnX, beginBtnY, beginBtnWidth, beginBtnHeight);
    [beginBtn addTarget:self action:@selector(beginDateTextViewClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.beginDateTextView addSubview:beginBtn];
   //提交日期对应的右侧分割线
    UIView *commitUnderLine = [[UIView alloc] init];
    CGFloat commitUnderLineX = beginDateTextViewX;
    CGFloat commitUnderLineY = commitDateLalbelY + commitDateLalbelHeight / 2 - 0.4;
    CGFloat commitUnderLineWidth = SCREEN_WIDTH - commitUnderLineX;
    CGFloat commitUnderLineHeight = 0.4;
    commitUnderLine.frame = CGRectMake(commitUnderLineX, commitUnderLineY, commitUnderLineWidth, commitUnderLineHeight);
    commitUnderLine.backgroundColor = [AppColor appTableCellSeparatLineColor];
    [contentView addSubview:commitUnderLine];
    //选择结束的日期
    OverallTextView *endDateTextView = [[OverallTextView alloc] init];
    endDateTextView.placeholder = @"请选择结束日期";
    CGFloat endDateTextViewX = beginDateTextViewX;
    CGFloat endDateTextViewY = CGRectGetMaxY(self.beginDateTextView.frame);
    CGFloat endDateTextViewWidth = beginDateTextViewWidth;
    CGFloat endDateTextViewHeight = clientLalbelHeight;
    endDateTextView.frame = CGRectMake(endDateTextViewX, endDateTextViewY, endDateTextViewWidth, endDateTextViewHeight);
    endDateTextView.isRight = YES;
    endDateTextView.delegate = self;
    [contentView addSubview:endDateTextView];
    self.endDateTextView = endDateTextView;
    //结束日期的点击事件
    UIButton *endBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    beginBtn.backgroundColor = [UIColor clearColor];
    CGFloat endBtnX = 0;
    CGFloat endBtnY = 0;
    CGFloat endBtnWidth = endDateTextViewWidth;
    CGFloat endBtnHeight = endDateTextViewHeight;
    endBtn.frame = CGRectMake(endBtnX, endBtnY, endBtnWidth, endBtnHeight);
    [endBtn addTarget:self action:@selector(endDateTextViewClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.endDateTextView addSubview:endBtn];

    //提交日期最底部的分割线
    UIView *commitMaxUnderLine = [[UIView alloc] init];
    CGFloat commitMaxUnderLineX = 0;
    CGFloat commitMaxUnderLineY = commitUnderLineY + clientLalbelHeight - 0.4;
    CGFloat commitMaxUnderLineWidth = SCREEN_WIDTH;
    CGFloat commitMaxUnderLineHeight = 0.4;
    commitMaxUnderLine.frame = CGRectMake(commitMaxUnderLineX, commitMaxUnderLineY, commitMaxUnderLineWidth, commitMaxUnderLineHeight);
    commitMaxUnderLine.backgroundColor = [AppColor appTableCellSeparatLineColor];
    [contentView addSubview:commitMaxUnderLine];

    
    
}
/**
 <#Description#>

 @param sender <#sender description#>
 */
- (void)beginDateTextViewClick:(UIButton *)sender
{
    self.beginDateTextView.text = @"2089-07-28";
    NSLog(@"请选择开始日期");
}
/**
 点击选择结束日期

 @param sender <#sender description#>
 */
- (void)endDateTextViewClick:(UIButton *)sender
{
    self.endDateTextView.text = @"2090-10-18";
    NSLog(@"请选择结束日期");

}
/**
 提交查询
 */
- (void)orderQueryCommit
{
    NSLog(@"orderQueryCommit");
    OMQueryModel *model = [[OMQueryModel alloc] init];
    model.client = self.clientTextView.text;
    model.startDate = self.beginDateTextView.text;
    model.endDate = self.endDateTextView.text;
    if (self.queryCallBackBlock) {
        self.queryCallBackBlock(model);
    }
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
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
