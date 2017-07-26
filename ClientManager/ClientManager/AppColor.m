//
//  AppColor.m
//  ClientManager
//
//  Created by iOS－MacBook on 2017/5/10.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import "AppColor.h"

@implementation AppColor
static UIColor *appMainColor;
static UIColor *appAbnormalColor;

+ (void)setAppMainColor:(NSString *)color
{
    appMainColor = [self hexStringToColor:color];
}

+ (UIColor *)appMainColor
{
    if (!appMainColor) {
        appMainColor = [UIColor colorWithRed:237/255.0f green:108/255.0f blue:0/255.0f alpha:1.0f];
    }
    return appMainColor;
}

+ (UIColor *)appAbnormalColor
{
    appAbnormalColor = [UIColor colorWithRed:235/255.0f green:97/255.0f blue:0/255.0f alpha:1.0f];
    return appAbnormalColor;
}

//默认颜色
+ (UIColor *)appDefaultColor
{
    return [UIColor colorWithRed:192/255.0f green:7/255.0f blue:18/255.0f alpha:1.0f];
}

//默认的无效按钮灰色
+ (UIColor *)appDefaultGrayColor
{
    return [UIColor colorWithRed:153/255.0f green:153/255.0f blue:153/255.0f alpha:1.0f];
}

//打卡上班按钮颜色
+ (UIColor *)appCheckInColor
{
    //绿色
    return [UIColor colorWithRed:8/255.0f green:188/255.0f blue:3/255.0f alpha:1.0f];
}

//打卡下班按钮颜色
+ (UIColor *)appCheckOutColor
{
    //红色
    return [UIColor colorWithRed:184/255.0f green:39/255.0f blue:42/255.0f alpha:1.0f];
}

//列表cell灰色内容颜色
+ (UIColor *)appTableCellGrayTextColor
{
    return [UIColor colorWithWhite:0.6 alpha:1.0f];
}

//列表cell分隔线颜色
+ (UIColor *)appTableCellSeparatLineColor
{
    return [UIColor colorWithWhite:0.8 alpha:1.0f];
}

//列表灰色的背景颜色
+ (UIColor *)appTableViewBackgroundColor
{
    return [UIColor colorWithRed:240/255.0f green:241/255.0f blue:243/255.0f alpha:1.0f];
}

//列表深色表头颜色
+ (UIColor *)appTableViewDarkHeaderColor
{
    return [UIColor colorWithWhite:0.55f alpha:1.0f];
}

//深色统计数据bar颜色
+ (UIColor *)appDataDarkGrayBarColor
{
    return [UIColor darkGrayColor];
}

//申请成功等页面的绿色
+ (UIColor *)successTipGreenColor
{
    return [UIColor colorWithRed:8/255.0f green:188/255.0f blue:3/255.0f alpha:1.0f];
}

/**拜访主要代表颜色*/
+ (UIColor *)visitChiefColor
{
    return [UIColor colorWithRed:132/255.0f green:204/255.0f blue:201/255.0f alpha:1.f];
}
/**日报主要代表颜色*/
+ (UIColor *)dailyChiefColor
{
    return [UIColor colorWithRed:150/255.0f green:204/255.0f blue:152/255.0f alpha:1.f];
}
/**销量主要代表颜色*/
+ (UIColor *)saleChiefColor
{
    return [UIColor colorWithRed:141/255.0f green:151/255.0f blue:203/255.0f alpha:1.f];
}
/**审批主要代表颜色*/
+ (UIColor *)approvalChiefColor
{
    return [UIColor colorWithRed:242/255.0f green:161/255.0f blue:55/255.0f alpha:1.f];
}
/**打卡主要代表颜色*/
+ (UIColor *)checkInChiefColor
{
    return [UIColor colorWithRed:242/255.0f green:209/255.0f blue:55/255.0f alpha:1.f];
}
/**客户主要代表颜色*/
+ (UIColor *)clientChiefColor
{
    return [UIColor colorWithRed:132/255.0f green:168/255.0f blue:204/255.0f alpha:1.f];
}

//16进制颜色(html颜色值)字符串转为UIColor
+(UIColor *)hexStringToColor:(NSString *)stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 charactersif ([cString length] < 6) return [UIColor blackColor];
    // strip 0X if it appearsif ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor blackColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

@end
