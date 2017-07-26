//
//  CMResponsibleView.h
//  ClientManager
//
//  Created by iOS－MacBook on 2017/7/12.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CMResponsibleModel;
@class CMButton;
typedef void(^responsibleViewCallBackBlock)(CMButton *sender);
typedef NS_ENUM(NSInteger, CMButtonPositionType) {
    CMButtonPositionTypeLeft,
    CMButtonPositionTypeMiddle,
    CMButtonPositionTypeRight
};

@interface CMResponsibleView : UIView
/**
 <#annotation#>
 */
@property (nonatomic,strong) NSArray <CMResponsibleModel *> *responsibleArr;
/**
 <#annotation#>
 */
@property (nonatomic,assign) CGFloat responsibleHeight;
/**
 <#annotation#>
 */
@property (nonatomic,copy) responsibleViewCallBackBlock responsibleBlock;
/**
 子控件的标题文字位置
 */
@property (nonatomic,assign) CMButtonPositionType positionType;
/**
 按钮的文字偏移位置
 */
@property (nonatomic,assign) CGFloat titleOffset;

+ (instancetype)shareResponsibleView;
- (instancetype)initWithResponsibleArr:(NSArray <CMResponsibleModel *> *)responsibleArr;
@end
