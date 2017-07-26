//
//  GCSliderMenue.h
//  FakeJingDongList
//
//  Created by 辰 宫 on 06/07/2017.
//  Copyright © 2017 Nickyxu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GCSliderMenue : NSObject

/**
 * 从右边滑出菜单控制器，滑出的页面需要传递NavicationController，注意打开的UIBarButtonItem最好使用自定义view，因为在iOS10会出现位置偏差
 *
 * @param popNaviC       需要弹出的导航控制器
 * @param parentNaviC    父导航控制器，一般就是弹出所在页的导航控制器
 * @param leftPadding    滑出的菜单距离左边的边距
 * @param parentNaviC    是否开启右滑关闭，默认不开启
 */
+ (void)popRightMenuController:(UINavigationController *)popNaviC
              fromeParentNaviC:(UINavigationController *)parentNaviC
                   leftPadding:(CGFloat)leftPadding
               swipeRightClose:(BOOL)canSwipeRightClose;

/**关闭菜单*/
+ (void)closeMenu;

@end
