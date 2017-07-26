//
//  AppColor.h
//  ClientManager
//
//  Created by iOS－MacBook on 2017/5/10.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppColor : NSObject
+ (void)setAppMainColor:(NSString *)color;

/**系统主色*/
+ (UIColor *)appMainColor;

/**异常状态颜色*/
+ (UIColor *)appAbnormalColor;

/**系统默认的红色颜色*/
+ (UIColor *)appDefaultColor;

/**默认的无效按钮灰色*/
+ (UIColor *)appDefaultGrayColor;

/**打卡上班按钮颜色*/
+ (UIColor *)appCheckInColor;

/**打卡下班按钮颜色*/
+ (UIColor *)appCheckOutColor;

/**列表cell灰色内容颜色*/
+ (UIColor *)appTableCellGrayTextColor;

/**列表cell分隔线颜色*/
+ (UIColor *)appTableCellSeparatLineColor;

/**列表灰色的背景颜色*/
+ (UIColor *)appTableViewBackgroundColor;

/**列表深色表头颜色*/
+ (UIColor *)appTableViewDarkHeaderColor;

/**深色统计数据bar颜色*/
+ (UIColor *)appDataDarkGrayBarColor;

/**申请成功等页面的绿色*/
+ (UIColor *)successTipGreenColor;

/**拜访主要代表颜色*/
+ (UIColor *)visitChiefColor;
/**日报主要代表颜色*/
+ (UIColor *)dailyChiefColor;
/**销量主要代表颜色*/
+ (UIColor *)saleChiefColor;
/**审批主要代表颜色*/
+ (UIColor *)approvalChiefColor;
/**打卡主要代表颜色*/
+ (UIColor *)checkInChiefColor;
/**客户主要代表颜色*/
+ (UIColor *)clientChiefColor;

/**16进制颜色(html颜色值)字符串转为UIColor*/
+(UIColor *)hexStringToColor:(NSString *)stringToConvert;

@end
