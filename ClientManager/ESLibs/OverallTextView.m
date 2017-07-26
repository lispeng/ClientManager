//
//  OverallTextView.m
//  TempApp
//
//  Created by iOS－MacBook on 2017/3/1.
//  Copyright © 2017年 iOS－MacBook. All rights reserved.
//

#import "OverallTextView.h"
#import "UIView+Extension.h"
#import "NSString+Extension.h"
#define OverallNotiCenter [NSNotificationCenter defaultCenter]

@interface OverallTextView()

@property (nonatomic,weak) UILabel *placeholderLabel;

@end
@implementation OverallTextView
- (UILabel *)placeholderLabel
{
    if (!_placeholder) {
        //添加一个用来显示占位文字的Label控件
        UILabel *placeholderLabel = [[UILabel alloc] init];
        placeholderLabel.numberOfLines = 0;
        placeholderLabel.x = 3;
        placeholderLabel.y = 15;
       // placeholderLabel.backgroundColor = [UIColor orangeColor];
        // placeholderLabel.backgroundColor = [UIColor redColor];
        // placeholderLabel.center = self.center;
        // placeholderLabel.hidden = YES;
        [self addSubview:placeholderLabel];
        self.placeholderLabel = placeholderLabel;
        
    }
    return _placeholderLabel;
}
- (instancetype)init
{
    if (self = [super init]) {
        //垂直方向上永远有弹簧效果
        self.alwaysBounceVertical = YES;
        //默认的的字体
        self.font = [UIFont systemFontOfSize:15];
        //默认的文字颜色
        self.placeholderColor = [UIColor grayColor];
        
        self.contentInset = UIEdgeInsetsMake(05, 0, 0, 0);

        //监听文字改变
        [OverallNotiCenter addObserver:self selector:@selector(overallTextViewTextDidChange) name:UITextViewTextDidChangeNotification object:nil];
        
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
   // self.placeholderLabel.x = 3;
   // self.placeholderLabel.y = 15;
   // self.placeholderLabel.width = self.frame.size.width - 2 * self.placeholderLabel.x;
    CGSize size = [self.placeholder sizeWithFont:self.placeholderLabel.font];
    self.placeholderLabel.frame = CGRectMake(5, 7, size.width, 44);
    [self.placeholderLabel sizeToFit];
    
   // NSLog(@"placeholderLabelFrame = %@",NSStringFromCGRect(self.placeholderLabel.frame));
    //NSLog(@"self.Frame = %@",NSStringFromCGRect(self.frame));
    
   }
- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    
    self.placeholderLabel.textColor = placeholderColor;
    [self setNeedsDisplay];
    //self.placeholderLabel.x = 3;
    //self.placeholderLabel.y = 15;
    
}
- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    self.placeholderLabel.text = placeholder;
    //self.placeholderLabel.frame = CGRectMake(5, 10, 200, 44);
    //  [self updatePlaceholderLabelSize];
    // [self setNeedsLayout];
}
- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    self.placeholderLabel.font = font;
    
    // [self updatePlaceholderLabelSize];
    [self setNeedsLayout];
    
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    [self overallTextViewTextDidChange];
    // [self setNeedsDisplay];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    [self overallTextViewTextDidChange];
    //[self setNeedsDisplay];
}
/**
 *  监听文字改变的通知
 */
- (void)overallTextViewTextDidChange
{

    //有文字显示，就隐藏占位文字控件
    self.placeholderLabel.hidden = self.hasText;
    // [self setNeedsDisplay];
}
- (void)dealloc
{
    [OverallNotiCenter removeObserver:self];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
