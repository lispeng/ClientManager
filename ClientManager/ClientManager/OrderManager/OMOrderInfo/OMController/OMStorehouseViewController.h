//
//  OMStorehouseViewController.h
//  ClientManager
//
//  Created by iOS－MacBook on 2017/5/23.
//  Copyright © 2017年 Lispeng. All rights reserved.
//-----------仓库选择主控制器--------------

#import <UIKit/UIKit.h>
@class OMStoreModel;
typedef void(^storehouseCallBackBlock)(OMStoreModel *model);
@interface OMStorehouseViewController : UIViewController
/**
 <#annotation#>
 */
@property (nonatomic,copy) storehouseCallBackBlock storeBlcok;

@end
