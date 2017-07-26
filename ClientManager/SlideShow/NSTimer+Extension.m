//
//  NSTimer+Extension.m
//  SouSou
//
//  Created by iOS－MacBook on 2017/5/27.
//  Copyright © 2017年 overmindgc. All rights reserved.
//

#import "NSTimer+Extension.h"

@implementation NSTimer (Extension)
+ (NSTimer *)lsp_scheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(timerBlock)block
{
    return [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(lsp_blockInvoke:) userInfo:[block copy] repeats:repeats];
}
+ (void)lsp_blockInvoke:(NSTimer *)timer
{
    void (^block)(NSTimer *timer) = timer.userInfo;
    if (block) {
        block(timer);
    }
}

@end
