//
//  OverallInputView.m
//  TempApp
//
//  Created by iOS－MacBook on 2017/3/1.
//  Copyright © 2017年 iOS－MacBook. All rights reserved.
//

#import "OverallInputView.h"
#import "OverallTextView.h"
#import "NSString+Extension.h"
//#import "OMTypeModel.h"
#define OVERALLINOUTVIEWFONT [UIFont systemFontOfSize:15]
#define OVERALLINPUTHEIGHT 44
#define OVERALLINPUTWIDTH 120

@interface OverallInputView()<UITextViewDelegate>

/**
 <#annotation#>
 */
@property (nonatomic,weak) UIView *lineView;
/**
 
 */
@property (nonatomic,assign) CGSize labelSize;
/**
 <#annotation#>
 */
@property (nonatomic,assign) CGFloat labelHeight;
/**
 <#annotation#>
 */
@property (nonatomic,assign) CGSize placeholderSize;

@end

@implementation OverallInputView
- (instancetype)initWithFrame:(CGRect)frame contentIsRight:(BOOL)isRight
{
    if (self = [super initWithFrame:frame]) {
        self.isRight = isRight;
       // self.backgroundColor = [UIColor whiteColor];
        [self setupOverallInputViewSubviews];

    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
       // self.titleLabel.backgroundColor = [UIColor orangeColor];
       // self.isRight = NO;
       // self.backgroundColor = [UIColor whiteColor];

        [self setupOverallInputViewSubviews];
          }
    return self;
}
- (void)setupOverallInputViewSubviews
{
    
    [self addSubview:self.titleLabel];
    self.textField.delegate = self;
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.textField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(overallInputTextViewDidChange) name:UITextViewTextDidChangeNotification object:nil];
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0f];
    [self addSubview:lineView];
    self.lineView = lineView;
    
}

- (void)setIsRight:(BOOL)isRight
{
    _isRight = isRight;
    self.textField.isRight = isRight;
    
}
- (void)overallInputTextViewDidChange
{
    NSLog(@"overallInputTextViewDidChange");
}
- (void)setFrame:(CGRect)frame
{
    NSLog(@"调用了inputView的SetFrame方法");
    CGFloat inputHeight = frame.size.height;
    CGFloat inputWidth = frame.size.width;
    //CGFloat screen_w = [UIScreen mainScreen].bounds.size.width;
    CGFloat titleW = OVERALLINPUTWIDTH;
    CGFloat titleWidth = self.titleLabel.frame.size.width;
    if (titleWidth > 0) {
        titleW = titleWidth;
    }
    //self.titleLabel.backgroundColor = [UIColor greenColor];
    if ([self.placeholder isEqualToString:@"请输入或选择"]) {
        NSLog(@"frame = %@",NSStringFromCGRect(frame));
        NSLog(@"123");
    }
    //self.titleLabel.backgroundColor = [UIColor orangeColor];
    //self.titleLabel.layer.borderColor = [UIColor whiteColor].CGColor;
    if(self.labelSize.width > 0){
        self.titleLabel.frame = CGRectMake(5, 0, self.labelSize.width, self.labelSize.height);
    }else{
        self.titleLabel.frame = CGRectMake(5, 0, titleW, inputHeight);
    }
    
    CGFloat margin = 5;
    CGFloat textFieldW = inputWidth - titleW - margin * 2;
    if(self.textField.frame.size.width > 0){
    self.textField.frame = CGRectMake(titleW + margin, 0, textFieldW, inputHeight);
    }
    if (self.isRight == YES) {
        CGSize placeholderSize = [ self.textField.placeholderLabel.text sizeWithFont:OVERALLPRAENTFONT];

       // CGSize placeholderSize = self.placeholderSize;
        //self.placeholderSize = placeholderSize;
        CGFloat placeholderX = textFieldW - placeholderSize.width - 3;
        // CGFloat placeholderX = self.textField.frame.size.width - 80 - 3;
        //self.textField.inputView.frame
        CGFloat fieldMargin = (inputHeight - placeholderSize.height) / 2  - 10;
        
        self.textField.contentInset = UIEdgeInsetsMake(fieldMargin, 0, 0, 0);
        CGFloat placeholderY = 9;
        CGFloat placeholderWidth = placeholderSize.width;
        //CGFloat placeholderWidth = 80;
        
        CGFloat placeholderHeight = placeholderSize.height;

        self.textField.placeholderLabel.frame = CGRectMake(placeholderX, placeholderY, placeholderWidth, placeholderHeight);
    }
    
    [super setFrame:frame];
    [self setNeedsLayout];
}
#pragma mark---UITextFieldDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if (_delegate && [_delegate respondsToSelector:@selector(overallInputVieShouldBeginEditing:)]){
       
        return [_delegate overallInputVieShouldBeginEditing:self];
    }else{
       return YES;
    }
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    NSLog(@"textView = %@",textView.text);
    if (_delegate && [_delegate respondsToSelector:@selector(overallInputViewEditWithInputView:)]) {
        [_delegate overallInputViewEditWithInputView:self];
    }
    
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (_delegate && [_delegate respondsToSelector:@selector(overallInputViewEditEndInputView:)]) {
        [_delegate overallInputViewEditEndInputView:textView];

    }
    NSLog(@"textViewDidEndEditing = %@",textView.text);
}
- (void)textViewDidChange:(UITextView *)textView
{
    NSLog(@"textViewDidChangeLength = %ld",textView.text.length);
    if (0 == textView.text.length) {
       // [self overallInoutViewLayoutSubviews];
    }
    if (_delegate && [_delegate respondsToSelector:@selector(overallTextViewInputDidChange:)]) {
        [_delegate overallTextViewInputDidChange:textView];
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (_delegate && [_delegate respondsToSelector:@selector(overallTextView:shouldChangeWithTextInRange:replacementText:)]) {
        return [_delegate overallTextView:textView shouldChangeWithTextInRange:range replacementText:text];
    }else{
        return YES;
    }
}
- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.text = self.title;
    [self overallInoutViewLayoutSubviews];
}
- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    self.textField.placeholder = placeholder;
    [self overallInoutViewLayoutSubviews];

}

- (void)overallInoutViewLayoutSubviews
{
    self.backgroundColor = [UIColor whiteColor];
    CGRect frame = self.frame;
    CGFloat width = frame.size.width;
    CGFloat height = frame.size.height;
    //self.textField.backgroundColor = [UIColor orangeColor];
    CGFloat predictMaxWidth = 120;
    CGSize titleSize = [self.title sizeWithFont:OVERALLPRAENTFONT];
    if(titleSize.width > predictMaxWidth)
    {
        titleSize = CGSizeMake(predictMaxWidth, titleSize.height);
    }
    //左边的标题frame
    CGFloat titleLabelX = 5;
    CGFloat titleLabelY = 0;
    CGFloat titleLabelWidth = titleSize.width;
    CGFloat titleLabelHeight = height;

    
    self.titleLabel.frame = CGRectIntegral(CGRectMake(titleLabelX, titleLabelY, titleLabelWidth, titleLabelHeight));
    
    //右边的输入控件frame
    
    CGFloat textFieldX = CGRectGetMaxX(self.titleLabel.frame) + 5;
    CGFloat textFieldY = 0;
        CGFloat textFieldWidth = SCREEN_WIDTH - titleLabelWidth - 5 * 5;
    if (width > 0) {
        textFieldWidth = width - titleLabelWidth - 5 * 5;
    }
    CGFloat textFieldHeight = titleLabelHeight;
    self.textField.frame = CGRectMake(textFieldX, textFieldY, textFieldWidth, textFieldHeight);
    self.lineView.frame = CGRectMake(0, titleLabelHeight - 1, SCREEN_WIDTH, 1);
    
    CGSize placeholderSize = [self.placeholder sizeWithFont:OVERALLPRAENTFONT];
    if (self.isRight == YES) {
        CGFloat placeholderX = self.textField.frame.size.width - placeholderSize.width - 3;
        // CGFloat placeholderX = self.textField.frame.size.width - 80 - 3;
        //self.textField.inputView.frame
        CGFloat fieldMargin = (textFieldHeight - placeholderSize.height) / 2  - 10;

        self.textField.contentInset = UIEdgeInsetsMake(fieldMargin, 0, 0, 0);
        CGFloat placeholderY = 7;
        CGFloat placeholderWidth = placeholderSize.width;
        //CGFloat placeholderWidth = 80;
        
        CGFloat placeholderHeight = placeholderSize.height;
        self.textField.placeholderLabel.frame = CGRectMake(placeholderX, placeholderY, placeholderWidth, placeholderHeight);
    }
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.lineView.frame = CGRectMake(0, self.frame.size.height - 1, SCREEN_WIDTH, 1);

  //  NSLog(@"ReportInputFrame = %@",NSStringFromCGRect(self.frame));
    
//    CGRect rect = self.frame;
//    CGFloat inputHeight = rect.size.height;
//    CGFloat screen_w = [UIScreen mainScreen].bounds.size.width;
//    CGFloat titleW = 70;
    /*
     if(self.labelSize.height > 44){
     self.titleLabel.frame = CGRectMake(5, 0, self.labelSize.width, self.labelSize.height);
     }else{
     self.titleLabel.frame = CGRectMake(5, 0, titleW, inputHeight);
     }
     */
//    if (self.labelHeight > 35) {
//        self.titleLabel.frame = CGRectMake(5, 0, titleW, self.labelHeight);//inputHeight-->44
//        
//    }else{
//        self.titleLabel.frame = CGRectMake(5, 0, titleW, 44);//inputHeight-->44
//    }
//    CGFloat margin = 5;
//    CGFloat textFieldW = screen_w - titleW - margin * 2;
//    self.textField.frame = CGRectMake(titleW + margin, 0, textFieldW, inputHeight);
//    self.lineView.frame = CGRectMake(0, inputHeight - 1, screen_w, 1);
    
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
