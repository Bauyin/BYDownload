//
//  BYDownloadOpreation.m
//  BYDownload
//
//  Created by 崔宝印 on 2018/8/15.
//  Copyright © 2018年 Koolearn. All rights reserved.
//

#import "BYDownloadOpreation.h"

@interface BYDownloadOpreation()<NSURLSessionDataDelegate>

#pragma mark property rewrite
@property (nonatomic, assign, getter=isFinished) BOOL finished; //rewrite，自己控制
@property (nonatomic, assign, getter=isFinished) BOOL executing; //rewrite，自己控制

#pragma mark property private

@property (nonatomic, strong) NSString *operationId;
@property (nonatomic, strong) NSString *downloadUrl;

@property (nonatomic, assign) long long startLocation;
@property (nonatomic, assign) long long totalFileLength;
@property (nonatomic, assign) long long writedFileLength;
@property (nonatomic, strong) NSString *saveFilePath;
@property (nonatomic, strong) NSOutputStream *outputStream;

@property (nonatomic, strong) BYDownloadOpreationProgressBlock progressBlock;
@property (nonatomic, strong) BYDownloadOpreationCompleteBlock completeBlock;

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSURLSessionDataTask *dataTask;

@end

@implementation BYDownloadOpreation
@synthesize finished = _finished;
@synthesize executing = _executing;

- (instancetype)initOperationWithDownloadUrl:(NSString *)URL
                                saveFilePath:(NSString *)filePath
                               startLocation:(long long)location
                               progressBlock:(BYDownloadOpreationProgressBlock)progressBlock
                               completeBlock:(BYDownloadOpreationCompleteBlock)completeBlock
{
    if (self = [super init])
    {
        self.saveFilePath = filePath;
        self.downloadUrl = URL;
        self.startLocation = location;
        self.progressBlock = progressBlock;
        self.completeBlock = completeBlock;
        NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
        self.operationId = [NSString stringWithFormat:@"%@%.0f",URL.lastPathComponent,interval];
    }
    return self;
}

/**
 异步处理必须rewrite start
 */
- (void)start
{
    if (self.isCancelled || self.isFinished)
    {
        _executing = YES;
    }
    
    NSURL *requestURL = [NSURL URLWithString:self.downloadUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestURL];
    if (self.startLocation > 0)
    {
        NSString *rangValue = [NSString stringWithFormat:@"bytes=%lld",self.startLocation];
        [request addValue:rangValue forHTTPHeaderField:@"Range"];
    }
    self.dataTask = [self.session dataTaskWithRequest:request];
    [self.dataTask resume];
}


/**
 同步处理无需rewrite start，只需rewrite main
 */
- (void)main
{
    NSLog(@"%s",__func__);
}

- (void)suspend
{
    [self.dataTask suspend];
    _executing = NO;
}

- (void)cancel
{
    [self.dataTask cancel];
    [super cancel];
    _executing = NO;
    [self setFinished:YES];
}

//- (void)stop
//{
//    [self.dataTask cancel];
//}
//
//- (void)resume
//{
//    
//}


#pragma mark - Gett && Setter
- (NSURLSession *)session
{
    if (_session == nil)
    {
        NSURLSessionConfiguration *configer = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:configer delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    }
    return _session;
}

- (void)setFinished:(BOOL)finished
{
    //手动触发KVO，让OpreationQueue结束此operation
    [self willChangeValueForKey:@"_isFinished"];
    _finished = finished;
    [self didChangeValueForKey:@"_isFinished"];
}

- (NSOutputStream *)outputStream
{
    if (_outputStream == nil)
    {
        _outputStream = [NSOutputStream outputStreamToFileAtPath:self.saveFilePath append:YES];
        [_outputStream open];
    }
    return _outputStream;
}
#pragma mark - NSURLSessionDataTaskDeleagte
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler
{
    self.totalFileLength = response.expectedContentLength;
    completionHandler(NSURLSessionResponseAllow);
    
    NSLog(@"%s",__func__);
}

- (void)URLSession:(NSURLSession *)session
          dataTask:(nonnull NSURLSessionDataTask *)dataTask
    didReceiveData:(nonnull NSData *)data
{
    [self.outputStream open];
    [self.outputStream write:[data bytes] maxLength:data.length];
    [self.outputStream close];
    self.writedFileLength += data.length;
    self.progressBlock(data, self.writedFileLength, dataTask.response.expectedContentLength);
//    NSLog(@"%s--%lu--%ld",__func__,(unsigned long)data.length,(long)lenth);
}

- (void)URLSession:(NSURLSession *)session
              task:(NSURLSessionTask *)task
didCompleteWithError:(nullable NSError *)error
{
    [self.outputStream close];
    if (error == nil)
    {
        self.completeBlock(self.operationId, YES, nil);
    }
    else
    {
        self.completeBlock(self.operationId, NO, error);
    }
    NSLog(@"%s",__func__);
}
@end
