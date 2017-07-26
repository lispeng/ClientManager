//
//  OverallInputView.h
//  TempApp
//
//  Created by iOS－MacBook on 2017/3/1.
//  Copyright © 2017年 iOS－MacBook. All rights reserved.
//

#import "OverallParentInputView.h"
//@class OMTypeModel;
@class OverallInputView;
@protocol OverallInputViewDelegate <NSObject>

@optional
- (BOOL)overallInputVieShouldBeginEditing:(OverallInputView *)inputView;
- (void)overallInputViewEditWithInputView:(OverallInputView *)inputView;
- (void)overallInputViewEditEndInputView:(UITextView *)textView;

- (void)overallTextViewInputDidChange:(UITextView *)textView;
- (BOOL)overallTextView:(UITextView *)textView shouldChangeWithTextInRange:(NSRange)range replacementText:(NSString *)text;
@end
@interface OverallInputView : OverallParentInputView
/**
 <#annotation#>
 */
@property (nonatomic,weak) id<OverallInputViewDelegate> delegate;
/**
 <#annotation#>
 */
@property (nonatomic,copy) NSString *title;
/**
 <#annotation#>
 */
@property (nonatomic,copy) NSString *placeholder;


/**
 内容模式是否靠右边
 */
@property (nonatomic,assign) BOOL isRight;
/**
 添加商品自定义字段的模型
 */
//@property (nonatomic,strong) OMTypeModel *model;

- (instancetype)initWithFrame:(CGRect)frame contentIsRight:(BOOL)isRight;

@end
