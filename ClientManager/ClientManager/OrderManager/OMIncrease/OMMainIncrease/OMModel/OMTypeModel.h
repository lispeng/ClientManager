//
//  OMTypeModel.h
//  ClientManager
//
//  Created by iOS－MacBook on 2017/5/17.
//  Copyright © 2017年 Lispeng. All rights reserved.
//-------------该数据类型用来判断新增订单页底部FooterView的自定义类型------------

#import <Foundation/Foundation.h>

@interface OMTypeModel : NSObject
/**
 小数精度
 */
@property (nonatomic,copy) NSString *digitalPrecision;
/**
 文本类型
 */
@property (nonatomic,copy) NSString *fieldType;
/**
 <#annotation#>
 */
@property (nonatomic,copy) NSString *id;

/**
 是否为必填写项
 */
@property (nonatomic,copy) NSString *isRequired;
/**
 填写的长度限制
 */
@property (nonatomic,copy) NSString *length;
/**
 下拉列表项
 */
@property (nonatomic,strong) NSArray *list;
/**
 名字
 */
@property (nonatomic,copy) NSString *name;

@end
