//
//  ShowAudioView.m
//  ClientManager
//
//  Created by iOS－MacBook on 2017/7/3.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import "ShowAudioView.h"
#import "Masonry.h"
#import "lame.h"
#import "LGAudioKit.h"
#import "AudioViewController.h"
#import "UIView+Size.h"
#import "ShowAudioModel.h"
#define collectionViewHeight 60
#define DocumentPath  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define MAXIMAGENUMBER   6

#define kScreenWidth      [UIScreen mainScreen].bounds.size.width
#define kScreenHeight     [UIScreen mainScreen].bounds.size.height

@interface ShowAudioView()

@property (nonatomic, weak) NSTimer *timerOf60Second;

@property (nonatomic, strong) NSMutableArray *dataArray;


@end

@implementation ShowAudioView
{
    AudioViewController* superViewController;
    UIButton* playButton;


}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self initSubViews];
    }
    
    return self;
    
}
- (void)initSubViews{
    
    _addRecordButton = [[UIButton alloc]initWithFrame:CGRectMake(self.right+5, self.top, self.width, self.height)];
   // [_addRecordButton setImage:[UIImage imageNamed:@"second_sounding_d"] forState:UIControlStateNormal];
    [_addRecordButton setTitle:@"按住说话" forState:UIControlStateNormal];
    [_addRecordButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_addRecordButton addTarget:self action:@selector(startRecordVoice) forControlEvents:UIControlEventTouchDown];
    [_addRecordButton addTarget:self action:@selector(cancelRecordVoice) forControlEvents:UIControlEventTouchUpOutside];
    [_addRecordButton addTarget:self action:@selector(confirmRecordVoice) forControlEvents:UIControlEventTouchUpInside];
    [_addRecordButton addTarget:self action:@selector(updateCancelRecordVoice) forControlEvents:UIControlEventTouchDragExit];
    [_addRecordButton addTarget:self action:@selector(updateContinueRecordVoice) forControlEvents:UIControlEventTouchDragEnter];
    [self addSubview:_addRecordButton];
    
    [_addRecordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(0);
        make.top.equalTo(self.mas_top).offset(0);
        make.left.equalTo(self.mas_left).offset(0);
        make.right.equalTo(self.mas_right).offset(0);
       // make.width.mas_equalTo(70);
        //make.height.mas_equalTo(70);
    }];
    
    
}
#pragma mark - Private Methods

/**
 *  开始录音
 */
- (void)startRecordVoice{
    
//    if (self.isVideo) {
//        
//        [_player stop];
//        
//    }
    __block BOOL isAllow = 0;
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    if ([audioSession respondsToSelector:@selector(requestRecordPermission:)]) {
        [audioSession performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
            if (granted) {
                isAllow = 1;
            } else {
                isAllow = 0;
            }
        }];
    }
    if (isAllow) {
        //		//停止播放
        [[LGAudioPlayer sharePlayer] stopAudioPlayer];
        //		//开始录音
        [[LGSoundRecorder shareInstance] startSoundRecord:[self getParentviewController].view recordPath:[self recordPath]];

        //开启定时器
        if (_timerOf60Second) {
            [_timerOf60Second invalidate];
            _timerOf60Second = nil;
        }
        _timerOf60Second = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(sixtyTimeStopSendVodio) userInfo:nil repeats:YES];
    } else {
        
    }
}

/**
 *  录音结束
 */
- (void)confirmRecordVoice {
    if ([[LGSoundRecorder shareInstance] soundRecordTime] < 1.0f) {
        if (_timerOf60Second) {
            [_timerOf60Second invalidate];
            _timerOf60Second = nil;
        }
        [self showShotTimeSign];
        return;
    }
    
    if ([[LGSoundRecorder shareInstance] soundRecordTime] < 61) {
        
       [self sendSound];
        
        if (self.recordFinishBlock) {
            NSString *mp3FileName = [self audio_PCMtoMP3];
            self.recordFinishBlock(mp3FileName);
        }
        
        [[LGSoundRecorder shareInstance] stopSoundRecord:[self getParentviewController].view];
    }
    if (_timerOf60Second) {
        [_timerOf60Second invalidate];
        _timerOf60Second = nil;
    }
}

/**
 *  更新录音显示状态,手指向上滑动后 提示松开取消录音
 */
- (void)updateCancelRecordVoice {
    [[LGSoundRecorder shareInstance] readyCancelSound];
}

/**
 *  更新录音状态,手指重新滑动到范围内,提示向上取消录音
 */
- (void)updateContinueRecordVoice {
    [[LGSoundRecorder shareInstance] resetNormalRecord];
}

/**
 *  取消录音
 */
- (void)cancelRecordVoice {
    [[LGSoundRecorder shareInstance] soundRecordFailed:[self getParentviewController].view];
}

/**
 *  录音时间短
 */
- (void)showShotTimeSign {
    [[LGSoundRecorder shareInstance] showShotTimeSign:[self getParentviewController].view];
}
- (void)sixtyTimeStopSendVodio {
    
    int countDown = 60 - [[LGSoundRecorder shareInstance] soundRecordTime];
    NSLog(@"countDown is %d soundRecordTime is %f",countDown,[[LGSoundRecorder shareInstance] soundRecordTime]);
    if (countDown <= 10) {
        [[LGSoundRecorder shareInstance] showCountdown:countDown - 1];
    }
    if ([[LGSoundRecorder shareInstance] soundRecordTime] >= 59 && [[LGSoundRecorder shareInstance] soundRecordTime] <= 60) {
        
        [_addRecordButton sendActionsForControlEvents:UIControlEventTouchUpInside];
        if (_timerOf60Second) {
            [_timerOf60Second invalidate];
            _timerOf60Second = nil;
        }
    }
}

#pragma mark 🎱 显示录音
- (void)sendSound {
    
    self.messageModel = [[ShowAudioModel alloc] init];
    self.messageModel.soundFilePath = [[LGSoundRecorder shareInstance] soundFilePath];
    self.messageModel.seconds = [[LGSoundRecorder shareInstance] soundRecordTime];
    
    NSLog(@"recorder sound file path %@",self.messageModel.soundFilePath);
    
    //    self.messageModel.mp3FilePath = [self formatConversionToMp3];
    self.messageModel.mp3FilePath = [self audio_PCMtoMP3];
    
    /*
    playButton = [[UIButton alloc]initWithFrame:CGRectMake(12, 0, kScreenWidth-24, 52)];
    [playButton setTitle:[NSString stringWithFormat:@"%.0fs",self.messageModel.seconds]forState:UIControlStateNormal];
    [playButton setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    playButton.backgroundColor = [UIColor lightGrayColor];
    playButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [playButton setImage:[UIImage imageNamed:@"sound"] forState:UIControlStateNormal];
    [playButton addTarget:self action:@selector(playRecordButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:playButton];
    [playButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(12);
        make.right.equalTo(self.mas_right).offset(-12);
        make.height.mas_equalTo(52);
        make.top.equalTo(self.mas_top);
    }];
    
    
    UIButton* deletVideo  = [[UIButton alloc]initWithFrame:CGRectMake(playButton.width-50 , (playButton.height-25)/2, 25, 25)];
    [deletVideo setImage:[UIImage imageNamed:@"delete28"] forState:UIControlStateNormal];
    [playButton addSubview:deletVideo];
    [deletVideo addTarget:self action:@selector(deleteRecordButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    */
    self.isRecord = YES;
    
  //  [self chanageCircleCollectonFrame];
    
    
    
}
#pragma mark 🎱 语音播放
- (void)playRecordButtonAction:(UIButton*)sender{
    
//    if ( self.isVideo) {
//        
//        [_player stop];
//    }
    NSData *audioData = [[NSData alloc] initWithContentsOfFile:self.messageModel.soundFilePath];
 
    NSLog(@"audioData-1 = %@",audioData);

    [[LGAudioPlayer sharePlayer] playAudioWithURLString:self.messageModel.soundFilePath atIndex:0 withParentButton:sender];
}

#pragma mark 🎱 删除录音
- (void)deleteRecordButtonAction:(UIButton*)sender{
    
    [playButton removeFromSuperview];
    self.isRecord = NO;
    
    NSString *mp3FilePath = [DocumentPath stringByAppendingPathComponent:@"SoundFile"] ;
    
    
    //    [[NSFileManager defaultManager] removeItemAtPath:self.messageModel.soundFilePath error:nil];
    [[NSFileManager defaultManager] removeItemAtPath:mp3FilePath error:nil];
    [_addRecordButton setTitle:@"按住说话" forState:UIControlStateNormal];
   // [_addRecordButton setImage:[UIImage imageNamed:@"second_sounding_d"] forState:UIControlStateNormal];
    
}
- (void)setIsDeleteAudio:(BOOL)isDeleteAudio
{
    _isDeleteAudio = isDeleteAudio;
    if (isDeleteAudio == YES) {
        [self deleteRecordAudio];
    }
}
- (void)deleteRecordAudio
{
    self.isRecord = NO;
    
    [playButton removeFromSuperview];
    NSString *mp3FilePath = [DocumentPath stringByAppendingPathComponent:@"SoundFile"] ;
    
    
    [[NSFileManager defaultManager] removeItemAtPath:self.messageModel.soundFilePath error:nil];
    [[NSFileManager defaultManager] removeItemAtPath:mp3FilePath error:nil];
    
    [_addRecordButton setTitle:@"按住说话" forState:UIControlStateNormal];

   // [_addRecordButton setImage:[UIImage imageNamed:@"second_sounding_d"] forState:UIControlStateNormal];
    NSData *audioData = [[NSData alloc] initWithContentsOfFile:self.messageModel.soundFilePath];
    NSLog(@"mp3FilePath = %@",mp3FilePath);
    NSLog(@"self.messageModel.soundFilePath = %@",self.messageModel.soundFilePath);
    NSLog(@"audioData = %@",audioData);
   
}



/**
 *  语音文件存储路径
 *
 *  @return 路径
 */
- (NSString *)recordPath {
    NSString *filePath = [DocumentPath stringByAppendingPathComponent:@"SoundFile"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSError *error = nil;
        [[NSFileManager defaultManager] createDirectoryAtPath:filePath withIntermediateDirectories:NO attributes:nil error:&error];
        if (error) {
            NSLog(@"%@", error);
        }
    }
    return filePath;
}
- (NSString*)audio_PCMtoMP3
{
    
    NSString *cafFilePath = self.messageModel.soundFilePath;    //caf文件路径
    
    NSString* fileName = [NSString stringWithFormat:@"/voice-%5.2f.mp3", [[NSDate date] timeIntervalSince1970] ];//存储mp3文件的路径
    
    NSString *mp3FileName = [[DocumentPath stringByAppendingPathComponent:@"SoundFile"] stringByAppendingPathComponent:fileName];
    
    
    @try {
        int read, write;
        
        FILE *pcm = fopen([cafFilePath cStringUsingEncoding:1], "rb");  //source 被转换的音频文件位置
        fseek(pcm, 4*1024, SEEK_CUR);                                   //skip file header
        FILE *mp3 = fopen([mp3FileName cStringUsingEncoding:1], "wb");  //output 输出生成的Mp3文件位置
        
        const int PCM_SIZE = 8192;
        const int MP3_SIZE = 8192;
        short int pcm_buffer[PCM_SIZE*2];
        unsigned char mp3_buffer[MP3_SIZE];
        
        lame_t lame = lame_init();
        lame_set_num_channels(lame, 2);//设置1为单通道，默认为2双通道
        lame_set_in_samplerate(lame, 8000.0);//11025.0
        //lame_set_VBR(lame, vbr_default);
        lame_set_brate(lame, 16);
        lame_set_mode(lame, 3);
        lame_set_quality(lame, 2);
        lame_init_params(lame);
        
        do {
            read = fread(pcm_buffer, 2*sizeof(short int), PCM_SIZE, pcm);
            if (read == 0)
                write = lame_encode_flush(lame, mp3_buffer, MP3_SIZE);
            else
                write = lame_encode_buffer_interleaved(lame, pcm_buffer, read, mp3_buffer, MP3_SIZE);
            
            fwrite(mp3_buffer, write, 1, mp3);
            
        } while (read != 0);
        
        lame_close(lame);
        fclose(mp3);
        fclose(pcm);
    }
    @catch (NSException *exception) {
        NSLog(@"%@",[exception description]);
    }
    @finally {
        //        self.audioFileSavePath = mp3FilePath;
        NSLog(@"MP3生成成功: %@",mp3FileName);
    }
    
    return mp3FileName;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
