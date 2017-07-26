//
//  Groups.h
//  ClientManager
//
//  Created by iOS－MacBook on 2017/5/27.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Groups : NSObject
/**
 <#annotation#>
 */
@property (nonatomic,strong) NSArray *modelArray;
/**
 <#annotation#>
 */
@property (nonatomic,copy) NSString *name;
/**
 <#annotation#>
 */
@property (nonatomic,assign) BOOL open;

@end
