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


@end
@implementation OverallTextView
- (UILabel *)placeholderLabel
{
    if (!_placeholder) {
        //添加一个用来显示占位文字的Label控件
        UILabel *placeholderLabel = [[UILabel alloc] init];
        placeholderLabel.numberOfLines = 0;
        placeholderLabel.x = 3;
        placeholderLabel.y = 0;
        //placeholderLabel.backgroundColor = [UIColor orangeColor];
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
        
       self.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.isRight = NO;
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

    if (self.isRight == NO) {
        self.placeholderLabel.frame = CGRectMake(5, -5, size.width, 44);
    }else{
      
    }
    
   // [self.placeholderLabel sizeToFit];
    

    
   }
- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    
    self.placeholderLabel.textColor = placeholderColor;

    //[self setNeedsDisplay];
    //self.placeholderLabel.x = 3;
    //self.placeholderLabel.y = 15;
    
}
/**
 占位颜色

 @param placeholder <#placeholder description#>
 */
- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    self.placeholderLabel.text = placeholder;
    self.placeholderLabel.textColor = self.placeholderColor;
   // self.placeholderLabel.backgroundColor = [UIColor purpleColor];
    self.placeholderLabel.font = self.font;
    [self overallTextViewLayoutSubviews];

}
- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    self.placeholderLabel.font = font;
    self.placeholderLabel.textColor = [UIColor lightGrayColor];
    NSLog(@"self.placeholderLabel.textColor = %@",self.placeholderLabel.textColor
          );
    NSLog(@"self.placeholderLabel.font.pointSize = %f",font.pointSize);

    // [self updatePlaceholderLabelSize];
   // [self setNeedsLayout];
    
}

- (void)setText:(NSString *)text
{
    [super setText:text];

    NSLog(@"placeholderLabel.font.pointSize = %f",self.placeholderLabel.font.pointSize);

    NSLog(@"self.placeholderLabel.textColor = %@",self.placeholderLabel.textColor);

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
- (void)setIsRight:(BOOL)isRight
{
    _isRight = isRight;
//    if (isRight == YES) {
//        self.textAlignment = NSTextAlignmentRight;
//        CGSize size = [self.placeholder sizeWithFont:self.placeholderLabel.font];
//        self.placeholderLabel.frame = CGRectMake(self.width - size.width, -5, size.width, 44);
//
//    }
    [self overallTextViewLayoutSubviews];

}
- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self overallTextViewLayoutSubviews];
}
- (void)overallTextViewLayoutSubviews
{
    if (self.isRight == YES) {
        self.textAlignment = NSTextAlignmentRight;
        self.contentInset = UIEdgeInsetsMake(5, 0, 0, 0);
        CGSize size = [self.placeholder sizeWithFont:self.placeholderLabel.font maxW:120];
        CGFloat placeholderLabelX = self.frame.size.width - size.width - 10;
        CGFloat placeholderLabelY = -5;
        CGFloat placeholderLabelWidth = size.width;
        CGFloat placeholderLabelHeight = self.frame.size.height;
        self.placeholderLabel.frame = CGRectMake(placeholderLabelX, placeholderLabelY, placeholderLabelWidth, placeholderLabelHeight);

    }else{
        
    }
   // [self setNeedsLayout];
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
