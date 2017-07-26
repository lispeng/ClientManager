//
//  OverallTextView.h
//  TempApp
//
//  Created by iOS－MacBook on 2017/3/1.
//  Copyright © 2017年 iOS－MacBook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OverallTextView : UITextView
/**
 *  占位文字
 */
@property (copy,nonatomic) NSString *placeholder;
/**
 *  占位文字的颜色
 */
@property (strong,nonatomic) UIColor *placeholderColor;

@end
