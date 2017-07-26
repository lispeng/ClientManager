//
//  CMCreateDateView.m
//  ClientManager
//
//  Created by iOS－MacBook on 2017/7/14.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import "CMCreateDateView.h"
#import "CMCreateDateModel.h"
#import "CMButton.h"
#define CreateDateViewHeight 44

@interface CMCreateDateView()


@end

@implementation CMCreateDateView
static CMCreateDateView *_createDateView;

+ (instancetype)shareCreateDateView
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _createDateView = [[CMCreateDateView alloc] init];
       // _createDateView.positionType = CMButtonPositionTypeMiddle;
        //  [_responsibleView setupResponsibleViewSubViews];
        
    });
    return _createDateView;
}

- (void)setCreateDateArr:(NSArray<CMCreateDateModel *> *)createDateArr
{
    _createDateArr = createDateArr;
    
    self.userInteractionEnabled = YES;
    NSInteger count = createDateArr.count;
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    if (count > 0) {
        for (NSInteger i = 0; i < count; i ++) {
            CMCreateDateModel *model = createDateArr[i];
            CMButton *btn = [CMButton buttonWithType:UIButtonTypeCustom];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setTitle:model.title forState:UIControlStateNormal];
            btn.titleLabel.font = ComFont;
            btn.titleLabel.textColor = [UIColor darkGrayColor];
            CGFloat btnWidth = SCREEN_WIDTH;
            CGFloat btnHeight = 44;
            CGFloat btnX = 0;
            CGFloat btnY = btnHeight * i;
            btn.frame = CGRectMake(btnX, btnY, btnWidth, btnHeight);
            
            //位置
            CGSize titleSize = [btn.currentTitle sizeWithFont:ComFont];
            CGFloat titileWidth = titleSize.width;
            NSUInteger interMargin = 10;
            CGFloat leftBtnWidth = SCREEN_WIDTH - interMargin * 2 - titileWidth;
            btn.titleEdgeInsets = UIEdgeInsetsMake(0, -leftBtnWidth / 2 + self.titleOffset, 0, 0);
            /*
             if (self.positionType == CMButtonPositionTypeLeft) {
             
             
             }else if (self.positionType == CMButtonPositionTypeMiddle)
             {
             btn.titleEdgeInsets = UIEdgeInsetsMake(0, leftBtnWidth / 2, 0, 0);
             
             }else{
             
             }*/
            
            
            [btn addTarget:self action:@selector(createDateViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.backgroundColor = [UIColor clearColor];
            btn.createDateModel = model;
            [_createDateView addSubview:btn];
            
            UIView *btnUnderLine = [[UIView alloc] init];
            btnUnderLine.backgroundColor = [AppColor appTableCellSeparatLineColor];
            
            CGFloat btnUnderLineWidth = SCREEN_WIDTH;
            CGFloat btnUnderLineHeight = 0.4;
            CGFloat btnUnderLineX = 0;
            CGFloat btnUnderLineY = btnHeight * (i + 1)- 0.4;
            btnUnderLine.frame = CGRectMake(btnUnderLineX, btnUnderLineY, btnUnderLineWidth, btnUnderLineHeight);
            [_createDateView addSubview:btnUnderLine];
            
        }
        
    }
    self.createDateHeight = count * 44;

}
- (void)createDateViewBtnClick:(CMButton *)sender
{
    if (self.createBlock) {
        self.createBlock(sender);
    }
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
