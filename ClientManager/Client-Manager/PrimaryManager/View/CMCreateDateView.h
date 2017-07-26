//
//  CMCreateDateView.h
//  ClientManager
//
//  Created by iOS－MacBook on 2017/7/14.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CMCreateDateModel;
@class CMButton;
typedef void(^createDateViewCallBackBlock)(CMButton *sender);

@interface CMCreateDateView : UIView
/**
 <#annotation#>
 */
@property (nonatomic,strong) NSArray <CMCreateDateModel *> *createDateArr;
/**
 <#annotation#>
 */
@property (nonatomic,assign) CGFloat createDateHeight;
/**
 <#annotation#>
 */
@property (nonatomic,copy) createDateViewCallBackBlock createBlock;
///**
// 子控件的标题文字位置
// */
//@property (nonatomic,assign) CMButtonPositionType positionType;
/**
 按钮的文字偏移位置
 */
@property (nonatomic,assign) CGFloat titleOffset;

+ (instancetype)shareCreateDateView;
//- (instancetype)initWithResponsibleArr:(NSArray <CMResponsibleModel *> *)responsibleArr;

@end
