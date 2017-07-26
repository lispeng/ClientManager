//
//  ShowAudioModel.h
//  ClientManager
//
//  Created by iOS－MacBook on 2017/7/3.
//  Copyright © 2017年 Lispeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShowAudioModel : NSObject
@property (nonatomic, copy) NSString *soundFilePath;
@property (nonatomic, assign) NSTimeInterval seconds;
@property (nonatomic, copy) NSString *mp3FilePath;
@end
