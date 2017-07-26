//
//  OMIncreaseFooterView.h
//  ClientManager
//
//  Created by iOS－MacBook on 2017/5/17.
//  Copyright © 2017年 Lispeng. All rights reserved.
//-----------------新增订单的底部FooterView------------------

#import <UIKit/UIKit.h>
@class OMTypeModel;
@class OverallInputView;
@class OverallInputArrowView;
@protocol OMIncreaseFooterViewDelegate <NSObject>
@optional
- (BOOL)increaseFooterInputVieShouldBeginEditing:(OverallInputView *)inputView;
- (BOOL)increaseRemarkTextView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
- (void)increaseFooterInputViewEditWithInputView:(OverallInputView *)inputView;
- (void)increaseFooterInputDidChange:(UITextView *)textView;
- (BOOL)increaseFooterTextView:(UITextView *)textView shouldChangeWithTextInRange:(NSRange)range replacementText:(NSString *)text;
- (void)increaseFooterInputArrowViewEditWithArrowView:(OverallInputArrowView *)arrowView;
@end
@interface OMIncreaseFooterView : UIView
/**
 <#annotation#>
 */
@property (nonatomic,strong) OMTypeModel *model;
/**
 总高度
 */
@property (nonatomic,assign) CGFloat footerHeight;

/**
 存放OMTypeModel模型的数组
 */
@property (nonatomic,strong) NSArray *modelArray;
/**
<#annotation#>
*/
@property (nonatomic,strong) NSMutableArray *textLabels;

/**
 <#annotation#>
 */
@property (nonatomic,strong) NSMutableArray *selectBoxArray;
/**
 <#annotation#>
 */
@property (nonatomic,strong) NSMutableArray *listArray;

/**
 <#annotation#>
 */
@property (nonatomic,weak) id<OMIncreaseFooterViewDelegate> delegate;

@end
