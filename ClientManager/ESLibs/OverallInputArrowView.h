//
//  OverallInputArrowView.h
//  TempApp
//
//  Created by iOS－MacBook on 2017/3/1.
//  Copyright © 2017年 iOS－MacBook. All rights reserved.
//

#import "OverallParentInputView.h"
@class OverallInputArrowView;
@protocol OverallInputArrowViewDelegate <NSObject>
@optional
- (void)overallInputArrowViewEditWithArrowView:(OverallInputArrowView *)arrowView;

@end
@interface OverallInputArrowView : OverallParentInputView
/**
 <#annotation#>
 */
@property (nonatomic,strong) UIImageView *imageView;

/**
 <#annotation#>
 */
@property (nonatomic,weak) id<OverallInputArrowViewDelegate> delegate;

@end
