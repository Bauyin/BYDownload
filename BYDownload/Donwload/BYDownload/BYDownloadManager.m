//
//  BYDownloadManager.m
//  BYDownload
//
//  Created by 崔宝印 on 2018/8/15.
//  Copyright © 2018年 Koolearn. All rights reserved.
//

#import "BYDownloadManager.h"
#import "BYDownloadOpreation.h"

@interface BYDownloadManager()

@property (nonatomic, strong) NSOperationQueue *downloadQueue;
@property (nonatomic, strong) NSMutableArray *downloadArray;

@property (nonatomic, strong) dispatch_semaphore_t downloadArraySemphore;

@end

@implementation BYDownloadManager
+ (instancetype)sharedDownloadManager
{
    static BYDownloadManager *sharedManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[BYDownloadManager alloc] init];
    });
    return sharedManager;
}

- (NSString *)startDownloadWithUrl:(NSString *)URL
                        toFilePath:(NSString *)path
                     startLocation:(long long)location
                     progressBlock:(BYDownloadManagerProgressBlock)progressBlock
                     completeBlock:(BYDownloadManagerCompleteBlock)completeBlock
{
    BYDownloadOpreation *operation = [[BYDownloadOpreation alloc] initOperationWithDownloadUrl:URL writeToFilePath:path writedFileSize:location progressBlock:^(NSData *recivedData, long recivedDataLengh, long totalDataLengh) {
                progressBlock(recivedData,recivedDataLengh,totalDataLengh);
    } completeBlock:^(NSString *taskId, BOOL isFinished, NSError *error) {
        completeBlock(taskId,isFinished,error);
    }];
    operation.completionBlock = ^{
        
    };
    dispatch_semaphore_wait(self.downloadArraySemphore, DISPATCH_TIME_FOREVER);
    [self.downloadArray addObject:operation];
    dispatch_semaphore_signal(self.downloadArraySemphore);
    
    [self.downloadQueue addOperation:operation];
    return operation.operationId;
}

- (void)cancelDownload:(NSString *)identifer
{
//    dispatch
    [self.downloadArray enumerateObjectsUsingBlock:^(BYDownloadOpreation *operation, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([operation.operationId isEqualToString:identifer])
        {
            [operation cancel];
            *stop = YES;
        }
    }];
}

- (void)pauseDownload:(NSString *)identifer
{
    [self.downloadArray enumerateObjectsUsingBlock:^(BYDownloadOpreation *operation, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([operation.operationId isEqualToString:identifer])
        {
            [operation suspend];
            *stop = YES;
        }
    }];
}

- (void)resumeDownload:(NSString *)identifer
{
    [self.downloadArray enumerateObjectsUsingBlock:^(BYDownloadOpreation *operation, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([operation.operationId isEqualToString:identifer])
        {
            [operation resume];
            *stop = YES;
        }
    }];
}

#pragma mark - Getter
- (NSMutableArray *)downloadArray
{
    if (_downloadArray == nil)
    {
        _downloadArray = [NSMutableArray array];
    }
    return _downloadArray;
}

- (NSOperationQueue *)downloadQueue
{
    if (_downloadQueue == nil)
    {
        _downloadQueue = [[NSOperationQueue alloc] init];
    }
    return _downloadQueue;
}

- (dispatch_semaphore_t)downloadArraySemphore
{
    if (_downloadArraySemphore == nil)
    {
        _downloadArraySemphore = dispatch_semaphore_create(1);
    }
    return _downloadArraySemphore;
}
@end
