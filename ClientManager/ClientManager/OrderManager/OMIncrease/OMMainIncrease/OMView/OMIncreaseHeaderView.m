//
//  OMIncreaseHeaderView.m
//  ClientManager
//
//  Created by iOS－MacBook on 2017/5/16.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import "OMIncreaseHeaderView.h"
#import "OverallTextView.h"
#include "OverallInputView.h"
#include "OverallInputArrowView.h"
#define AddBtnFont [UIFont systemFontOfSize:13]
#define InputHeight 44
#define AddViewHeight 55
@interface OMIncreaseHeaderView()<OverallInputViewDelegate,OverallInputArrowViewDelegate>

@end
@implementation OMIncreaseHeaderView
- (instancetype)init
{
    if (self = [super init]) {
        [self setupIncreaseHeaderViewSubviews];
    }
    return self;
}
- (void)setupIncreaseHeaderViewSubviews
{
    
    //头部的背景View
    UIView *topContentView = [[UIView alloc] init];
    topContentView.backgroundColor = [AppColor appTableViewBackgroundColor];
    topContentView.userInteractionEnabled = YES;
    [self addSubview:topContentView];
    self.topContentView = topContentView;
    //头部的背景View内部的子控件
    //1.客户名称
    OverallInputArrowView *clientInputArrowView = [[OverallInputArrowView alloc] init];
    clientInputArrowView.titleLabel.text = @"客户名称";
    clientInputArrowView.delegate = self;
    [self.topContentView addSubview:clientInputArrowView];
    self.clientInputArrowView = clientInputArrowView;
    //2.收货人
    OverallInputArrowView *receiverInputArrowView = [[OverallInputArrowView alloc] init];
    receiverInputArrowView.titleLabel.text = @"收货人";
    receiverInputArrowView.delegate = self;
    [self.topContentView addSubview:receiverInputArrowView];
    self.receiverInputArrowView = receiverInputArrowView;
    //3.收货人电话
   // OverallInputView *receiverNumInputView = [[OverallInputView alloc] init];
    OverallInputView *receiverNumInputView = [[OverallInputView alloc] init];
    receiverNumInputView.isRight = YES;
    receiverNumInputView.title = @"收货人电话";
    receiverNumInputView.delegate = self;
    receiverNumInputView.placeholder = @"请输入";
    receiverNumInputView.textField.keyboardType = UIKeyboardTypeNumberPad;
    [self.topContentView addSubview:receiverNumInputView];
    [self addSubview:receiverNumInputView];
    self.receiverNumInputView = receiverNumInputView;
    //4."扫码添加"，“手动添加”的容器
    UIView *addOrderView = [[UIView alloc] init];
    addOrderView.backgroundColor = [UIColor whiteColor];
    addOrderView.userInteractionEnabled = YES;
    [self.topContentView addSubview:addOrderView];
    self.addOrderView = addOrderView;
    //01.扫码添加按钮
    UIButton *sweepBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sweepBtn setTitle:@"扫码添加" forState:UIControlStateNormal];
    [sweepBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    sweepBtn.titleLabel.font = [UIFont boldSystemFontOfSize:19];
    sweepBtn.layer.borderColor = [AppColor appTableCellGrayTextColor].CGColor;
    sweepBtn.layer.borderWidth = 0.5;
    sweepBtn.layer.cornerRadius = 5;
    sweepBtn.layer.masksToBounds = YES;
    [sweepBtn addTarget:self action:@selector(sweepBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    //UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sweepBtnTapClick)];
    //tap.numberOfTapsRequired = 1;
   // [sweepBtn addGestureRecognizer:tap];
    [self.addOrderView addSubview:sweepBtn];
    self.sweepBtn = sweepBtn;
    
    //02.手动添加按钮
    UIButton *handBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [handBtn setTitle:@"手动添加" forState:UIControlStateNormal];
    [handBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    handBtn.titleLabel.font = [UIFont boldSystemFontOfSize:19];
    handBtn.layer.borderColor = [AppColor appTableCellGrayTextColor].CGColor;
    handBtn.layer.borderWidth = 0.5;
    handBtn.layer.cornerRadius = 5;
    handBtn.layer.masksToBounds = YES;
    [handBtn addTarget:self action:@selector(handBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.addOrderView addSubview:handBtn];
    self.handBtn = handBtn;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.receiverNumInputView.textField resignFirstResponder];
}

/**
 扫码添加

 @param sender <#sender description#>
 */
- (void)sweepBtnClick:(UIButton *)sender
{
    [self.receiverNumInputView.textField resignFirstResponder];

    NSLog(@"sweepBtnClick");
}
/**
 手动添加

 @param sender <#sender description#>
 */
- (void)handBtnClick:(UIButton *)sender
{
    [self.receiverNumInputView.textField resignFirstResponder];
    if (self.handBlock) {
        self.handBlock();
    }
    NSLog(@"handBtnClick");
}
#pragma mark---OverallInputArrowViewDelegate
- (void)overallInputArrowViewEditWithArrowView:(OverallInputArrowView *)arrowView
{
    [self.receiverNumInputView.textField resignFirstResponder];
    if (_delegate && [_delegate respondsToSelector:@selector(increaseHeaderViewArrowViewEditWithArrowView:)]) {
        [_delegate increaseHeaderViewArrowViewEditWithArrowView:arrowView];
    }
    NSLog(@"overallInputArrowViewEditWithArrowView");
}
#pragma mark---OverallInputViewDelegate
- (void)overallInputViewEditWithInputView:(OverallInputView *)inputView
{
    [self.receiverNumInputView.textField becomeFirstResponder];

}
- (void)overallTextViewInputDidChange:(UITextView *)textView
{
    
}
- (BOOL)overallTextView:(UITextView *)textView shouldChangeWithTextInRange:(NSRange)range replacementText:(NSString *)text
{
    return YES;
}
//------------------------------
- (void)layoutSubviews
{
    [super layoutSubviews];
    //
    CGFloat orderX = 0;
    CGFloat orderY = 0;
    CGFloat orderWidth = SCREEN_WIDTH;
    CGFloat orderHeight = InputHeight * 3 + AddViewHeight + 5 + 0.8;
    self.frame = CGRectMake(orderX, orderY, orderWidth, orderHeight);
    //顶部的背景View
    self.topContentView.frame = self.bounds;
    //客户名称frame
    CGFloat clientX = 0;
    CGFloat clientY = 0;
    CGFloat clientWidth = SCREEN_WIDTH;
    CGFloat clientHeight = InputHeight;
    self.clientInputArrowView.frame = CGRectMake(clientX, clientY, clientWidth, clientHeight);
    //收货人frame
    CGFloat receiverX = 0;
    CGFloat receiverY = CGRectGetMaxY(self.clientInputArrowView.frame);
    CGFloat receiverWidth = SCREEN_WIDTH;
    CGFloat receiverHeight = InputHeight;
    self.receiverInputArrowView.frame = CGRectMake(receiverX, receiverY, receiverWidth, receiverHeight);
    //收货人电话
    CGFloat receiverNumX = 0;
    CGFloat receiverNumY = CGRectGetMaxY(self.receiverInputArrowView.frame);
    CGFloat receiverNumWidth = SCREEN_WIDTH;
    CGFloat receiverNumHeight = InputHeight;
    self.receiverNumInputView.frame = CGRectMake(receiverNumX, receiverNumY, receiverNumWidth, receiverNumHeight);
    //“扫码添加”和“手动添加”容器frame
    CGFloat addOrderViewX = 0;
    CGFloat addOrderViewY = CGRectGetMaxY(self.receiverNumInputView.frame) + 5;
    CGFloat addOrderViewWidth = SCREEN_WIDTH;
    CGFloat addOrderViewHeight = AddViewHeight;
    self.addOrderView.frame = CGRectMake(addOrderViewX, addOrderViewY, addOrderViewWidth, addOrderViewHeight);
    //"扫码添加"按钮frame
    CGFloat sweepWidth = 140;
    CGFloat sweepHeight = 40;
    CGFloat sweepX = SCREEN_WIDTH / 2 - sweepWidth - 10;
    CGFloat sweepY = (addOrderViewHeight - sweepHeight) / 2;
    self.sweepBtn.frame = CGRectMake(sweepX, sweepY, sweepWidth, sweepHeight);
    //"手动添加"按钮frame
    CGFloat handWidth = sweepWidth;
    CGFloat handHeight = sweepHeight;
    CGFloat handX = SCREEN_WIDTH / 2 + 10;
    CGFloat handY = sweepY;
    self.handBtn.frame = CGRectMake(handX, handY, handWidth, handHeight);

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
