//
//  SULoader.h
//  SULoader
//
//  Created by SouSouTec on 2017.
//  Copyright © 2017年 SouSouTec. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "SURequestTask.h"

//#define MimeType @"video/mp4"
#define MimeType @"audio/mp4"

@class SUResourceLoader;
@protocol SULoaderDelegate <NSObject>

@required
- (void)loader:(SUResourceLoader *)loader cacheProgress:(CGFloat)progress;

@optional
- (void)loader:(SUResourceLoader *)loader failLoadingWithError:(NSError *)error;

@end

@interface SUResourceLoader : NSObject<AVAssetResourceLoaderDelegate,SURequestTaskDelegate>

@property (nonatomic, weak) id<SULoaderDelegate> delegate;
@property (atomic, assign) BOOL seekRequired; //Seek标识
@property (nonatomic, assign) BOOL cacheFinished;

- (void)stopLoading;

@end

