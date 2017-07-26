//
//  ShowAudioView.h
//  ClientManager
//
//  Created by iOS－MacBook on 2017/7/3.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ShowAudioModel;
typedef void(^recordIsFinishCallBackBlock)(NSString *mp3FileName);
@interface ShowAudioView : UIView
@property (nonatomic, assign)    BOOL isRecord;
@property (nonatomic, strong) UIButton* addRecordButton;
@property (nonatomic,strong)ShowAudioModel *messageModel;
/**
 <#annotation#>
 */
@property (nonatomic,copy) recordIsFinishCallBackBlock recordFinishBlock;
/**
 <#annotation#>
 */
@property (nonatomic,assign) BOOL isDeleteAudio;

- (void)deleteRecordAudio;

@end
