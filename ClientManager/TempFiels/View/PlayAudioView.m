//
//  PlayAudioView.m
//  ClientManager
//
//  Created by iOS－MacBook on 2017/7/4.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import "PlayAudioView.h"
#import "Masonry.h"
#import "lame.h"
#import "LGAudioKit.h"
#import "AudioViewController.h"
#import "UIView+Size.h"
#import "ShowAudioModel.h"
//http://sc1.111ttt.com/2016/5/12/06/205061921568.mp3
#define DocumentPath  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define PlayViewH 50
@interface PlayAudioView()
/**
 <#annotation#>
 */
@property (nonatomic,weak) UIButton *playBtn;
/**
 删除录音按钮
 */
@property (nonatomic,weak) UIButton *deleteBtn;
/**
 <#annotation#>
 */
@property (nonatomic,weak) UIView *recordBgView;


@end

@implementation PlayAudioView
- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupPlayAudionViews];
    }
    
    return self;
    
}
- (void)setupPlayAudionViews
{
    self.messageModel = [[ShowAudioModel alloc] init];
    self.messageModel.soundFilePath = [[LGSoundRecorder shareInstance] soundFilePath];
    self.messageModel.seconds = [[LGSoundRecorder shareInstance] soundRecordTime];
    
    NSLog(@"recorder sound file path %@",self.messageModel.soundFilePath);
    
    //    self.messageModel.mp3FilePath = [self formatConversionToMp3];
   // self.messageModel.mp3FilePath = [self audio_PCMtoMP3];
    
    self.messageModel.mp3FilePath = self.mp3FileName;
    CGFloat myHeight = self.frame.size.height;
    
    //录音背景
    UIView *recordBgView = [[UIView alloc] init];
    recordBgView.backgroundColor = [UIColor whiteColor];
    CGFloat recordBgViewX = 0;
    CGFloat recordBgViewY = 0;
    CGFloat recordBgViewWidth = SCREEN_WIDTH;
    CGFloat recordBgViewHeight = myHeight;
    recordBgView.frame = CGRectMake(recordBgViewX, recordBgViewY, recordBgViewWidth, recordBgViewHeight);
   // recordBgView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:recordBgView];
    self.recordBgView = recordBgView;
    //
    UIView *topLine = [[UIView alloc] init];
    topLine.backgroundColor = [AppColor appTableCellSeparatLineColor];
    CGFloat topLineX = 0;
    CGFloat topLineY = 0;
    CGFloat topLineWidth = recordBgViewWidth;
    CGFloat topLineHeight = 0.4;
    topLine.frame = CGRectMake(topLineX, topLineY, topLineWidth, topLineHeight);
    [self.recordBgView addSubview:topLine];
    
    
  //  UIButton *playButton = [[UIButton alloc]initWithFrame:CGRectMake(12, 0, SCREEN_WIDTH-24, 52)];
    UIButton *playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat playButtonWidth = 46;
    CGFloat playButtonHeight = playButtonWidth;
    CGFloat playMargin = (recordBgViewHeight - playButtonHeight) / 2;
    CGFloat playButtonX = ComMargin;
    CGFloat playButtonY = playMargin;

    playButton.frame = CGRectMake(playButtonX, playButtonY, playButtonWidth, playButtonHeight);
   // [playButton setTitle:[NSString stringWithFormat:@"%.0fs",self.messageModel.seconds]forState:UIControlStateNormal];
    [playButton setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
  //  playButton.backgroundColor = [UIColor lightGrayColor];
    playButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [playButton setImage:[UIImage imageNamed:@"sound"] forState:UIControlStateNormal];
    [playButton addTarget:self action:@selector(playRecordButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    playButton.backgroundColor = [UIColor colorWithRed:155 / 255.0 green:205 / 255.0 blue:253 / 255.0 alpha:1.0];
    [recordBgView addSubview:playButton];
    self.playBtn = playButton;
//
    NSString *titleStr = @"录音";
    CGSize titleSize = [titleStr sizeWithFont:ComFont];
    //
    NSString *descStr = [NSString stringWithFormat:@"录音总时长%f\"",self.messageModel.seconds];
    CGSize descSize = [descStr sizeWithFont:[UIFont systemFontOfSize:13]];
    //
    CGFloat margin = (recordBgViewHeight - titleSize.height - descSize.height - 5) / 2;
    //录音
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = ComFont;
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.textColor = [UIColor blackColor];
    CGFloat titleLabelX = ComMargin * 2 + playButtonWidth;
    CGFloat titleLabelY = margin;
    CGFloat titleLabelWidth = titleSize.width;
    CGFloat titleLabelHeight = titleSize.height;
    titleLabel.frame = CGRectMake(titleLabelX, titleLabelY, titleLabelWidth, titleLabelHeight);
    titleLabel.text = titleStr;
    [self.recordBgView addSubview:titleLabel];
    //录音简介
    UILabel *descLabel = [[UILabel alloc] init];
    descLabel.font = [UIFont systemFontOfSize:13];
    descLabel.textAlignment = NSTextAlignmentLeft;
    descLabel.textColor = [UIColor lightGrayColor];
    CGFloat descLabelX = titleLabelX;
    CGFloat descLabelY = CGRectGetMaxY(titleLabel.frame) + 5;
    CGFloat descLabelWidth = descSize.width;
    CGFloat descLabelHeight = descSize.height;
    descLabel.frame = CGRectMake(descLabelX, descLabelY, descLabelWidth, descLabelHeight);
    descLabel.text = descStr;
    [self.recordBgView addSubview:descLabel];

    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat deleteBtnWidth = 25;
    CGFloat deleteBtnHeight = deleteBtnWidth;

    CGFloat deleteBtnX = recordBgViewWidth - deleteBtnWidth - ComMargin;
    CGFloat deleteBtnY = 0;
    deleteBtn.frame = CGRectMake(deleteBtnX, deleteBtnY, deleteBtnWidth, deleteBtnHeight);
   // [deleteBtn setTitle:[NSString stringWithFormat:@"%.0fs",self.messageModel.seconds]forState:UIControlStateNormal];
    [deleteBtn setImage:[UIImage imageNamed:@"delete28"] forState:UIControlStateNormal];
    [deleteBtn setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
   // deleteBtn.backgroundColor = [UIColor lightGrayColor];
    deleteBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [deleteBtn addTarget:self action:@selector(deleteRecordAudioButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.recordBgView addSubview:deleteBtn];
    self.deleteBtn = deleteBtn;

    UIView *bottomLine = [[UIView alloc] init];
    bottomLine.backgroundColor = [AppColor appTableCellSeparatLineColor];
    CGFloat bottomLineX = 0;
    CGFloat bottomLineY = recordBgViewHeight - 0.4;
    CGFloat bottomLineWidth = recordBgViewWidth;
    CGFloat bottomLineHeight = 0.4;
    bottomLine.frame = CGRectMake(bottomLineX, bottomLineY, bottomLineWidth, bottomLineHeight);
    [self.recordBgView addSubview:bottomLine];

    
    
//    [playButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.mas_left).offset(0);
//        make.right.equalTo(self.mas_right).offset(0);
//        make.height.mas_equalTo(0);
//        make.top.equalTo(self.mas_top);
//    }];
//  
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
- (void)deleteRecordAudioButtonAction:(UIButton *)sender
{
   // [LGAudioPlayer sharePlayer];
  //  [self.playBtn removeFromSuperview];
    NSData *audioData = [[NSData alloc] initWithContentsOfFile:self.messageModel.soundFilePath];
    
    NSLog(@"删除后audioData = %@",audioData);
    [[LGAudioPlayer sharePlayer] stopAudioPlayer];
    if (self.deleteAudioBlock) {
        self.deleteAudioBlock();
    }
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
