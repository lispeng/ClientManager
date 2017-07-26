//
//  CMButton.h
//  ClientManager
//
//  Created by iOS－MacBook on 2017/7/12.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CMResponsibleModel;
@class CMCreateDateModel;
@interface CMButton : UIButton
/**
 <#annotation#>
 */
@property (nonatomic,strong) CMResponsibleModel *responsibleModel;
/**
 <#annotation#>
 */
@property (nonatomic,strong) CMCreateDateModel *createDateModel;

@end
