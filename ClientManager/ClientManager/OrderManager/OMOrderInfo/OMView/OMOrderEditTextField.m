//
//  OMOrderEditTextField.m
//  ClientManager
//
//  Created by iOS－MacBook on 2017/5/15.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import "OMOrderEditTextField.h"

@implementation OMOrderEditTextField
- (instancetype)init
{
    if (self = [super init]) {
        [self setupOrderEditTextField];
    }
    return self;
}
- (void)setupOrderEditTextField
{
    self.keyboardType = UIKeyboardTypeDecimalPad;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//    UIView *leftView = [[UIView alloc] init];
//    leftView.frame = CGRectMake(0, 0, 5, self.height);
//    self.leftBackspaceView = leftView;
//}
@end
