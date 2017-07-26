//
//  ModelFrame.m
//  ClientManager
//
//  Created by iOS－MacBook on 2017/5/26.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import "ModelFrame.h"
#import "Model.h"

@implementation ModelFrame
- (void)setModel:(Model *)model
{
    _model = model;
    CGFloat imageViewWidth = 70;
    CGFloat imageViewHeight = imageViewWidth;
    CGFloat imageViewX = OMDetailMargin;
    CGFloat imageViewY = (CellH - imageViewHeight) / 2;
    self.imageViewFrame = CGRectMake(imageViewX, imageViewY, imageViewWidth, imageViewHeight);
    
    
    CGFloat nameLabelX = OMDetailMargin * 2 + imageViewWidth;
    CGFloat nameLabelY = OMDetailMargin;
    CGFloat predictNameWidth = SCREEN_WIDTH - nameLabelX - OMDetailMargin;
    NSString *nameStr = model.name;
    CGSize nameSize = [nameStr sizeWithFont:OMDetailFont maxW:predictNameWidth];
    CGFloat nameLabelWidth = nameSize.width;
    CGFloat nameLabelHeight = nameSize.height;
    self.nameLabelFrame = CGRectMake(nameLabelX, nameLabelY, nameLabelWidth, nameLabelHeight);
    
    CGFloat infoLabelX = OMDetailMargin * 2 + imageViewWidth;
    CGFloat predictInfoWidth = SCREEN_WIDTH - infoLabelX - OMDetailMargin;
    NSString *infoStr = model.info;
    CGSize infoSize = [infoStr sizeWithFont:OMDetailFont maxW:predictInfoWidth];
    CGFloat infoWidth = infoSize.width;
    CGFloat infoHeight = infoSize.height;
    CGFloat infoLabelY = CellH - infoSize.height - OMDetailMargin;
    self.infoLabelFrame = CGRectMake(infoLabelX, infoLabelY, infoWidth, infoHeight);
    
    CGFloat underLineX = 0;
    CGFloat underLineY = CellH - 0.4;
    CGFloat underLineWidth = SCREEN_WIDTH;
    CGFloat underLineHeight = 0.4;
    self.underLineFrame = CGRectMake(underLineX, underLineY, underLineWidth, underLineHeight);
    
}
@end
