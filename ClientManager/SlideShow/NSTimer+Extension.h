//
//  NSTimer+Extension.h
//  SouSou
//
//  Created by iOS－MacBook on 2017/5/27.
//  Copyright © 2017年 overmindgc. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^timerBlock)(NSTimer *timer);
@interface NSTimer (Extension)
+ (NSTimer *)lsp_scheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(timerBlock)block;

@end
