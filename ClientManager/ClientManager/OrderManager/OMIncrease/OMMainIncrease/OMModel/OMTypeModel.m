//
//  OMTypeModel.m
//  ClientManager
//
//  Created by iOS－MacBook on 2017/5/17.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import "OMTypeModel.h"
#import "OMListModel.h"
#import "MJExtension.h"

@implementation OMTypeModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"list" : [OMListModel class]
             };
}

@end
