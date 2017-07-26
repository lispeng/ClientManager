//
//  OverallParentInputView.h
//  TempApp
//
//  Created by iOS－MacBook on 2017/3/1.
//  Copyright © 2017年 iOS－MacBook. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OverallTextView;
@protocol OverallParentInputViewDelegate <NSObject>

- (void)overallTextView:(UITextView *)textView shouldChangeWithTextInRange:(NSRange)range replacementText:(NSString *)text;

@end
@interface OverallParentInputView : UIView
/**
 <#annotation#>
 */
@property (nonatomic,strong) UILabel *titleLabel;
/**
 <#annotation#>
 */
@property (nonatomic,strong) OverallTextView *textField;

@end
