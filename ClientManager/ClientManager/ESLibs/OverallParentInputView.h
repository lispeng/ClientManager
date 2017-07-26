//
//  OverallParentInputView.h
//  TempApp
//
//  Created by iOS－MacBook on 2017/3/1.
//  Copyright © 2017年 iOS－MacBook. All rights reserved.
//

#import <UIKit/UIKit.h>
#define OVERALLPRAENTFONT [UIFont systemFontOfSize:15]
#define OVERALLINPUTHEIGHT 44
@class OverallTextView;
@class OMTypeModel;
@protocol OverallParentInputViewDelegate <NSObject>

- (void)overallTextView:(UITextView *)textView shouldChangeWithTextInRange:(NSRange)range replacementText:(NSString *)text;

@end
@interface OverallParentInputView : UIView
/**
 <#annotation#>
 */
@property (nonatomic,strong) UILabel *contentLabel;

/**
 <#annotation#>
 */
@property (nonatomic,strong) UILabel *titleLabel;
/**
 <#annotation#>
 */
@property (nonatomic,strong) OverallTextView *textField;
/**
 添加商品自定义字段的模型
 */
@property (nonatomic,strong) OMTypeModel *model;

@end
