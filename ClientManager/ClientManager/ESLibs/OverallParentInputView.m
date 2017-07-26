//
//  OverallParentInputView.m
//  TempApp
//
//  Created by iOS－MacBook on 2017/3/1.
//  Copyright © 2017年 iOS－MacBook. All rights reserved.
//

#import "OverallParentInputView.h"
#import "OverallTextView.h"
@implementation OverallParentInputView

- (UILabel *)titleLabel
{
    if (nil == _titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = OVERALLPRAENTFONT;
        _titleLabel.numberOfLines = 2;
        _titleLabel.backgroundColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
      
        // [self addSubview:_titleLabel];
    }
    return _titleLabel;
}
- (UILabel *)contentLabel
{
    if (nil == _contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = OVERALLPRAENTFONT;
        _contentLabel.numberOfLines = 2;
        _contentLabel.backgroundColor = [UIColor whiteColor];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        // [self addSubview:_titleLabel];
    }
    return _contentLabel;

}

-(OverallTextView *)textField
{
    if (nil == _textField) {
        _textField = [[OverallTextView alloc] init];
        _textField.font = OVERALLPRAENTFONT;
        _textField.textAlignment = NSTextAlignmentLeft;
        // _textField.backgroundColor = [UIColor redColor];
        _textField.placeholderColor = [UIColor lightGrayColor];

  
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
