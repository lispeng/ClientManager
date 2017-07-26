//
//  OMAddOrderViewController.m
//  ClientManager
//******************新增订单主页面***********************
//  Created by iOS－MacBook on 2017/5/11.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import "OMAddOrderViewController.h"
#import "NSString+Extension.h"
#import "OMAddModel.h"
#import "OMAddModelFrame.h"
#import "OMAddOrderTableViewCell.h"
#import "OMOrderEditInfoViewController.h"
#import "OMOrderInfoViewController.h"
#import "OverallInputView.h"
#import "OverallInputArrowView.h"
#import "OverallTextView.h"
#import "OMIncreaseHeaderView.h"
#import "OMIncreaseFooterView.h"
#import "OMListModel.h"
#import "OMTypeModel.h"
#import "OMDetailModel.h"
#import "OMClientViewController.h"
#import "OMClientModel.h"
#import "ClientManagerViewController.h"
#define AddOrderMargin 10
#define AddOrderContentMargin 5
#define OMAddOrderFont [UIFont systemFontOfSize:15]
@interface OMAddOrderViewController ()<UITableViewDelegate,UITableViewDataSource,OMIncreaseFooterViewDelegate,OMIncreaseHeaderViewDelegate>
/**
 <#annotation#>
 */
@property (nonatomic,weak) UITableView *tableView;
/**
 <#annotation#>
 */
@property (nonatomic,weak) OMIncreaseHeaderView *tableHeaderView;

/**
 <#annotation#>
 */
@property (nonatomic,weak) OMIncreaseFooterView *tableFooterView;
/**
 存放OMAddModelFrame的数组
 */
@property (nonatomic,strong) NSMutableArray *addOrderArray;
/**
 <#annotation#>
 */
@property (nonatomic,strong) NSMutableArray *typeArray;

/**
 <#annotation#>
 */
@property (nonatomic,assign) CGFloat tempHeight;
/**
 <#annotation#>
 */
@property (nonatomic,weak) OverallInputView *inputView;
/**
 <#annotation#>
 */
@property (nonatomic,weak) OverallInputView *lastInputView;

/**
 <#annotation#>
 */
@property (nonatomic,assign) CGFloat keyboardHeight;
/**
 底部的工具条
 */
@property (nonatomic,weak) UIView *bottomView;
/**
 合计金额
 */
@property (nonatomic,weak) UILabel *totalLabel;
/**
 提交按钮
 */
@property (nonatomic,weak) UIButton *commitBtn;

@end

@implementation OMAddOrderViewController
- (NSMutableArray *)addOrderArray
{
    if (nil == _addOrderArray) {
        _addOrderArray = [NSMutableArray array];
    }
    return _addOrderArray;
}
- (NSMutableArray *)typeArray
{
    if (nil == _typeArray) {
        _typeArray = [NSMutableArray array];
    }
    return _typeArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新增订单";
    //初始化新增订单的内部子控件
    [self setupAddOrderViewControllerSubviews];
    //创建底部的工具条
    [self setupAddOrderViewControllerBottomSubviews];
    //数据请求
    [self addOrderViewControllerRequestData];
    //其他
    [self testApp];
    // Do any additional setup after loading the view.
}
/**
 初始化新增订单的内部子控件
 */
- (void)setupAddOrderViewControllerSubviews
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 44) style:UITableViewStyleGrouped];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = [AppColor appTableViewBackgroundColor];
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.showsVerticalScrollIndicator = NO;
   // tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    //UItableView的表头设置
    OMIncreaseHeaderView *tableHeaderView = [[OMIncreaseHeaderView alloc] init];
    tableHeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 44 * 3 + 5 + 0.8 + 60);
   // tableHeaderView.backgroundColor = [UIColor redColor];
    tableHeaderView.delegate = self;
    tableView.tableHeaderView = tableHeaderView;
    __weak typeof(self)weakSelf = self;
    tableHeaderView.handBlock = ^{
        __strong typeof(weakSelf)strongSelf = weakSelf;
        ClientManagerViewController *clientVC = [[ClientManagerViewController alloc] init];
        [strongSelf.navigationController pushViewController:clientVC animated:YES];
    };
    self.tableHeaderView = tableHeaderView;
    
    
   // NSMutableArray *modelArray = [NSMutableArray array];
    OMTypeModel *model1 = [[OMTypeModel alloc] init];
    OMTypeModel *model2 = [[OMTypeModel alloc] init];
    OMTypeModel *model3 = [[OMTypeModel alloc] init];
    OMTypeModel *model4 = [[OMTypeModel alloc] init];
    OMTypeModel *model5 = [[OMTypeModel alloc] init];

    model1.fieldType = @"multitext";
    model1.name = @"公司名称";
    model1.length = @"23";
    model1.isRequired = @"1";
    
    model2.fieldType = @"singletext";
    model2.name = @"下拉框选项";
    model2.length = @"36";
    model2.isRequired = @"0";

    model3.fieldType = @"multitext";
    model3.name = @"这是多行文本";
    model3.length = @"400";
    model3.isRequired = @"1";

    model4.fieldType = @"singletext";
    model4.name = @"数字类型";
    model4.digitalPrecision = @"3";
    model4.length = @"10";
    model4.isRequired = @"1";

    model5.fieldType = @"datetime";
    model5.name = @"今天是什么日子";
    model5.isRequired = @"1";
    model5.length = @"17";
    [self.typeArray addObject:model1];
    [self.typeArray addObject:model2];
    [self.typeArray addObject:model3];
    [self.typeArray addObject:model4];
    [self.typeArray addObject:model5];
    OMIncreaseFooterView *tableFooterView = [[OMIncreaseFooterView alloc] init];
    //tableFooterView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 120);
    tableFooterView.backgroundColor = [UIColor whiteColor];
    tableFooterView.delegate = self;
    tableFooterView.modelArray = self.typeArray;
    tableView.tableFooterView = tableFooterView;
    self.tableFooterView = tableFooterView;
    self.tableFooterView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.tableFooterView.footerHeight + 170);
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0.4, 0);
    
    
    
    //增加监听，当键盘出现或改变时收出消息
    
   // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    //增加监听，当键退出时收出消息
    //注册通知,监听键盘消失事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHidden) name:UIKeyboardDidHideNotification object:nil];

   // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addOrderViewControllerKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    //监听键盘弹出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addOrderViewControllerKeyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
     //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addOrderViewControllerKeyboardWillChangeFrame:) name:@"KeyboardWillChangeFrameNotification" object:nil];
}
/**
 创建底部的工具条
 */
- (void)setupAddOrderViewControllerBottomSubviews
{
    //底部工具条容器
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    bottomView.frame = CGRectMake(0, SCREEN_HEIGHT - 50, SCREEN_WIDTH, 50);
    [self.view addSubview:bottomView];
    self.bottomView = bottomView;
    //分割线
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [AppColor appTableCellSeparatLineColor];
    line.frame = CGRectMake(0, 0, SCREEN_WIDTH, 0.4);
    [self.bottomView addSubview:line];
    //合计金额标签;
    
    UILabel *totalSignLabel = [[UILabel alloc] init];
    totalSignLabel.font = OMAddOrderFont;
    totalSignLabel.textColor = [UIColor blackColor];
    totalSignLabel.textAlignment = NSTextAlignmentCenter;
    totalSignLabel.numberOfLines = 0;
    NSString *totalSignStr = @"合计金额:";
    CGSize totalSignSize = [totalSignStr sizeWithFont:OMAddOrderFont];
    CGFloat totalSignX = AddOrderMargin;
    CGFloat totalSignY = 0;
    CGFloat totalSignWidth = totalSignSize.width;
    CGFloat totalSignHeight = self.bottomView.frame.size.height;
    totalSignLabel.frame = CGRectMake(totalSignX, totalSignY, totalSignWidth, totalSignHeight);
    totalSignLabel.text = totalSignStr;
    [self.bottomView addSubview:totalSignLabel];
   //合计金额内容
    UILabel *totalLabel = [[UILabel alloc] init];
    totalLabel.font = OMAddOrderFont;
    totalLabel.textColor = [AppColor appMainColor];
    totalLabel.textAlignment = NSTextAlignmentLeft;
    totalLabel.numberOfLines = 0;
    NSString *totalStr = @"13432";
    CGSize totalSize = [totalStr sizeWithFont:OMAddOrderFont];
    CGFloat totalLabelX = CGRectGetMaxX(totalSignLabel.frame) + AddOrderContentMargin;
    CGFloat totalLabelY = 0;
    CGFloat totalLabelWidth = totalSize.width;
    totalLabelWidth = 80;
    CGFloat totalLabelHeight = self.bottomView.frame.size.height;
    totalLabel.frame = CGRectMake(totalLabelX, totalLabelY, totalLabelWidth, totalLabelHeight);
    totalLabel.text = totalStr;
    [self.bottomView addSubview:totalLabel];
    self.totalLabel = totalLabel;
    //提交按钮
    UIButton *commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    commitBtn.backgroundColor = [AppColor appMainColor];
    commitBtn.titleLabel.textColor = [UIColor whiteColor];
    commitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    CGFloat commitWidth = 109;
    CGFloat commitHeight = self.bottomView.frame.size.height;
    CGFloat commitX = SCREEN_WIDTH - commitWidth;
    CGFloat commitY = 0;
    commitBtn.frame = CGRectMake(commitX, commitY, commitWidth, commitHeight);
    [commitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [commitBtn addTarget:self action:@selector(addOrderCommitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:commitBtn];
    self.commitBtn = commitBtn;
}
- (void)addOrderCommitBtnClick:(UIButton *)sender
{
    
    NSArray *inputViewArray = self.tableFooterView.textLabels;
    NSInteger count = inputViewArray.count;
    for (NSInteger i = 0; i < count; i ++) {
        OverallParentInputView *inputView = inputViewArray[i];
        NSLog(@"%@ = %@",inputView.titleLabel.text,inputView.textField.text);

    }
    NSString *telephoneNum = self.tableHeaderView.receiverNumInputView.textField.text;
    if ([self validateContactNumber:telephoneNum] == NO) {
        [self alertViewWithMessage:@"请输入正确的手机号或电话号码"];
        return;
    }
    NSLog(@"点击了提交按钮");
}


- (void)addOrderViewControllerKeyboardWillChangeFrame:(NSNotification *)notification
{
    CGRect keyboardRect = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.keyboardHeight = keyboardRect.size.height;
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    NSLog(@"键盘弹出");
    NSLog(@"上一个输入类型:%@",self.lastInputView.model.name);
    NSLog(@"输入类型：%@",self.inputView.model.name);
    //坐标系转换
    //CGRect inputFrame = [self.inputView convertRect:self.inputView.frame toView:self.tableView];
    CGRect receiverNumInputRect = [self.tableHeaderView.receiverNumInputView convertRect:self.tableHeaderView.receiverNumInputView.frame toView:self.view];
    CGRect inputRect = [self.inputView convertRect:self.inputView.frame toView:self.view];
    CGFloat keyboardY = keyboardRect.origin.y;
    CGFloat receiverNumInputMaxY = receiverNumInputRect.origin.y + receiverNumInputRect.size.height;
    CGFloat inputMaxY = inputRect.origin.y + inputRect.size.height;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, inputRect.size.height, 0);
    
    if (keyboardY < receiverNumInputMaxY || keyboardY < inputMaxY) {
        
        [UIView animateWithDuration:duration animations:^{
        NSLog(@"keyboardRect.origin.y = %f",keyboardRect.origin.y);
        self.tableView.y = keyboardRect.origin.y - self.tableView.height;
      
        NSLog(@"self.tableView.y = %f",self.tableView.y);
        NSLog(@"self.tableView.height = %f",self.tableView.height);
            NSLog(@"rnritgk");
        
    }];
    }else{
        self.tableView.y = 0;
    }
}
-(void)keyboardDidHidden
{
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);

}

//- (void)addOrderViewControllerKeyboardWillHide:(NSNotification *)notification
//{
//    self.tableView.y = 0;
//}
/**
 添加订单的数据请求
 */
- (void)addOrderViewControllerRequestData
{
    [self.addOrderArray removeAllObjects];
    for (NSInteger i = 0; i < 20; i ++) {
        OMAddModelFrame *modelFrame = [[OMAddModelFrame alloc] init];
        OMAddModel *model = [[OMAddModel alloc] init];
        model.clientName = [NSString stringWithFormat:@"Apple-%ld",i + 1];
        model.receiver = [NSString stringWithFormat:@"Google-%ld",i + 1];
        model.receiverTelNum = [NSString stringWithFormat:@"1887890%ld",i + 10];
        model.commodityUrl = [NSString stringWithFormat:@"%ld.jpg",i+ 1];
        model.commodityInfo = [NSString stringWithFormat:@"水饮料-%ld 500ml",i + 1];
        model.commodityPrice = @"5";
        model.commodityUnit = @"瓶";
        model.remarks = @"这是一种很好喝的碳酸型汽水饮料";
        
        modelFrame.model = model;
        [self.addOrderArray addObject:modelFrame];
    }
    [self.tableView reloadData];
}
- (void)setModel:(OMDetailModel *)model
{
    _model = model;
    
}
- (void)testApp
{
    //self.tableHeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 300);
  //  self.tableFooterView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 300);
   // self.tableFooterView.backgroundColor = [UIColor blackColor];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
   // [self.view endEditing:YES];
   // [self.inputView resignFirstResponder];
   // self.tableView.y = 0;
}
#pragma mark---UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.addOrderArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OMAddOrderTableViewCell *cell = [OMAddOrderTableViewCell addOrderTableViewCellWithTableView:tableView];
    cell.modelFrame = self.addOrderArray[indexPath.row];
    return cell;
    
}

#pragma mark---UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableHeaderView.receiverNumInputView.textField resignFirstResponder];

    OMOrderEditInfoViewController *orderEditInfoVC = [[OMOrderEditInfoViewController alloc] init];
    OMOrderInfoViewController *orderInfoVC = [[OMOrderInfoViewController alloc] init];
    if (indexPath.row % 2 == 0) {
        [self.navigationController pushViewController:orderEditInfoVC animated:YES];

    }else{
        [self.navigationController pushViewController:orderInfoVC animated:YES];

    }
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;

}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.addOrderArray removeObjectAtIndex:indexPath.row];
        // Delete the row from the data source.
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView reloadData];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (0 == self.addOrderArray.count) {
        return 80;
    }else{
    return 0;
    }
}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *tableHeaderView = [[UIView alloc] init];
//    tableHeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 120);
//    tableHeaderView.backgroundColor = [UIColor orangeColor];
//    return tableHeaderView;
//}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
   // [self.inputView.textField resignFirstResponder];
    self.tableView.y = 0;
    [self.tableHeaderView.receiverNumInputView.textField resignFirstResponder];
    [self.view endEditing:YES];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self resignAddOrderFirstResponder];
}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    [self resignAddOrderFirstResponder];

}
#pragma mark---OMIncreaseHeaderViewDelegate
- (void)increaseHeaderViewArrowViewEditWithArrowView:(OverallInputArrowView *)arrowView
{
    NSLog(@"");
    if ([arrowView.titleLabel.text isEqualToString:self.tableHeaderView.clientInputArrowView.titleLabel.text]) {
       // __weak typeof(self)weakSelf = self;
        OMClientViewController *clientVC = [[OMClientViewController alloc] init];
        clientVC.clientBlock = ^(OMClientModel *model) {
           // __strong typeof(weakSelf)strongSelf = weakSelf;
            arrowView.textField.text = model.client;
        };
        [self.navigationController pushViewController:clientVC animated:YES];

    }else{
        NSLog(@"点击了收货人");
    }
}
#pragma mark---OMIncreaseFooterViewDelegate
- (BOOL)increaseFooterInputVieShouldBeginEditing:(OverallInputView *)inputView
{
    //[self.lastInputView.textField resignFirstResponder];
    self.inputView = inputView;
    NSLog(@"increaseFooterInputVieShouldBeginEditing");
    return YES;
}
//备注
- (BOOL)increaseRemarkTextView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
   return [self limitTextView:textView range:range replacementText:text limitLength:300 reportDayModel:nil];
   // return YES;
}
//文本输入
- (void)increaseFooterInputViewEditWithInputView:(OverallInputView *)inputView
{
    NSLog(@"正在编辑intputview = %@,text:%@",inputView,inputView.textField.text);
   // [self.lastInputView.textField resignFirstResponder];
   // [self.inputView.textField becomeFirstResponder];

    //self.tableView.y = 0;
    self.lastInputView = inputView;
    
//    if (self.inputView1 == inputView) {
//        [self.inputView2.textField resignFirstResponder];
//        NSLog(@"inputView1");
//    }else if (self.inputView2 == inputView)
//    {
//        [self.inputView2.textField resignFirstResponder];
//        NSLog(@"inputView2");
//    }

}
//文本输入
- (void)increaseFooterInputDidChange:(UITextView *)textView
{
    /////////////////////////////限定输入的字符个数////////////////////////////////////
    NSLog(@"输入的文字：%@",textView.text);
    //查找到正在编辑的对象
    NSInteger sign = [self positionWithTextView:textView];
    //从数组中取出正在编辑的对象
    // ReportParentInputView *inputView = self.textLabels[sign];
    //取出相应的模板模型
    OMTypeModel *model = self.typeArray[sign];
    //判断限定的字符长度
    NSInteger length = 0;
    if ([model.fieldType isEqualToString:@"number"]) {
        length = [model.length integerValue];
        if ([textView.text contains:@"."]) {
            length = length + [model.digitalPrecision integerValue] + 1;
        }
    }else{
        length = [model.length integerValue];
    }
    UITextRange *selectedRange = [textView markedTextRange];
    //获取高亮部分
    UITextPosition *pos = [textView positionFromPosition:selectedRange.start offset:0];
    
    //如果在变化中是高亮部分在变，就不要计算字符了
    if (selectedRange && pos) {
        return;
    }
    
    NSString  *nsTextContent = textView.text;
    NSInteger existTextNum = nsTextContent.length;
    
    if (existTextNum > length)
    {
        //截取到最大位置的字符
        NSString *s = [nsTextContent substringToIndex:length];
        
        [textView setText:s];
    }
    

}
//文本输入
- (BOOL)increaseFooterTextView:(UITextView *)textView shouldChangeWithTextInRange:(NSRange)range replacementText:(NSString *)text
{
    //查找到正在编辑的对象
    NSInteger sign = [self positionWithTextView:textView];
    //从数组中取出正在编辑的对象
    // ReportParentInputView *inputView = self.textLabels[sign];
    //取出相应的模板模型
    OMTypeModel *model = self.typeArray[sign];
    //空输入，放行，不然不能删除
    if ([text isEqualToString:@""]) {
        return YES;
    }
    if ([model.fieldType isEqualToString:@"number"]) {
        // NSInteger digital = [model.digitalPrecision integerValue];
        
        //判断输入的只能是数字和小数点
        if (![NUMBERS_AND_DOT contains:text]) {
            NSString *message = @"输入的只能是数字和小数点";
            [self alertViewWithMessage:message];
            return NO;
        }
        NSInteger maxLeftNum = [model.length integerValue];
        
        //判断首位，必须是数字
        if (range.location == 0) {
            if ([text isEqualToString:@"."]) {
                NSString *message = @"首位输入的只能是数字";
                [self alertViewWithMessage:message];
                return NO;
            }
        }
        
        BOOL isHaveDot = YES;
        
        if ([textView.text rangeOfString:@"."].location == NSNotFound) {
            isHaveDot = NO;
        }
        
        if (isHaveDot) {
            //如果已经有小数点了，不能再输入
            if ([text isEqualToString:@"."]) {
                NSString *message = @"已经有小数点了，不能再输小数点了";
                [self alertViewWithMessage:message];
                return NO;
            }
            //小数点后已经有两位数字了，不能再输入
            NSString *afterNum = [[textView.text componentsSeparatedByString:@"."] objectAtIndex:1];
            NSInteger afterDotNum = [model.digitalPrecision integerValue];//小数点后位数
            if (afterNum.length == afterDotNum) {
                NSString *message = [NSString stringWithFormat:@"小数点后只能输入%ld小数",afterDotNum];
                [self alertViewWithMessage:message];
                return NO;
            }
        } else {
            if (textView.text.length == maxLeftNum && ![text isEqualToString:@"."]) {
                NSString *message = [NSString stringWithFormat:@"只能输入%ld整数",maxLeftNum];
                [self alertViewWithMessage:message];
                return NO;
            }
        }
        
        return YES;
    }
    if ([model.fieldType isEqualToString:@"multitext"]) {//对多行文本的限制
        NSInteger limitLength = 0;
        //ReportDayModel *reportModel = self.reportDataArray[signNum];
        limitLength = [model.length integerValue];
        return [self limitTextView:textView range:range replacementText:text limitLength:limitLength reportDayModel:model];
        
    }
    return [self layoutTextView:textView textInRange:range replacementText:text];

}
//文本选择
- (void)increaseFooterInputArrowViewEditWithArrowView:(OverallInputArrowView *)arrowView
{
    NSString *arrowViewStr = NSStringFromCGRect(arrowView.frame);
    NSLog(@"arrowFrameViewStr = %@",arrowViewStr);
   // [self.inputView1.textField resignFirstResponder];
  //  [self.inputView2.textField resignFirstResponder];
    [self.view endEditing:YES];
    //    NSLog(@"self.arrowView3 = %@",self.arrowView3);
    //    NSLog(@"arrowView = %@",arrowView);
    //    if (self.selectBoxArrowView == arrowView ) {
    //        self.selectBoxView = arrowView;
    //        ListTableViewController *listVC = [[ListTableViewController alloc] init];
    //        listVC.listArr = model.list;
    //        [self.navigationController pushViewController:listVC animated:YES];
    //    }
    NSUInteger count = self.tableFooterView.selectBoxArray.count;
    if(count > 0){
        for (NSInteger i = 0; i < count; i ++) {
            OverallInputArrowView *selectBoxArrowView = self.tableFooterView.selectBoxArray[i];
            
            if (selectBoxArrowView == arrowView ) {
                NSLog(@"下拉选择的内容：--> %ld",self.tableFooterView.listArray.count);
                if(self.tableFooterView.listArray.count == 0)
                {
                    NSString *alertString = @"下拉框中没有弹出内容";
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:alertString preferredStyle:UIAlertControllerStyleAlert];
                    __weak typeof(self)weakSelf = self;
                    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        __strong typeof(weakSelf)strongSelf = weakSelf;
                        [strongSelf dismissViewControllerAnimated:YES completion:nil];
                    }];
                    [alertController addAction:alertAction];
                    [self presentViewController:alertController animated:YES completion:nil];
                    // return;
                }else{
                    //跳转到选择控制器
                   
                
                }
            }
        }
    }
   //日期选择
    /*
    if([arrowView.model.fieldType isEqualToString:@"datetime"]){
        NSString *nowDateStr = [DateUtils dateToStringNowOffset:0];
        NSString *nowYear = [nowDateStr substringToIndex:4];
        NSString *nowYearLastDay = [NSString stringWithFormat:@"%@-12-31",nowYear];
        SelectDateTimePopUpView *dateView = [[SelectDateTimePopUpView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 220) pickerMode:UIDatePickerModeDate minimumDate:[DateUtils stringToDate:@"yyyy-MM-dd" dateString:@"1949-01-01"] maximumDate:[DateUtils stringToDate:@"yyyy-MM-dd" dateString:nowYearLastDay] defaultDate:nil];
        [dateView setSelectDateWithDateStr:[NSUserDefaults currentEntrySchoolDate]];
        ITASPopupController *popUp = [[ITASPopupController alloc] initWithView:dateView];
        dateView.selectedBlock = ^(NSDate *selectDate){
            NSString *selectDateStr = [DateUtils dateToDateString:selectDate];
            arrowView.textField.text = selectDateStr;
            [popUp dismissView];
        };
        [popUp popUpView];
    }
*/
}
/**
 验证电话号码或手机号的正则表达式
 
 @param mobileNum <#mobileNum description#>
 @return <#return value description#>
 */
- (BOOL)validateContactNumber:(NSString *)mobileNum{
    
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,177,180,189
     22         */
    NSString * CT = @"^1((33|53|77|8[09])[0-9]|349)\\d{7}$";
    
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSPredicate *regextestPHS = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    
    if(([regextestmobile evaluateWithObject:mobileNum] == YES)
       || ([regextestcm evaluateWithObject:mobileNum] == YES)
       || ([regextestct evaluateWithObject:mobileNum] == YES)
       || ([regextestcu evaluateWithObject:mobileNum] == YES)
       || ([regextestPHS evaluateWithObject:mobileNum] == YES)){
        return YES;
    }else{
        return NO;
    }
}



/**
 根据输入的文字进行布局
 
 @param textView <#textView description#>
 @param range <#range description#>
 @param text <#text description#>
 */
- (BOOL)layoutTextView:(UITextView *)textView textInRange:(NSRange)range replacementText:(NSString *)text
{
    CGRect frame = textView.frame;
    
    //float  height = [self heightForTextView:textView WithText:textView.text];
    
   // frame.size.height = height;
   // NSLog(@"text = %@,frame = %@",text,NSStringFromCGRect(frame));
    /*
     NSUInteger count = self.textLabels.count;
     NSUInteger signNum = 0;
     for (NSUInteger i = 0; i < count; i ++) {
     ReportParentInputView *inputView = self.textLabels[i];
     if (inputView.textField == textView) {
     signNum = i;
     //return;
     }
     }*/
    NSUInteger count = self.tableFooterView.textLabels.count;
    //查询正在编辑的对象在数组中的位置
    NSUInteger signNum = [self positionWithTextView:textView];
    
    //从数组中取出正在编辑的对象
    OverallParentInputView *inputView = self.tableFooterView.textLabels[signNum];
    
    //////////////////////////////////////////////////////////////////////////////////////////////
    [UIView animateWithDuration:0.01 animations:^{
        
        
        textView.frame = frame;
       // inputView.frame = CGRectMake(inputView.frame.origin.x, inputView.frame.origin.y, frame.size.width, frame.size.height);
        
       // CGRect inputFrame = inputView.frame;
        
        CGFloat maxInputViewY;
        CGFloat tempH = 0;
        CGFloat tempH2 = 0;
        maxInputViewY = CGRectGetMaxY(inputView.frame);
        OverallParentInputView *viewInput;
        NSUInteger left = count - (signNum + 1);
        if(left > 0){
            for (NSUInteger i = 0; i < left; i ++) {
                viewInput = self.tableFooterView.textLabels[signNum + i + 1];
                // CGFloat viewInputH; //= viewInput.frame.size.height;
                tempH += self.tempHeight;
                if (i == left - 1) {
                    tempH2 = tempH + viewInput.frame.size.height;
                }
              //  viewInput.frame = CGRectMake(inputFrame.origin.x, maxInputViewY + tempH, inputFrame.size.width, viewInput.frame.size.height);
                self.tempHeight = viewInput.frame.size.height;
                
                // NSLog(@"viewInput.frame = %@",NSStringFromCGRect(viewInput.frame));
                
                
            }
            //CGFloat screen_w = [UIScreen mainScreen].bounds.size.width;
            //CGFloat screen_h = [UIScreen mainScreen].bounds.size.height;
            
          //  NSInteger inputH = 44;
           // CGFloat contentViewH = 117 + inputH * 2;
          //  self.contentView.frame = CGRectMake(0, maxInputViewY + tempH2, screen_w, contentViewH);
            self.tempHeight = 0;
            tempH = 0;
            
        }else{
           // CGFloat screen_w = [UIScreen mainScreen].bounds.size.width;
            // CGFloat screen_h = [UIScreen mainScreen].bounds.size.height;
            
           // NSInteger inputH = 44;
          //  CGFloat contentViewH = 117 + inputH * 2;
            //self.contentView.frame = CGRectMake(0, maxInputViewY, screen_w, contentViewH);
            
            // self.contentView.frame =
        }
        
        
        
        
        
    } completion:nil];
    ////////////////////////////////////////////////////////////////////////////////////////////
    //NSInteger count = self.textLabels.count;
    NSInteger limitLength = 0;
    OMTypeModel *reportModel = self.typeArray[signNum];
    limitLength = [reportModel.length integerValue];
    return [self limitTextView:textView range:range replacementText:text limitLength:limitLength reportDayModel:reportModel];
}
/**
 限定输入字符的个数的函数
 
 @param textView 文本输入框
 @param range 输入范围
 @param text 输入的内容
 @param length 限定的输入长度
 @return 返回BOOL类型
 */
- (BOOL)limitTextView:(UITextView *)textView range:(NSRange)range replacementText:(NSString *)text limitLength:(NSInteger)length reportDayModel:(OMTypeModel *)model
{
    UITextRange *selectedRange = [textView markedTextRange];
    //获取高亮部分
    UITextPosition *pos = [textView positionFromPosition:selectedRange.start offset:0];
    NSLog(@"textPosition = %@",pos);
    //获取高亮部分内容
    //NSString * selectedtext = [textView textInRange:selectedRange];
    //如果有高亮且当前字数开始位置小于最大限制时允许输入
    if (selectedRange && pos) {
        NSInteger startOffset = [textView offsetFromPosition:textView.beginningOfDocument toPosition:selectedRange.start];
        NSLog(@"selecedRangeStart = %ld\n",startOffset);
        
        NSInteger endOffset = [textView offsetFromPosition:textView.beginningOfDocument toPosition:selectedRange.end];
        NSLog(@"selecedRangeEnd = %ld\n",endOffset);
        
        NSRange offsetRange = NSMakeRange(startOffset, endOffset - startOffset);
        
        if (offsetRange.location < length) {
            return YES;
        }
        else
        {
            //超出输入范围，弹出提示框
            [self alertWithHintLength:length];
            return NO;
        }
    }
    
    NSString *contentStr = [textView.text stringByReplacingCharactersInRange:range withString:text];
    NSInteger num = length - contentStr.length;
    
    
    if (num >= 0) {
        
        return YES;
        
    }else{
        NSInteger len = text.length + num;
        //防止当text.length + num < 0时，使得rg.length为一个非法最大正数出错
        NSRange rg = {0,MAX(len,0)};
        
        if (rg.length > 0)
        {
            NSString *s = @"";
            //判断是否只普通的字符或asc码(对于中文和表情返回NO)
            BOOL asc = [text canBeConvertedToEncoding:NSASCIIStringEncoding];
            if (asc) {
                s = [text substringWithRange:rg];//因为是ascii码直接取就可以了不会错
            }
            else
            {
                __block NSInteger idx = 0;
                __block NSString  *trimString = @"";//截取出的字串
                //使用字符串遍历，这个方法能准确知道每个emoji是占一个unicode还是两个
                [text enumerateSubstringsInRange:NSMakeRange(0, [text length])
                                         options:NSStringEnumerationByComposedCharacterSequences
                                      usingBlock: ^(NSString* substring, NSRange substringRange, NSRange enclosingRange, BOOL* stop) {
                                          
                                          if (idx >= rg.length) {
                                              *stop = YES; //取出所需要就break，提高效率
                                              return ;
                                          }
                                          
                                          trimString = [trimString stringByAppendingString:substring];
                                          
                                          idx++;
                                      }];
                
                s = trimString;
            }
            //rang是指从当前光标处进行替换处理(注意如果执行此句后面返回的是YES会触发didchange事件)
            [textView setText:[textView.text stringByReplacingCharactersInRange:range withString:s]];
            //既然是超出部分截取了，哪一定是最大限制了。
            //self.warnLabel.text = [NSString stringWithFormat:@"%d/%ld",0,(long)MAXTEXT];
        }
        //超出输入范围，弹出提示框
        [self alertWithHintLength:length];
        
        return NO;
    }
    
}
- (BOOL)judgeNumWithTextView:(UITextView *)textView reportDayModel:(OMTypeModel *)model
{
    if([model.fieldType isEqualToString:@"number"])
    {
        if ([self isNum:textView.text] == NO) {
            textView.text = nil;
            NSString *str = @"请输入数字";
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:str preferredStyle:UIAlertControllerStyleAlert];
            __weak typeof(self)weakSelf = self;
            
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                __strong typeof(weakSelf)strongSelf = weakSelf;
                [strongSelf dismissViewControllerAnimated:YES completion:nil];
            }];
            [alertVC addAction:action];
            [self presentViewController:alertVC animated:YES completion:nil];
            //textView.text = @"";
            return YES;
        }
    }
    return NO;
}
/**
 查询正在编辑的对象在数组中的位置
 
 @param textView <#textView description#>
 @return <#return value description#>
 */
- (NSInteger)positionWithTextView:(UITextView *)textView
{
    NSUInteger count = self.tableFooterView.textLabels.count;
    NSUInteger signNum = 0;
    for (NSUInteger i = 0; i < count; i ++) {
        OverallParentInputView *inputView = self.tableFooterView.textLabels[i];
        if (inputView.textField == textView) {
            signNum = i;
            //return;
        }
    }
    return signNum;
}
- (BOOL)isNum:(NSString *)checkedNumString {
    
    return YES;
    // NSString *string = [checkedNumString stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    
    // NSString *regex1 = @"(-?\\d+)(\\.\\d+)?";
    // NSString *regex1 = @"^[-+]?[0-9]*\\.?[0-9]+$";
    //NSString *pattern = @"^[1-9]\\d*\\.\\d*|0\\.\\d*[1-9]\\d*|0?\\.0+|0$ ";//匹配非负浮点数
    // NSString *regex1 = @"^[+-]?\\d+(\\.\\d+)?$";        //匹配规则
    // NSRegularExpression *regular = [[NSRegularExpression alloc] initWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    
    //NSArray *isFloatArr = [regular matchesInString:checkedNumString options:NSMatchingReportProgress range:NSMakeRange(0, checkedNumString.length)];
    
    
    //将正则表达式作为字符串赋值给变量regex
    //^[1-9]\d*([.][0-9][1-9])?$
    //NSString *regex1 = @"^[1-9]\\d*\\.\\d*|0\\.\\d*[1-9]\\d*|0?\\.0+|0$ ";
    NSString *regex1 = @"^[0-9]\\d*([.][1-9][1-9])?$";
    
    // NSString *regex2 = @"[0-9]";
    NSRegularExpression *regular1 = [[NSRegularExpression alloc] initWithPattern:regex1 options:NSRegularExpressionCaseInsensitive error:nil];
    //NSRegularExpression *regular2 = [[NSRegularExpression alloc] initWithPattern:regex2 options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSArray *isFloatArr = [regular1 matchesInString:checkedNumString options:NSMatchingReportProgress range:NSMakeRange(0, checkedNumString.length)];
    //NSArray *isFloatArr2 = [regular2 matchesInString:checkedNumString options:NSMatchingReportProgress range:NSMakeRange(0, checkedNumString.length)];
    
    //根据正则表达式将NSPredicate的格式设置好
    // NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex1];
    //NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex2];
    
    //判断正则表达式能否正确匹配_textFiedld.text的内容
    // BOOL isMatch = [pred evaluateWithObject:checkedNumString];
    // BOOL isMatch2 = [pred2 evaluateWithObject:checkedNumString];
    if (isFloatArr.count > 0) {
        return YES;
    }else{
        return NO;
    }
}

/**
 提示弹出框
 
 @param message <#message description#>
 */
- (void)alertViewWithMessage:(NSString *)message
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提醒" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertVC addAction:action];
    [self presentViewController:alertVC animated:YES completion:nil];
}
/**
 提示框
 
 @param limitLength <#limitLength description#>
 */
- (void)alertWithHintLength:(NSInteger)limitLength
{
    NSString *str = [NSString stringWithFormat:@"你最多只能输入%ld个字",limitLength];
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:str preferredStyle:UIAlertControllerStyleAlert];
    __weak typeof(self)weakSelf = self;
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        __strong typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertVC addAction:action];
    [self presentViewController:alertVC animated:YES completion:nil];
    
}
- (float)heightForTextView:(UITextView *)textView WithText:(NSString *)strText{
    CGSize constraint = CGSizeMake(textView.contentSize.width , CGFLOAT_MAX);
    CGRect size = [strText boundingRectWithSize:constraint
                                        options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                     attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]}
                                        context:nil];
    float textHeight = size.size.height + 22.0;
    return textHeight;
}
/**
 隐藏键盘
 */
- (void)resignAddOrderFirstResponder
{
    NSArray *inputArray = self.tableFooterView.textLabels;
    NSInteger count = inputArray.count;
    for (NSInteger i = 0; i < count; i ++) {
        OverallParentInputView *parentInputView = inputArray[i];
        if ([parentInputView isKindOfClass:[OverallInputView class]]) {
            OverallInputView *inputView = (OverallInputView *)parentInputView;
            if ([inputView.textField isFirstResponder]) {
                [inputView resignFirstResponder];
            }
        }
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
