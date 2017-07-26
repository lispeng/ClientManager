//
//  ModelFrame.h
//  ClientManager
//
//  Created by iOS－MacBook on 2017/5/26.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Model;
@interface ModelFrame : NSObject
/**
 <#annotation#>
 */
@property (nonatomic,strong) Model *model;
/**
 <#annotation#>
 */
@property (nonatomic,assign) CGRect imageViewFrame;
/**
 <#annotation#>
 */
@property (nonatomic,assign) CGRect nameLabelFrame;

/**
 <#annotation#>
 */
@property (nonatomic,assign) CGRect infoLabelFrame;
/**
 <#annotation#>
 */
@property (nonatomic,assign) CGRect underLineFrame;


@end
