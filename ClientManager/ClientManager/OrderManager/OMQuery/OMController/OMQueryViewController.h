//
//  OMQueryViewController.h
//  ClientManager
//
//  Created by iOS－MacBook on 2017/5/11.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OMQueryModel;
typedef void(^orderQueryCallBackBlock)(OMQueryModel *model);
@interface OMQueryViewController : UIViewController
/**
 <#annotation#>
 */
@property (nonatomic,copy) orderQueryCallBackBlock queryCallBackBlock;

@end
