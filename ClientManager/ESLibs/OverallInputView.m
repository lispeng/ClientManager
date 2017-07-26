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
#define OVERALLINOUTVIEWFONT [UIFont systemFontOfSize:15]
#define OVERALLINPUTHEIGHT 44
#define OVERALLINPUTWIDTH 95

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

@end

@implementation OverallInputView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
       // self.titleLabel.backgroundColor = [UIColor orangeColor];
        [self addSubview:self.titleLabel];
        self.textField.delegate = self;
        
        [self addSubview:self.textField];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(overallInputTextViewDidChange) name:UITextViewTextDidChangeNotification object:nil];
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0f];
        [self addSubview:lineView];
        self.lineView = lineView;
    }
    return self;
}
- (void)overallInputTextViewDidChange
{
    NSLog(@"overallInputTextViewDidChange");
}
- (void)setFrame:(CGRect)frame
{
    NSLog(@"调用了inputView的SetFrame方法");
    CGFloat inputHeight = frame.size.height;
    CGFloat screen_w = [UIScreen mainScreen].bounds.size.width;
    CGFloat titleW = OVERALLINPUTWIDTH;
    //self.titleLabel.backgroundColor = [UIColor greenColor];
    
    if(self.labelSize.width > 0){
        self.titleLabel.frame = CGRectMake(5, 0, self.labelSize.width, self.labelSize.height);
    }else{
        self.titleLabel.frame = CGRectMake(5, 0, titleW, inputHeight);
    }
    
    CGFloat margin = 5;
    CGFloat textFieldW = screen_w - titleW - margin * 2;
    self.textField.frame = CGRectMake(titleW + margin, 0, textFieldW, inputHeight);
    [super setFrame:frame];
    //[self setNeedsLayout];
}
#pragma mark---UITextFieldDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    NSLog(@"textView = %@",textView.text);
    if (_delegate && [_delegate respondsToSelector:@selector(overallInputViewEditWithInputView:)]) {
        [_delegate overallInputViewEditWithInputView:self];
    }
    
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    
}
- (void)textViewDidChange:(UITextView *)textView
{
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
- (void)layoutSubviews
{
    [super layoutSubviews];
  //  NSLog(@"ReportInputFrame = %@",NSStringFromCGRect(self.frame));
    CGRect rect = self.frame;
    CGFloat inputHeight = rect.size.height;
    CGFloat screen_w = [UIScreen mainScreen].bounds.size.width;
    CGFloat titleW = 70;
    /*
     if(self.labelSize.height > 44){
     self.titleLabel.frame = CGRectMake(5, 0, self.labelSize.width, self.labelSize.height);
     }else{
     self.titleLabel.frame = CGRectMake(5, 0, titleW, inputHeight);
     }
     */
    if (self.labelHeight > 35) {
        self.titleLabel.frame = CGRectMake(5, 0, titleW, self.labelHeight);//inputHeight-->44
        
    }else{
        self.titleLabel.frame = CGRectMake(5, 0, titleW, 44);//inputHeight-->44
    }
    CGFloat margin = 5;
    CGFloat textFieldW = screen_w - titleW - margin * 2;
    self.textField.frame = CGRectMake(titleW + margin, 0, textFieldW, inputHeight);
    self.lineView.frame = CGRectMake(0, inputHeight - 1, screen_w, 1);
    
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
