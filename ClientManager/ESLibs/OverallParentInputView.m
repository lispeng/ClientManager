//
//  OverallParentInputView.m
//  TempApp
//
//  Created by iOS－MacBook on 2017/3/1.
//  Copyright © 2017年 iOS－MacBook. All rights reserved.
//

#import "OverallParentInputView.h"
#import "OverallTextView.h"
#define OVERALLPRAENTFONT [UIFont systemFontOfSize:15]
#define OVERALLINPUTHEIGHT 44
@implementation OverallParentInputView
- (UILabel *)titleLabel
{
    if (nil == _titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = OVERALLPRAENTFONT;
        _titleLabel.numberOfLines = 0;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        // [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

-(OverallTextView *)textField
{
    if (nil == _textField) {
        _textField = [[OverallTextView alloc] init];
        _textField.font = OVERALLPRAENTFONT;
        _textField.textAlignment = NSTextAlignmentLeft;
        // _textField.backgroundColor = [UIColor redColor];
        _textField.placeholderColor = [UIColor lightGrayColor];
        // _textField.delegate = self;
        //也可以监听contentSize属性
           }
    return _textField;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
