//
//  AudioPlayer.h
//  ClientManager
//
//  Created by iOS－MacBook on 2017/7/6.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface AudioPlayer : NSObject
/**
 <#annotation#>
 */
@property (nonatomic,assign) BOOL isPrepareToPlay;

+ (instancetype)shareAudioPlayer;

- (void)playerWithURL:(NSURL *)url;
- (void)playerWithAudioPath:(NSString *)audioPath playButton:(UIButton *)playButton;
- (void)play;
- (void)pause;
- (void)stop;
@end
