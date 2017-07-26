//
//  CMFilterViewController.m
//  ClientManager
//*****************筛选的控制器*****************
//  Created by iOS－MacBook on 2017/7/17.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import "CMFilterViewController.h"
#import "OverallTextView.h"
#import "OverallParentInputView.h"
#import "OverallInputView.h"
#import "OverallInputArrowView.h"
#define FilterHeight 44
#define LeftMargin 40
@interface CMFilterViewController ()<UIScrollViewDelegate,UITextViewDelegate,UITextFieldDelegate,OverallInputViewDelegate,OverallInputArrowViewDelegate>

/**
 负责人
 */
@property (nonatomic,weak) OverallInputView *inputResponsibleView;
/**
 相关人
 */
@property (nonatomic,weak) OverallInputView *inputRelatedView;
/**
 行业
 */
@property (nonatomic,weak) OverallInputArrowView *professionArrowView;
/**
 等级
 */
@property (nonatomic,weak) OverallInputArrowView *gradeArrowView;
/**
 区划
 */
@property (nonatomic,weak) OverallInputArrowView *compartmentArrowView;
/**
 开始日期
 */
@property (nonatomic,weak) OverallInputArrowView *beginDateTextView;
/**
 结束日期
 */
@property (nonatomic,weak) OverallInputArrowView *endDateTextView;
/**
 未拜访天数开始的输入框
 */
@property (nonatomic,weak) UITextField *visitBeginField;
/**
 未拜访天数结束的输入框
 */
@property (nonatomic,weak) UITextField *visitEndField;
/**
 剩余天数开始的数字输入框
 */
@property (nonatomic,weak) UITextField *leftBeginField;
/**
 剩余天数结束的数字输入框
 */
@property (nonatomic,weak) UITextField *leftEndField;
/**
 <#annotation#>
 */
@property (nonatomic,weak) UIScrollView *scrollView;



@end

@implementation CMFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   // self.view.backgroundColor = [UIColor colorWithRed:214 / 255.0 green:214 / 255.0 blue:214 / 255.0 alpha:1.0];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupFilterViewControllerSubviews];
    // Do any additional setup after loading the view.
}
- (void)setupFilterViewControllerSubviews
{
    CGFloat leftMargin = LeftMargin;

    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.delegate = self;
    CGFloat scrollViewX = 0;
    CGFloat scrollViewY = 64;
    CGFloat scrollViewWidth = SCREEN_WIDTH - leftMargin;
    CGFloat scrollViewHeight = SCREEN_HEIGHT - 64 - 44;
    scrollView.frame = CGRectMake(scrollViewX, scrollViewY, scrollViewWidth, scrollViewHeight);
    scrollView.contentSize = CGSizeMake(scrollViewWidth, SCREEN_HEIGHT);
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    //负责人
    OverallInputView *inputResponsibleView = [[OverallInputView alloc] init];
    CGFloat inputResponsibleViewX = 0;
    CGFloat inputResponsibleViewY = 0;
    CGFloat inputResponsibleViewWidth = scrollViewWidth;
    CGFloat inputResponsibleViewHeight = FilterHeight;
    inputResponsibleView.frame = CGRectMake(inputResponsibleViewX, inputResponsibleViewY, inputResponsibleViewWidth, inputResponsibleViewHeight);
    inputResponsibleView.delegate = self;
    inputResponsibleView.isRight = YES;
    inputResponsibleView.title = @"负责人";
    inputResponsibleView.placeholder = @"请输入姓名";
    [scrollView addSubview:inputResponsibleView];
    self.inputResponsibleView = inputResponsibleView;
    
    //相关人
    OverallInputView *inputRelatedView = [[OverallInputView alloc] init];
    CGFloat inputRelatedViewX = 0;
    CGFloat inputRelatedViewY = FilterHeight;
    CGFloat inputRelatedViewWidth = scrollViewWidth;
    CGFloat inputRelatedViewHeight = FilterHeight;
    inputRelatedView.frame = CGRectMake(inputRelatedViewX, inputRelatedViewY, inputRelatedViewWidth, inputRelatedViewHeight);
    inputRelatedView.delegate = self;
    inputRelatedView.isRight = YES;
    inputRelatedView.title = @"负责人";
    inputRelatedView.placeholder = @"请输入姓名";
    [scrollView addSubview:inputRelatedView];
    self.inputRelatedView = inputRelatedView;

    //行业
    OverallInputArrowView *professionArrowView = [[OverallInputArrowView alloc] init];
    CGFloat professionArrowViewX = 0;
    CGFloat professionArrowViewY = FilterHeight * 2;
    CGFloat professionArrowViewWidth = scrollViewWidth;
    CGFloat professionArrowViewHeight = FilterHeight;
    professionArrowView.frame = CGRectMake(professionArrowViewX, professionArrowViewY, professionArrowViewWidth, professionArrowViewHeight);
    professionArrowView.isShowTextView = YES;
    professionArrowView.isRight = YES;
    professionArrowView.delegate = self;
    professionArrowView.titleLabel.text = @"行业";
    professionArrowView.placeholder = @"请选择行业";
    [scrollView addSubview:professionArrowView];
    self.professionArrowView = professionArrowView;

    //等级
    OverallInputArrowView *gradeArrowView = [[OverallInputArrowView alloc] init];
    CGFloat gradeArrowViewX = 0;
    CGFloat gradeArrowViewY = FilterHeight * 3;
    CGFloat gradeArrowViewWidth = scrollViewWidth;
    CGFloat gradeArrowViewHeight = FilterHeight;
    gradeArrowView.frame = CGRectMake(gradeArrowViewX, gradeArrowViewY, gradeArrowViewWidth, gradeArrowViewHeight);
    gradeArrowView.isShowTextView = YES;
    gradeArrowView.isRight = YES;
    gradeArrowView.delegate = self;
    gradeArrowView.titleLabel.text = @"等级";
    gradeArrowView.placeholder = @"请选择等级";
    [scrollView addSubview:gradeArrowView];
    self.gradeArrowView = gradeArrowView;

    //区划
    OverallInputArrowView *compartmentArrowView = [[OverallInputArrowView alloc] init];
    CGFloat compartmentArrowViewX = 0;
    CGFloat compartmentArrowViewY = FilterHeight * 4;
    CGFloat compartmentArrowViewWidth = scrollViewWidth;
    CGFloat compartmentArrowViewHeight = FilterHeight;
    compartmentArrowView.frame = CGRectMake(compartmentArrowViewX, compartmentArrowViewY, compartmentArrowViewWidth, compartmentArrowViewHeight);
    compartmentArrowView.isShowTextView = YES;
    compartmentArrowView.isRight = YES;
    compartmentArrowView.delegate = self;
    compartmentArrowView.titleLabel.text = @"区划";
    compartmentArrowView.placeholder = @"请选择区划";
    [scrollView addSubview:compartmentArrowView];
    self.compartmentArrowView = compartmentArrowView;

    
    //创建日期背景容器
    //背景容器
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor whiteColor];
    CGFloat contentViewX = 0;
    CGFloat contentViewY = FilterHeight * 5;
    CGFloat contentViewWidth = scrollViewWidth;
    CGFloat contentViewHeight = FilterHeight * 2;
    contentView.frame = CGRectMake(contentViewX, contentViewY, contentViewWidth, contentViewHeight);
    [scrollView addSubview:contentView];
    //提交日期
    NSString *createDateStr = @"创建日期";
    CGSize createDateSize = [createDateStr sizeWithFont:ComFont];
    UILabel *createDateLalbel = [[UILabel alloc] init];
    createDateLalbel.textColor = [UIColor blackColor];
    createDateLalbel.font = ComFont;
    CGFloat createDateLalbelX = ComMargin;
    CGFloat createDateLalbelY = (FilterHeight * 2 - createDateSize.height) / 2;
    CGFloat createDateLalbelWidth = createDateSize.width;
    CGFloat createDateLalbelHeight = createDateSize.height;
    createDateLalbel.frame = CGRectMake(createDateLalbelX, createDateLalbelY, createDateLalbelWidth, createDateLalbelHeight);
    createDateLalbel.text = createDateStr;
    [contentView addSubview:createDateLalbel];

    //1.选择开始日期
    OverallInputArrowView *beginDateTextView = [[OverallInputArrowView alloc] init];
    beginDateTextView.placeholder = @"请选择开始日期";
    CGFloat beginDateTextViewX = CGRectGetMaxX(createDateLalbel.frame) + ComMargin;
    CGFloat beginDateTextViewY = 0;
    CGFloat beginDateTextViewWidth = scrollViewWidth - beginDateTextViewX;
    CGFloat beginDateTextViewHeight = FilterHeight;
    beginDateTextView.frame = CGRectMake(beginDateTextViewX, beginDateTextViewY, beginDateTextViewWidth, beginDateTextViewHeight);
    beginDateTextView.isRight = YES;
    beginDateTextView.delegate = self;
    [contentView addSubview:beginDateTextView];
    self.beginDateTextView = beginDateTextView;

    //2.选择结束日期
    OverallInputArrowView *endDateTextView = [[OverallInputArrowView alloc] init];
    endDateTextView.placeholder = @"请选择结束日期";
    CGFloat endDateTextViewX = beginDateTextViewX;
    CGFloat endDateTextViewY = CGRectGetMaxY(self.beginDateTextView.frame);
    CGFloat endDateTextViewWidth = beginDateTextViewWidth;
    CGFloat endDateTextViewHeight = FilterHeight;
    endDateTextView.frame = CGRectMake(endDateTextViewX, endDateTextViewY, endDateTextViewWidth, endDateTextViewHeight);
    endDateTextView.isRight = YES;
    endDateTextView.delegate = self;
    endDateTextView.lineView.hidden = YES;
    [contentView addSubview:endDateTextView];
    self.endDateTextView = endDateTextView;
    //底部的分割线
    UIView *underLineView = [[UIView alloc] init];
    underLineView.backgroundColor = [AppColor appTableCellSeparatLineColor];
    CGFloat underLineViewX = 0;
    CGFloat underLineViewY = contentViewHeight - 0.4;
    CGFloat underLineViewWidth = scrollViewWidth;
    CGFloat underLineViewHeight = 0.4;
    underLineView.frame = CGRectMake(underLineViewX, underLineViewY, underLineViewWidth, underLineViewHeight);
    [contentView addSubview:underLineView];
    
    //底部的背景容器（未拜访天数--剩余天数）
    UIView *contentBottomView = [[UIView alloc] init];
    contentBottomView.backgroundColor = [UIColor whiteColor];
    CGFloat contentBottomViewX = 0;
    CGFloat contentBottomViewY = FilterHeight * 5 + contentViewHeight;
    CGFloat contentBottomViewWidth = scrollViewWidth;
    CGFloat contentBottomViewHeight = 100 * 2;
    contentBottomView.frame = CGRectMake(contentBottomViewX, contentBottomViewY, contentBottomViewWidth, contentBottomViewHeight);
    [scrollView addSubview:contentBottomView];
    
    
    
    //1.未拜访天数
    //1.1   21 10
    CGFloat middleMargin = 30;
    CGFloat fieldWidth = (scrollViewWidth - ComMargin * 2 - middleMargin) / 2;
    CGFloat fieldHeight = 30;
    
    NSString *unVisitStr = @"未拜访天数";
    CGSize unVisitSize = [unVisitStr sizeWithFont:ComFont];
    CGFloat margin = ((contentBottomViewHeight - 2) / 2 - ComMargin - unVisitSize.height - fieldHeight) / 2 - 3;
    UILabel *unVisitLabel = [[UILabel alloc] init];
    unVisitLabel.font = ComFont;
    unVisitLabel.textColor = [UIColor blackColor];
    unVisitLabel.textAlignment = NSTextAlignmentLeft;
    unVisitLabel.text = unVisitStr;
    CGFloat unVisitLabelX = ComMargin;
    CGFloat unVisitLabelY = ComMargin;
    CGFloat unVisitLabelWidth = unVisitSize.width;
    CGFloat unVisitLabelHeight = unVisitSize.height;
    unVisitLabel.frame = CGRectMake(unVisitLabelX, unVisitLabelY, unVisitLabelWidth, unVisitLabelHeight);
    [contentBottomView addSubview:unVisitLabel];
    
    //2.未拜访天数开始的数字输入框
    UITextField *visitBeginField = [[UITextField alloc] init];
    visitBeginField.backgroundColor = [UIColor colorWithRed:241 / 255.0 green:242 / 255.0 blue:247 / 255.0 alpha:1.0];
    CGFloat visitBeginFieldX = ComMargin;
    CGFloat visitBeginFieldY = CGRectGetMaxY(unVisitLabel.frame) + margin;
    CGFloat visitBeginFieldWidth = fieldWidth;
    CGFloat visitBeginFieldHeight = fieldHeight;
    visitBeginField.frame = CGRectMake(visitBeginFieldX, visitBeginFieldY, visitBeginFieldWidth, visitBeginFieldHeight);
    visitBeginField.layer.cornerRadius = 5;
    visitBeginField.layer.masksToBounds = YES;
    visitBeginField.delegate = self;
    //光标位置的控制
    UIView *beginLeftView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, 7, fieldHeight)];
    beginLeftView.backgroundColor = [UIColor clearColor];
    visitBeginField.leftView = beginLeftView;
    visitBeginField.leftViewMode = UITextFieldViewModeAlways;
    visitBeginField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    ////////////////////////////////////////
    [contentBottomView addSubview:visitBeginField];
    self.visitBeginField = visitBeginField;
    //中间的间距分割线条
    UIView *middleLine1 = [[UIView alloc] init];
    middleLine1.backgroundColor = [AppColor appTableCellSeparatLineColor];
    CGFloat middleLine1Width = 10;
    CGFloat middleLine1Height = 0.4;
    CGFloat marginLR = (middleMargin - middleLine1Width) / 2;
    CGFloat tempH = (visitBeginFieldHeight - middleLine1Height) / 2;
    CGFloat middleLine1X = CGRectGetMaxX(visitBeginField.frame) + marginLR;
    CGFloat middleLine1Y = visitBeginFieldY + tempH;
    middleLine1.frame = CGRectMake(middleLine1X, middleLine1Y, middleLine1Width, middleLine1Height);
    [contentBottomView addSubview:middleLine1];
    //3.未拜访天数结束的数字输入框
    UITextField *visitEndField = [[UITextField alloc] init];
    visitEndField.backgroundColor = [UIColor colorWithRed:241 / 255.0 green:242 / 255.0 blue:247 / 255.0 alpha:1.0];
    CGFloat visitEndFieldX = CGRectGetMaxX(middleLine1.frame) + marginLR;
    CGFloat visitEndFieldY = visitBeginFieldY;
    CGFloat visitEndFieldWidth = fieldWidth;
    CGFloat visitEndFieldHeight = fieldHeight;
    visitEndField.frame = CGRectMake(visitEndFieldX, visitEndFieldY, visitEndFieldWidth, visitEndFieldHeight);
    visitEndField.layer.cornerRadius = 5;
    visitEndField.layer.masksToBounds = YES;
    visitEndField.delegate = self;
    //光标位置的控制
    UIView *visitEndLeftView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, 7, fieldHeight)];
    visitEndLeftView.backgroundColor = [UIColor clearColor];
    visitEndField.leftView = visitEndLeftView;
    visitEndField.leftViewMode = UITextFieldViewModeAlways;
    visitEndField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    ////////////////////////////////////////

    [contentBottomView addSubview:visitEndField];
    self.visitEndField = visitEndField;
    //中间的分割线
    UIView *middleBottomLine = [[UIView alloc] init];
    middleBottomLine.backgroundColor = [AppColor appTableCellSeparatLineColor];
    CGFloat middleBottomLineWidth = scrollViewWidth;
    CGFloat middleBottomLineHeight = 2.0;
    CGFloat middleBottomLineX = 0;
    CGFloat middleBottomLineY = (contentBottomViewHeight - middleBottomLineHeight) / 2;
    middleBottomLine.frame = CGRectMake(middleBottomLineX, middleBottomLineY, middleBottomLineWidth, middleBottomLineHeight);
    [contentBottomView addSubview:middleBottomLine];
    
    //剩余天数
    
    UILabel *leftDayLabel = [[UILabel alloc] init];
    leftDayLabel.font = ComFont;
    leftDayLabel.textColor = [UIColor blackColor];
    leftDayLabel.textAlignment = NSTextAlignmentLeft;
    leftDayLabel.text = @"剩余天数";
    CGFloat leftDayLabelX = ComMargin;
    CGFloat leftDayLabelY = CGRectGetMaxY(middleBottomLine.frame) + ComMargin;
    CGFloat leftDayLabelWidth = unVisitSize.width;
    CGFloat leftDayLabelHeight = unVisitSize.height;
    leftDayLabel.frame = CGRectMake(leftDayLabelX, leftDayLabelY, leftDayLabelWidth, leftDayLabelHeight);
    [contentBottomView addSubview:leftDayLabel];
    
    //2.剩余天数开始的数字输入框
    UITextField *leftBeginField = [[UITextField alloc] init];
    leftBeginField.backgroundColor = [UIColor colorWithRed:241 / 255.0 green:242 / 255.0 blue:247 / 255.0 alpha:1.0];
    CGFloat leftBeginFieldX = ComMargin;
    CGFloat leftBeginFieldY = CGRectGetMaxY(leftDayLabel.frame) + margin;
    CGFloat leftBeginFieldWidth = fieldWidth;
    CGFloat leftBeginFieldHeight = fieldHeight;
    leftBeginField.frame = CGRectMake(leftBeginFieldX, leftBeginFieldY, leftBeginFieldWidth, leftBeginFieldHeight);
    leftBeginField.layer.cornerRadius = 5;
    leftBeginField.layer.masksToBounds = YES;
    leftBeginField.delegate = self;
    //光标位置的控制
    UIView *leftBeginView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, 7, fieldHeight)];
    leftBeginView.backgroundColor = [UIColor clearColor];
    leftBeginField.leftView = leftBeginView;
    leftBeginField.leftViewMode = UITextFieldViewModeAlways;
    leftBeginField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    ////////////////////////////////////////

    [contentBottomView addSubview:leftBeginField];
    self.leftBeginField = leftBeginField;
    
    //中间的间距分割线条
    UIView *middleLine2 = [[UIView alloc] init];
    middleLine2.backgroundColor = [AppColor appTableCellSeparatLineColor];
    CGFloat middleLine2Width = 10;
    CGFloat middleLine2Height = 0.4;
    CGFloat middleLine2X = CGRectGetMaxX(visitBeginField.frame) + marginLR;
    CGFloat middleLine2Y = leftBeginFieldY + tempH;
    middleLine2.frame = CGRectMake(middleLine2X, middleLine2Y, middleLine2Width, middleLine2Height);
    [contentBottomView addSubview:middleLine2];

    //3.剩余天数结束的数字输入框
    UITextField *leftEndField = [[UITextField alloc] init];
    leftEndField.backgroundColor = [UIColor colorWithRed:241 / 255.0 green:242 / 255.0 blue:247 / 255.0 alpha:1.0];
    CGFloat leftEndFieldX = CGRectGetMaxX(middleLine2.frame) + marginLR;
    CGFloat leftEndFieldY = leftBeginFieldY;
    CGFloat leftEndFieldWidth = fieldWidth;
    CGFloat leftEndFieldHeight = fieldHeight;
    leftEndField.frame = CGRectMake(leftEndFieldX, leftEndFieldY, leftEndFieldWidth, leftEndFieldHeight);
    leftEndField.layer.cornerRadius = 5;
    leftEndField.layer.masksToBounds = YES;
    leftEndField.delegate = self;
    //光标位置的控制
    UIView *leftEndView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, 7, fieldHeight)];
    leftEndView.backgroundColor = [UIColor clearColor];
    leftEndField.leftView = leftEndView;
    leftEndField.leftViewMode = UITextFieldViewModeAlways;
    leftEndField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    ////////////////////////////////////////

    [contentBottomView addSubview:leftEndField];
    self.leftEndField = leftEndField;

    //底部的分割线
    UIView *bottomLine = [[UIView alloc] init];
    bottomLine.backgroundColor = [AppColor appTableCellSeparatLineColor];
    CGFloat bottomLineX = 0;
    CGFloat bottomLineY = contentBottomViewHeight - 0.4;
    CGFloat bottomLineWidth = scrollViewWidth;
    CGFloat bottomLineHeight = 0.4;
    bottomLine.frame = CGRectMake(bottomLineX, bottomLineY, bottomLineWidth, bottomLineHeight);
    [contentBottomView addSubview:bottomLine];
    
    //监听键盘弹出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(filterViewControllerKeyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
//UIKeyboardDidHideNotification

    //最底部的工具条按钮创建（重置和确定）
    [self createFilterBottomView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(filterViewControllerKeyboardDidHideFrame:) name:UIKeyboardDidHideNotification object:nil];
}
- (void)filterViewControllerKeyboardWillChangeFrame:(NSNotification *)notification
{
       
    CGRect keyboardRect = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //self.keyboardHeight = keyboardRect.size.height;
 //   NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
   // CGRect inputFrame = self.inputView.frame;
    
  //  CGRect inputRect = [self.inputView convertRect:inputFrame toView:self.view];
    
    
    self.scrollView.y = keyboardRect.origin.y - self.scrollView.height;
            
    
    
    
    // self.tableView.contentInset = UIEdgeInsetsMake(0, 0, inputRect.size.height, 0);
    
    // if (keyboardY < receiverNumInputMaxY) {//keyboardY < receiverNumInputMaxY
   // [UIView animateWithDuration:duration animations:^{
        // NSLog(@"keyboardRect.origin.y = %f",keyboardRect.origin.y);
      //  self.scrollView.y = keyboardRect.origin.y - self.scrollView.height;
        
        // self.tableView.y = self.tableView.y - insectionHeight;
        // [self.tableView setContentOffset:CGPointMake(0, keyboardCoverHeight) animated:YES];
        
        
  //  }];
    
}
- (void)filterViewControllerKeyboardDidHideFrame:(NSNotification *)notification
{
    self.scrollView.y = 64;
}
- (void)createFilterBottomView
{
    UIView *filterBottomView = [[UIView alloc] init];
    filterBottomView.backgroundColor = [UIColor whiteColor];
    CGFloat filterViewWidth = SCREEN_WIDTH - LeftMargin;
    CGFloat filterViewHeight = 44;
    CGFloat filterViewX = 0;
    CGFloat filterViewY = SCREEN_HEIGHT - filterViewHeight;
    filterBottomView.frame = CGRectMake(filterViewX, filterViewY, filterViewWidth, filterViewHeight);
    [self.view addSubview:filterBottomView];
    
    //重置
    UIButton *resetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [resetBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [resetBtn setTitle:@"重置" forState:UIControlStateNormal];
    [resetBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    resetBtn.titleLabel.font = ComFont;
    CGFloat resetBtnWidth = filterViewWidth / 2;
    CGFloat resetBtnHeight = 44;
    CGFloat resetBtnX = 0;
    CGFloat resetBtnY = 0;
    resetBtn.frame = CGRectMake(resetBtnX, resetBtnY, resetBtnWidth, resetBtnHeight);
    
    [resetBtn addTarget:self action:@selector(resetBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    resetBtn.backgroundColor = [UIColor whiteColor];
    [filterBottomView addSubview:resetBtn];
    //确定
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sureBtn.titleLabel.font = ComFont;
    sureBtn.backgroundColor = [UIColor orangeColor];
    CGFloat sureBtnWidth = filterViewWidth / 2;
    CGFloat sureBtnHeight = 44;
    CGFloat sureBtnX = filterViewWidth / 2;
    CGFloat sureBtnY = 0;
    sureBtn.frame = CGRectMake(sureBtnX, sureBtnY, sureBtnWidth, sureBtnHeight);
    
    [sureBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    //sureBtn.backgroundColor = [UIColor clearColor];
    [filterBottomView addSubview:sureBtn];

    //
    UIView *topLine = [[UIView alloc] init];
    topLine.backgroundColor = [AppColor appTableCellSeparatLineColor];
    CGFloat topLineX = 0;
    CGFloat topLineY = 0;
    CGFloat topLineWidth = filterViewWidth;
    CGFloat topLineHeight = 0.4;
    topLine.frame = CGRectMake(topLineX, topLineY, topLineWidth, topLineHeight);
    [filterBottomView addSubview:topLine];

}
/**
 重置的触发点击

 @param sender <#sender description#>
 */
- (void)resetBtnClick:(UIButton *)sender
{
    NSLog(@"重置");
}
/**
 确定按钮的点击

 @param sender <#sender description#>
 */
- (void)sureBtnClick:(UIButton *)sender
{
    NSLog(@"确定");
}
#pragma mark --- UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
    //return [self validateNumber:string];
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    BOOL isNum = [self validateNumber:textField.text];
    if (isNum == NO) {
        [self alertViewWithMessage:@"只能输入正整数"];
        textField.text = nil;
    }
}

#pragma mark---OverallInputViewDelegate
- (BOOL)overallInputVieShouldBeginEditing:(OverallInputView *)inputView
{
    return YES;
}
- (void)overallInputViewEditWithInputView:(OverallInputView *)inputView
{
    if (inputView == self.inputResponsibleView) {//负责人
        
        
        
    }else if (inputView == self.inputRelatedView)//相关人
    {
        
        
        
    }
}
- (void)overallInputViewEditEndInputView:(UITextView *)textView
{
    
}

- (void)overallTextViewInputDidChange:(UITextView *)textView
{
    
}
- (BOOL)overallTextView:(UITextView *)textView shouldChangeWithTextInRange:(NSRange)range replacementText:(NSString *)text
{
    return YES;
}
#pragma mark--OverallInputArrowViewDelegate
- (void)overallInputArrowViewEditWithArrowView:(OverallInputArrowView *)arrowView
{
    
}

#pragma mark--UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
   // [self.inputResponsibleView.textField resignFirstResponder];
    [self.view endEditing:YES];
}
/**
 限定输入字符的个数的函数
 
 @param textView 文本输入框
 @param range 输入范围
 @param text 输入的内容
 @param length 限定的输入长度
 @return 返回BOOL类型
 */
- (BOOL)limitTextView:(UITextField *)textView range:(NSRange)range replacementText:(NSString *)text limitLength:(NSInteger)length reportDayModel:(OMTypeModel *)model
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

/**
 正整数的正则验证

 @param textString <#textString description#>
 @return <#return value description#>
 */
- (BOOL)validateNumber:(NSString *) textString
{
    
    NSString* number=@"^[1-9]\\d*$";
   
    NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF  MATCHES %@",number];
    
    return [numberPre evaluateWithObject:textString];
}
/**
 提示弹出框
 
 @param message <#message description#>
 */
- (void)alertViewWithMessage:(NSString *)message
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提醒" message:message preferredStyle:UIAlertControllerStyleAlert];
    __weak typeof(self)weakSelf = self;
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        __strong typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf dismissViewControllerAnimated:YES completion:nil];
        
    }];
    [alertVC addAction:action];
    [self presentViewController:alertVC animated:YES completion:nil];
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
