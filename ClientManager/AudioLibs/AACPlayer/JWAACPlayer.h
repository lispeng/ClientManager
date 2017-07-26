//
//  JWAACPlayer.h
//  H264
//
//  Created by SouSouTec on 2017.
//  Copyright © 2017年 evenCoder. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JWAACPlayer : NSObject

- (instancetype)initWithUrl:(NSURL *)url;

- (void)play;

- (double)getCurrentTime;

@end
