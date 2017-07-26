//
//  CustomButtom.m
//  ClientManager
//
//  Created by iOS－MacBook on 2017/7/12.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import "CustomButtom.h"


@interface CustomButtom()

@end

@implementation CustomButtom
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}

- (void)setup
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}
/**
 *  布局按钮内部的子控件
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
   // CGRect imageViewFrame = self.imageView.frame;
    CGFloat margin = (self.width - self.titleLabel.frame.size.width - self.imageView.frame.size.width) / 2;
    
    CGFloat titleLabelX = margin;
    CGFloat titleLabelY = self.titleLabel.frame.origin.y;
    CGFloat titleLabelWidth = self.titleLabel.frame.size.width;
    CGFloat titleLabelHeight = self.titleLabel.frame.size.height;
    self.titleLabel.frame = CGRectMake(titleLabelX, titleLabelY, titleLabelWidth, titleLabelHeight);
    
    CGFloat imageViewX = self.titleLabel.frame.origin.x + titleLabelWidth + 5;
    CGFloat imageViewY = self.imageView.frame.origin.y;
    CGFloat imageViewWidth = self.imageView.frame.size.width;
    CGFloat imageViewHeight = self.imageView.frame.size.height;
    self.imageView.frame = CGRectMake(imageViewX, imageViewY, imageViewWidth, imageViewHeight);
    
    //self.imageView.frame = self.titleLabel.frame;
  
    
    
    
   // self.titleLabel.frame = imageViewFrame;
    /*
    //调整图片
    self.imageView.x = self.titleLabel.x + self.titleLabel.width;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.imageView.height;
    
    //调整文字
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.width = self.imageView.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
     */
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
