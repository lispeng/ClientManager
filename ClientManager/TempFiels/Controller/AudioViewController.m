//
//  AudioViewController.m
//  ClientManager
//
//  Created by iOS－MacBook on 2017/7/3.
//  Copyright © 2017年 Lispeng. All rights reserved.
//http://fjdx.sc.chinaz.com/Files/DownLoad/sound1/201707/8895.mp3

#import "AudioViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "ShowAudioView.h"
#import "ShowAudioModel.h"
#import "PlayAudioView.h"
#import "LGAudioKit.h"
#import "ZHCMessagesAudioPlayer.h"
#import "JWAACPlayer.h"
#import "AudioPlayer.h"
#import "AudioPlayerView.h"
#import "SUPlayer.h"
//#import "LGAudioPlayer.h"
@interface AudioViewController ()
@property (nonatomic,strong)ShowAudioModel *messageModel;

/**
 <#annotation#>
 */
@property (nonatomic,weak) UIScrollView *showScrollView;
/**
 <#annotation#>
 */
@property (nonatomic,weak) ShowAudioView *audioView;
/**
 <#annotation#>
 */
@property (nonatomic,strong) AVPlayer *player;
/**
 <#annotation#>
 */
@property (nonatomic,strong) SUPlayer *suPlayer;


/**
 <#annotation#>
 */
@property (nonatomic,weak) AudioPlayerView *playerView;
/**
 <#annotation#>
 */
@property (nonatomic,weak) AudioPlayerView *playerView1;


@end

@implementation AudioViewController
- (AVPlayer *)player
{
    if (nil == _player) {
        _player = [[AVPlayer alloc] init];
    }
    return _player;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self addSubViews];

}
- (void)addSubViews
{
//    UIScrollView *showScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//    showScrollView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:showScrollView];
//    self.showScrollView = showScrollView;
    
    ShowAudioView *audioView = [[ShowAudioView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 2 - 25, SCREEN_HEIGHT / 2 - 150, 100, 100)];
    audioView.backgroundColor = [UIColor lightGrayColor];
    __weak typeof(self)weakSelf = self;
    audioView.recordFinishBlock = ^(NSString *mp3FileName) {
        __strong typeof(weakSelf)strongSelf = weakSelf;
        PlayAudioView *playView = [[PlayAudioView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2 - 25, SCREEN_HEIGHT / 2 + 150, 100, 100)];
        
        NSData *mp3Data = [NSData dataWithContentsOfFile:mp3FileName];
        NSLog(@"mp3FileName = %@",mp3FileName);
        NSLog(@"mp3Data = %@",mp3Data);

        //playView.backgroundColor = [UIColor lightGrayColor];
        [strongSelf.view addSubview:playView];
        
        
    };
    
    [self.view addSubview:audioView];
    self.audioView = audioView;
    
    
    UIButton *playButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 2 - 25, SCREEN_HEIGHT / 2, 50, 50)];
    [playButton setTitle:[NSString stringWithFormat:@"%.0fs",self.messageModel.seconds]forState:UIControlStateNormal];
    [playButton setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    playButton.backgroundColor = [UIColor lightGrayColor];
    playButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [playButton setImage:[UIImage imageNamed:@"sound"] forState:UIControlStateNormal];
    [playButton addTarget:self action:@selector(playRecordButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playButton];
    
    
    UIButton *playButton1 = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 2 - 25, SCREEN_HEIGHT / 2 + 50, 50, 50)];
    [playButton1 setTitle:[NSString stringWithFormat:@"%.0fs",self.messageModel.seconds]forState:UIControlStateNormal];
    [playButton1 setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    playButton1.backgroundColor = [UIColor orangeColor];
    playButton1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [playButton1 setImage:[UIImage imageNamed:@"sound"] forState:UIControlStateNormal];
    [playButton1 addTarget:self action:@selector(playMusic:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playButton1];
    
    
    UIButton *playButton2 = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 2 + 125, SCREEN_HEIGHT / 2 + 50, 80, 80)];
   // [playButton2 setTitle:[NSString stringWithFormat:@"%.0fs",self.messageModel.seconds]forState:UIControlStateNormal];
    [playButton2 setTitle:@"清除缓存"forState:UIControlStateNormal];
    [playButton2 setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    playButton2.backgroundColor = [UIColor orangeColor];
    playButton2.layer.cornerRadius = 40;
    playButton2.layer.masksToBounds = YES;
    playButton2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [playButton2 setImage:[UIImage imageNamed:@"sound"] forState:UIControlStateNormal];
    [playButton2 addTarget:self action:@selector(clearMusicCache:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playButton2];

    
/*
    //AudioPlayerView *playView = [[AudioPlayerView alloc] init];
    AudioPlayerView *playView = [[AudioPlayerView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2 - 100, SCREEN_HEIGHT / 2 + 120, 50, 50)];
   // playView.frame = CGRectMake(SCREEN_WIDTH / 2 - 100, SCREEN_HEIGHT / 2 + 120, 50, 50);
    NSString *mp3DMusic = @"http://xmdx.sc.chinaz.com/files/download/sound1/201202/645.mp3";
    playView.backgroundColor = [UIColor redColor];
   // playView.urlString = mp3DMusic;
    [playView playerWithURLFilePath:mp3DMusic];
    [self.view addSubview:playView];
    self.playerView = playView;
    
    AudioPlayerView *playView1 = [[AudioPlayerView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2 - 100, SCREEN_HEIGHT / 2 - 130, 50, 50)];
    // playView.frame = CGRectMake(SCREEN_WIDTH / 2 - 100, SCREEN_HEIGHT / 2 + 120, 50, 50);
    NSString *mp3FileName = @"http://xmdx.sc.chinaz.com/Files/DownLoad/sound1/201706/8893.mp3";
    playView1.backgroundColor = [UIColor blueColor];
   // playView1.urlString = mp3FileName;
    [playView1 playerWithURLFilePath:mp3FileName];
    [self.view addSubview:playView1];
    self.playerView1 = playView1;
*/

}

- (void)playRecordButtonAction:(UIButton *)sender
{
    NSString *mp3FileName = @"http://xmdx.sc.chinaz.com/Files/DownLoad/sound1/201706/8893.mp3";
   // self.suPlayer = [[SUPlayer alloc] initWithURL:[NSURL URLWithString:mp3FileName]];
  //  [self.suPlayer play];
    
    [[SUPlayer shareSUPlayer] playerWithAudioPath:mp3FileName playButton:sender];
    [[SUPlayer shareSUPlayer] play];
    
    
   // [[AudioPlayer shareAudioPlayer] playerWithAudioPath:mp3FileName playButton:sender];
    //[[AudioPlayer shareAudioPlayer] play];
    
//    [[AudioPlayer shareAudioPlayer] playerWithAudioPath:mp3FileName playButton:sender];
//    [[AudioPlayer shareAudioPlayer] play];
    //self.messageModel.soundFilePath = @"http://fjdx.sc.chinaz.com/Files/DownLoad/sound1/201707/8895.mp3";
   // NSURL *mp3URL = [NSURL URLWithString:mp3FileName];
   // AVPlayerItem *playerItem = [[AVPlayerItem alloc] initWithURL:mp3URL];
//    [[AudioPlayer shareInstance] playerWithURL:mp3URL];
//    [[AudioPlayer shareInstance] play];

   // self.playerView.urlString = mp3FileName;
    
    
//    self.player = [[AVPlayer alloc] initWithPlayerItem:playerItem];
//    [self.player play];
   // [self.player replaceCurrentItemWithPlayerItem:playerItem];
   // [self.player play];
  
 //  [[LGAudioPlayer sharePlayer] playAudioWithURLString:mp3FileName atIndex:0 withParentButton:sender];
    
    //[[ZHCMessagesAudioPlayer shareVoicePlayer] playAudioWithUrl:mp3URL];
  // [[LGAudioPlayer sharePlayer] playAudioWithURLString:mp3FileName atIndex:0 withParentButton:sender];
   // JWAACPlayer *aacPlayer = [[JWAACPlayer alloc] initWithUrl:mp3URL];
    
   // [aacPlayer play];
    
   // self.player = [[AVPlayer alloc] initWithURL:mp3URL];
    
    
   // [self.player play];
    
  

}
- (void)clearMusicCache:(UIButton *)sender
{
    
    BOOL isClear = [SUPlayer clearCache];
    if (isClear) {
        NSLog(@"本地缓存清除完毕");
    }
}
- (void)playMusic:(UIButton *)sender
{
    NSString *mp3DMusic = @"http://xmdx.sc.chinaz.com/files/download/sound1/201202/645.mp3";
    
    [[SUPlayer shareSUPlayer] playerWithAudioPath:mp3DMusic playButton:sender];
    [[SUPlayer shareSUPlayer] play];

    
   // [[AudioPlayer shareAudioPlayer] playerWithAudioPath:mp3DMusic playButton:sender];
   // [[AudioPlayer shareAudioPlayer] play];
    
   // NSURL *musicURL = [NSURL URLWithString:mp3DMusic];
   /// AVPlayerItem *playerItem = [[AVPlayerItem alloc] initWithURL:musicURL];
    
   // self.playerView.urlString = mp3DMusic;

   // self.player = [[AVPlayer alloc] initWithPlayerItem:playerItem];
    //[self.player replaceCurrentItemWithPlayerItem:playerItem];

   // self.player = [[AVPlayer alloc] initWithURL:musicURL];
   // [self.player play];
    
//    [[AudioPlayer shareInstance] playerWithURL:musicURL];
//    [[AudioPlayer shareInstance] play];
    
    // [[LGAudioPlayer sharePlayer] playAudioWithURLString:mp3DMusic atIndex:0 withParentButton:sender];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
