//
//  AudioPlayer.m
//  ClientManager
//
//  Created by iOS－MacBook on 2017/7/6.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import "AudioPlayer.h"
#import <AVFoundation/AVFoundation.h>
#import "AFNetworking.h"
////////////////////////////////
#import "SULoaderCategory.h"
@interface AudioPlayer()
/**
 <#annotation#>
 */
@property (nonatomic,strong) AVPlayer *player;
/**
 <#annotation#>
 */
@property (nonatomic,assign) BOOL isPlaying;
/**
 <#annotation#>
 */
@property (nonatomic,assign) CGFloat progress;
/**
 <#annotation#>
 */
@property (nonatomic,copy) NSString *playTime;
/**
 <#annotation#>
 */
@property (nonatomic,copy) NSString *playDuration;
/**
 <#annotation#>
 */
@property (nonatomic,strong) AVPlayerItem *currentPlayerItem;
/**
 <#annotation#>
 */
@property (nonatomic,strong) NSTimer *timer;
/**
 <#annotation#>
 */
@property (nonatomic,strong) UIButton *playButton;
/**
 <#annotation#>
 */
@property (nonatomic,assign) NSInteger tagIndex;
/**
 <#annotation#>
 */
@property (nonatomic,assign) BOOL isTimerOpen;


@end

@implementation AudioPlayer

    static AudioPlayer *_instance;

- (AVPlayer *)player
{
    if (nil == _player) {
        _player = [[AVPlayer alloc] init];
            }
    return _player;
}
+ (instancetype)shareAudioPlayer
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}
- (void)playerWithURL:(NSURL *)url
{
    AVPlayerItem *playerItem = [[AVPlayerItem alloc] initWithURL:url];
    [self.player replaceCurrentItemWithPlayerItem:playerItem];
    self.currentPlayerItem = playerItem;
//    //添加观察者监听播放状态
//    [playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
//
   

    
    __weak typeof(self)weakSelf = self;
   [ self.player addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
       __strong typeof(weakSelf)strongSelf = weakSelf;
       float currentTime = CMTimeGetSeconds(time);
       float totalTime = CMTimeGetSeconds(playerItem.duration);
       strongSelf.progress = currentTime / totalTime;
       
       strongSelf.playTime = [NSString stringWithFormat:@"%.f",currentTime];
       strongSelf.playDuration = [NSString stringWithFormat:@"%.2f",totalTime];
       NSLog(@"strongSelf.playTime = %@",strongSelf.playTime);
       NSLog(@"strongSelf.playDuration = %@",strongSelf.playDuration);
       
   }];
    
    
}
- (void)playbackFinished:(NSNotification *)noti
{
    [self stop];
}
- (void)playerWithAudioPath:(NSString *)audioPath playButton:(UIButton *)playButton
{
    self.playButton = playButton;
    
    
    NSURL *url = [NSURL URLWithString:audioPath];
    AVURLAsset *urlAssert = [[AVURLAsset alloc] initWithURL:url options:nil];
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:urlAssert];
   // AVPlayerItem *playerItem = [[AVPlayerItem alloc] initWithURL:url];
    [self.player replaceCurrentItemWithPlayerItem:playerItem];
    self.currentPlayerItem = playerItem;
    
    
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.currentPlayerItem];
    
    
    //    //添加观察者监听播放状态
    //    [playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    //
    
    __weak typeof(self)weakSelf = self;
    [ self.player addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        __strong typeof(weakSelf)strongSelf = weakSelf;
        float currentTime = CMTimeGetSeconds(time);
        float totalTime = CMTimeGetSeconds(playerItem.duration);
        strongSelf.progress = currentTime / totalTime;
        
        strongSelf.playTime = [NSString stringWithFormat:@"%.f",currentTime];
        NSLog(@"playTime = %@",strongSelf.playTime);
        strongSelf.playDuration = [NSString stringWithFormat:@"%.2f",totalTime];
        NSLog(@"playDuration = %@",strongSelf.playDuration);

        
    }];

}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"status"]) {
        switch (self.player.status) {
            case AVPlayerStatusUnknown:
                NSLog(@"KVO：未知状态，此时不能播放");
                break;
            case AVPlayerStatusReadyToPlay:
               // self.isPrepareToPlay = YES;


                [self.player play];
                [self audioPrepareToPlay];
               // self.status = AVPlayStatusReadyToPlay;
                //BASE_INFO_FUN(@"KVO：准备完毕，可以播放");
                break;
            case AVPlayerStatusFailed:
               // BASE_INFO_FUN(@"KVO：加载失败，网络或者服务器出现问题");
                break;
            default:
                break;
        }
    }
}

- (void)audioPrepareToPlay
{
    if (_timer == nil) {
        
        _timer =  [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(soundTimerAction) userInfo:nil repeats:YES];
    }
}
- (void)soundTimerAction
{
    self.isTimerOpen = YES;
    
    if (self.tagIndex < 4) {
        
        [self.playButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"sound %ld",self.tagIndex]] forState:UIControlStateNormal];
        
        self.tagIndex++;
        
    }else{
        
        self.tagIndex = 1;
    }

}


- (void)play
{
    if (self.isTimerOpen == YES ) {
        [self resumeTimer];
    }
    //添加观察者监听播放状态
    [self.currentPlayerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)pause
{
    
    [self.player pause];
    [self pauseTimer];
    //    if (self.playe) {
    //        <#statements#>
    //    }
}
- (void)stop
{
    self.isTimerOpen = NO;
    [self.timer invalidate];
    self.timer = nil;
    [self.playButton setImage:[UIImage imageNamed:@"sound"] forState:UIControlStateNormal];
}

-(void)pauseTimer{
    
    [self.playButton setImage:[UIImage imageNamed:@"sound"] forState:UIControlStateNormal];
    
    if (![self.timer isValid]) {
        return ;
    }
    self.isTimerOpen = NO;
    [self.timer setFireDate:[NSDate distantFuture]]; //如果给我一个期限，我希望是4001-01-01 00:00:00 +0000
    
    
}


-(void)resumeTimer{
    
    if (![self.timer isValid]) {
        return ;
    }
    
    //[self setFireDate:[NSDate dateWithTimeIntervalSinceNow:0]];
    self.isTimerOpen = YES;
    [self.timer setFireDate:[NSDate date]];
    
}
@end
