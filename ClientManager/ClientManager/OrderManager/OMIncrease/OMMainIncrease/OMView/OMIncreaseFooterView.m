//
//  OMIncreaseFooterView.m
//  ClientManager
//-----------------新增订单的底部FooterView------------------
//  Created by iOS－MacBook on 2017/5/17.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import "OMIncreaseFooterView.h"
#import "NSString+Extension.h"
#import "OverallTextView.h"
#include "OverallInputView.h"
#include "OverallInputArrowView.h"
#import "OMListModel.h"
#import "OMTypeModel.h"

#define OMTypeMargin 10
#define OMTypeContentMargin 5
#define OMTypeFont [UIFont systemFontOfSize:15]
#define NUMBERS_AND_DOT @"0123456789."

@interface OMIncreaseFooterView()<UITextViewDelegate,OverallInputViewDelegate,OverallInputArrowViewDelegate>
/**
 存放自定义控件的模型数组
 */
@property (nonatomic,strong) NSMutableArray *typeArray;
/**
 备注背景容器
 */
@property (nonatomic,weak) UIView *remarkContentView;
/**
 所有自定义的背景容器
 */
@property (nonatomic,weak) UIView *customContentView;
/**
 备注标签
 */
@property (nonatomic,weak) UILabel *remarksLabel;
/**
 备注的实体内容控件
 */
@property (nonatomic,weak) UITextView *remarksTextView;
/**
 <#annotation#>
 */
//@property (nonatomic,strong) NSMutableArray *textLabels;

/**
 <#annotation#>
 */
//@property (nonatomic,strong) NSMutableArray *selectBoxArray;
/**
 <#annotation#>
 */
//@property (nonatomic,strong) NSMutableArray *listArray;
/**
 <#annotation#>
 */
@property (nonatomic,assign) CGFloat tempHeight;
/**
 <#annotation#>
 */
@property (nonatomic,weak) OverallInputView *inputView1;

@end

@implementation OMIncreaseFooterView
- (NSMutableArray *)textLabels
{
    if (nil == _textLabels) {
        _textLabels = [NSMutableArray array];
    }
    return _textLabels;
}
- (NSMutableArray *)typeArray
{
    if (nil == _typeArray) {
        _typeArray = [NSMutableArray array];
    }
    return _typeArray;
}
- (NSMutableArray *)selectBoxArray
{
    if (nil == _selectBoxArray) {
        _selectBoxArray = [NSMutableArray array];
    }
    return _selectBoxArray;
}
- (NSMutableArray *)listArray
{
    if (nil == _listArray) {
        _listArray = [NSMutableArray array];
    }
    return _listArray;
}

- (instancetype)init
{
    if (self = [super init]) {
        [self increaseFooterViewSubviews];
    }
    return self;
}
/**
 控件的初始化
 */
- (void)increaseFooterViewSubviews
{
    //备注的背景容器
    UIView *remarkContentView = [[UIView alloc] init];
    remarkContentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:remarkContentView];
    self.remarkContentView = remarkContentView;
    //所有自定义的背景容器
    UIView *customContentView = [[UIView alloc] init];
    customContentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:customContentView];
    self.customContentView = customContentView;
    //备注标签
    UILabel *remarksLabel = [[UILabel alloc] init];
    remarksLabel.font = OMTypeFont;
    remarksLabel.textColor = [UIColor blackColor];
    remarksLabel.textAlignment = NSTextAlignmentLeft;
    remarksLabel.numberOfLines = 0;
    [self.remarkContentView addSubview:remarksLabel];
    self.remarksLabel = remarksLabel;
    //备注的实体内容标签
    UITextView *remarksTextView = [[UITextView alloc] init];
    remarksTextView.layer.borderColor = [UIColor grayColor].CGColor;
    remarksTextView.layer.borderWidth = 0.5;
    remarksTextView.font = OMTypeFont;
    remarksTextView.delegate = self;
    [self.remarkContentView addSubview:remarksTextView];
    self.remarksTextView = remarksTextView;
}
- (void)setModel:(OMTypeModel *)model
{
    _model = model;
    
    //备注的背景容器frame
    CGFloat remarkContentX = 0;
    CGFloat remarkContentY = 0;
    CGFloat remarkContentWidth = SCREEN_WIDTH;
    CGFloat remarkContentHeight = 85;
    self.remarkContentView.frame = CGRectMake(remarkContentX, remarkContentY, remarkContentWidth, remarkContentHeight);
    //备注标签的frame
    NSString *remarks = @"备注";
    CGSize remarksSize = [remarks sizeWithFont:OMTypeFont];
    CGFloat remarkSignX = OMTypeMargin;
    CGFloat remarkSignY = OMTypeContentMargin;
    CGFloat remarkSignWidth = remarksSize.width;
    CGFloat remarkSignHeight = remarksSize.height;
    self.remarksLabel.frame = CGRectMake(remarkSignX, remarkSignY, remarkSignWidth, remarkSignHeight);
    self.remarksLabel.text = remarks;
    //备注内容控件的frame
    CGFloat remarksTextViewX = CGRectGetMaxX(self.remarksLabel.frame) + OMTypeMargin;
    CGFloat remarksTextViewY = OMTypeContentMargin;
    CGFloat remarksTextViewWidth = SCREEN_WIDTH - remarksTextViewX - OMTypeMargin;
    CGFloat remarksTextViewHeight = remarkContentHeight - OMTypeContentMargin * 2;
    self.remarksTextView.frame = CGRectMake(remarksTextViewX, remarksTextViewY, remarksTextViewWidth, remarksTextViewHeight);
    //备注背景下面的分割线
    UIView *remarkLine = [[UIView alloc] init];
    remarkLine.backgroundColor = [AppColor appTableCellSeparatLineColor];
    remarkLine.frame = CGRectMake(0, remarkContentHeight - 0.4, SCREEN_WIDTH, 0.4);
    [self.remarkContentView addSubview:remarkLine];
    //--------------------自定义类型设置-------------------------
    //记录总高度的变量
    //CGFloat totalH = 0;
    //默认单个自定义控件高度
   // CGFloat inputH = 44;
    
}
- (void)setModelArray:(NSArray *)modelArray
{
    _modelArray = modelArray;
    //备注的背景容器frame
    CGFloat remarkContentX = 0;
    CGFloat remarkContentY = 0;
    CGFloat remarkContentWidth = SCREEN_WIDTH;
    CGFloat remarkContentHeight = 100;
    self.remarkContentView.frame = CGRectMake(remarkContentX, remarkContentY, remarkContentWidth, remarkContentHeight);
    //备注标签的frame
    NSString *remarks = @"备注";
    CGSize remarksSize = [remarks sizeWithFont:OMTypeFont];
    CGFloat remarkSignX = OMTypeMargin;
    CGFloat remarkSignY = OMTypeContentMargin;
    CGFloat remarkSignWidth = remarksSize.width;
    CGFloat remarkSignHeight = remarksSize.height;
    self.remarksLabel.frame = CGRectMake(remarkSignX, remarkSignY, remarkSignWidth, remarkSignHeight);
    self.remarksLabel.text = remarks;
    //备注内容控件的frame
    CGFloat remarksTextViewX = CGRectGetMaxX(self.remarksLabel.frame) + OMTypeMargin;
    CGFloat remarksTextViewY = OMTypeMargin;
    CGFloat remarksTextViewWidth = SCREEN_WIDTH - remarksTextViewX - OMTypeMargin;
    CGFloat remarksTextViewHeight = remarkContentHeight - OMTypeMargin * 2;
    self.remarksTextView.frame = CGRectMake(remarksTextViewX, remarksTextViewY, remarksTextViewWidth, remarksTextViewHeight);
    //备注背景下面的分割线
    UIView *remarkLine = [[UIView alloc] init];
    remarkLine.backgroundColor = [AppColor appTableCellSeparatLineColor];
    remarkLine.frame = CGRectMake(0, remarkContentHeight - 0.4, SCREEN_WIDTH, 0.4);
    [self.remarkContentView addSubview:remarkLine];
    //--------------------自定义类型设置-------------------------
    //记录总高度的变量
    CGFloat totalH = 0;
    //默认单个自定义控件高度
    CGFloat inputH = 44;
    NSUInteger count = modelArray.count;
    if (0 != count) {
        [self.selectBoxArray removeAllObjects];
        for (NSUInteger i = 0; i < count; i ++) {
            OMTypeModel *typeModel = modelArray[i];
            if ([typeModel.fieldType isEqualToString:@"singletext"]) {//单行输入文本
                
                CGSize labelSize = [typeModel.name sizeWithFont:[UIFont systemFontOfSize:15] maxW:120];
//                if (labelSize.height > inputH) {
//                    inputH = labelSize.height;
//                }
                totalH += inputH;

               // OverallInputView *singleInputView = [[OverallInputView alloc] initWithFrame:CGRectMake(0, totalH - inputH, SCREEN_WIDTH, inputH)];
                 OverallInputView *singleInputView = [[OverallInputView alloc] init];
               // singleInputView.frame = CGRectMake(0, totalH - inputH, SCREEN_WIDTH, inputH);
                singleInputView.frame = CGRectMake(0, totalH - inputH, SCREEN_WIDTH, inputH);
                if ([typeModel.name isEqualToString:@"数字类型"]) {
                    NSLog(@"%@ = %@",typeModel.name,NSStringFromCGRect(singleInputView.frame));
                  NSLog(@"height %@ = %f",typeModel.name,labelSize.height);
                }
                //singleInputView.backgroundColor = [UIColor redColor];

                singleInputView.model = typeModel;
                //inputView1.backgroundColor = [UIColor blueColor];
                singleInputView.title = typeModel.name;
                if ([typeModel.isRequired isEqualToString:@"1"]) {
                    singleInputView.isRight = YES;
                    singleInputView.placeholder = @"请输入文字(必填)";
                }else if([typeModel.isRequired isEqualToString:@"0"]){
                    singleInputView.isRight = YES;
                    singleInputView.placeholder = @"请输入文字";
                }
                singleInputView.delegate = self;
                [self.textLabels addObject:singleInputView];
                [self.customContentView addSubview:singleInputView];
                //self.inputView1 = inputView1;
                
                
            }else if([typeModel.fieldType isEqualToString:@"selectbox"]){//下拉
                // [self.listArray addObjectsFromArray:dayModel.list];
                NSLog(@"daymodel.list = %@",typeModel.list);
                [self.listArray addObjectsFromArray:typeModel.list];
                CGSize labelSize = [typeModel.name sizeWithFont:OMTypeFont maxW:120];
                if (labelSize.height > inputH) {
                    inputH = labelSize.height;
                }
                totalH += inputH;
                OverallInputArrowView *selectBoxArrowView = [[OverallInputArrowView alloc] initWithFrame:CGRectMake(0, totalH - inputH, SCREEN_WIDTH, inputH)];
                
                selectBoxArrowView.model = typeModel;
                selectBoxArrowView.titleLabel.text = typeModel.name;
                if ([typeModel.isRequired isEqualToString:@"1"]) {
                    selectBoxArrowView.textField.placeholder = @"下拉框选择(必选)";
                }else if([typeModel.isRequired isEqualToString:@"0"]){
                    selectBoxArrowView.textField.placeholder = @"下拉框选择";
                }
                selectBoxArrowView.delegate = self;
                [self.textLabels addObject:selectBoxArrowView];
                [self.customContentView addSubview:selectBoxArrowView];
                [self.selectBoxArray addObject:selectBoxArrowView];
                //self.selectBoxArrowView = selectBoxArrowView;
                // self.arrowView4 = arrowView4;
                
            }else if ([typeModel.fieldType isEqualToString:@"multitext"])//多行文本
            {
                CGSize labelSize = [typeModel.name sizeWithFont:OMTypeFont maxW:120];
                if (labelSize.height > inputH) {
                    inputH = labelSize.height;
                }
                CGFloat textHeight = 25;
                totalH += textHeight * 3;
                OverallInputView *multiTextView = [[OverallInputView alloc] initWithFrame:CGRectMake(0, totalH - textHeight * 3, SCREEN_WIDTH, textHeight * 3)];
            multiTextView.frame = CGRectMake(0, totalH - textHeight * 3, SCREEN_WIDTH, textHeight * 3);
               // multiTextView.backgroundColor = [UIColor redColor];
                multiTextView.model = typeModel;
                multiTextView.title = typeModel.name;
                if ([typeModel.isRequired isEqualToString:@"1"]) {
                    multiTextView.isRight = YES;
                    multiTextView.placeholder = @"请输入多行文本(必填)";
                }else if([typeModel.isRequired isEqualToString:@"0"]){
                    multiTextView.isRight = YES;
                    multiTextView.placeholder = @"请输入多行文本";
                }
                multiTextView.delegate = self;
                [self.textLabels addObject:multiTextView];
                [self.customContentView addSubview:multiTextView];
                //self.arrowView3 = arrowView3;
                
            }else if ([typeModel.fieldType isEqualToString:@"number"])//数字
            {
                CGSize labelSize = [typeModel.name sizeWithFont:OMTypeFont maxW:120];
                if (labelSize.height > inputH) {
                    inputH = labelSize.height;
                }
                totalH += inputH;
                OverallInputView *multiTextView = [[OverallInputView alloc] initWithFrame:CGRectMake(0, totalH - inputH, SCREEN_WIDTH, inputH)];
               // multiTextView.backgroundColor = [UIColor orangeColor];
               // multiTextView.frame = CGRectMake(0, totalH - inputH, SCREEN_WIDTH, inputH);
                multiTextView.textField.keyboardType = UIKeyboardTypeDecimalPad;
                multiTextView.model = typeModel;
                multiTextView.title = typeModel.name;
                if ([typeModel.isRequired isEqualToString:@"1"]) {
                    multiTextView.isRight = YES;
                    multiTextView.placeholder = @"请输入数字(必填)";
                }else if([typeModel.isRequired isEqualToString:@"0"]){
                    multiTextView.isRight = YES;
                    multiTextView.placeholder = @"请输入数字";
                }
                // NSLog(@"输入数字是：%@",dayModel.name);
                multiTextView.delegate = self;
                [self.textLabels addObject:multiTextView];
                [self.customContentView addSubview:multiTextView];
                
            }else if ([typeModel.fieldType isEqualToString:@"datetime"])//日期选项
            {
                CGSize labelSize = [typeModel.name sizeWithFont:OMTypeFont maxW:120];
                if (labelSize.height > inputH) {
                    inputH = labelSize.height;
                }
                totalH += inputH;
                OverallInputArrowView *selectBoxArrowView = [[OverallInputArrowView alloc] initWithFrame:CGRectMake(0, totalH - inputH, SCREEN_WIDTH, inputH)];
                selectBoxArrowView.model = typeModel;
                selectBoxArrowView.titleLabel.text = typeModel.name;
                selectBoxArrowView.isRight = YES;
                if ([typeModel.isRequired isEqualToString:@"1"]) {
                    selectBoxArrowView.placeholder = @"请选择日期(必选)";
                }else if([typeModel.isRequired isEqualToString:@"0"]){
                    selectBoxArrowView.placeholder = @"请选择日期";
                }
                NSLog(@"日期的frame：%@",NSStringFromCGRect(selectBoxArrowView.frame));
                selectBoxArrowView.delegate = self;
                [self.textLabels addObject:selectBoxArrowView];
                [self.customContentView addSubview:selectBoxArrowView];
                
            }
            
        }
        //[self layoutInputView];
        
    }
    //自定义控件容器的frame
    CGFloat customContentX = 0;
    CGFloat customContentY = CGRectGetMaxY(self.remarkContentView.frame);
    CGFloat customContentWidth = SCREEN_WIDTH;
    CGFloat customContentHeight = totalH;
    self.customContentView.frame = CGRectMake(customContentX, customContentY, customContentWidth, customContentHeight);
     self.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.remarkContentView.frame.size.height + self.customContentView.frame.size.height);
    self.footerHeight = customContentY + totalH;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
}
#pragma mark---UITextViewDelegate
- (BOOL)overallInputVieShouldBeginEditing:(OverallInputView *)inputView
{
    if (_delegate && [_delegate respondsToSelector:@selector(increaseFooterInputVieShouldBeginEditing:)]) {
        return [_delegate increaseFooterInputVieShouldBeginEditing:inputView];
    }else{
        return YES;
    }
    
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (_delegate && [_delegate respondsToSelector:@selector(increaseRemarkTextView:shouldChangeTextInRange:replacementText:)]) {
        return [_delegate increaseRemarkTextView:textView shouldChangeTextInRange:range replacementText:text];
    }else{
        return YES;
    }
}
#pragma mark---OverallInputViewDelegate
- (void)overallInputViewEditWithInputView:(OverallInputView *)inputView
{
    if (_delegate && [_delegate respondsToSelector:@selector(increaseFooterInputViewEditWithInputView:)]) {
        [_delegate increaseFooterInputViewEditWithInputView:inputView];
    }
}
- (void)overallTextViewInputDidChange:(UITextView *)textView
{
    if (_delegate && [_delegate respondsToSelector:@selector(increaseFooterInputDidChange:)]) {
        [_delegate increaseFooterInputDidChange:textView];
    }
}
- (BOOL)overallTextView:(UITextView *)textView shouldChangeWithTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (_delegate && [_delegate respondsToSelector:@selector(increaseFooterTextView:shouldChangeWithTextInRange:replacementText:)]) {
       return  [_delegate increaseFooterTextView:textView shouldChangeWithTextInRange:range replacementText:text];
    }else{
    return YES;
    }
}
#pragma mark---OverallInputArrowViewDelegate
- (void)overallInputArrowViewEditWithArrowView:(OverallInputArrowView *)arrowView
{
    if (_delegate && [_delegate respondsToSelector:@selector(increaseFooterInputArrowViewEditWithArrowView:)]) {
        [_delegate increaseFooterInputArrowViewEditWithArrowView:arrowView];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
   
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
