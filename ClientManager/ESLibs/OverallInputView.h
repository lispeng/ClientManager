//
//  OverallInputView.h
//  TempApp
//
//  Created by iOS－MacBook on 2017/3/1.
//  Copyright © 2017年 iOS－MacBook. All rights reserved.
//

#import "OverallParentInputView.h"
@class OverallInputView;
@protocol OverallInputViewDelegate <NSObject>

@optional
- (void)overallInputViewEditWithInputView:(OverallInputView *)inputView;
- (void)overallTextViewInputDidChange:(UITextView *)textView;
- (BOOL)overallTextView:(UITextView *)textView shouldChangeWithTextInRange:(NSRange)range replacementText:(NSString *)text;
@end
@interface OverallInputView : OverallParentInputView
/**
 <#annotation#>
 */
@property (nonatomic,weak) id<OverallInputViewDelegate> delegate;

@end
