//
//  OverallInputArrowView.h
//  TempApp
//
//  Created by iOS－MacBook on 2017/3/1.
//  Copyright © 2017年 iOS－MacBook. All rights reserved.
//

#import "OverallParentInputView.h"
//@class OMTypeModel;
@class OverallInputArrowView;
@protocol OverallInputArrowViewDelegate <NSObject>
@optional
- (void)overallInputArrowViewEditWithArrowView:(OverallInputArrowView *)arrowView;

@end
@interface OverallInputArrowView : OverallParentInputView
/**
 底部的分割线
 */
@property (nonatomic,weak) UIView *lineView;

/**
 文字内容
 */
@property (nonatomic,copy) NSString *text;

/**
 <#annotation#>
 */
@property (nonatomic,assign) BOOL isLabel;
/**
 contentLabel显示的行数
 */
@property (nonatomic,assign) NSInteger numberOfLines;


/**
 <#annotation#>
 */
@property (nonatomic,strong) UIImageView *imageView;

/**
 <#annotation#>
 */
@property (nonatomic,weak) id<OverallInputArrowViewDelegate> delegate;
/**
 添加商品自定义字段的模型
 */
//@property (nonatomic,strong) OMTypeModel *model;
/**
 <#annotation#>
 */
@property (nonatomic,assign) BOOL isShowTextView;

/**
 <#annotation#>
 */
@property (nonatomic,assign) BOOL isRight;
/**
 <#annotation#>
 */
@property (nonatomic,copy) NSString *placeholder;

@end
