//
//  OMTextField.m
//  ClientManager
//
//  Created by iOS－MacBook on 2017/5/15.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import "OMTextField.h"
@interface OMTextField()

@end
@implementation OMTextField
- (instancetype)init
{
    if (self = [super init]) {
    }
    return self;
}
// 控制placeHolder的位置，左右缩20，但是光标位置不变
/*
 -(CGRect)placeholderRectForBounds:(CGRect)bounds
 {
 CGRect inset = CGRectMake(bounds.origin.x+100, bounds.origin.y, bounds.size.width -10, bounds.size.height);//更好理解些
 return inset;
 }
 */

// 修改文本展示区域，一般跟editingRectForBounds一起重写
- (CGRect)textRectForBounds:(CGRect)bounds
{
    CGRect inset = CGRectMake(bounds.origin.x+3, bounds.origin.y, bounds.size.width-3, bounds.size.height);//更好理解些
    return inset;
}

// 重写来编辑区域，可以改变光标起始位置，以及光标最右到什么地方，placeHolder的位置也会改变
-(CGRect)editingRectForBounds:(CGRect)bounds
{
    CGRect inset = CGRectMake(bounds.origin.x+3, bounds.origin.y, bounds.size.width, bounds.size.height);//更好理解些
    return inset;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
