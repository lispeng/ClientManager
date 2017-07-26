//
//  OverallInputArrowView.m
//  TempApp
//
//  Created by iOS－MacBook on 2017/3/1.
//  Copyright © 2017年 iOS－MacBook. All rights reserved.
//

#import "OverallInputArrowView.h"
#import "NSString+Extension.h"
#import "OverallTextView.h"
//#import "OMTypeModel.h"
#define OVERALLARROWFONT [UIFont systemFontOfSize:15]
#define OVERALLARROWINPUTHEIGHT 44

@interface OverallInputArrowView()<UITextViewDelegate>
/**
 <#annotation#>
 */
@property (nonatomic,weak) UIButton *pickArrowBtn;

@end

@implementation OverallInputArrowView
- (UIImageView *)imageView
{
    if (nil == _imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.userInteractionEnabled = YES;
        _imageView.contentMode = UIViewContentModeCenter;
        _imageView.image = [UIImage imageNamed:@"s-3.0-l"];
    }
    return _imageView;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
      //  self.titleLabel.backgroundColor = [UIColor blueColor];
        [self addSubview:self.titleLabel];
        self.textField.delegate = self;
        [self addSubview:self.textField];
        [self addSubview:self.imageView];
        self.backgroundColor = [UIColor whiteColor];
        
        
        UIButton *pickArrowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        pickArrowBtn.backgroundColor = [UIColor clearColor];
       // pickArrowBtn.backgroundColor = [UIColor ];
        [pickArrowBtn addTarget:self action:@selector(ovarallPickArrowBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:pickArrowBtn];
        self.pickArrowBtn = pickArrowBtn;
        
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0f];
        [self addSubview:lineView];
        self.lineView = lineView;
        
    }
    return self;
}
- (void)ovarallPickArrowBtnClick:(UIButton *)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(overallInputArrowViewEditWithArrowView:)]) {
        [_delegate overallInputArrowViewEditWithArrowView:self];
    }
    
}

- (void)setIsLabel:(BOOL)isLabel
{
    _isLabel = isLabel;
    if (isLabel == YES) {
        //[self.textField removeFromSuperview];
       // self.textField.hidden = YES;
        self.contentLabel.hidden = YES;
        [self addSubview:self.contentLabel];
        if ([self.titleLabel.text isEqualToString:@"提交人"]) {
            self.contentLabel.numberOfLines = 1;
        }
    }
}
- (void)setIsShowTextView:(BOOL)isShowTextView
{
    _isShowTextView = isShowTextView;
    if (isShowTextView) {
        self.contentLabel.hidden = YES;
        self.textField.hidden = NO;
    }else{
        self.contentLabel.hidden = NO;
        self.textField.hidden = YES;
    }
}
- (void)setText:(NSString *)text
{
    _text = text;
    self.textField.text = text;
    if (self.isRight == YES) {
        
        CGRect rect = self.frame;
        CGFloat inputHeight = rect.size.height;
        CGFloat screen_w = [UIScreen mainScreen].bounds.size.width;
        CGFloat titleW = 80;
        self.titleLabel.frame = CGRectMake(5, 0, titleW, inputHeight);
        CGFloat margin = 5;
        CGFloat textFieldW = screen_w - titleW - margin * 2 - OVERALLARROWINPUTHEIGHT + 15;
        self.textField.frame = CGRectMake(titleW + margin, 0, textFieldW, inputHeight);
        self.contentLabel.frame = CGRectMake(titleW + margin, 0, textFieldW, inputHeight - 1);
        
        CGSize textSize = [text sizeWithFont:OVERALLPRAENTFONT maxW:textFieldW];
        
        CGSize placeholderSize = [self.placeholder sizeWithFont:OVERALLPRAENTFONT];
        if (self.isRight == YES) {
            
            CGFloat textY = (inputHeight - textSize.height) / 2;
            CGFloat textHeight = textSize.height;
            self.textField.contentInset = UIEdgeInsetsMake(-10, 0, 0, 0);
            self.textField.frame = CGRectMake(titleW + margin, textY, textFieldW, textHeight);
            //self.textField.frame = CGRectMake(titleW + margin, 5, textFieldW, inputHeight);
            CGFloat placeholderX = textFieldW - placeholderSize.width;
            // CGFloat placeholderX = self.textField.frame.size.width - 80 - 3;
            CGFloat placeholderWidth = placeholderSize.width;
            CGFloat placeholderHeight = 44;
            
            CGFloat placeholderY = (rect.size.height - placeholderHeight) / 2 - 5 - 5;
            self.textField.placeholderLabel.frame = CGRectMake(placeholderX, placeholderY, placeholderWidth, placeholderHeight);
            
        }

        
        
    }
}
- (void)setNumberOfLines:(NSInteger)numberOfLines
{
    _numberOfLines = numberOfLines;
    self.contentLabel.numberOfLines = numberOfLines;
}
- (void)setFrame:(CGRect)frame
{

    [super setFrame:frame];
}
- (void)setIsRight:(BOOL)isRight
{
    _isRight = isRight;
    if (isRight == YES) {
        self.contentLabel.textAlignment = NSTextAlignmentRight;
    }
    self.textField.isRight = isRight;
    
}
- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    self.textField.placeholder = placeholder;
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    if (nil != self.text) {
        // CGSize textSize = [self.text sizeWithFont:OVERALLPRAENTFONT maxW:textFieldW];
        return;
        
    }
    CGRect rect = self.frame;
    CGFloat inputHeight = rect.size.height;
    CGFloat screen_w = [UIScreen mainScreen].bounds.size.width;
    //zui
    if (rect.size.width > 0) {
        screen_w = rect.size.width;
    }
    CGFloat titleW = 80;
    self.titleLabel.frame = CGRectMake(5, 0, titleW, inputHeight);
    CGFloat margin = 5;
    CGFloat textFieldW = screen_w - titleW - margin * 2 - OVERALLARROWINPUTHEIGHT + 15;
    
    self.textField.frame = CGRectMake(titleW + margin, 0, textFieldW, inputHeight);
    self.contentLabel.frame = CGRectMake(titleW + margin, 0, textFieldW, inputHeight - 1);
    
    CGSize placeholderSize = [self.placeholder sizeWithFont:OVERALLPRAENTFONT];
    if (self.isRight == YES) {
        
       
        CGFloat placeholderX = textFieldW - placeholderSize.width;
        // CGFloat placeholderX = self.textField.frame.size.width - 80 - 3;
        CGFloat placeholderWidth = placeholderSize.width;
        CGFloat placeholderHeight = 44;

        CGFloat placeholderY = (rect.size.height - placeholderHeight) / 2 - 5;
          self.textField.placeholderLabel.frame = CGRectMake(placeholderX, placeholderY, placeholderWidth, placeholderHeight);

    }

    CGFloat imageViewX = titleW + margin + textFieldW;
    CGFloat imageViewWidth = OVERALLARROWINPUTHEIGHT - 15;
    CGFloat imageViewWH = OVERALLARROWINPUTHEIGHT;
    
    CGFloat imageY = (inputHeight - imageViewWH) / 2;
    self.pickArrowBtn.frame = CGRectMake(titleW + margin, 0, textFieldW + imageViewWidth, inputHeight);

    self.imageView.frame = CGRectMake(imageViewX, imageY, imageViewWidth, imageViewWH);
    self.lineView.frame = CGRectMake(0, inputHeight - 1, screen_w, 1);
    
    
}
#pragma mark---UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    //    if (_delegate && [_delegate respondsToSelector:@selector(reportInputArrowViewEditWithArrowView:)]) {
    //        [_delegate reportInputArrowViewEditWithArrowView:self];
    //    }
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
