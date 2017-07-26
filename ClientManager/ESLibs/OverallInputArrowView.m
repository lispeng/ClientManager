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
#define OVERALLARROWFONT [UIFont systemFontOfSize:15]
#define OVERALLARROWINPUTHEIGHT 44
@interface OverallInputArrowView()<UITextViewDelegate>
/**
 <#annotation#>
 */
@property (nonatomic,weak) UIView *lineView;
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
        
        
        UIButton *pickArrowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        pickArrowBtn.backgroundColor = [UIColor clearColor];
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
- (void)setFrame:(CGRect)frame
{

    [super setFrame:frame];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect rect = self.frame;
    CGFloat inputHeight = rect.size.height;
    CGFloat screen_w = [UIScreen mainScreen].bounds.size.width;
    CGFloat titleW = 70;
    self.titleLabel.frame = CGRectMake(5, 0, titleW, inputHeight);
    CGFloat margin = 5;
    CGFloat textFieldW = screen_w - titleW - margin * 2 - OVERALLARROWINPUTHEIGHT;
    self.textField.frame = CGRectMake(titleW + margin, 0, textFieldW, inputHeight);
    self.pickArrowBtn.frame = CGRectMake(titleW + margin, 0, textFieldW, inputHeight);
    CGFloat imageViewX = titleW + margin + textFieldW;
    CGFloat imageViewWH = OVERALLARROWINPUTHEIGHT;
    NSLog(@"123456");
    CGFloat imageY = (inputHeight - imageViewWH) / 2;
    self.imageView.frame = CGRectMake(imageViewX, imageY, imageViewWH, imageViewWH);
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
