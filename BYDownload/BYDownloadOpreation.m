//
//  BYDownloadOpreation.m
//  BYDownload
//
//  Created by 崔宝印 on 2018/8/15.
//  Copyright © 2018年 Koolearn. All rights reserved.
//

#import "BYDownloadOpreation.h"

@interface BYDownloadOpreation()<NSURLSessionDelegate>

#pragma mark property rewrite
@property (nonatomic, assign, getter=isFinished) BOOL finished; //rewrite，自己控制
@property (nonatomic, assign, getter=isFinished) BOOL executing; //rewrite，自己控制

#pragma mark property private

@property (nonatomic, strong) NSString *downloadUrl;
@property (nonatomic, assign) long long startLocation;
@property (nonatomic, strong) BYDownloadOpreationProgressBlock progressBlock;
@property (nonatomic, strong) BYDownloadOpreationCompleteBlock completeBlock;

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSURLSessionDataTask *dataTask;

@end

@implementation BYDownloadOpreation
@synthesize finished = _finished;
@synthesize executing = _executing;

- (instancetype)initOperationWithDownloadUrl:(NSString *)URL
                               startLocation:(long long)location
                               progressBlock:(BYDownloadOpreationProgressBlock)progressBlock
                               completeBlock:(BYDownloadOpreationCompleteBlock)completeBlock
{
    if (self = [super init])
    {
        self.downloadUrl = URL;
        self.startLocation = location;
        self.progressBlock = progressBlock;
        self.completeBlock = completeBlock;
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
//        self.isExecuting = YES;

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
    
}

- (void)stop
{
    [self cancel];
}

- (void)resume
{
    
}


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
                     
@end
