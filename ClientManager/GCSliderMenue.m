//
//  GCSliderMenue.m
//  FakeJingDongList
//
//  Created by 辰 宫 on 06/07/2017.
//  Copyright © 2017 Nickyxu. All rights reserved.
//

#import "GCSliderMenue.h"

#define GC_ScreenWidth [UIScreen mainScreen].bounds.size.width
#define GC_ScreenHeight [UIScreen mainScreen].bounds.size.height
#define POP_MENUE_LEFT_PADDING_WIDTH [UIScreen mainScreen].bounds.size.width * 0.1 * [[UIScreen mainScreen] scale]

static UINavigationController *navi;
static UIView *backColorView;
static CGFloat viewPaddingLeft;
static UISwipeGestureRecognizer *recognizer;

@interface GCSliderMenue ()

@end

@implementation GCSliderMenue

+ (void)popRightMenuController:(UINavigationController *)popNaviC
              fromeParentNaviC:(UINavigationController *)parentNaviC
                   leftPadding:(CGFloat)leftPadding
               swipeRightClose:(BOOL)canSwipeRightClose
{
    viewPaddingLeft = leftPadding;
    if (viewPaddingLeft < 0) {
        viewPaddingLeft = 0;
    }
    /* 创建一个阴影 */
    if (!backColorView) {
        backColorView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    }
    backColorView.backgroundColor = [UIColor blackColor];
    backColorView.alpha = .0;   //开始透明度为0,后面通过动画逐渐变黑
    [parentNaviC.view addSubview:backColorView];
    
    navi = popNaviC;
    navi.view.frame = CGRectMake(GC_ScreenWidth, 0, GC_ScreenWidth - viewPaddingLeft, GC_ScreenHeight);
    /* 把创建的第二个的导航栏控制器作为本导航栏控制器的子控制器 */
    [parentNaviC addChildViewController:navi];
    /* 把第二个导航栏控制器的视图加到本导航栏控制器的view上(事实上导航栏控制器的view是包含了导航栏,视图控制器的视图 */
    [parentNaviC.view addSubview:navi.view];
    /* 出现的动画 */
    [UIView animateWithDuration:.2 animations:^{
        backColorView.alpha = .5;
        navi.view.frame = CGRectMake(leftPadding, 0, GC_ScreenWidth - viewPaddingLeft, GC_ScreenHeight);
    } completion:^(BOOL finished) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeMenu)];
        [backColorView addGestureRecognizer:tap]; //加入触摸手势,点阴影区域时关闭右侧导航栏
    }];
    
    if (canSwipeRightClose) {
        recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
        [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
        [navi.view addGestureRecognizer:recognizer];
    }
}
+ (void)closeMenu
{
    /* 关闭操作,先动画后移除 */
    [UIView animateWithDuration:.2 animations:^{
        backColorView.alpha  = 0;
        navi.view.frame = CGRectMake(GC_ScreenWidth, 0, GC_ScreenWidth - viewPaddingLeft, GC_ScreenHeight);
    } completion:^(BOOL finished) {
        [backColorView removeFromSuperview];
        [navi.view removeFromSuperview];
        [navi removeFromParentViewController];
        navi = nil;
    }];
}

+ (void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer{
    if(recognizer.direction == UISwipeGestureRecognizerDirectionRight) {
        [self closeMenu];
    }
}

@end
