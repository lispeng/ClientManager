//
//  OMClientViewController.h
//  ClientManager
//
//  Created by iOS－MacBook on 2017/5/22.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OMClientModel;
typedef void(^clientClickCallBackBlock)(OMClientModel *model);
@interface OMClientViewController : UIViewController
/**
 <#annotation#>
 */
@property (nonatomic,copy) clientClickCallBackBlock clientBlock;

@end
