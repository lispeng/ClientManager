//
//  AudioPlayerView.h
//  ClientManager
//
//  Created by iOS－MacBook on 2017/7/6.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AudioPlayerView : UIView

+ (instancetype)shareAudioPlayerView;
/**
 <#annotation#>
 */
@property (nonatomic,copy) NSString *urlString;

/**
 是否开始播放
 */
@property (nonatomic,assign) BOOL isPrepareToPlay;
/**
 传入播放地址进行准本播放的方法

  <#url description#>
 */
- (void)playerWithURLFilePath:(NSString *)audioPath;
/**
 开启播放
 */
- (void)play;
/**
 播放暂停
 */
- (void)pause;
/**
 关闭播放
 */
- (void)stop;

- (void)audioPlayerViewWithURLString:(NSString *)urlString;
@end
