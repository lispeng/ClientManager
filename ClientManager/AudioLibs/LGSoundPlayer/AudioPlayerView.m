//
//  AudioPlayerView.m
//  ClientManager
//
//  Created by iOS－MacBook on 2017/7/6.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import "AudioPlayerView.h"
#import "AudioPlayer.h"
#import "Masonry.h"
#import <AVFoundation/AVFoundation.h>
@interface AudioPlayerView()
/**
 播放器
 */
@property (nonatomic,strong) AVPlayer *player;
/**
 是否正在播放
 */
@property (nonatomic,assign) BOOL isPlaying;
/**
 播放进度
 */
@property (nonatomic,assign) CGFloat progress;
/**
 播放时间
 */
@property (nonatomic,copy) NSString *playTime;
/**
 播放剩余时间
 */
@property (nonatomic,copy) NSString *playDuration;
/**
 一个播放源信息对象
 */
@property (nonatomic,strong) AVPlayerItem *currentPlayerItem;
/**
 <#annotation#>
 */
@property (nonatomic,assign) BOOL isTimerOpen;

/*********************************************/
/**
 <#annotation#>
 */
@property (nonatomic,weak) UIButton *playButton;
/**
 <#annotation#>
 */
@property (nonatomic,strong) NSTimer *timer;
/**
 <#annotation#>
 */
@property (nonatomic,assign) NSInteger tagIndex;


@end

@implementation AudioPlayerView
static AudioPlayerView *_playerView;
//+ (instancetype)shareAudioPlayerView
//{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        _playerView = [[self alloc] init];
//    });
//    return _playerView;
//}
/*
- (AACPlayer *)player
{
    if (nil == _player) {
        
        _player = [AACPlayer shareAACPlayer];
    }
    return _player;
}
 */
- (instancetype)init
{
    if (self = [super init]) {
              //  [self setupAudioPlayerViewSubviews];

    }
    
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupAudioPlayerViewSubviews];

    }
    return self;
}




- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self setupAudioPlayerViewSubviews];
}

- (void)setupAudioPlayerViewSubviews
{
    self.tagIndex = 1;

   // UIButton *playButton = [[UIButton alloc]initWithFrame:CGRectMake(12, 0, SCREEN_WIDTH-24, 52)];
    UIButton *playButton = [UIButton buttonWithType:UIButtonTypeCustom];
   // [playButton setTitle:[NSString stringWithFormat:@"%.0fs",self.messageModel.seconds]forState:UIControlStateNormal];
    playButton.bounds = self.frame;
    [playButton setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    playButton.backgroundColor = [UIColor lightGrayColor];
    playButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [playButton setImage:[UIImage imageNamed:@"sound"] forState:UIControlStateNormal];
    [playButton addTarget:self action:@selector(playAudioButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:playButton];
    
    self.playButton = playButton;
    
        [playButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(0);
            make.right.equalTo(self.mas_right).offset(0);
            make.height.mas_equalTo(0);
            make.top.equalTo(self.mas_top);
        }];
      


}
//////////////////////////////////////////

- (void)playerWithURLFilePath:(NSString *)audioPath
{
    
   // self.player.currentItem
    NSURL *url = [NSURL URLWithString:audioPath];
    AVPlayerItem *playerItem = [[AVPlayerItem alloc] initWithURL:url];
    if (self.player.currentItem != self.currentPlayerItem) {
        [self stop];

    }
    self.player = [[AVPlayer alloc] initWithPlayerItem:playerItem];

    [self.player replaceCurrentItemWithPlayerItem:playerItem];
    self.currentPlayerItem = playerItem;
    //    //添加观察者监听播放状态
    //    [playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    //
    
    //监听播放进度
    __weak typeof(self)weakSelf = self;
    [ self.player addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        __strong typeof(weakSelf)strongSelf = weakSelf;
        float currentTime = CMTimeGetSeconds(time);
        float totalTime = CMTimeGetSeconds(playerItem.duration);
        strongSelf.progress = currentTime / totalTime;
        
        strongSelf.playTime = [NSString stringWithFormat:@"%.f",currentTime];
        strongSelf.playDuration = [NSString stringWithFormat:@"%.2f",totalTime];
        
        
    }];
 
}
/**
 播放状态

 */
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








///////////////////////////////////////////
- (void)setUrlString:(NSString *)urlString
{
    _urlString = urlString;
    
}
- (void)playAudioButtonAction:(UIButton *)sender
{
    //if(nil == self.urlString)return;
    //NSURL *url = [NSURL URLWithString:self.urlString];
    //[self.player playerWithURL:url];
    
    
    [self play];
    
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
    //关闭红外检测
    [[UIDevice currentDevice] setProximityMonitoringEnabled:NO]; //建议在播放之前设置yes，播放结束设置NO，这个功能是开启红外感应
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
    //关闭红外检测
    [[UIDevice currentDevice] setProximityMonitoringEnabled:YES]; //建议在播放之前设置yes，播放结束设置NO，这个功能是开启红外感应
    self.isTimerOpen = NO;
    [self.timer invalidate];
    self.timer = nil;
    [self.playButton setImage:[UIImage imageNamed:@"sound"] forState:UIControlStateNormal];
}

-(void)pauseTimer{
    
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


- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect btnFrame = self.frame;
    self.playButton.bounds = btnFrame;
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
