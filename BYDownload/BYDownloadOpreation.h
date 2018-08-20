//
//  BYDownloadOpreation.h
//  BYDownload
//
//  Created by 崔宝印 on 2018/8/15.
//  Copyright © 2018年 Koolearn. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BYDownloadOpreation;

typedef void(^BYDownloadOpreationProgressBlock)(NSData *recivedData, long recivedDataLengh, long totalDataLengh);
typedef void(^BYDownloadOpreationCompleteBlock)(NSString *taskId, BOOL isFinished, NSError *error);

@interface BYDownloadOpreation : NSOperation

@property (nonatomic, strong, readonly) NSString *operationId;

- (instancetype)initOperationWithDownloadUrl:(NSString *)URL
                                saveFilePath:(NSString *)filePath
            startLocation:(long long)location
            progressBlock:(BYDownloadOpreationProgressBlock)progressBlock
            completeBlock:(BYDownloadOpreationCompleteBlock)completeBlock;

/**
 暂停
 */
- (void)suspend;

- (void)cancel;

/**
 取消
 */
- (void)stop;

/**
 恢复
 */
- (void)resume;

@end
