//
//  PlayAudioView.h
//  ClientManager
//
//  Created by iOS－MacBook on 2017/7/4.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ShowAudioModel;
typedef void(^deleteRecordAudioBlock)();
@interface PlayAudioView : UIView
@property (nonatomic,strong)ShowAudioModel *messageModel;
/**
 <#annotation#>
 */
@property (nonatomic,copy) NSString *mp3FileName;
/**
 <#annotation#>
 */
@property (nonatomic,copy) deleteRecordAudioBlock deleteAudioBlock;

@end
