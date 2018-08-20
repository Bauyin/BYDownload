//
//  BYDownloadManager.h
//  BYDownload
//
//  Created by 崔宝印 on 2018/8/15.
//  Copyright © 2018年 Koolearn. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^BYDownloadManagerProgressBlock)(NSData *recivedData, long recivedDataLengh, long totalDataLengh);
typedef void(^BYDownloadManagerCompleteBlock)(NSString *taskId, BOOL isFinished, NSError *error);


@interface BYDownloadManager : NSObject

+ (instancetype)sharedDownloadManager;

- (NSString *)startDownloadWithUrl:(NSString *)URL
                                toFilePath:(NSString *)path
                               startLocation:(long long)location
                               progressBlock:(BYDownloadManagerProgressBlock)progressBlock
                               completeBlock:(BYDownloadManagerCompleteBlock)completeBlock;

- (void)cancelDownload:(NSString *)identifer;
- (void)pauseDownload:(NSString *)identifer;
- (void)resumeDownload:(NSString *)identifer;

- (void)cancelAllDownload;

- (void)pauseAllDownload;

- (void)resumeAllDownload;
@end
