//
//  CMResponsibleView.m
//  ClientManager
//
//  Created by iOS－MacBook on 2017/7/12.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import  "CMResponsibleView.h"
#include "CMResponsibleModel.h"
#import  "CMButton.h"
#define ResponsibleViewHeight 44
@interface CMResponsibleView()
/**
 <#annotation#>
 */
@property (nonatomic,strong) NSMutableArray *btnArr;
/**
 <#annotation#>
 */
@property (nonatomic,strong) NSMutableArray *lineArr;
/**
 我负责的
 */
@property (nonatomic,weak) CMButton *responsibleBtn;
/**
 <#annotation#>
 */
@property (nonatomic,weak) UIView *responsibleLine;
/**
 我相关的
 */
@property (nonatomic,weak) CMButton *correlationBtn;
/**
 <#annotation#>
 */
@property (nonatomic,weak) UIView *correlationLine;
/**
 我下属的
 */
@property (nonatomic,weak) CMButton *subordinateBtn;
/**
 <#annotation#>
 */
@property (nonatomic,weak) UIView *subordinateLine;
/**
 我领取的
 */
@property (nonatomic,weak) CMButton *visitBtn;
/**
 <#annotation#>
 */
@property (nonatomic,weak) UIView *visitLine;
/**
 已赢单的
 */
@property (nonatomic,weak) CMButton *winBtn;
/**
 <#annotation#>
 */
@property (nonatomic,weak) UIView *winLine;


@end

@implementation CMResponsibleView
- (NSMutableArray *)btnArr
{
    
    if (nil == _btnArr) {
        
        _btnArr = [NSMutableArray array];
        
    }
    
    return _btnArr;
    
}
- (NSMutableArray *)lineArr
{
    
    if (nil == _lineArr) {
        
        _lineArr = [NSMutableArray array];
        
    }
    
    return _lineArr;
    
}
static CMResponsibleView *_responsibleView;

+ (instancetype)shareResponsibleView
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _responsibleView = [[CMResponsibleView alloc] init];
        _responsibleView.positionType = CMButtonPositionTypeMiddle;
      //  [_responsibleView setupResponsibleViewSubViews];

    });
    return _responsibleView;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupResponsibleViewSubViews];

    }
    return self;
}
- (instancetype)initWithResponsibleArr:(NSArray<CMResponsibleModel *> *)responsibleArr
{
    if (self = [super init]) {
       // self.responsibleArr = responsibleArr;
        [self setupResponsibleViewSubViews];

    }
    return self;
}
- (void)setResponsibleArr:(NSArray<CMResponsibleModel *> *)responsibleArr
{
    _responsibleArr = responsibleArr;
    self.userInteractionEnabled = YES;
    NSInteger count = responsibleArr.count;
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    if (count > 0) {
        for (NSInteger i = 0; i < count; i ++) {
            CMResponsibleModel *model = responsibleArr[i];
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
            btn.titleEdgeInsets = UIEdgeInsetsMake(0, -leftBtnWidth + self.titleOffset + interMargin, 0, 0);
/*
            if (self.positionType == CMButtonPositionTypeLeft) {
                
                
            }else if (self.positionType == CMButtonPositionTypeMiddle)
            {
                btn.titleEdgeInsets = UIEdgeInsetsMake(0, leftBtnWidth / 2, 0, 0);
                
            }else{
                
            }*/
            
            
            [btn addTarget:self action:@selector(responsibelViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.backgroundColor = [UIColor clearColor];
            btn.responsibleModel = model;
            [_responsibleView addSubview:btn];
            
            UIView *btnUnderLine = [[UIView alloc] init];
            btnUnderLine.backgroundColor = [AppColor appTableCellSeparatLineColor];
            
            CGFloat btnUnderLineWidth = SCREEN_WIDTH;
            CGFloat btnUnderLineHeight = 0.4;
            CGFloat btnUnderLineX = 0;
            CGFloat btnUnderLineY = btnHeight * (i + 1)- 0.4;
            btnUnderLine.frame = CGRectMake(btnUnderLineX, btnUnderLineY, btnUnderLineWidth, btnUnderLineHeight);
            [_responsibleView addSubview:btnUnderLine];
        
        }
        
    }
    self.responsibleHeight = count * 44;
}
- (void)responsibelViewBtnClick:(CMButton *)sender
{
    NSLog(@"responsibelViewBtnTitle = %@",sender.responsibleModel.title);
    if (self.responsibleBlock) {
        self.responsibleBlock(sender);
    }

}
- (void)setupResponsibleViewSubViews
{
    
    //我负责的
    CMButton *responsibleBtn = [CMButton buttonWithType:UIButtonTypeCustom];
    [responsibleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [responsibleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [responsibleBtn setTitle:@"我负责的" forState:UIControlStateNormal];
    responsibleBtn.backgroundColor = [UIColor whiteColor];
    [responsibleBtn addTarget:self action:@selector(responsibelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    responsibleBtn.hidden = YES;
    [_responsibleView addSubview:responsibleBtn];
    self.responsibleBtn = responsibleBtn;
    
    UIView *responsibleLine = [[UIView alloc] init];
    responsibleLine.backgroundColor = [AppColor appTableCellSeparatLineColor];
    [_responsibleView addSubview:responsibleLine];
    self.responsibleLine = responsibleLine;
    
    //我相关的
    CMButton *correlationBtn = [CMButton buttonWithType:UIButtonTypeCustom];
    [correlationBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [correlationBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [correlationBtn setTitle:@"我相关的" forState:UIControlStateNormal];
    correlationBtn.backgroundColor = [UIColor whiteColor];

    [correlationBtn addTarget:self action:@selector(correlationBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_responsibleView addSubview:correlationBtn];
    self.correlationBtn = correlationBtn;
    
    UIView *correlationLine = [[UIView alloc] init];
    correlationLine.backgroundColor = [AppColor appTableCellSeparatLineColor];
    [_responsibleView addSubview:correlationLine];
    self.correlationLine = correlationLine;
    
    
    //我下属的
    CMButton *subordinateBtn = [CMButton buttonWithType:UIButtonTypeCustom];
    [subordinateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [subordinateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [subordinateBtn setTitle:@"我下属的" forState:UIControlStateNormal];
    subordinateBtn.backgroundColor = [UIColor whiteColor];

    [subordinateBtn addTarget:self action:@selector(subordinateBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_responsibleView addSubview:subordinateBtn];
    self.subordinateBtn = subordinateBtn;
    
    UIView *subordinateLine = [[UIView alloc] init];
    subordinateLine.backgroundColor = [AppColor appTableCellSeparatLineColor];
    [_responsibleView addSubview:subordinateLine];
    self.subordinateLine = subordinateLine;
    
      //已赢单的
    CMButton *winBtn = [CMButton buttonWithType:UIButtonTypeCustom];
    [winBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [winBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [winBtn setTitle:@"已赢单的" forState:UIControlStateNormal];
    winBtn.backgroundColor = [UIColor whiteColor];

    [winBtn addTarget:self action:@selector(winBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_responsibleView addSubview:winBtn];
    self.winBtn = winBtn;
    
    UIView *winLine = [[UIView alloc] init];
    winLine.backgroundColor = [AppColor appTableCellSeparatLineColor];
    [_responsibleView addSubview:winLine];
    self.winLine = winLine;
    
    //今天拜访联系的
    CMButton *visitBtn = [CMButton buttonWithType:UIButtonTypeCustom];
    [visitBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [visitBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    visitBtn.backgroundColor = [UIColor whiteColor];

    [visitBtn setTitle:@"今天拜访联系的" forState:UIControlStateNormal];
    [visitBtn addTarget:self action:@selector(visitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    //visitBtn.backgroundColor = [UIColor orangeColor];
    [_responsibleView addSubview:visitBtn];
    self.visitBtn = visitBtn;
    
    UIView *visitLine = [[UIView alloc] init];
    visitLine.backgroundColor = [AppColor appTableCellSeparatLineColor];
    [_responsibleView addSubview:visitLine];
    self.visitLine = visitLine;
    

    
}


- (void)responsibelBtnClick:(CMButton *)sender
{
    if (self.responsibleBlock) {
        self.responsibleBlock(sender);
    }
}
- (void)correlationBtnClick:(CMButton *)sender
{
    if (self.responsibleBlock) {
        self.responsibleBlock(sender);
    }
}
- (void)subordinateBtnClick:(CMButton *)sender
{
    if (self.responsibleBlock) {
        self.responsibleBlock(sender);
    }
}

- (void)winBtnClick:(CMButton *)sender
{
    if (self.responsibleBlock) {
        self.responsibleBlock(sender);
    }
}
- (void)visitBtnClick:(CMButton *)sender
{
    if (self.responsibleBlock) {
        self.responsibleBlock(sender);
    }
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self layoutResponsibleSubviews];
}
- (void)layoutResponsibleSubviews
{
    //CGFloat responsibleHeight = self.frame.size.height;
   // CGFloat height = responsibleHeight / 5;
   // self.responsibleBtn.height = 0;
    //self.responsibleBtn.hidden = YES;

    
    //_responsibleView.frame = self.frame;
    //我负责的
    CGFloat responsibleBtnX = 0;
    CGFloat responsibleBtnY = 0;
    CGFloat responsibleBtnWidth = SCREEN_WIDTH;
    CGFloat responsibleBtnHeight = ResponsibleViewHeight;
    self.responsibleBtn.frame = CGRectMake(responsibleBtnX, responsibleBtnY, responsibleBtnWidth, responsibleBtnHeight);
        self.responsibleBtn.hidden = NO;
       // self.responsibleBtn = responsibleBtn;

    CGFloat responsibleLineX = 0;
    CGFloat responsibleLineY = ResponsibleViewHeight - 0.4;
    CGFloat responsibleLineWidth = SCREEN_WIDTH;
    CGFloat responsibleLineHeight = 0.4;
    self.responsibleLine.frame = CGRectMake(responsibleLineX, responsibleLineY, responsibleLineWidth, responsibleLineHeight);
    
    //我相关的
    CGFloat correlationBtnX = 0;
    CGFloat correlationBtnY = ResponsibleViewHeight;
    CGFloat correlationBtnWidth = SCREEN_WIDTH;
    CGFloat correlationBtnHeight = ResponsibleViewHeight;
    self.correlationBtn.frame = CGRectMake(correlationBtnX, correlationBtnY, correlationBtnWidth, correlationBtnHeight);
    
    CGFloat correlationLineX = 0;
    CGFloat correlationLineY = ResponsibleViewHeight * 2 - 0.4;
    CGFloat correlationLineWidth = SCREEN_WIDTH;
    CGFloat correlationLineHeight = 0.4;
    self.correlationLine.frame = CGRectMake(correlationLineX, correlationLineY, correlationLineWidth, correlationLineHeight);
    //我下属的
    CGFloat subordinateBtnX = 0;
    CGFloat subordinateBtnY = ResponsibleViewHeight * 2;
    CGFloat subordinateBtnWidth = SCREEN_WIDTH;
    CGFloat subordinateBtnHeight = ResponsibleViewHeight;
    self.subordinateBtn.frame = CGRectMake(subordinateBtnX, subordinateBtnY, subordinateBtnWidth, subordinateBtnHeight);
    
    CGFloat subordinateLineX = 0;
    CGFloat subordinateLineY = ResponsibleViewHeight * 3 - 0.4;
    CGFloat subordinateLineWidth = SCREEN_WIDTH;
    CGFloat subordinateLineHeight = 0.4;
    self.subordinateLine.frame = CGRectMake(subordinateLineX, subordinateLineY, subordinateLineWidth, subordinateLineHeight);
     //已赢单的
    CGFloat winBtnX = 0;
    CGFloat winBtnY = ResponsibleViewHeight * 3;
    CGFloat winBtnWidth = SCREEN_WIDTH;
    CGFloat winBtnHeight = ResponsibleViewHeight;
    self.winBtn.frame = CGRectMake(winBtnX, winBtnY, winBtnWidth, winBtnHeight);
    
    CGFloat winLineX = 0;
    CGFloat winLineY = ResponsibleViewHeight * 4 - 0.4;
    CGFloat winLineWidth = SCREEN_WIDTH;
    CGFloat winLineHeight = 0.4;
    self.winLine.frame = CGRectMake(winLineX, winLineY, winLineWidth, winLineHeight);
    
    //今天拜访联系的
    CGFloat visitBtnX = 0;
    CGFloat visitBtnY = ResponsibleViewHeight * 4;
    CGFloat visitBtnWidth = SCREEN_WIDTH;
    CGFloat visitBtnHeight = ResponsibleViewHeight;
    self.visitBtn.frame = CGRectMake(visitBtnX, visitBtnY,visitBtnWidth, visitBtnHeight);
    
    CGFloat visitLineX = 0;
    CGFloat visitLineY = ResponsibleViewHeight * 5 - 0.4;
    CGFloat visitLineWidth = SCREEN_WIDTH;
    CGFloat visitLineHeight = 0.4;
    self.visitLine.frame = CGRectMake(visitLineX, visitLineY, visitLineWidth, visitLineHeight);

}
- (void)layoutSubviews
{
    [super layoutSubviews];
        
    /*
    //我负责的
    CGFloat responsibleBtnX = 0;
    CGFloat responsibleBtnY = 0;
    CGFloat responsibleBtnWidth = SCREEN_WIDTH;
    CGFloat responsibleBtnHeight = ResponsibleViewHeight;
    self.responsibleBtn.frame = CGRectMake(responsibleBtnX, responsibleBtnY, responsibleBtnWidth, responsibleBtnHeight);
    
    CGFloat responsibleLineX = 0;
    CGFloat responsibleLineY = ResponsibleViewHeight - 0.4;
    CGFloat responsibleLineWidth = SCREEN_WIDTH;
    CGFloat responsibleLineHeight = 0.4;
    self.responsibleLine.frame = CGRectMake(responsibleLineX, responsibleLineY, responsibleLineWidth, responsibleLineHeight);
    
    //我相关的
    CGFloat correlationBtnX = 0;
    CGFloat correlationBtnY = ResponsibleViewHeight;
    CGFloat correlationBtnWidth = SCREEN_WIDTH;
    CGFloat correlationBtnHeight = ResponsibleViewHeight;
    self.correlationBtn.frame = CGRectMake(correlationBtnX, correlationBtnY, correlationBtnWidth, correlationBtnHeight);
    
    CGFloat correlationLineX = 0;
    CGFloat correlationLineY = ResponsibleViewHeight * 2 - 0.4;
    CGFloat correlationLineWidth = SCREEN_WIDTH;
    CGFloat correlationLineHeight = 0.4;
    self.correlationLine.frame = CGRectMake(correlationLineX, correlationLineY, correlationLineWidth, correlationLineHeight);
    //我下属的
    CGFloat subordinateBtnX = 0;
    CGFloat subordinateBtnY = ResponsibleViewHeight * 2;
    CGFloat subordinateBtnWidth = SCREEN_WIDTH;
    CGFloat subordinateBtnHeight = ResponsibleViewHeight;
    self.subordinateBtn.frame = CGRectMake(subordinateBtnX, subordinateBtnY, subordinateBtnWidth, subordinateBtnHeight);
    
    CGFloat subordinateLineX = 0;
    CGFloat subordinateLineY = ResponsibleViewHeight * 3 - 0.4;
    CGFloat subordinateLineWidth = SCREEN_WIDTH;
    CGFloat subordinateLineHeight = 0.4;
    self.subordinateLine.frame = CGRectMake(subordinateLineX, subordinateLineY, subordinateLineWidth, subordinateLineHeight);
    //我领取的
    CGFloat getBtnX = 0;
    CGFloat getBtnY = ResponsibleViewHeight * 3;
    CGFloat getBtnWidth = SCREEN_WIDTH;
    CGFloat getBtnHeight = ResponsibleViewHeight;
    self.getBtn.frame = CGRectMake(getBtnX, getBtnY, getBtnWidth, getBtnHeight);
    
    CGFloat getLineX = 0;
    CGFloat getLineY = ResponsibleViewHeight * 4 - 0.4;
    CGFloat getLineWidth = SCREEN_WIDTH;
    CGFloat getLineHeight = 0.4;
    self.getLine.frame = CGRectMake(getLineX, getLineY, getLineWidth, getLineHeight);
    //已赢单的
    CGFloat winBtnX = 0;
    CGFloat winBtnY = ResponsibleViewHeight * 4;
    CGFloat winBtnWidth = SCREEN_WIDTH;
    CGFloat winBtnHeight = ResponsibleViewHeight;
    self.winBtn.frame = CGRectMake(winBtnX, winBtnY, winBtnWidth, winBtnHeight);
    
    CGFloat winLineX = 0;
    CGFloat winLineY = ResponsibleViewHeight * 5 - 0.4;
    CGFloat winLineWidth = SCREEN_WIDTH;
    CGFloat winLineHeight = 0.4;
    self.winLine.frame = CGRectMake(winLineX, winLineY, winLineWidth, winLineHeight);
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
